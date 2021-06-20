-- 1) Import the relevant file into a new database
/*
createdb foreign_keys
psql -d foreign_keys < orders_products.sql
*/

-- 2) Update the orders table so that referential integrity will be preserved for the data between orders and products.
ALTER TABLE orders
ADD CONSTRAINT product_id_fkey FOREIGN KEY (product_id) REFERENCES products (id); 

-- 3) Use psql to insert the data shown in the following table into the database:
/*
Quantity 	Product
10 	small bolt
25 	small bolt
15 	large bolt
*/
INSERT INTO products (name)
VALUES ('small bolt'),
('large bolt');

INSERT INTO orders (quantity, product_id)
VALUES (10, 1),
(25, 1),
(15, 2);

-- 4) Write a SQL statement that returns a result like this:
/*
 quantity |    name
----------+------------
       10 | small bolt
       25 | small bolt
       15 | large bolt
(3 rows)
*/
SELECT o.quantity, p.name
  FROM orders AS o 
  INNER JOIN products AS p 
    ON o.product_id = p.id;

-- 5) Can you insert a row into orders without a product_id? Write a SQL statement to prove your answer.
-- Yes, as there is no NOT NULL constraint on the product_id column.
INSERT INTO orders (quantity)
VALUES (65);

-- 6) Write a SQL statement that will prevent NULL values from being stored in orders.product_id. What happens if you execute that statement?
ALTER TABLE orders
ALTER COLUMN product_id SET NOT NULL;
-- We will get an ERROR:  column "product_id" of relation "orders" contains null values, as there is already an entry in the table with no product_id

-- 7) Make any changes needed to avoid the error message encountered in #6.
DELETE FROM orders 
WHERE product_id IS NULL;

ALTER TABLE orders
ALTER COLUMN product_id SET NOT NULL;

-- 8) Create a new table called reviews to store the data shown below. This table should include a primary key and a reference to the products table.
CREATE TABLE reviews (
  id serial PRIMARY KEY,
  product_id integer REFERENCES products (id),
  review text NOT NULL
);

-- 9) Write SQL statements to insert the data shown in the table in #8.
INSERT INTO reviews (product_id, review)
VALUES (1, 'a little small'),
(1, 'very round!'),
(2, 'could have been smaller');

-- 10) A foreign key constraint prevents NULL values from being stored in a column.
-- Foreign key columns allow NULL values. As a result, it is often necessary to use NOT NULL and a foreign key constraint together.
