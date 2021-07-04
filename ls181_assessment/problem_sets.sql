-- 3_view_and_alter
-- 4_alter_tables
-- 5_adding_data
-- 8_updating_data
-- 9_multiple_tables
-- 13_more_single_table_queries
-- 15_more_constraints
-- 16_keys
-- 19_foreign_keys
-- 20_one_to_many
-- 21_many_to_many
-- 22_converting_many_to_many

-- 3_view_and_alter
CREATE DATABASE encyclopedia
-- \c encyclopedia

CREATE TABLE countries (
  id SERIAL,
  name VARCHAR(50) UNIQUE NOT NULL,
  capital VARCHAR(50) NOT NULL,
  population INTEGER
);

CREATE TABLE famous_people (
  id SERIAL,
  name VARCHAR(50) NOT NULL,
  occupation VARCHAR(150),
  date_of_birth VARCHAR(50),
  deceased BOOLEAN DEFAULT false
);

CREATE TABLE animals (
  id SERIAL,
  name VARCHAR(100) NOT NULL,
  binomial_name VARCHAR(100) NOT NULL,
  max_weight_kg DECIMAL(8,3),
  max_age_years INTEGER,
  conservation_status CHAR(2)
);

-- \dt
-- \d animals
-- \c ls_burger

CREATE TABLE orders (
  id SERIAL,
  customer_name VARCHAR(100) NOT NULL,
  burger VARCHAR(50),
  side VARCHAR(50),
  drink VARCHAR(50),
  order_total DECIMAL(4,2) NOT NULL
);

-- 4_alter_tables
ALTER TABLE famous_people
  RENAME TO celebrities;

ALTER TABLE celebrities
  RENAME COLUMN name TO first_name;

-- Different types of ALTER TABLE commands can't be chained
ALTER TABLE celebrities
  ALTER COLUMN name TYPE VARCHAR(80);

ALTER TABLE celebrities
  ADD COLUMN last_name varchar(100) NOT NULL;

ALTER TABLE celebrities
  ALTER COLUMN date_of_birth TYPE DATE
  USING date_of_birth::date,
  ALTER COLUMN date_of_birth SET NOT NULL;

ALTER TABLE animals
  ALTER COLUMN max_weight_kg TYPE DECIMAL(10, 4);

ALTER TABLE animals
  ADD UNIQUE(binomial_name);

-- \c ls_burger
ALTER TABLE orders
  ADD COLUMN customer_email VARCHAR(50),
  ADD COLUMN customer_loyalty_points INTEGER DEFAULT 0;

ALTER TABLE orders
  ADD COLUMN burger_cost DECIMAL(4,2) DEFAULT 0,
  ADD COLUMN side_cost DECIMAL(4,2) DEFAULT 0,
  ADD COLUMN drink_cost DECIMAL(4,2) DEFAULT 0;

ALTER TABLE orders
  DROP COLUMN order_total;

-- 5_adding_data
-- \c encyclopedia
INSERT INTO countries (name, capital, population)
  VALUES ('France', 'Paris', 67158000),
  ('USA', 'Washington D.C.', 325365189),
  ('Germany', 'Berlin', 82349400),
  ('Japan', 'Tokyo', 126672000);

INSERT INTO celebrities (first_name, occupation, deceased, last_name, date_of_birth)
  VALUES ('Bruce', 'Singer and songwriter', false, 'Springsteen', '1949-09-23'),
  ('Scarlett', 'Actress', DEFAULT, 'Johansson', '1984-11-22'),
  ('Frank', 'Singer, Actor', true, 'Sinatra', '1915-12-12'),
  ('Tom', 'Actor', DEFAULT, 'Cruise', '1962-07-03');

ALTER TABLE animals
  DROP CONSTRAINT animals_binomial_name_key;

INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
  VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
  ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
  ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
  ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
  ('Kakapo', 'Strigops habroptila', 4, 60,'CR');

-- \c ls_burger
INSERT INTO orders (customer_name, customer_email, customer_loyalty_points, burger, side, drink, burger_cost, side_cost, drink_cost)
  VALUES ('James Bergman', 'james1998@email.com', 28, 'LS Chicken Burger', 'Fries', 'Cola', 4.50, 0.99, 1.50),
  ('Natasha O''Shea', 'natasha@osheafamily.com', 18, 'LS Cheeseburger', 'Fries', NULL, 3.50, 0.99, DEFAULT),
  ('Natasha O''Shea', 'natasha@osheafamily.com', 42, 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 6.00, 1.50, 2.00),
  ('Aaron Muller', NULL, 10, 'LS Burger', NULL, NULL, 3.00, DEFAULT, DEFAULT);

-- 8_updating_data
-- \c encyclopedia
ALTER TABLE animals
  ADD COLUMN class VARCHAR(100);

UPDATE animals SET class = 'Aves';

ALTER TABLE animals
  ADD COLUMN phylum VARCHAR(100),
  ADD COLUMN kingdom VARCHAR(100);

