-- 1) Import the films2.sql file into a Postgres database
-- createdb films 
-- psql -d films < films2.sql

-- 2) Modify all of the columns to be NOT NULL.
ALTER TABLE films
ALTER COLUMN title SET NOT NULL;
ALTER TABLE films
ALTER COLUMN year SET NOT NULL;
ALTER TABLE films
ALTER COLUMN genre SET NOT NULL;
ALTER TABLE films
ALTER COLUMN director SET NOT NULL;
ALTER TABLE films
ALTER COLUMN duration SET NOT NULL;

-- 3) How does modifying a column to be NOT NULL affect how it is displayed by \d films?
-- NOT NULL will appear in a column's nullable column.

-- 4) Add a constraint to the table films that ensures that all films have a unique title.
ALTER TABLE films
ADD CONSTRAINT unique_title UNIQUE(title);

-- 5) How is the constraint added in #4 displayed by \d films?
/*
Indexes:
  "title_unique" UNIQUE CONSTRAINT, btree (title)
*/

-- 6) Write a SQL statement to remove the constraint added in #4.
ALTER TABLE films
DROP CONSTRAINT unique_title;

-- 7) Add a constraint to films that requires all rows to have a value for title that is at least 1 character long.
ALTER TABLE films
ADD CONSTRAINT title_length CHECK(LENGTH(title) >= 1);

-- 8) What error is shown if the constraint created in #7 is violated? Write a SQL INSERT statement that demonstrates this.
INSERT INTO films (title)
VALUES ();

-- 9) How is the constraint added in #7 displayed by \d films?
/*
Check constraints:
  "title_length" CHECK (length(title::text) >= 1)
*/

-- 10) Write a SQL statement to remove the constraint added in #7.
ALTER TABLE films
DROP CONSTRAINT title_length;

-- 11) Add a constraint to the table films that ensures that all films have a year between 1900 and 2100.
ALTER TABLE films
ADD CONSTRAINT film_year CHECK(year BETWEEN 1900 AND 2100);

-- 12) How is the constraint added in #11 displayed by \d films?
/*
Check constraints:
  "year_range" CHECK (year >= 1900 AND year <= 2100)
*/

-- 13) Add a constraint to films that requires all rows to have a value for director that is at least 3 characters long and contains at least one space character ().
ALTER TABLE films
ADD CONSTRAINT director_length CHECK(LENGTH(director) >= 3 AND position(' ' IN director) > 0);

-- 14) How does the constraint created in #13 appear in \d films?
/*
Check constraints:
  "director_name" CHECK (length(director::text) >= 3 AND "position"(director::text, ' '::text) > 0)
*/

-- 15) Write an UPDATE statement that attempts to change the director for "Die Hard" to "Johnny". Show the error that occurs when this statement is executed.
UPDATE films SET director = 'Johnny'
WHERE film = 'Die Hard';
/*
ERROR: new row for relation "films" violates check constraint "director_name"
DETAIL: Failing row contains (Die Hard, 1988, action, Johnny, 132).
*/

-- 16) List three ways to use the schema to restrict what values can be stored in a column.
/*
Data type (which can include a length limitation)
NOT NULL Constraint
Check Constraint
*/

-- 17) Is it possible to define a default value for a column that will be considered invalid by a constraint? Create a table that tests this.
-- Yes, by adding a default value first and then setting a constraint that excludes this default value.
ALTER TABLE films
ALTER COLUMN year SET DEFAULT 0;

ALTER TABLE films
ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100);

INSERT INTO films (title) VALUES ('Hello');
/*
ERROR:  new row for relation "films" violates check constraint "year_range"
DETAIL:  Failing row contains (Hello, 0, null, null, null).
*/

-- 18) How can you see a list of all of the constraints on a table?
-- Use \d table_name
