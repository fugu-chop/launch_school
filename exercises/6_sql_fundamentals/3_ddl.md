1) First create a postgresql database named "extrasolar", and then create two tables in the database as follows:

`stars` table:
- `id`: a unique serial number that auto-increments and serves as a primary key for this table.
- `name`: the name of the star,e,g., "Alpha Centauri A". Allow room for 25 characters. Must be unique and non-null.
- `distance`: the distance in light years from Earth. Define this as a whole number (e.g., 1, 2, 3, etc) that must be non-null and greater than 0.
- `spectral_type`: the spectral type of the star: O, B, A, F, G, K, and M. Use a one character string.
- `companions`: how many companion stars does the star have? A whole number will do. Must be non-null and non-negative.

`planets` table:
- `id`: a unique serial number that auto-increments and serves as a primary key for this table.
- `designation`: a single alphabetic character that uniquely identifies the planet in its star system ('a', 'b', 'c', etc.)
- `mass`: estimated mass in terms of Jupiter masses; use an integer for this value.

```
createdb extrasolar
psql -d extrasolar
```

```sql
CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1),
  mass integer
);
```
2) Add a `star_id` column to the `planets` table; this column will be used to relate each planet in the `planets` table to its home star in the `stars` table. Make sure the column is defined in such a way that it is required and must have a value that is present as an `id` in the `stars` table.
```sql
ALTER TABLE planets
ADD COLUMN star_id integer NOT NULL REFERENCES stars (id);
```
3) Modify the `name` column in `stars` so that it allows star names as long as 50 characters.
```sql
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);
```
3b) Assume the `stars` table already contains one or more rows of data. What will happen when you try to run the above command? To test this, revert the modification and add a row or two of data:
```sql
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(25);

INSERT INTO stars (name, distance, spectral_type, companions)
VALUES ('Alpha Centauri B', 4, 'K', 3);

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);
```
No error occurs if we change the accepted length of the column to a value that is equal to or longer than all existing values int he column. However, if we try to change to a value that's shorter than a value that already exists in the column, an error will be raised - `ERROR:  value too long for type character varying(10)`.

4) Modify the `distance` column in the `stars` table so that it allows fractional light years to any degree of precision required.
```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;
```
4b) Assume the stars table already contains one or more rows of data. What will happen when you try to run the above command? To test this, revert the modification and add a row or two of data:
```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE integer;

INSERT INTO stars (name, distance, spectral_type, companions)
VALUES ('Alpha Orionis', 643, 'M', 9);

ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;
```
There's no issue with converting from type `integer` to `numeric`, since `numeric` accepts number to any level of precision. However, if we already have data in the `numeric` format, converting to `integer` means that we lose the precision (i.e. decimal places). This is permanent; if we convert back from `numeric` to `integer`, we do not get our decimal places back.

5) The `spectral_type` column in the `stars` table is currently defined as a one-character string that contains one of the following 7 values: `'O'`, `'B'`, `'A'`, `'F'`, `'G'`, `'K'`, and `'M'`. However, there is currently no enforcement on the values that may be entered. Add a constraint to the table `stars` that will enforce the requirement that a row must hold one of the 7 listed values above. Also, make sure that a value is required for this column.
```sql
ALTER TABLE stars
ADD CONSTRAINT spectral_types CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;
```
5b) Assume the `stars` table contains one or more rows that are missing a `spectral_type` value, or that have an illegal value. What will happen when you try to alter the table schema? How would you go about adjusting the data to work around this problem?
```sql
ALTER TABLE stars
DROP CONSTRAINT spectral_types,
ALTER COLUMN spectral_type DROP NOT NULL;

INSERT INTO stars (name, distance, companions)
VALUES ('Epsilon Eridani', 10.5, 0);

INSERT INTO stars (name, distance, spectral_type, companions)
VALUES ('Lacaille 9352', 10.68, 'X', 0);

ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;
```
This will cause Postgres to raise an error, `ERROR:  column "spectral_type" of relation "stars" contains null values`, as we cannot apply a `NOT NULL` constraint to a table where there are already `NULL` values. We would have to delete the rows where there are `NULL` values, and re-insert them with a value. If we do have missing values, we might choose to insert a default value, such as `'?'`.

