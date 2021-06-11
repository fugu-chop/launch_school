1) Make sure you are connected to the `encyclopedia` database. Write a query to retrieve the population of the USA.
```sql
SELECT population FROM countries WHERE = 'USA';
```
2) Write a query to return the population and the capital (with the columns in that order) of all the countries in the table.
```sql
SELECT population, capital FROM countries;
```
3) Write a query to return the names of all the countries ordered alphabetically.
```sql
SELECT name FROM countries ORDER BY name;
```
4) Write a query to return the names and the capitals of all the countries in order of population, from lowest to highest.
```sql
SELECT name, capital FROM countries ORDER BY population;
```
5) Write a query to return the same information as the previous query, but ordered from highest to lowest.
```sql
SELECT name, capital FROM countries ORDER BY population DESC;
```
6) Write a query on the `animals` table, using `ORDER BY`, that will return the following output:
```
       name       |      binomial_name       | max_weight_kg | max_age_years
------------------+--------------------------+---------------+---------------
 Peregrine Falcon | Falco Peregrinus         |        1.5000 |            15
 Pigeon           | Columbidae Columbiformes |        2.0000 |            15
 Dove             | Columbidae Columbiformes |        2.0000 |            15
 Golden Eagle     | Aquila Chrysaetos        |        6.3500 |            24
 Kakapo           | Strigops habroptila      |        4.0000 |            60
(5 rows)
```
```sql
SELECT name, binomial_name, max_weight_kg, max_age_years FROM animals ORDER BY max_age_years, max_weight_kg, name DESC;
```
7) Write a query that returns the names of all the countries with a population greater than 70 million.
```sql
SELECT name FROM countries WHERE population > 70000000;
```
8) Write a query that returns the names of all the countries with a population greater than 70 million but less than 200 million.
```sql
SELECT name FROM countries WHERE population BETWEEN 70000000 AND 200000000;
```
9) Write a query that will return the first name and last name of all entries in the celebrities table where the value of the deceased column is not true.
```sql
SELECT first_name, last_name FROM celebrities WHERE deceased = FALSE OR deceased IS NULL;
```
10) Write a query that will return the first and last names of all the celebrities who sing.
```sql
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%singer%';
```
11) Write a query that will return the first and last names of all the celebrities who act.
```sql
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%act%';
```
12) Write a query that will return the first and last names of all the celebrities who both sing and act.
```sql
SELECT first_name, last_name FROM celebrities WHERE occupation ILIKE '%act%' AND occupation ILIKE '%singer%';
```
13) Connect to the ls_burger database. Write a query that lists all of the burgers that have been ordered, from cheapest to most expensive, where the cost of the burger is less than $5.00.
```sql
SELECT burger FROM ls_burger WHERE burger_cost < 5 ORDER BY burger_cost;
```
14) Write a query to return the customer name and email address and loyalty points from any order worth 20 or more loyalty points. List the results from the highest number of points to the lowest.
```sql
SELECT customer_name, customer_email, customer_loyalty_points FROM ls_burger WHERE customer_loyalty_points >= 20 ORDER BY customer_loyalty_points DESC;
```
15) Write a query that returns all the burgers ordered by Natasha O'Shea.
```sql
SELECT burger FROM ls_burger WHERE customer_name = 'Natasha O''Shea';
```
16) Write a query that returns the customer name from any order which does not include a drink item.
```sql
SELECT customer_name FROM ls_burger WHERE drink IS NULL;
```
17) Write a query that returns the three meal items for any order which does not include fries.
```sql
SELECT burger, side, drink FROM ls_burger WHERE side != 'Fries' OR side IS NULL;
```
18) Write a query that returns the three meal items for any order that includes both a side and a drink.
```sql
SELECT burger, side, drink FROM ls_burger WHERE side IS NOT NULL AND drink IS NOT NULL;
```
