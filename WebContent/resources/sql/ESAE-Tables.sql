-- DROP DATABASE ESALE;
/*
CREATE DATABASE ESALE
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'English_United States.1252'
       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;




DROP table nested_category_sale_item;
DROP table nested_category_delevery_schedule_item;
DROP table nested_category_item;
DROP table nested_category;
DROP table item;
DROP table sale_item;
DROP table delevery_schedule_item;
DROP table item_type;
DROP table category;
DROP SEQUENCE item_type_sq;
DROP SEQUENCE item_sq;
DROP SEQUENCE category_sq;
DROP SEQUENCE nested_category_sq;
DROP SEQUENCE securityuser_sq;
DROP SEQUENCE voicecontact_sq;
DROP SEQUENCE locationcontact_sq;
DROP SEQUENCE shipping_sq;
DROP TABLE user_voicecontact;
DROP TABLE user_locationcontact;
DROP TABLE voicecontact;
DROP TABLE locationcontact;
DROP TABLE securityuser;
DROP TABLE shipping;
DROP TABLE shipping_locationcontact;
DROP TABLE shipping_voicecontact;
DROP TABLE delivery_schedule;
DROP TABLE shipping_delivery_schedule;
*/

-- DROP SEQUENCE item_type_sq;

CREATE SEQUENCE item_type_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE item_type_sq OWNER TO postgres;


-- DROP SEQUENCE category_sq;

CREATE SEQUENCE category_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 36
  CACHE 1;
ALTER TABLE category_sq OWNER TO postgres;


-- DROP SEQUENCE locationcontact_sq;

CREATE SEQUENCE locationcontact_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 68
  CACHE 1;
ALTER TABLE locationcontact_sq OWNER TO postgres;


-- DROP SEQUENCE nested_category_sq;

CREATE SEQUENCE nested_category_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 36
  CACHE 1;
ALTER TABLE nested_category_sq OWNER TO postgres;


-- DROP SEQUENCE item_sq;

CREATE SEQUENCE item_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 2
  CACHE 1;
ALTER TABLE item_sq OWNER TO postgres;


-- DROP SEQUENCE securityuser_sq;

CREATE SEQUENCE securityuser_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 64
  CACHE 1;
ALTER TABLE securityuser_sq OWNER TO postgres;


-- DROP SEQUENCE voicecontact_sq;

CREATE SEQUENCE voicecontact_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 60
  CACHE 1;
ALTER TABLE voicecontact_sq OWNER TO postgres;

CREATE SEQUENCE shipping_sq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE shipping_sq OWNER TO postgres;


-- DROP TABLE item_type;

