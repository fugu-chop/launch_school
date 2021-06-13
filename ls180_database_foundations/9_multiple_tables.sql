/*
1) Make sure you are connected to the `encyclopedia` database. We want to hold the `continent` data in a separate table from the `country` data.
- Create a `continents` table with an auto-incrementing `id` column (set as the Primary Key), and a `continent_name` column which can hold the same data as the `continent` column from the `countries` table.
- Remove the `continent` column from the `countries` table.
- Add a `continent_id` column to the `countries` table of type `integer`.
- Add a Foreign Key constraint to the `continent_id` column which references the `id` field of the `continents` table.
*/
CREATE TABLE continents (
  id serial PRIMARY KEY,
  continent_name varchar(25) NOT NULL
);

ALTER TABLE country
DROP COLUMN continent;

ALTER TABLE country
ADD COLUMN continent_id integer NOT NULL;

ALTER TABLE country
ADD FOREIGN KEY (continent_id) REFERENCES continents (id);

-- 2) Write statements to add data to the `countries` and `continents` tables so that the data is correctly represented across the two tables. Add both the `countries` and the `continents` to their respective tables in alphabetical order.
INSERT INTO continent (continent_name)
VALUES ('Africa'), ('Asia'), ('Europe'), ('North America'), ('South America');

INSERT INTO country (name, capital, population, continent_id)
VALUES ('Brazil', 'Brasilia', 208385000, 5),
('Egypt', 'Cairo', 96308900, 1),
('France', 'Paris', 67158000, 3),
('Germany', 'Berlin', 82349400, 3),
('Japan', 'Tokyo', 126672000, 2),
('USA', 'Washington D.C.', 325365189, 4);

-- 3) We want to create an `albums` table to hold data except the singer name, and create a reference from the `albums` table to the `singers` table to link each album to the correct singer. Write the necessary SQL statements to do this and to populate the table with data. Assume Album Name, Genre, and Label can hold strings up to 100 characters. Include an auto-incrementing `id` column in the `albums` table.
ALTER TABLE singers
ADD CONSTRAINT unique_id UNIQUE (id);

CREATE TABLE albums (
  id serial PRIMARY KEY,
  album_name varchar(100), 	
  released date,
  genre varchar(100),
  label varchar(100),
  singer_id integer,
  FOREIGN KEY (singer_id) REFERENCES singers (id)
);

INSERT INTO albums (album_name, released, genre, label, singer_id)
VALUES ('Born to Run', '1975-08-25', 'Rock and roll', 'Columbia', 1),
('Purple Rain', '1984-06-25', 'Pop, R&B, Rock', 'Warner Bros', 6),
('Born in the USA', '1984-06-04', 'Rock and roll, pop', 'Columbia', 1),
('Madonna', '1983-07-27', 'Dance-pop, post-disco', 'Warner Bros', 5),
('True Blue', '1986-06-30', 'Dance-pop, Pop', 'Warner Bros', 5),
('Elvis', '1956-10-19', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 7),
('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 7);

-- 4) Normalise the `ls_burger` `orders` table. First of all create a `customers` table to hold the customer name data and an `email_addresses` table to hold the customer email data. Create a one-to-one relationship between them, ensuring that if a customer record is deleted so is the equivalent email address record. Populate the tables with the appropriate data from the current orders table.
CREATE TABLE customers (
  id serial PRIMARY KEY,
  customer_name varchar(100)
);

CREATE TABLE email_addresses (
  customer_id integer PRIMARY KEY,
  customer_email varchar(50),
  FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);

INSERT INTO customers (customer_name)
VALUES ('James Bergman'), ('Natasha O''Shea'), ('Aaron Muller');

INSERT INTO email_addresses (customer_id, customer_email)
VALUES (1, 'james1998@email.com'), (2, 'natasha@osheafamily.com');

-- 5) We want to make our ordering system more flexible, so that customers can order any combination of burgers, sides and drinks. The first step towards doing this is to put all our product data into a separate table called `products`. The table should also have an auto-incrementing `id` column which acts as its PRIMARY KEY. The `product_type` column should hold strings of up to 20 characters. Other than that, the column types should be the same as their equivalent columns from the `orders` table.
CREATE TABLE products (
  id serial PRIMARY KEY,
  product_name varchar(50),
  product_cost numeric(4,2) DEFAULT 0,
  product_type varchar(20),
  product_loyalty_points integer
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
VALUES ('LS Burger', 3.00, 'Burger', 10 ),
('LS Cheeseburger', 3.50, 'Burger', 15 ),
('LS Chicken Burger', 4.50, 'Burger', 20 ),
('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
('Fries', 1.20, 'Side', 3 ),
('Onion Rings', 1.50, 'Side', 5 ),
('Cola', 1.50, 'Drink', 5 ),
('Lemonade', 1.50, 'Drink', 5 ),
('Vanilla Shake', 2.00, 'Drink', 7 ),
('Chocolate Shake', 2.00, 'Drink', 7 ),
('Strawberry Shake', 2.00, 'Drink', 7);

/*
6) To associate customers with products, we need to do two more things:
- Alter or replace the `orders` table so that we can associate a customer with one or more orders (we also want to record an order status in this table).
- Create an `order_items` table so that an order can have one or more products associated with it.

Based on the order descriptions below, amend and create the tables as necessary and populate them with the appropriate data.
- James has one order, consisting of a Chicken Burger, Fries, Onion Rings, and a Lemonade. It has a status of 'In Progress'.
- Natasha has two orders. The first consists of a Cheeseburger, Fries, and a Cola, and has a status of 'Placed'; the second consists of a Double Deluxe Burger, a Cheeseburger, two sets of Fries, Onion Rings, a Chocolate Shake and a Vanilla Shake, and has a status of 'Complete'.
- Aaron has one order, consisting of an LS Burger and Fries. It has a status of 'Placed'.

Assume that the `order_status` field of the orders table can hold strings of up to 20 characters.
*/
DROP TABLE orders;

CREATE TABLE orders (
  id serial PRIMARY KEY,
  customer_id integer,
  order_status varchar(20),
  FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);

CREATE TABLE order_items (
  id serial PRIMARY KEY,
  order_id integer NOT NULL,
  product_id integer NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

INSERT INTO orders (customer_id, order_status)
VALUES (1, 'In Progress'),
(2, 'Placed'),
(2, 'Complete'),
(3, 'Placed');

INSERT INTO order_items (order_id, product_id)
VALUES (1, 3),
(1, 5),
(1, 6),
(1, 8),
(2, 2),
(2, 5),
(2, 7),
(3, 4),
(3, 2),
(3, 5),
(3, 5),
(3, 6),
(3, 10),
(3, 9),
(4, 1),
(4, 5);
```
