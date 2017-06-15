/*
DROP FUNCTION get_nested_category_depth(integer);
DROP FUNCTION delete_nodes(integer,text);
DROP FUNCTION add_new_node(integer, integer, text, integer, text, text);
DROP FUNCTION get_nested_category_edge_id(text, integer);
DROP FUNCTION get_single_path(integer);
DROP FUNCTION get_immediate_subordinates(integer);
DROP type nested_category_record;

CREATE LANGUAGE plpgsql;
*/
-- DROP FUNCTION add_new_node(integer, integer, text, integer, text, text);

CREATE OR REPLACE FUNCTION add_new_node(integer, integer, text, integer, text, text)
  RETURNS bigint AS
$BODY$
	
		DECLARE
		edgeid integer;
		nestedcatid bigint;
		catid bigint;
		BEGIN
		IF $1 > 0 THEN
			SELECT * from get_nested_category_edge_id('rgt',$1) INTO edgeid;
		ELSE
			SELECT * from get_nested_category_edge_id('lft',$2) INTO edgeid;
		END IF;
		IF edgeid = NULL THEN
			edgeid=0;
		END IF;
		UPDATE nested_category SET rgt = rgt + 2 WHERE type = $5 AND rgt > edgeid;
		UPDATE nested_category SET lft = lft + 2 WHERE type = $5 AND lft > edgeid;
		SELECT nextval ('nested_category_sq') INTO nestedcatid; 
		SELECT nextval ('category_sq') INTO catid;
		INSERT INTO category(category_id,name,diff_factor,image_path) VALUES(catid,$3,$4,$6);
		INSERT INTO nested_category(nested_category_id,category_id, lft, rgt,type) VALUES(nestedcatid,catid,edgeid + 1, edgeid + 2, $5);

		
		return nestedcatid;
		END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION add_new_node(integer, integer, text, integer, text, text) OWNER TO postgres;


-- DROP FUNCTION delete_nodes(integer, text);

CREATE OR REPLACE FUNCTION delete_nodes(integer, text)
  RETURNS boolean AS
$BODY$
	
		DECLARE
		lftId integer;
		rgtId integer;
		widthId integer;
		rec nested_category_record;
		BEGIN
		SELECT INTO lftId,rgtId 
		lft,rgt 
		FROM nested_category
		WHERE nested_category_id = $1;
		widthId := rgtId - lftId + 1;
		for rec in SELECT nested_category_id,category_id 
			FROM nested_category 
			WHERE type = $2 
			AND lft BETWEEN lftId AND rgtId
		loop
		-- DELETE FROM nested_category_item WHERE nested_category_id=rec.nested_category_id;
		DELETE FROM nested_category WHERE nested_category_id=rec.nested_category_id;
		DELETE FROM category WHERE category_id=rec.category_id;
		end loop;
		
		UPDATE nested_category SET rgt = rgt - widthId WHERE type = $2 AND rgt > rgtId;
		UPDATE nested_category SET lft = lft - widthId WHERE type = $2 AND lft > rgtId;	
		return true;
		END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION delete_nodes(integer, text) OWNER TO postgres;


-- DROP FUNCTION get_immediate_subordinates(integer);

CREATE OR REPLACE FUNCTION get_immediate_subordinates(integer)
  RETURNS SETOF nested_category_record AS
$BODY$
	DECLARE
		r nested_category_record;
		depth integer;
	BEGIN
		SELECT * from get_nested_category_depth($1) INTO depth;
		for r in SELECT node.nested_category_id AS nested_category_id,node.type AS nested_category_type,main_category.category_id AS category_id,main_category.name AS category_name,main_category.diff_factor AS diff_factor,main_category.image_path AS image_path,node.lft AS category_lft,node.rgt AS category_rgt, (COUNT(parent.category_id) - (depth+1)) AS category_depth
		FROM nested_category AS node,
        nested_category AS parent,
        nested_category AS sub_parent,
		category AS main_category,
        (
                SELECT node.category_id, (COUNT(parent.category_id) - 1)
                FROM nested_category AS node,
                        nested_category AS parent
                WHERE node.type = parent.type
				AND node.lft BETWEEN parent.lft AND parent.rgt
                        AND node.category_id = $1
                GROUP BY node.category_id
        
        )AS sub_tree
	WHERE node.type = parent.type
	AND node.type = sub_parent.type
	AND node.lft BETWEEN parent.lft AND parent.rgt
    AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
    AND sub_parent.category_id = sub_tree.category_id
	AND node.category_id = main_category.category_id
	AND node.category_id <> $1
GROUP BY node.nested_category_id,node.type,main_category.category_id,main_category.name,main_category.diff_factor,main_category.image_path,node.lft,node.rgt
HAVING (COUNT(parent.category_id) - (depth+1)) <= 1
ORDER BY node.lft
loop
return next r;
end loop;
return;
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION get_immediate_subordinates(integer) OWNER TO postgres;


-- DROP FUNCTION get_nested_category_depth(integer);

CREATE OR REPLACE FUNCTION get_nested_category_depth(integer)
  RETURNS integer AS
$BODY$
	
		DECLARE
		retId integer;
		BEGIN
		SELECT (COUNT(parent.category_id) - 1) INTO retId
                FROM nested_category AS node,
                        nested_category AS parent
                WHERE node.type = parent.type 
			AND node.lft BETWEEN parent.lft AND parent.rgt
                        AND node.category_id = $1
                GROUP BY node.category_id;
		
		RETURN retId;
		END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_nested_category_depth(integer) OWNER TO postgres;


-- DROP FUNCTION get_nested_category_edge_id(text, integer);

CREATE OR REPLACE FUNCTION get_nested_category_edge_id(text, integer)
  RETURNS integer AS
$BODY$
	
		DECLARE
		retId integer;
		BEGIN
		IF $1 = 'lft' THEN
			SELECT INTO retId lft FROM nested_category WHERE nested_category_id =$2;
		ELSE
			SELECT INTO retId rgt FROM nested_category WHERE nested_category_id =$2;
		END IF;
		IF retId IS NULL THEN
			RETURN 0;
		ELSE 
			RETURN retId;
		END IF;
		END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION get_nested_category_edge_id(text, integer) OWNER TO postgres;


-- DROP FUNCTION get_single_path(integer);

CREATE OR REPLACE FUNCTION get_single_path(integer)
  RETURNS SETOF nested_category_record AS
$BODY$
declare
r nested_category_record;
begin
for r in SELECT parent.nested_category_id AS nested_category_id,parent.type AS nested_category_type,main_category.category_id AS category_id,main_category.name AS category_name,main_category.diff_factor AS diff_factor,main_category.image_path AS image_path,parent.lft AS category_lft,parent.rgt AS category_rgt
FROM nested_category AS node,
        nested_category AS parent,
        category AS main_category
        WHERE node.type = parent.type
	AND node.lft BETWEEN parent.lft AND parent.rgt
	AND parent.category_id=main_category.category_id
        AND node.nested_category_id = $1
ORDER BY parent.lft
loop
return next r;
end loop;
return;
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION get_single_path(integer) OWNER TO postgres;