-- Import the relevant file
/*
createdb books

psql books < many_to_may.sql
*/
-- 1) Write a SQL statement that will return the following:
/*
 id |     author      |           categories
----+-----------------+--------------------------------
  1 | Charles Dickens | Fiction, Classics
  2 | J. K. Rowling   | Fiction, Fantasy
  3 | Walter Isaacson | Nonfiction, Biography, Physics
(3 rows)
*/
SELECT b.id, 
       b.author, 
       STRING_AGG(c.categories, ', ') AS categories
  FROM books AS b
    INNER JOIN books_categories AS bc
      ON b.id = bc.book_id
    INNER JOIN categories AS c
      ON bc.category_id = c.id
  GROUP BY b.author
  ORDER BY b.id
;
-- 2) Write SQL statements to insert the following new books into the database. What do you need to do to ensure this data fits in the database?
/*
Author 	Title 	Categories
Lynn Sherr 	Sally Ride: America's First Woman in Space 	Biography, Nonfiction, Space Exploration
Charlotte Brontë 	Jane Eyre 	Fiction, Classics
Meeru Dhalwala and Vikram Vij 	Vij's: Elegant and Inspired Indian Cuisine 	Cookbook, Nonfiction, South Asia
*/
-- We need to change the column type of title, as the column currently only supports up to 32 characters.
ALTER TABLE books 
ALTER COLUMN title TYPE text;

INSERT INTO books (title, author) 
VALUES ('Sally Ride: America''s First Woman in Space', 'Lynn Sherr'),
('Jane Eyre', 'Charlotte Brontë'),
('Vij''s: Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala and Vikram Vij');

INSERT INTO categories (name)
VALUES ('Space Exploration'),
('Cookbook'),
('South Asia');

INSERT INTO books_categories
VALUES (4, 1),
(4, 5),
(4, 7),
(5, 2), 
(5, 4),
(6, 1),
(6, 8),
(6, 9);

-- 3) Write a SQL statement to add a uniqueness constraint on the combination of columns book_id and category_id of the books_categories table. This constraint should be a table constraint; so, it should check for uniqueness on the combination of book_id and category_id across all rows of the books_categories table.
ALTER TABLE books_categories
ADD CONSTRAINT unique_id_combo UNIQUE (book_id, category_id);

-- 4) Write a SQL statement that will return the following result:
/*
      name        | book_count |                                 book_titles
------------------+------------+-----------------------------------------------------------------------------
Biography         |          2 | Einstein: His Life and Universe, Sally Ride: America's First Woman in Space
Classics          |          2 | A Tale of Two Cities, Jane Eyre
Cookbook          |          1 | Vij's: Elegant and Inspired Indian Cuisine
Fantasy           |          1 | Harry Potter
Fiction           |          3 | Jane Eyre, Harry Potter, A Tale of Two Cities
Nonfiction        |          3 | Sally Ride: America's First Woman in Space, Einstein: His Life and Universe, Vij's: Elegant and Inspired Indian Cuisine
Physics           |          1 | Einstein: His Life and Universe
South Asia        |          1 | Vij's: Elegant and Inspired Indian Cuisine
Space Exploration |          1 | Sally Ride: America's First Woman in Space
*/
SELECT c.name
     , COUNT(DISTINCT bc.book_id) AS book_count
     , STRING_AGG(b.title, ', ') AS book_titles
FROM categories AS c
JOIN books_categories AS bc
  ON c.id = bc.category_id
JOIN books AS b
  ON b.id = bc.book_id
GROUP BY c.name
ORDER BY c.name;