6) PostgreSQL provides what is called an enumerated data type; that is, a data type that must have one of a finite set of values. For instance, a traffic light can be red, green, or yellow: these are enumerate values for the color of the currently lit signal light.

Modify the stars table to remove the `CHECK` constraint on the `spectral_type` column, and then modify the `spectral_type` column so it becomes an `enumerated` type that restricts it to one of the following 7 values: `'O'`, `'B'`, `'A'`, `'F'`, `'G'`, `'K'`, and `'M'`.
```sql
ALTER TABLE stars
DROP CONSTRAINT spectral_types;

CREATE TYPE spectral_type_enum AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER COLUMN spectral_type TYPE spectral_type_enum USING spectral_type::spectral_type_enum;
```
7) Modify the `mass` column in the `planets` table so that it allows fractional masses to any degree of precision required. In addition, make sure the `mass` is required and positive. While we're at it, also make the `designation` column required.
```sql
ALTER TABLE planets
ALTER COLUMN designation SET NOT NULL,
ALTER COLUMN mass TYPE numeric, 
ADD CHECK (mass > 0),
ALTER COLUMN mass SET NOT NULL;
```
8) Add a `semi_major_axis` column for the semi-major axis of each planet's orbit; the semi-major axis is the average distance from the planet's star as measured in astronomical units (1 AU is the average distance of the Earth from the Sun). Use a data type of numeric, and require that each planet have a value for the `semi_major_axis`.
```sql
ALTER TABLE planet
ADD COLUMN semi_major_axis numeric NOT NULL;
```
8b) Assume the `planets` table already contains one or more rows of data. What will happen when you try to run the above command? What will you need to do differently to obtain the desired result? To test this, delete the semi_major_axis column and then add a row or two of data (note: your stars table will also need some data that corresponds to the star_id values):
```sql
ALTER TABLE planets
DROP COLUMN semi_major_axis;

DELETE FROM stars;
INSERT INTO stars (name, distance, spectral_type, companions)
VALUES ('Alpha Centauri B', 4.37, 'K', 3);
INSERT INTO stars (name, distance, spectral_type, companions)
VALUES ('Epsilon Eridani', 10.5, 'K', 0);

INSERT INTO planets (designation, mass, star_id)
VALUES ('b', 0.0036, 1); -- check star_id; see note below
INSERT INTO planets (designation, mass, star_id)
VALUES ('c', 0.1, 2); -- check star_id; see note below

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;
```
NOTE: The `semi_major_axis` for Alpha Centauri B planet b is 0.04 AU while that for Epsilon Eridani planet c is about 40 AU. 

The above query will fail, as Postgres will attempt to add a `NOT NULL` constraint to a column that is full of `NULL` values (since we have just created it). In order to apply the `NOT NULL` constraint correctly, we need to add the column first, populate the values for each planet, and then add a constraint of `NOT NULL`, in that order.
```sql
ALTER TABLE planets
ADD COLUMN semi_major_axis numeric;

UPDATE planets SET semi_major_axis = 0.04 WHERE star_id = 1; -- or another star_id
UPDATE planets SET semi_major_axis = 40 WHERE star_id = 2; -- or another star_id

ALTER TABLE planets
ALTER COLUMN semi_major_axis SET NOT NULL;
```
9) Your task is to add a `moons` table to the database. The table should include the following data:
- `id`: a unique serial number that auto-increments and serves as a primary key for this table.
- `designation`: the designation of the moon. We will assume that moon designations will be numbers, with the first moon discovered for each planet being moon 1, the second moon being moon 2, etc. The designation is required.
- `semi_major_axis`: the average distance in kilometers from the planet when a moon is farthest from its corresponding planet. This field must be a number greater than 0, but is not required; it may take some time before we are able to measure moon-to-planet distances in extrasolar systems.
- `mass`: the mass of the moon measured in terms of Earth Moon masses. This field must be a numeric value greater than 0, but is not required.

Make sure you also specify any foreign keys necessary to tie each moon to other rows in the database.
```sql
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK (mass > 0.0),
  planet_id integer NOT NULL REFERENCES planets (id)
);
```
10) Delete the `extrasolar` database. Use the psql console, not the terminal level commands.
```sql
DROP DATABASE extrasolar;
```
