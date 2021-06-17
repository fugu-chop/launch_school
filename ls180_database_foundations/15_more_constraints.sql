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
-- There is a section at the bottom of the output, 'Index', which show the constraints on a table.

-- 6) Write a SQL statement to remove the constraint added in #4.
ALTER TABLE films
DROP CONSTRAINT unique_title;