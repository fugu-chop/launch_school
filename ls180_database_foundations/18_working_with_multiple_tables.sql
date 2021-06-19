-- 1) Import the linked data
/*
psql films < theater_full.sql
*/

-- 2) Write a query that determines how many tickets have been sold.
SELECT COUNT(id) FROM tickets;

-- 3) Write a query that determines how many different customers purchased tickets to at least one event.
SELECT COUNT(DISTINCT customer_id) FROM tickets;

-- 4) Write a query that determines what percentage of the customers in the database have purchased a ticket to one or more of the events.
SELECT ROUND(COUNT(DISTINCT customer_id) * 100 / (SELECT COUNT(id) FROM customers)::decimal, 2) AS percent FROM tickets;

/*
-- Alt solution
SELECT ROUND(COUNT(DISTINCT tickets.customer_id) / COUNT(DISTINCT customers.id)::decimal * 100, 2) AS percent
  FROM customers
  LEFT OUTER JOIN tickets
    ON tickets.customer_id = customers.id;
*/

-- 5) 