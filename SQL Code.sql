CREATE SCHEMA TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA

---------------------------------------------------------------------------------------------------------------
// This section is used to check how long the fields need to be that we are adding into the Woody Schema
SELECT MAX(LENGTH(name))
    ,MAX(LENGTH(RGB))
    ,MAX(LENGTH(IS_TRANS))
    
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_COLORS;
---------------------------------------------------------------------------------------------------------------
// This section adds the Lego Colors table to the Woody Schema

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_COLORS (
	ID NUMBER(38,0),
	NAME VARCHAR(28),
	RGB VARCHAR(6),
	IS_TRANS VARCHAR(1)
);
---------------------------------------------------------------------------------------------------------------
// Checking Length of LEGO_INVENTORIES table
SELECT MAX(LENGTH(SET_NUM))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_INVENTORIES;
---------------------------------------------------------------------------------------------------------------
// This section adds the Lego Inventories table to the Woody Schema

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_INVENTORIES (
	ID NUMBER(38,0),
	VERSION NUMBER(38,0),
	SET_NUM VARCHAR(16)
);
---------------------------------------------------------------------------------------------------------------
// Checking Length of LEGO_INVENTORIES table
SELECT MAX(LENGTH(PART_NUM))
    ,MAX(LENGTH(IS_Spare))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_INVENTORY_PARTS;
---------------------------------------------------------------------------------------------------------------
// This section adds the Lego INVENTORY_PARTS table to the Woody Schema

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_INVENTORY_PARTS (
	INVENTORY_ID NUMBER(38,0),
	PART_NUM VARCHAR(15),
	COLOR_ID NUMBER(38,0),
	QUANTITY NUMBER(38,0),
	IS_SPARE VARCHAR(1)
);
---------------------------------------------------------------------------------------------------------------
// CHECKING LENGTH OF LEGO_INVENTORY_SETS TABLE
SELECT MAX(LENGTH(SET_NUM))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_INVENTORY_SETS;
---------------------------------------------------------------------------------------------------------------
// ADDING INVENTORY_SETS TABLE

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_INVENTORY_SETS (
	INVENTORY_ID NUMBER(38,0),
	SET_NUM VARCHAR(16),
	QUANTITY NUMBER(38,0)
);
---------------------------------------------------------------------------------------------------------------
// CHECKING THE LENGTH OF LEGO_PARTS TABLE
SELECT MAX(LENGTH(PART_NUM))
    ,MAX(LENGTH(NAME))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PARTS;
---------------------------------------------------------------------------------------------------------------
// ADDING LEGO_PARTS TABLE

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_PARTS (
	PART_NUM VARCHAR(15),
	NAME VARCHAR(253),
	PART_CAT_ID NUMBER(38,0)
);
---------------------------------------------------------------------------------------------------------------
// CHECKING LENGTH OF LEGO_PARTS_CATEGORIES TABLE
SELECT MAX(LENGTH(NAME))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PART_CATEGORIES;
---------------------------------------------------------------------------------------------------------------
// ADDING LEGO_PARTS_CATEGORIES TABLE

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_PART_CATEGORIES (
	ID NUMBER(38,0),
	NAME VARCHAR(44)
);
---------------------------------------------------------------------------------------------------------------
// CHECKING LENGTH OF LEGO_SETS TABLE
SELECT MAX(LENGTH(SET_NUM))
    ,MAX(LENGTH(NAME))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_SETS;
---------------------------------------------------------------------------------------------------------------
// ADDING LEGO_SETS TABLE

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_SETS (
	SET_NUM VARCHAR(16),
	NAME VARCHAR(95),
	YEAR NUMBER(38,0),
	THEME_ID NUMBER(38,0),
	NUM_PARTS NUMBER(38,0)
);
---------------------------------------------------------------------------------------------------------------
// CHECKING LENGTH OF LEGO_THEMES TABLE
SELECT MAX(LENGTH(NAME))

FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_SETS;
---------------------------------------------------------------------------------------------------------------
// ADDING LEGO_THEMES TABLE

create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_THEMES (
	ID NUMBER(38,0),
	NAME VARCHAR(95),
	PARENT_ID NUMBER(38,0)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// THE STEPS ABOVE ARE CHECKING THE LENGTHS OF THE FIELDS OF THE TABLES WE ARE ADDING TO THE SCHEMA AND THEN THEY ARE ADDING THE TABLES TO WOODYS SCHEMA.

// NOW WE MUST ADD DATA TO THESE FIELDS

// LEGO_COLOUR

INSERT INTO WOODY_SCHEMA.LEGO_COLORS
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_COLORS;

// LEGO_INVENTORIES

INSERT INTO WOODY_SCHEMA.LEGO_INVENTORIES
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_INVENTORIES;

// LEGO_INVENTORY_PARTS

INSERT INTO WOODY_SCHEMA.LEGO_INVENTORY_PARTS
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_INVENTORY_PARTS;

// LEGO_INVENTORY_SETS

INSERT INTO WOODY_SCHEMA.LEGO_INVENTORY_SETS
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_INVENTORY_SETS;

// LEGO_PARTS

INSERT INTO WOODY_SCHEMA.LEGO_PARTS
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PARTS;

// LEGO_PART_CATEGORIES

INSERT INTO WOODY_SCHEMA.LEGO_PART_CATEGORIES
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PART_CATEGORIES;

// LEGO_SETS

INSERT INTO WOODY_SCHEMA.LEGO_SETS
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_SETS;

// LEGO_THEMES

INSERT INTO WOODY_SCHEMA.LEGO_THEMES
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_THEMES;

// DONE, ALL TABLES NOW HAVE DATA INSERTTED INTO THEM

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// NOW WE NEED TO SET THE PRIMARY AND FOREIGN KEYS IN THE TABLES

-- Setting Primary Keys
ALTER TABLE LEGO_COLORS ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_INVENTORIES ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_PARTS ADD PRIMARY KEY (PART_NUM);
ALTER TABLE LEGO_PART_CATEGORIES ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_SETS ADD PRIMARY KEY (SET_NUM);
ALTER TABLE LEGO_THEMES ADD PRIMARY KEY (ID);

-- Add foreign keys
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (INVENTORY_ID) REFERENCES LEGO_INVENTORIES(ID);
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (PART_NUM) REFERENCES LEGO_PARTS(PART_NUM);
ALTER TABLE LEGO_INVENTORY_PARTS ADD FOREIGN KEY (COLOR_ID) REFERENCES LEGO_COLORS(ID);

ALTER TABLE LEGO_PARTS ADD FOREIGN KEY (PART_CAT_ID) REFERENCES LEGO_PART_CATEGORIES(ID);

ALTER TABLE LEGO_INVENTORY_SETS ADD FOREIGN KEY (INVENTORY_ID) REFERENCES LEGO_INVENTORIES(ID);
ALTER TABLE LEGO_INVENTORY_SETS ADD FOREIGN KEY (SET_NUM) REFERENCES LEGO_SETS(SET_NUM);

ALTER TABLE LEGO_SETS ADD FOREIGN KEY (THEME_ID) REFERENCES LEGO_THEMES(ID);

ALTER TABLE LEGO_INVENTORIES ADD FOREIGN KEY (SET_NUM) REFERENCES LEGO_SETS(SET_NUM);



