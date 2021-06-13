-- 1) Make sure you are connected to the `encyclopedia` database. Rename the `famous_people` table to `celebrities`.
ALTER TABLE famous_people
RENAME TO celebrities;

-- 2) Change the name of the `name` column in the `celebrities` table to `first_name`, and change its data type to `varchar(80)`.
ALTER TABLE celebrities
RENAME COLUMN name TO first_name;

ALTER TABLE celebrities
ALTER COLUMN first_name TYPE varchar(80);

-- 3) Create a new column in the `celebrities` table called `last_name`. It should be able to hold strings of lengths up to 100 characters. This column should always hold a value.
ALTER TABLE celebrities
ADD COLUMN last_name varchar(100) NOT NULL;

-- 4) Change the `celebrities` table so that the `date_of_birth` column uses a data type that holds an actual date value rather than a string. Also ensure that this column must hold a value.
ALTER TABLE celebrities
ALTER COLUMN date_of_birth TYPE date
USING date_of_birth::date;

ALTER TABLE celebrities
ALTER COLUMN date_of_birth SET NOT NULL;

-- 5) Change the `max_weight_kg` column in the `animals` table so that it can hold values in the range 0.0001kg to 200,000kg
ALTER TABLE animals 
ALTER COLUMN max_weight TYPE decimal(10, 4)

-- 6) Change the `animals` table so that the `binomial_name` column cannot contain duplicate values.
ALTER TABLE animals
ADD CONSTRAINT unique_binomial_name UNIQUE (binomial_name);

-- 7) Connect to the `ls_burger` database. Add the following columns to the `orders` table:
-- - A column called `customer_email`; it should hold strings of up to 50 characters.
-- - A column called `customer_loyalty_points` that should hold integer values. If no value is specified for this column, then a value of 0 should be applied.
ALTER TABLE orders
ADD COLUMN customer_email varchar(50),
ADD COLUMN customer_loyalty_points integer DEFAULT 0;

-- 8) Add three columns to the `orders` table called `burger_cost`, `side_cost`, and `drink_cost` to hold monetary values in dollars and cents (assume that all values will be less than $100). If no value is entered for these columns, a value of `0` dollars should be used.
ALTER TABLE orders
ADD COLUMN burger_cost DECIMAL(4,2) DEFAULT 0,
ADD COLUMN side_cost DECIMAL(4,2) DEFAULT 0,
ADD COLUMN drink_cost DECIMAL(4,2) DEFAULT 0;

-- 9) Remove the `order_total` column from the `orders` table.
ALTER TABLE orders
DROP COLUMN order_total;
