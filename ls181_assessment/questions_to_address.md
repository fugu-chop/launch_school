### What is the relational model of data?
The relational model of data defines a series of relations (entities that can be queried or interacted with by a user or application, such as tables, views and sequences) and describes the relationships between these relations to determine how those relations can interact.

### What is a relational database?
A relational database is a database that organises structured data according to the relational model of data. Using the relational model of data can allow us to reduce data redundancy and improve data quality through referential integrity (ensuring that all rows in a table that are intended to reference rows in other tables, actually do so) through a process of data normalisation.

### What is a RDBMS?
An RDBMS (Relational Database Management System) is a software application that manages relational databases (e.g. PostgreSQL). It enables users (or other applications) to interact with a database by issuing commands using syntax that ocnforms to a set of conventions or standards.

### What is a relation?
A relation (in the context of the relational model of data) is an object that can be interacted with by a user or application, such as a table, view or sequence through use of the appropriate syntax.

### What is SQL? What is Postgres?
SQL (Structured Query Language) is a special purpose language used to interact with relational databases. It is declarative, meaning that users or applications specify what they wish to do with the relational databases, but the specific execution of the query itself is an implementation detail handled by the RDBMS (relational database management system).

### What are the three sub-languages of SQL?
SQL can be broken down into three sub-languages:
- Data Definition Language (DDL): This controls the definition and structure of a database and the tables/columns within it.
  - Common commands for DDL include `ALTER`, `CREATE` or `DROP`
- Data Manipulation Language (DML): This controls the creation, retrieval and modification of data stored within a database.
  - Common commands for DML include `SELECT`, `UPDATE`, `INSERT` and `DELETE`
- Data Control Language (DCL): This controls the access privileges to the database for different users or applications. Common commands include `GRANT`, `REVOKE`.

### What is the difference between data and a schema?
A _schema_ refers to the structure of the database that houses data. It controls what tables exist, what columns exist within the table, what the data types are for each column, and any constraints that might apply to columns or the table itself. The _data_ refers to the contents of the tables themselves. These are the specific values contained in rows and columns within a table. Data must be combined with a schema to create a useful entity of structured data with which users or applications can interact.

### What is a constraint? What purpose does it serve?
A constraint is a limitation that can be applied to a column, table, or schema so that data inserted into that column/table conforms with an expected format. It helps maintain _data quality and integrity_ within the table.

### What is `NULL` in SQL? Why do we have to be careful with it?
Within the context of SQL, `NULL` refers to an unknown value. We need to be careful in the design and querying of our tables when dealing with `NULL` values, as when evaluated by comparison operators, they return `NULL`, making it impossible to compared them with non-`NULL` values. When columns are ordered with an `ORDER BY` clause, the order in which `NULL` values appear can also change (appears first in a descending order sort, or last in an ascending order sort), which may have implications on information returned within an application. Similarly, when using comparison operators on columns with other values, `NULL` values will _not_ be returned; e.g. `SELECT * FROM table WHERE col1 != true` will _not_ return rows where `col1` is `NULL`.

### What is normalisation? Why would we use it?
Normalisation is the process of splitting up data into multiple tables and creating relationships between them in order to reduce data redundancy (i.e. the amount of duplicated information within a single tables) and improve data integrity. Normalisation helps reduce the amount of _anomalies_ in databases.

### What are anomalies?
Anomalies are issues that occur when tables in a database are not normalised. Three examples of anomalies include:
- Update anomaly: This occurs when there is an update to data that is not applied consistently throughout a table - e.g. in a one-to-many table on the many table, an update anomaly will occur when there are multiple different values associated with a particular key.
- Insertion anomaly: This exists in a table that has not been normalised, when simple information about a particular entity cannot be inserted into a table because it lacks other more detailed information - e.g. when information about a customer cannot be inserted into table because they have not yet made a purchase.
- Deletion anomaly: This is the opposite of an insertion anomaly - if all detailed information about an entity is deleted, the simple information is also deleted - in our previous example, if we delete all sales data about a customer, the basic information about that customer no longer exists within a table.

