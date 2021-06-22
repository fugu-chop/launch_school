1) Name and define DDL and DML, and give at least 2 examples of each.
The DDL, or Data Definition Language, relates to dealing with creating, modifying or deleting databases and tables, and describes how data is structured. Examples of commands within DDL include `ALTER`, `DROP` and `CREATE`.

The Data Manipulation Language (DML) component of SQL is used to create, read, update, and delete the actual data in a database. Examples of commands within DML include `SELECT`, `INSERT`, `UPDATE` and `DELETE`.

2) Does the following statement use the Data Definition Language (DDL) or the Data Manipulation Language (DML) component of SQL?
```sql
SELECT column_name FROM my_table;
```
This statement uses the Data Manipulation Language component of SQL, as the statement is performing a read-only retrieval of data from an existing table - it does not change the table itself or the structure of the data.

3) Does the following statement use the DDL or DML component of SQL?
```sql
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);
```
This statement uses the Data Definition Language component of SQL, as it is creating a table, thus defining the structure of data that has yet to be inserted into this table. `CREATE TABLE` defines the type of information stored in a database table by describing the data and its attributes. It does not actually manipulate any data, but instead manipulates the data definitions.

4) Does the following statement use the DDL or DML component of SQL?
```sql
ALTER TABLE things
DROP CONSTRAINT things_item_key;
```
This statement uses the Data Definition Language component of SQL, as it is changing the attributes of data already in the database. `ALTER TABLE` modifies the characteristics and attributes of a table. It does not actually manipulate any data, but instead manipulates the data definitions.

5) Does the following statement use the DDL or DML component of SQL?
```sql
INSERT INTO things VALUES (3, 'Scissors', 'Metal');
```
This statement describes the Data Manipulation Language component of SQL. `INSERT` is not changing the shape or attributes of data within tables or databases; rather, it is inserting new data that adheres to the pre-defined shape.

6) Does the following statement use the DDL or DML component of SQL?
```sql
UPDATE things
SET material = 'plastic'
WHERE item = 'Cup';
```
This statement describes the Data Manipulation Language component of SQL, as `UPDATE` is changing the existing data within a table - it is not changing the underlying shape of the data within a table.

7) Does the following statement use the DDL, DML, or DCL component of SQL?
```
\d things
```
`\d` is a `psql` console command, not part of SQL. As such, it is not part of any SQL sublanguage. However, it does act something like a DDL statement -- it displays the schema of the named table.

8) Does the following statement use the DDL or DML component of SQL?
```sql
DELETE FROM things WHERE item = 'Cup';
```
This statement describes the Data Manipulation Language component of SQL. `DELETE` is removing existing data from a relation; it does not change the underlying data structure.

9) Does the following statement use the DDL or DML component of SQL?
```sql
DROP DATABASE xyzzy;
```
This statement relates to the Data Definition Language component of SQL. The main purpose of `DROP DATABASE` is to remove an existing database and it's structure; the fact that all associated data within is removed is a side effect.

`DROP DATABASE` removes all data from the database, including any and all tables in the database. In this respect, it manipulates data, so some people think of it as part of DML. However, `DROP DATABASE` also deletes everything about the structure of the database and its tables. Furthermore, all variants of the `DROP` statement are generally treated as DDL. In these respects, `DROP DATABASE` manipulates how the data is structured, so it is considered part of the DDL sublanguage.

10) 
```sql
CREATE SEQUENCE part_number_sequence;
```
`CREATE SEQUENCE` statements modify the characteristics and attributes of a database by adding a sequence object to the database structure. It does not actually manipulate any data, but instead manipulates the data definitions. As such, `CREATE SEQUENCE` statements are part of the DDL sublanguage.

It could also be argued that `CREATE SEQUENCE` is DML; the sequence object it creates is a bit of data that is used to keep track of a sequence of automatically generated values, so it can be thought of as being part of the data instead of a characteristic of the data. However, all `CREATE` statements (not just `CREATE SEQUENCE`) are generally thought of as DDL.
