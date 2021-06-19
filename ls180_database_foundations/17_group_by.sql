-- 1) Import the working file.
/*
-- The SQL file specifies what table to create; the -d flag specifies which database to use
psql -d films < films4.sql
*/

-- 2) Write SQL statements that will insert the following films into the database:
/*
title 	year 	genre 	director 	duration
Wayne's World 	1992 	comedy 	Penelope Spheeris 	95
Bourne Identity 	2002 	espionage 	Doug Liman 	118
*/
INSERT INTO films (title, year, genre, director, duration)
VALUES ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
('Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);

-- 3) Write a SQL query that lists all genres for which there is a movie in the films table.
SELECT DISTINCT genre FROM films;

-- 4) Write a SQL query that returns the same results as the answer for #3, but without using DISTINCT.
SELECT genre FROM FILMS GROUP BY genre;

-- 5) Write a SQL query that determines the average duration across all the movies in the films table, rounded to the nearest minute.
SELECT ROUND(AVG(duration), 0) AS avg_duration FROM films;

-- 6) Write a SQL query that determines the average duration for each genre in the films table, rounded to the nearest minute.
SELECT genre, ROUND(AVG(duration), 0) AS avg_duration FROM films GROUP BY genre;

-- 7) Write a SQL query that determines the average duration of movies for each decade represented in the films table, rounded to the nearest minute and listed in chronological order.
SELECT year / 10 * 10 as decade, ROUND(AVG(duration)) as average_duration
FROM films GROUP BY decade ORDER BY decade;

-- 8) Write a SQL query that finds all films whose director has the first name John.
SELECT * FROM films WHERE director LIKE 'John %';

-- 9) Write a SQL query that will return the following data:
/*
   genre   | count
-----------+-------
 scifi     |     5
 comedy    |     4
 drama     |     2
 espionage |     2
 crime     |     1
 thriller  |     1
 horror    |     1
 action    |     1
(8 rows)
*/
SELECT genre, COUNT(id) FROM films GROUP BY genre ORDER BY COUNT(id) DESC;

-- 10) Write a SQL query that will return the following data:
/*
 decade |   genre   |                  films
--------+-----------+------------------------------------------
   1940 | drama     | Casablanca
   1950 | drama     | 12 Angry Men
   1950 | scifi     | 1984
   1970 | crime     | The Godfather
   1970 | thriller  | The Conversation
   1980 | action    | Die Hard
   1980 | comedy    | Hairspray
   1990 | comedy    | Home Alone, The Birdcage, Wayne's World
   1990 | scifi     | Godzilla
   2000 | espionage | Bourne Identity
   2000 | horror    | 28 Days Later
   2010 | espionage | Tinker Tailor Soldier Spy
   2010 | scifi     | Midnight Special, Interstellar, Godzilla
(13 rows)
*/
SELECT year / 10 * 10 AS decade, genre, string_agg(title, ', ') AS films 
  FROM films GROUP BY decade, genre ORDER BY decade, genre, films;

-- 11) Write a SQL query that will return the following data:
/*
   genre   | total_duration
-----------+----------------
 horror    |            113
 thriller  |            113
 action    |            132
 crime     |            175
 drama     |            198
 espionage |            245
 comedy    |            407
 scifi     |            632
(8 rows)
*/
SELECT genre, SUM(duration) AS total_duration FROM films GROUP BY genre ORDER BY total_duration;