CREATE TABLE item_type
(
  item_type_id bigint NOT NULL DEFAULT nextval('item_type_sq'::regclass),
  name character varying(255) NOT NULL,
  CONSTRAINT item_type_pkey PRIMARY KEY (item_type_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE item_type OWNER TO postgres;
GRANT ALL ON TABLE item_type TO postgres;
GRANT ALL ON TABLE item_type TO public;


---DROP type nested_category_record;

create type nested_category_record AS (
nested_category_id bigint,
nested_category_type character varying(255),
category_id bigint,
category_name character varying(255),
diff_factor integer,
image_path  character varying(255),
category_lft integer,
category_rgt integer,
category_depth bigint
);


-- DROP TABLE category;

CREATE TABLE category
(
  category_id bigint NOT NULL DEFAULT nextval('category_sq'::regclass),
  name character varying(255) NOT NULL,
  diff_factor integer,
  image_path character varying(255),
  CONSTRAINT category_pkey PRIMARY KEY (category_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE category OWNER TO postgres;
GRANT ALL ON TABLE category TO postgres;
GRANT ALL ON TABLE category TO public;


-- DROP TABLE locationcontact;

CREATE TABLE locationcontact
(
  locationcontactid bigint NOT NULL,
  addressline1 character varying(256) NOT NULL,
  addressline2 character varying(256),
  city character varying(126),
  postcode character varying(126),
  statecode character varying(126),
  countrycode character varying(126),
  prioriylevel integer,
  CONSTRAINT locationcontact_pk PRIMARY KEY (locationcontactid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE locationcontact OWNER TO postgres;


-- DROP TABLE nested_category;

CREATE TABLE nested_category
(
  nested_category_id bigint NOT NULL DEFAULT nextval('nested_category_sq'::regclass),
  category_id bigint NOT NULL,
  lft integer NOT NULL,
  rgt integer NOT NULL,
  type character varying(126) NOT NULL,
  CONSTRAINT nested_category_pkey PRIMARY KEY (nested_category_id),
  CONSTRAINT nested_category_fk FOREIGN KEY (category_id)
      REFERENCES category (category_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nested_category OWNER TO postgres;
GRANT ALL ON TABLE nested_category TO postgres;
GRANT ALL ON TABLE nested_category TO public;

-- DROP TABLE item;

CREATE TABLE item
(
  item_id bigint NOT NULL DEFAULT nextval('item_sq'::regclass),
  name character varying(255) NOT NULL,
  item_type_id bigint NOT NULL,
  enabled boolean,
  CONSTRAINT item_pkey PRIMARY KEY (item_id),
  CONSTRAINT item_fk FOREIGN KEY (item_type_id)
      REFERENCES item_type (item_type_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE item OWNER TO postgres;
GRANT ALL ON TABLE item TO postgres;
GRANT ALL ON TABLE item TO public;

-- DROP TABLE sale_item;

CREATE TABLE sale_item
(
  item_id bigint NOT NULL DEFAULT nextval('item_sq'::regclass),
  display_name character varying(255),
  description character varying(510),
  price numeric DEFAULT 0,
  image_path character varying(255),
  base_price numeric DEFAULT 0,
  price_for character varying(100),
  enabled boolean,

  CONSTRAINT sale_item_pkey PRIMARY KEY (item_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sale_item OWNER TO postgres;
GRANT ALL ON TABLE sale_item TO postgres;
GRANT ALL ON TABLE sale_item TO public;

-- DROP TABLE sale_item;

CREATE TABLE delevery_schedule_item
(
  item_id bigint NOT NULL DEFAULT nextval('item_sq'::regclass),
  display_name character varying(255),
  description character varying(510),
  cost numeric DEFAULT 0,
  image_path character varying(255),
  
  CONSTRAINT delevery_schedule_item_pkey PRIMARY KEY (item_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE delevery_schedule_item OWNER TO postgres;
GRANT ALL ON TABLE delevery_schedule_item TO postgres;
GRANT ALL ON TABLE delevery_schedule_item TO public;

-- DROP TABLE nested_category_item;

CREATE TABLE nested_category_item
(
  item_id bigint NOT NULL,
  nested_category_id bigint NOT NULL,
  active boolean,
  CONSTRAINT nested_category_item_pk PRIMARY KEY (item_id, nested_category_id),
  CONSTRAINT nested_category_item_fk1 FOREIGN KEY (item_id)
      REFERENCES item (item_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT nested_category_item_fk2 FOREIGN KEY (nested_category_id)
      REFERENCES nested_category (nested_category_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nested_category_item OWNER TO postgres;
GRANT ALL ON TABLE nested_category_item TO postgres;
GRANT ALL ON TABLE nested_category_item TO public;

-- DROP TABLE nested_category_sale_item;

CREATE TABLE nested_category_sale_item
(
  item_id bigint NOT NULL DEFAULT nextval('item_sq'::regclass),
  nested_category_id bigint NOT NULL,
  display_name character varying(255),
  description character varying(510),
  price numeric DEFAULT 0,
  image_path character varying(255),
  base_price numeric DEFAULT 0,
  price_for character varying(100),
  active boolean,
  
  CONSTRAINT nested_category_sale_item_pk PRIMARY KEY (item_id, nested_category_id),
  CONSTRAINT nested_category_sale_item_fk1 FOREIGN KEY (item_id)
      REFERENCES item (item_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT nested_category_sale_item_fk2 FOREIGN KEY (nested_category_id)
      REFERENCES nested_category (nested_category_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nested_category_sale_item OWNER TO postgres;
GRANT ALL ON TABLE nested_category_sale_item TO postgres;
GRANT ALL ON TABLE nested_category_sale_item TO public;

-- DROP TABLE nested_category_delevery_schedule_item;

CREATE TABLE nested_category_delevery_schedule_item
(
  item_id bigint NOT NULL,
  nested_category_id bigint NOT NULL,
  display_name character varying(255),
  description character varying(510),
  cost numeric DEFAULT 0,
  image_path character varying(255),
  
  CONSTRAINT nested_category_delevery_schedule_item_pk PRIMARY KEY (item_id, nested_category_id),
  CONSTRAINT nested_category_delevery_schedule_item_fk1 FOREIGN KEY (item_id)
      REFERENCES item (item_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT nested_category_delevery_schedule_item_fk2 FOREIGN KEY (nested_category_id)
      REFERENCES nested_category (nested_category_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE nested_category_delevery_schedule_item OWNER TO postgres;
GRANT ALL ON TABLE nested_category_delevery_schedule_item TO postgres;
GRANT ALL ON TABLE nested_category_delevery_schedule_item TO public;

-- DROP TABLE securityuser;

CREATE TABLE securityuser
(
  userid bigint NOT NULL,
  othernames character varying(255),
  lastname character varying(255),
  gender character(1),
  createdon date,
  lastupdatedon date,
  title character varying(255),
  enabled boolean,
  password character varying(255),
  username character varying(255) NOT NULL,
  email character varying(255),
  CONSTRAINT securityuser_pkey PRIMARY KEY (userid),
  CONSTRAINT securityuser_username_key UNIQUE (username)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE securityuser OWNER TO postgres;
GRANT ALL ON TABLE securityuser TO postgres;
GRANT ALL ON TABLE securityuser TO public;

-- DROP TABLE user_locationcontact;

CREATE TABLE user_locationcontact
(
  locationcontactid bigint NOT NULL,
  userid bigint NOT NULL,
  CONSTRAINT user_locationcontact_pk PRIMARY KEY (locationcontactid, userid),
  CONSTRAINT user_locationcontact_fk1 FOREIGN KEY (userid)
      REFERENCES securityuser (userid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT user_locationcontact_fk2 FOREIGN KEY (locationcontactid)
      REFERENCES locationcontact (locationcontactid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE user_locationcontact OWNER TO postgres;

-- DROP TABLE voicecontact;

CREATE TABLE voicecontact
(
  voicecontactid bigint NOT NULL,
  contacttype character varying(25),
  contactnumber character varying(125) NOT NULL,
  prioritylevel integer,
  CONSTRAINT voicecontact_pk PRIMARY KEY (voicecontactid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE voicecontact OWNER TO postgres;


-- DROP TABLE user_voicecontact;

CREATE TABLE user_voicecontact
(
  voicecontactid bigint NOT NULL,
  userid bigint NOT NULL,
  CONSTRAINT user_voicecontact_pk PRIMARY KEY (voicecontactid, userid),
  CONSTRAINT user_voicecontact_fk1 FOREIGN KEY (userid)
      REFERENCES securityuser (userid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT user_voicecontact_fk2 FOREIGN KEY (voicecontactid)
      REFERENCES voicecontact (voicecontactid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE user_voicecontact OWNER TO postgres;

-- DROP TABLE delivery_schedule;

CREATE TABLE delivery_schedule
(
  delivery_schedule_id bigint NOT NULL,
  description character varying(510),
  enabled boolean,
  CONSTRAINT delivery_schedule_pkey PRIMARY KEY (delivery_schedule_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE delivery_schedule OWNER TO postgres;
GRANT ALL ON TABLE delivery_schedule TO postgres;
GRANT ALL ON TABLE delivery_schedule TO public;

-- DROP TABLE shipping;

CREATE TABLE shipping
(
  shipping_id NOT NULL DEFAULT nextval('shipping_sq'::regclass),
  shipto character varying(255),
  comments character varying(510),
  status character varying(24),
  CONSTRAINT shipping_pkey PRIMARY KEY (shipping_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE shipping OWNER TO postgres;
GRANT ALL ON TABLE shipping TO postgres;
GRANT ALL ON TABLE shipping TO public;

-- DROP TABLE shipping_locationcontact;

CREATE TABLE shipping_locationcontact
(
  locationcontact_id bigint NOT NULL,
  shipping_id bigint NOT NULL,
  CONSTRAINT shipping_locationcontact_pk PRIMARY KEY (locationcontact_id, shipping_id),
  CONSTRAINT shipping_locationcontact_fk1 FOREIGN KEY (shipping_id)
      REFERENCES shipping (shipping_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT shipping_locationcontact_fk2 FOREIGN KEY (locationcontact_id)
      REFERENCES locationcontact (locationcontactid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE shipping_locationcontact OWNER TO postgres;


-- DROP TABLE shipping_voicecontact;

CREATE TABLE shipping_voicecontact
(
  voicecontact_id bigint NOT NULL,
  shipping_id bigint NOT NULL,
  CONSTRAINT shipping_voicecontact_pk PRIMARY KEY (voicecontact_id,shipping_id),
  CONSTRAINT shipping_voicecontact_fk1 FOREIGN KEY (shipping_id)
      REFERENCES shipping (shipping_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT shipping_voicecontact_fk2 FOREIGN KEY (voicecontact_id)
      REFERENCES voicecontact (voicecontactid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE shipping_voicecontact OWNER TO postgres;

-- DROP TABLE shipping_delivery_schedule;

CREATE TABLE shipping_delivery_schedule
(
  delivery_schedule_id bigint NOT NULL,
  shipping_id bigint NOT NULL,
  description character varying(510),
  CONSTRAINT shipping_delivery_schedule_pk PRIMARY KEY (delivery_schedule_id, shipping_id),
  CONSTRAINT shipping_delivery_schedule_fk1 FOREIGN KEY (shipping_id)
      REFERENCES shipping (shipping_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT shipping_delivery_schedule_fk2 FOREIGN KEY (delivery_schedule_id)
      REFERENCES delivery_schedule (delivery_schedule_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE shipping_delivery_schedule OWNER TO postgres;


SELECT nextval('category_sq');
SELECT nextval('nested_category_sq');
insert into category values(36,'DELIVERY LOCATION',0);
insert into nested_category values(36,36,1,2,'DELIVERY LOCATION');
SELECT nextval('category_sq');
SELECT nextval('nested_category_sq');
insert into category values(37,'SALE_ITEMS',0);
insert into nested_category values(37,37,1,2,'ITEM');
SELECT nextval('category_sq');
SELECT nextval('nested_category_sq');
insert into category values(38,'DELIVERY SCHEDULE',0);
insert into nested_category values(38,38,1,2,'DELIVERY SCHEDULE');
SELECT nextval('category_sq');
SELECT nextval('nested_category_sq');
insert into category values(100,'DELIVERY METHOD',0);
insert into nested_category values(100,100,1,2,'DELIVERY METHOD');
SELECT nextval('category_sq');
SELECT nextval('nested_category_sq');
insert into category values(101,'PAYMENT_METHOD',0);
insert into nested_category values(101,101,1,2,'PAYMENT_METHOD');
