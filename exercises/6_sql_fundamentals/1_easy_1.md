1) Create a new database called `animals`.
```sql
CREATE DATABASE animals;
```
2) Make a table called `birds`. It should have the following fields:
- id (a primary key)
- name (string with space for up to 25 characters)
- age (integer)
- species (a string with room for no more than 15 characters)

```sql
CREATE TABLE birds (
  id SERIAL PRIMARY KEY,
  name varchar(25),
  age integer,
  species varchar(15)
);
```
3)  Add five records to this database so that our data looks like:

```
 id |   name   | age | species
----+----------+-----+---------
  1 | Charlie  |   3 | Finch
  2 | Allie    |   5 | Owl
  3 | Jennifer |   3 | Magpie
  4 | Jamie    |   4 | Owl
  5 | Roy      |   8 | Crow
(5 rows)
```

```sql
INSERT INTO birds (name, age, species)
VALUES ('Charlie', 3, 'Finch'),
('Allie', 5, 'Owl'),
('Jennifer', 3, 'Magpie'),
('Jamie', 4, 'Owl'),
('Roy', 8, 'Crow');
```
There is also the option to not specify the columns in the `INSERT INTO` syntax if we're populating values for each column, in the order that the columsn appear in the table.

4) Write an SQL statement to query all data that is currently in our `birds` table.
```sql
SELECT * 
FROM birds;
```
5) Using a `WHERE` clause, `SELECT` records for birds under the age of 5.
```sql
SELECT * 
FROM birds
WHERE age < 5;
```
6) Update the `birds` table so that a row with a species of 'Crow' now reads 'Raven'.
```sql
UPDATE birds 
SET species = 'Raven'
WHERE species = 'Crow';
```
6b) Jamie isn't an Owl - he's a Hawk. Correct his information.
```sql
UPDATE birds
SET species = 'Hawk'
WHERE name = 'Jamie' 
AND species = 'Owl';
```
7) Write an SQL statement that deletes the record that describes a 3 year-old finch.
```sql
DELETE FROM birds
WHERE species = 'Finch'
AND age = 3;
```
8) For this exercise, write some code that ensures that only birds with a positive age may be added to the database. Then write and execute an SQL statement to check that this new constraint works correctly.
```sql
ALTER TABLE birds
ADD CONSTRAINT positive_age CHECK (age > 0);

SELECT *
FROM birds
WHERE age < 0;

INSERT INTO birds (age, name, species)
VALUES (-2, 'Alan', 'Blue Jay');
```
9) Write an SQL statement that will drop the `birds` table and all its data from the `animals` database.
```sql
DROP TABLE birds;
```
10) Write a SQL statement or PostgreSQL command to drop the `animals` database.
```sql
DROP DATABASE animals;
```
