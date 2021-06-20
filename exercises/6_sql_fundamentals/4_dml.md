1) Create a database to store information and tables related to a `workshop`.

One table should be called `devices`. This table should have columns that meet the following specifications:
- Includes a primary key called `id` that is auto-incrementing.
- A column called `name`, that can contain a String. It cannot be `NULL`.
- A column called `created_at` that lists the date this device was created. It should be of type `timestamp` and it should also have a default value related to when a device is created.

In the workshop, we have several devices, and each device should have many different parts. These parts are unique to each device, so one device can have various parts, but those parts won't be used in any other device. Make a table called `parts` that reflects the information listed above. Table parts should have the following columns that meet the following specifications:
- An `id` which auto-increments and acts as the primary key
- A `part_number`. This column should be unique and not null.
- A foreign key column called `device_id`. This will be used to associate various parts with a device.
```sql
CREATE DATABASE workshop;

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name varchar(50) NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices (id)
);
```
2) Add in two different devices. One should be named, "Accelerometer". The other should be named, "Gyroscope".

The first device should have 3 parts (this is grossly simplified). The second device should have 5 parts. The part numbers may be any number between 1 and 10000. There should also be 3 parts that don't belong to any device yet.
```sql
INSERT INTO devices (name)
VALUES ('Gyroscope'),
('Accelerometer');

-- Double-check what the device ids are
SELECT * FROM devices;

INSERT INTO parts (part_number, device_id)
VALUES (43, 1),
(32, 1),
(90, 1),
(782, 2),
(15, 2),
(876, 2),
(97, 2),
(22, 2);

INSERT INTO parts (part_number)
VALUES (12),
(17),
(2);
```
3) Write an SQL query to display all devices along with all the parts that make them up. We only want to display the name of the devices. Its parts should only display the part_number.
```sql
SELECT d.name, p.part_number
  FROM devices AS d
  INNER JOIN parts AS p
    ON d.id = p.device_id
  ORDER BY d.name, p.part_number
;
```
4) We want to grab all parts that have a `part_number` that starts with 3. Write a `SELECT` query to get this information. This table may show all attributes of the parts table.
```sql
SELECT p.part_number
  FROM parts AS p
  WHERE p.part_number::text LIKE '3%';
```
5) Write an SQL query that returns a result table with the name of each device in our database together with the number of parts for that device.
```sql
SELECT d.name,
       COUNT(p.id) AS num_parts
  FROM devices AS d
  LEFT OUTER JOIN parts AS p
    ON d.id = p.device_id
  GROUP BY d.name;
```
6) Alter the SQL query above so that we get a result table that orders the results by name descending.
```sql
SELECT d.name,
       COUNT(p.id) AS num_parts
  FROM devices AS d
  LEFT OUTER JOIN parts AS p
    ON d.id = p.device_id
  GROUP BY d.name
  ORDER BY d.name DESC;
```
7) Write two SQL queries:
- One that generates a listing of parts that currently belong to a device.
- One that generates a listing of parts that don't belong to a device.

Do not include the `id` column in your queries.
```sql
SELECT p.part_number,
       p.device_id
  FROM parts AS p
 WHERE p.device_id IS NOT NULL;

SELECT p.part_number,
       p.device_id
  FROM parts AS p
 WHERE p.device_id IS NULL;
```
8) Insert one more device into the devices table. Assuming nothing about the existing order of the records in the database, write an SQL statement that will return the name of the oldest device from our devices table.
```sql
INSERT INTO devices (name)
VALUES ('Thermometer');

SELECT d.name
  FROM devices AS d
  ORDER BY d.created_at ASC
  LIMIT 1;
```