UPDATE animals 
  SET phylum = 'Chordata';

-- Cannot chain SET commands here since the criteria is different
UPDATE animals
  SET kingdom = 'Animalia';

ALTER TABLE countries
  ADD COLUMN continent VARCHAR(50);

UPDATE countries SET continent = 'Europe'
  WHERE name IN ('France', 'Germany');

UPDATE countries SET continent = 'Asia'
  WHERE name = 'Japan';

UPDATE countries SET continent = 'North America'
  WHERE name = 'USA';

UPDATE celebrities SET deceased = true
  WHERE first_name = 'Elvis';

ALTER TABLE celebrities
  ALTER COLUMN deceased SET NOT NULL;

DELETE FROM celebrities
  WHERE first_name = 'Tom' AND last_name = 'Cruise';

ALTER TABLE celebrities
  RENAME TO singers;

DELETE FROM celebrities
  WHERE occupation NOT LIKE '%Singer%';

DELETE FROM countries;

-- \c ls_burger

-- Can chain SET statements in one if the criteria is the same
UPDATE orders 
  SET drink = 'Lemonade', 
  side = 'Fries',
  side_cost = 0.99,
  customer_loyalty_points = 100
  WHERE name = 'James Bergman';

UPDATE orders SET side_cost = 1.20
WHERE side = 'Fries';

-- 9_multiple_tables
-- \c encyclopedia
CREATE TABLE continents (
  id SERIAL PRIMARY KEY,
  continent_name VARCHAR(50) NOT NULL
);

ALTER TABLE countries
  DROP COLUMN continent,
  ADD COLUMN continent_id INTEGER REFERENCES continents (id);

INSERT INTO continents (continent_name)
  VALUES ('Europe'),
  ('North America'),
  ('Asia'),
  ('Africa'),
  ('South America');

INSERT INTO countries (name, capital, population, continent_id)
  VALUES('Egypt', 'Cairo', 96308900, 4),
  ('Brazil', 'Brasilia', 208385500, 5); 

UPDATE countries SET continent_id = 1
  WHERE name IN ('France', 'Germany');

UPDATE countries SET continent_id = 2
  WHERE name= 'USA';

UPDATE countries SET continent_id = 3
  WHERE name = 'Japan';

-- \c encyclopedia

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  album_name VARCHAR(100),
  released DATE,
  genre VARCHAR(100),
  label VARCHAR(100),
  artist_id INTEGER NOT NULL REFERENCES singers (id)
);

-- \c ls_burger

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE email_addresses (
  customer_id SERIAL PRIMARY KEY REFERENCES customers (id) ON DELETE CASCADE,
  customer_email VARCHAR(100)
);

INSERT INTO customers (customer_name)
  VALUES ('James Bergman'),
  ('Natasha O''Shea'),
  ('Aaron Muller');

INSERT INTO email_addresses (customer_id, customer_email)
  VALUES (1, 'james1998@email.com'),
  (2, 'natasha@osheafamily.com');

CREATE TYPE product_classes AS ENUM('Burger', 'Drink', 'Side');

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  product_name VARCHAR(20) NOT NULL UNIQUE,
  product_cost NUMERIC(4,2) NOT NULL DEFAULT 0,
  product_type PRODUCT_CLASSES NOT NULL,
  product_loyalty_points INTEGER NOT NULL DEFAULT 0
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
  VALUES ('LS Burger', 3.00, 'Burger', 10),
  ('LS Cheeseburger', 3.50, 'Burger', 15),
  ('LS Chicken Burger', 4.50, 'Burger', 20),
  ('LS Double Deluxe Burger', 6.00, 'Burger', 30),
  ('Fries', 1.20, 'Side', 3),
  ('Onion Rings', 1.50, 'Side', 5),
  ('Cola', 1.50, 'Drink', 5),
  ('Lemonade', 1.50, 'Drink', 5),
  ('Vanilla Shake', 2.00, 'Drink', 7),
  ('Chocolate Shake', 2.00, 'Drink', 7),
  ('Strawberry Shake', 2.00, 'Drink', 7);

DROP TABLE orders;

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers (id) ON DELETE CASCADE,
  order_status VARCHAR(20) NOT NULL
);

CREATE TABLE order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
  product_id INTEGER NOT NULL REFERENCES products (id) ON DELETE CASCADE
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

-- 11_working_with_a_single_table
-- createdb residents
-- psql -d residents < /Users/dean/Documents/launch_school/ls180_database_foundations/residents_with_data.sql
-- psql -d residents

SELECT state,
      COUNT(DISTINCT id)
FROM people
GROUP BY state
ORDER BY count DESC
LIMIT 10;

SELECT SUBSTR(email, STRPOS(email, '@')) AS domain,
       COUNT(DISTINCT id) AS count
FROM people
GROUP BY domain
ORDER BY count DESC
LIMIT 10;
