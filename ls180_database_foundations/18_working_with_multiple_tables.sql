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

-- 5) Write a query that returns the name of each event and how many tickets were sold for it, in order from most popular to least popular.
SELECT e.name, COUNT(DISTINCT t.id) AS popularity 
FROM events AS e 
INNER JOIN tickets AS t 
  ON e.id = t.event_id 
GROUP BY name 
ORDER BY popularity DESC;

-- 6) Write a query that returns the user id, email address, and number of events for all customers that have purchased tickets to three events.
SELECT c.id, c.email, COUNT(DISTINCT t.event_id)
FROM customers AS c 
INNER JOIN tickets AS t 
  ON c.id = t.customer_id 
GROUP BY c.id, c.email
HAVING COUNT(DISTINCT (t.event_id)) = 3;

-- 7) Write a query to print out a report of all tickets purchased by the customer with the email address 'gennaro.rath@mcdermott.co'. The report should include the event name and starts_at and the seat's section name, row, and seat number.
SELECT e.name AS event,
       e.starts_at,
       ss.name AS section,
       st.row,
       st.number AS seat
  FROM tickets AS t
  INNER JOIN events AS e
    ON t.event_id = e.id
  INNER JOIN customers AS c
    ON t.customer_id = c.id
  INNER JOIN seats AS st
    ON t.seat_id = st.id
  INNER JOIN sections AS ss
    ON st.section_id = ss.id
  WHERE c.email = 'gennaro.rath@mcdermott.co';
