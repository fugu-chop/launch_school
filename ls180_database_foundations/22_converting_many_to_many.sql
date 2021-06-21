-- 1) Import the data
/*
dropdb films

createdb films

psql -d films < films7.sql
*/
-- 2) Write the SQL statement needed to create a join table that will allow a film to have multiple directors, and directors to have multiple films. Include an id column in this table, and add foreign key constraints to the other columns.
-- The convention for naming tables in SQL is to use alphabetical order when the table name consists of more than one word.
CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id integer NOT NULL REFERENCES directors (id),
  film_id integer NOT NULL REFERENCES films (id)
);

-- 3) Write the SQL statements needed to insert data into the new join table to represent the existing one-to-many relationships.
INSERT INTO directors_films (film_id, director_id)
VALUES (1, 1),
(2, 2),
(3, 3), 
(4, 4), 
(5, 5), 
(6, 6), 
(7, 3), 
(8, 7), 
(9, 8), 
(10, 4);

-- 4) Write a SQL statement to remove any unneeded columns from films.
ALTER TABLE films
DROP COLUMN director_id;

-- 5) Write a SQL statement that will return the following result:
/*
           title           |         name
---------------------------+----------------------
 12 Angry Men              | Sidney Lumet
 1984                      | Michael Anderson
 Casablanca                | Michael Curtiz
 Die Hard                  | John McTiernan
 Let the Right One In      | Michael Anderson
 The Birdcage              | Mike Nichols
 The Conversation          | Francis Ford Coppola
 The Godfather             | Francis Ford Coppola
 Tinker Tailor Soldier Spy | Tomas Alfredson
 Wayne's World             | Penelope Spheeris
(10 rows)
*/
SELECT f.title 
     , d.name
FROM films AS f
JOIN directors_films AS df
  ON f.id = df.film_id
JOIN directors AS d
  ON d.id = df.director_id
ORDER BY f.title
;

-- 6) Write SQL statements to insert data for the following films into the database:
/*
Film 	Year 	Genre 	Duration 	Directors
Fargo 	1996 	comedy 	98 	Joel Coen
No Country for Old Men 	2007 	western 	122 	Joel Coen, Ethan Coen
Sin City 	2005 	crime 	124 	Frank Miller, Robert Rodriguez
Spy Kids 	2001 	scifi 	88 	Robert Rodriguez
*/
INSERT INTO films (title, year, genre, duration)
VALUES ('Fargo', 1996, 'comedy', 98),
('No Country for Old Men', 2007, 'western', 122),
('Sin City', 2005, 'crime', 124),
('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name)
VALUES ('Joel Cohen'),
('Ethan Coen'),
('Frank Miller'),
('Robert Rodriguez');

INSERT INTO directors_films (film_id, director_id)
VALUES (11, 9),
(12, 9),
(12, 10),
(13, 11),
(13, 12),
(14, 12);

-- 7) Write a SQL statement that determines how many films each director in the database has directed. Sort the results by number of films (greatest first) and then name (in alphabetical order).
SELECT d.name AS director
     , COUNT(DISTINCT film_id) AS films
FROM directors AS d
JOIN director_films AS df
  ON d.id = df.director_id
ORDER BY films DESC, director
;
