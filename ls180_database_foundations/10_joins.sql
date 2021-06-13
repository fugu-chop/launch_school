-- 1) Connect to the encyclopedia database. Write a query to return all of the country names along with their appropriate continent names.
SELECT cy.name, ct.continent_name
FROM country AS cy
JOIN continent AS ct
ON cy.continent_id = ct.id;

-- 2) Write a query to return all of the names and capitals of the European countries.
SELECT cy.name, cy.capital
FROM country AS cy
JOIN continent AS ct
ON cy.continent_id = ct.id
WHERE ct.continent_name = 'Europe';

-- 3) Write a query to return the first name of any singer who had an album released under the Warner Bros label.
SELECT DISTINCT s.first_name
FROM singers AS s
JOIN albums AS a
ON s.id = a.singer_id
WHERE a.label = '%Warner Bros%';

-- 4) Write a query to return the first name and last name of any singer who released an album in the 80s and who is still living, along with the names of the album that was released and the release date. Order the results by the singer's age (youngest first).
SELECT s.first_name, s.last_name
FROM singers AS s
JOIN albums AS a
ON s.singer_id = a.id
WHERE DATE_PART('year', released) BETWEEN 1980 AND 1989
AND (deceased = FALSE OR deceased = NULL)
ORDER BY s.date_of_birth DESC;

-- 5) Write a query to return the first name and last name of any singer without an associated album entry.
SELECT s.first_name, s.last_name
FROM singers AS s
LEFT JOIN albums AS a
ON s.singer_id = a.id
WHERE a.id IS NULL;

-- 6) Rewrite the query for the last question as a sub-query.
SELECT s.first_name, s.last_name
FROM singers AS s
WHERE s.singer_id NOT IN (SELECT id FROM albums);

-- 7) Connect to the `ls_burger` database. Return a list of all orders and their associated product items.
SELECT o.*, oi.*
FROM orders AS o
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON o.product_id = p.id;

-- 8) Return the id of any order that includes Fries. Use table aliasing in your query.
SELECT o.id
FROM orders AS o
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON o.product_id = p.id
WHERE p.product_name = 'Fries';

-- 9) Build on the query from the previous question to return the name of any customer who ordered fries. Return this in a column called 'Customers who like Fries'. Don't repeat the same customer name more than once in the results.
SELECT DISTINCT c.customer_name AS "Customers who like Fried"
FROM orders AS o
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON o.product_id = p.id
WHERE p.product_name = 'Fries';

-- 10) Write a query to return the total cost of Natasha O'Shea's orders.
SELECT SUM(p.product_cost)
FROM customers AS c 
JOIN orders as o
ON c.id = o.customer_id
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON oi.product_id = p.id
WHERE c.customer_name = 'Natasha O''Shea';

-- 11) Write a query to return the name of every product included in an order alongside the number of times it has been ordered. Sort the results by product name, ascending.
SELECT p.product_name
    , COUNT(p.id) AS "Number of Times Ordered"
FROM products AS p 
JOIN order_items AS oi
ON p.id = oi.product_id
GROUP BY p.product_name
ORDER BY p.product_name