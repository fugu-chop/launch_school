1) This set of exercises will focus on an auction. Create a new database called `auction`. In this database there will be three tables, `bidders`, `items`, and `bids`.

After creating the database, set up the 3 tables using the following specifications:
`bidders`
- `id` of type SERIAL: this should be a primary key
- `name` of type text: this should be `NOT NULL`

`items`
- `id` of type SERIAL: this should be a primary key
- `name` of type text: this should be `NOT NULL`
- `initial_price` and `sales_price`: These two columns should both be of type numeric. Each column should be able to hold a number as high as 1000 dollars with 2 decimal points of precision.
- The `initial_price` represents the starting price of an item when it is first put up for auction. This column should never be `NULL`.
- The `sales_price` represents the final price at which the item was sold. This column may be `NULL`, as it is possible to have an item that was never sold off.

`bids`
- `id` of type SERIAL: this should be a primary key
- `bidder_id`, `item_id`: These will be of type integer and should not be `NULL`. This table connects a bidder with an item and each row represents an individual bid. There should never be a row that has `bidder_id` or `item_id` unknown or `NULL`. Nor should there ever be a bid that references a nonexistent item or bidder. If the item or bidder associated with a bid is removed, that bid should also be removed from the database.
- Create your `bids` table so that both `bidder_id` and `item_id` together form a composite index for faster lookup.
- `amount` - The amount of money placed for each individual bid by a bidder. This column should be of the same type as `items.initial_price` and have the same constraints.

Finally, use the `\copy` meta-command to import the below files into your auction database. You'll have to create these files yourself before you can import them with `\copy`.
```sql
CREATE DATABASE auction;

CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price NUMERIC(6, 2) NOT NULL CHECK (initial_price >= 0.01),
  sales_price NUMERIC(6, 2) CHECK (sales_price >= 0.01)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id INTEGER NOT NULL REFERENCES bidders (id) ON DELETE CASCADE,
  item_id INTEGER NOT NULL REFERENCES items (id) ON DELETE CASCADE,
  amount NUMERIC(6, 2) NOT NULL CHECK (amount >= 0.01)
);

CREATE INDEX bids_index ON bids (bidder_id, item_id);

/*
\copy bidders FROM '/Users/dean/Documents/launch_school/exercises/6_sql_fundamentals/bidders.csv' WITH HEADER CSV
\copy items FROM '/Users/dean/Documents/launch_school/exercises/6_sql_fundamentals/items.csv' WITH HEADER CSV
\copy bids FROM '/Users/dean/Documents/launch_school/exercises/6_sql_fundamentals/bids.csv' WITH HEADER CSV
*/
```
2) Write a SQL query that shows all items that have had bids put on them. Use the logical operator IN for this exercise, as well as a subquery.
```sql
SELECT name AS "Bid on Items"
FROM items
WHERE id IN (SELECT DISTINCT item_id
FROM bids);
```
3) Write a SQL query that shows all items that have not had bids put on them. Use the logical operator NOT IN for this exercise, as well as a subquery.
```sql
SELECT name AS "Not Bid On"
FROM items
WHERE id NOT IN (SELECT DISTINCT item_id
FROM bids);
```
3) Write a SELECT query that returns a list of names of everyone who has bid in the auction. While it is possible (and perhaps easier) to do this with a JOIN clause, we're going to do things differently: use a subquery with the EXISTS clause instead.
```sql
SELECT b.name
FROM bidders AS b
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```
3b) More often than not, we can get an equivalent result by using a JOIN clause, instead of a subquery. Can you figure out a SELECT query that uses a JOIN clause that returns the same output as our solution above?
```sql
SELECT bd.name
FROM bidders AS bd
JOIN bids AS b
  ON bd.id = b.bidder_id;
```
4) Write an SQL query that finds the largest number of bids from an individual bidder. For this exercise, you must use a subquery to generate a result table (or virtual table), and then query that table for the largest number of bids.
```sql
SELECT MAX(num_bids)
FROM (SELECT b.id, COUNT(id) AS num_bids FROM bids AS b GROUP BY b.id);
```
5) Use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the name of each item along with the number of bids on an item.
```sql
SELECT i.name, (SELECT COUNT(b.id) FROM bids AS b WHERE i.id = b.item_id) 
FROM items AS i;
```
5b) If we wanted to get an equivalent result, without using a subquery, then we would have to use a LEFT OUTER JOIN. Can you come up with the equivalent query that uses a JOIN clause?
```sql
SELECT i.name,
       COUNT(b.id)
FROM items AS i
LEFT JOIN bids AS b
  ON i.id = b.item_id
;
```
6) Write an SQL query that will display the id for the item that matches all of the data that we know, but does not use the AND keyword.
```sql
SELECT 
FROM items AS i
WHERE i.name IN ('Painting)

```