### What is database design? What are the considerations behind it?
Database design refers to the process of defining entities to represent different types of data and defining the relationships between those entities. An entity can be regarded as a set of data (or a real world object) that we want to model in our database (this does not necessarily mean an entity will be represented in only a single table).

### What is an Entity Relationship Diagram? Why would we use it?
An entity relationship diagram (ERD) is a conceptual level diagram used in the database design process, showing a high level overview of the different entities and how they relate to one another. Detailed implementation information, such as the types of the data and concerns such as modality and cardinality, are not represented here. It is a high level design used to provide a higher level of abstraction to simplify the overall database design process.

### What is a database diagram? What are the different levels at which it can be shown?
A database diagram is a graphical representation of the different entities and relationships within a database. Database diagrams can be divided into three broad categories of _schema_, which differ in the level of abstration/detail shown:
- Conceptual: This is a high level database diagram, which is primarily focused on larger objects and concepts; the relations and their general relationships with other relations. It may not show specifics of the implementation, such as the columns data types within an entity.
- Logical: This a diagram with a 'moderate' level of detail, existing between conceptual and physical database diagrams. I may include a list of attributes of an entity (i.e. the columns) and their data types, but at a level of detail that's not specific to an actual database.
- Physical: This is the most granular level of database diagram - it is concerned with the database level implementation of a conceptional model. It includes all the attributes of an entity, the data types of those attributes, constraints on those attributes or relations and rules about how those entities and attributes relate to each other (e.g. defining the modality and cardinality of relationships between models).

### What are keys? Why would we use them?
Keys are a type of constraint that are used to establish relationships _between_ entities in a database, and uniqueness of a record _within_ an entity. They are one way of identifying specific rows within a table (or related table) in the case of primary keys, and can be used to establish relationships between different tables, by associating foreign keys with a primary key.

### What is a primary key?
A primary key is a constraint that can be applied to a table that allows references to specific, individual rows within that table. They are unique identifiers for rows, and act as a way to establish relationships between two tables, in that a foreign key in a table should reference an entry in another table with the associated primary key. As part of applying a primary key constraint, this means that all values within the primary key column are intended to be unique, and not `NULL`.

### What is a foreign key?
A foreign key is a constraint that can be applied to a column within a table such that a given row can be associated with another row in a different table, through that other table's primary key. Applying the foreign key constraint does __not__ inherently create a non-`NULL` (though it makes no sense for a foreign key to be `NULL`) or unique constraint (otherwise creating one-to-many relationships would not be possible between tables). Foreign keys help us ensure referential integrity, in that a row with a value in the foreign key column must reference a primary key value found in in another table.

### What is a natural key?
A natural key is an identifier for individual records within a table that is created by using existing data within a table (e.g. through using a specific column, or combination of columns). Natural keys aren't particularly prevalent, since as they rely on context specific values and are potentially vulnerable to external changes (e.g. product SKUs used as a natural key might be carried over between different product versions, or phone numbers can change over time). 

### What is a surrogate key?
A surrogate key is an identifier created specifically for the purposes of uniquely identifying rows within a table. Unlike a natrual key, it does not rely on existing data or it's context - the value of the key should not be affected by external circumstances.

### What is a sequence? Why would we use it? How do we access it?
A sequence is a relation that generates a series of incrementing numbers. Sequences can be used to generate surrogate keys for tables for use as primary keys. A sequence can only return a number once, regardless of whether it's used. Sequences should be used in conjunction with other constraints - sequences themselves do not prevent duplicate values from being manually inserted into a column; if a duplicate value was entered as a primary key, this would defeat the purpose of generating a unique identifier.

### What is referential integrity?
Referential integrity is an assurance that all column values in a table reference existing values in other tables where a relationship exists between the two. It's a way to ensure that relationships between entities are implemented correctly, and can be achieved (among other methods) through the setting of primary and foreign keys between different tables.

### What is cardinality?
Cardinality is a term used to describe the number of objects on each side of a relationship between two entities. As an example, assume table A and B have a _one-to-many_ relationship; the cardinality of table A in this relationship is _one_, while the cardinality of Table B in this relationship is _many_. In database design diagrams, we can use crows feet notation to indicate the cardinality of relationships.

