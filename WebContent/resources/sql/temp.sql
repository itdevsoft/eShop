--select ns.nested_category_id,c.name from nested_category ns,category c where ns.category_id=c.category_id and type='ITEM' order by lft;

/*SELECT node.nested_category_id,node.category_id,cat.name 
                FROM category AS cat,
			nested_category AS node,
                        nested_category AS parent
                WHERE cat.category_id=node.category_id
			AND node.type = parent.type 
			AND node.lft BETWEEN parent.lft AND parent.rgt
                        AND parent.category_id = 41*/

--select * from nested_category_sale_item where nested_category_id=35 and active='t' 
select * from nested_category_sale_item where nested_category_id in(41,43,44,45,46)  and active='t'

--select p.* from nested_category_sale_item AS p join nested_category_sale_item AS c on p.sale_item_id=c.sale_item_id and c.nested_category_id in(41,43,44,45,46)  and c.active='t' where p.nested_category_id=35 and p.active='t'