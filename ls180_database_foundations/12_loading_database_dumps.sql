/*
1) Load the linked file into your database

createdb films
psql -d films < films.sql
*/
-- 2) Write a SQL statement that returns all rows in the films table.
SELECT * FROM films;

-- 3) Write a SQL statement that returns all rows in the films table with a title shorter than 12 letters.
SELECT * FROM films WHERE LENGTH(title) < 12;

-- 4) Write the SQL statements needed to add two additional columns to the films table: director, which will hold a director's full name, and duration, which will hold the length of the film in minutes.
ALTER TABLE films
ADD COLUMN director varchar(255);

ALTER TABLE films
ADD COLUMN duration integer;

-- 5) Write SQL statements to update the existing rows in the database with values for the new columns:
UPDATE films SET director = 'John McTiernan', duration = 132 WHERE title = 'Die Hard';
UPDATE films SET director = 'Michael Curtiz', duration = 102 WHERE title = 'Casablanca';
UPDATE films SET director = 'Francis Ford Coppola', duration = 113 WHERE title = 'The Conversation';

-- 6) Write SQL statements to insert data into the films table;
INSERT INTO films (title, "year", genre, director, duration)
VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

-- 7) Write a SQL statement that will return the title and age in years of each movie, with newest movies listed first:
SELECT title, EXTRACT("year" FROM current_date) - "year" AS age FROM films ORDER BY age;

-- 8) Write a SQL statement that will return the title and duration of each movie longer than two hours, with the longest movies first.
SELECT title, duration FROM films WHERE duration > 120 ORDER BY duration DESC;

-- 9) Write a SQL statement that returns the title of the longest film.
SELECT title FROM films ORDER BY duration DESC LIMIT 1;