### What is modality?
Modality is a term used to describe the minimum required number of objects on each side of the relationship between two entities. When describing modality, we typically classify the relationship as either requiring at least 0 or 1 objects. In the case of 0 objects, we do not require a record to exist on both sides of the relationship; in the case of 1 object, this indicates that one side of the relationship requires an object before a relationship can be established (e.g. an entry in a table must have a primary key must exist before an entry with a foreign key can be inserted or updated in another table).

### What are the three types of relationships that can exist between relations?
There are three types of relationships that can exist between relations:
1. One-to-one: This indicates that between two tables, each row should reference precisely one row in the other table. These are somewhat unusual in practice, as it might be simpler to consolidate the two tables into one. This is established by setting a column as both a primary key and a foreign key to another table.
2. One-to-many: This indicates that between two entities, one row in an entity can be associated with multiple rows in the other entity (note that the opposite relationship does not exist).
3. Many-to-many: These relationships typically exist through the use of a join table (effectively combining two one-to-many relationships) and denote the ability for multiple instances of each entity to reference multiple instances of another entity.

### What are joins? What are the different types of joins?
`JOIN` clauses in SQL allow us to retrieve data from multiple relations, by linking those relations together through keys between tables. The types of joins are:
- `INNER JOIN` - this returns a subset of rows that is common between tables; i.e. where the primary and foreign key can be matched across both rows in multiple tables.
- `LEFT OUTER JOIN` - this returns all of the results from the LEFT table, and the elements of the other table that are common to the left table (again, where the primary and foreign keys can be matched)
- `RIGHT OUTER JOIN` - this returns all of the results from the RIGHT table, and the common elements of the left table that can be matched with the right table (i.e. rows where the primary and foreign keys can be matched)
- `FULL OUTER JOIN` - this returns all of the rows from both tables, joined where possible (the inner join is performed first, followed by a left outer join, then a right outer join).
- `CROSS JOIN` - also known as a cartesian join, this returns each combination of possible rows between the tables. There is no `ON` clause used to match rows of data between the two fields.

### What are indexes?
Indexes are a mechanism that SQL engines can use to increase the speed of retrieving information. Indexed data is stored in table like structures which can be quickly accessed via various search algorithms, and link to specific rows within tables. The speed increase is a result of removing the need to sequentially scan every row within a table to find the necessary values. 

### When might we use an index?
Indexes are typically used where sequential scans are not adequate - this might include primary or foreign key columns, columns that are frequent targets of `WHERE` clauses, or columns that are frequently used within an `ORDER BY` clause. While indexes can speed up read speeds, they do slow down write speeds, since every time new data is inserted/updated within the table, the indexes need to be updated as well.

Indexes are automatically created when a primary key, or `UNIQUE` constraint is applied to a given column. Foreign keys do not automatically have indexes applied on them when set on a column, but make for good indexing candidates. Indexes can be unique (primary keys, `UNIQUE` constraint columns) or non-unique (normally in the case of foreign keys).

### What are the different types of index?
Other types of indexes include _multi-column_ indexes, which are indexes created from a combination of columns (though only certain index types (the search algorithm) support multi-column indexes, and the number of columns that can be combined in an index is limited). Another type of index is the _partial_ index, which is an index applied to certain values within a column. They can be defined using the same syntax as creating a normal index, with the addition of a `WHERE` clause. 

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`?
The `EXPLAIN` command provides a step-by-step analysis of how a query will be executed by the SQL engine (a query plan) when prepended to a SQL query. The query plan will show a node-tree, or a list of all the 'elements' within a query; the more clauses that are included, the more nodes that exist within the node-tree.

The `EXPLAIN` command also provides an estimated start-up and total-cost, which are arbitrary values created by the SQL engine using various parameters, and seek to measure the estimated amount of effort and resources required to execute a query. A number of rows and an average width of rows in bytes is also returned.

The `EXPLAIN ANALYZE` command provides the same output as the `EXPLAIN` command, with the addition of actually executing the query, and providing the actual time required to execute the query and the number of rows returned by each node. `EXPLAIN ANALYZE` is useful when extra data may be needed to compare different queries as an effort to optimise database queries. 
