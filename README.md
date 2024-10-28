# SQL-LEGO-Schema-Creation-Project 🧱
The SQL Code within this repository was used to create a schema using LEGO Data in Snowflake.

## Tasks 📃
- Schema setup
  - create schema
  - create tables
  - insert data
  - set primary and foreign key
  - create ER diagram

- Analysis 
  - find unique parts
  - analyse sets
  - create view
  - download data
  - Visualise data

## Outcomes 🕵️‍♂️

### Schema Setup

ER Diagram:
![TIL_PORTFOLIO_PROJECTS - TIL_PORTFOLIO_PROJECTS - WOODY_SCHEMA](https://github.com/user-attachments/assets/1d31791f-f524-4324-8fae-e159234c2289)



### Analysis

## Learnings 🧠

- Creating a schema
````sql
CREATE OR REPLACE SCHEMA TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA;
````
- Creat or replace a table
````sql
create or replace TABLE TIL_PORTFOLIO_PROJECTS.WOODY_SCHEMA.LEGO_COLORS (
	ID NUMBER(38,0),
	NAME VARCHAR(28),
	RGB VARCHAR(6),
	IS_TRANS VARCHAR(1)
);
````
- Inserting data into a table
````sql
INSERT INTO WOODY_SCHEMA.LEGO_COLORS
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_COLORS;
````
- Assigning foreign and primary keys
````sql
ALTER TABLE LEGO_THEMES ADD PRIMARY KEY (ID);
ALTER TABLE LEGO_SETS ADD FOREIGN KEY (THEME_ID) REFERENCES LEGO_THEMES(ID);
````
