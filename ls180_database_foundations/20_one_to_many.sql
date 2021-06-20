-- 1)  Write a SQL statement to add data to the database
INSERT INTO calls ("when", duration, contact_id)
VALUES('2016-01-18 14:47:00',	632, 6);

-- 2) Write a SQL statement to retrieve the call times, duration, and first name for all calls not made to William Swift.
SELECT ca.when, 
       ca.duration,
       co.first_name
  FROM calls AS ca
  INNER JOIN contacts AS co
    ON ca.contact_id = co.id
  WHERE co.first_name != 'William'
    AND co.last_name != 'Swift'

-- 3) Write SQL statements to add call data to the database:
INSERT INTO calls ("when", duration, contact_id)
VALUES('2016-01-17 11:52:00', 175, 26),
('2016-01-18 21:22:00', 79, 27);

INSERT INTO contacts (first_name, last_name, number)
VALUES('Merve', 'Elk', 6343511126),
('Sawa', 'Fyodorov', 6125594874);

-- 4) Add a constraint to contacts that prevents a duplicate value being added in the column number.
ALTER TABLE contacts
ADD CONSTRAINT duplicate_num UNIQUE(number);

-- 5) Write a SQL statement that attempts to insert a duplicate number for a new contact but fails. What error is shown?
INSERT INTO contacts (first_name, last_name, number)
VALUES ('Nivi', 'Petrussen', '6125594874');
/*
ERROR:  duplicate key value violates unique constraint "dulicate_num"
DETAIL:  Key (number)=(6125594874) already exists.
*/

-- 6) Why does "when" need to be quoted in many of the queries in this lesson?
-- WHEN is a SQL reserved words. Without escaping the reserved word, SQL will think this is a reference to a SQL function, rather than a column name.