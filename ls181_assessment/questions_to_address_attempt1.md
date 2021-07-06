### What is the relational model of data?
The relational model of data defines different relations (e.g. views, tables and sequences) and their relationships to one another (which defines how these relations can interact with one another), through the use of keys, where each relation represents a real world object (e.g. a customer, or a product).

### What is a relational database?
A relational database is a construct that persists structured data that follows the relational model of data (i.e. where data is stored in the form of relations, and each relation has specific relationships and methods of interactions with other relations).

### What is a RDBMS?
An RDBMS is a relational database management system. It is a software or application that allows users or applications to interface with an underlying relational database using syntax that conforms to a specification. An example of an RDBMS is Postgres.

### What is a relation?
A relation is a set of data that exists within a relational model of data, and can be interacted with by users and applications through an RDBMS in various ways). Examples of relations include tables, views and sequences.

### What is SQL? What is Postgres?
SQL (structured query language) is a declarative language that is used specifically to interact with data or schemas within a database (i.e. a special purpose language). Postgres is an RDBMS that allows users or applications to use SQL to interface with the relational model of data housed within the RDBMS. The RDBMS abstracts away the implementation level specifics of how a SQL query is executed; the user generally only needs to worry about writing syntax that returns _what_ they want, and not _how_ to run a query within a RDBMS.

### What are the three sub-languages of SQL?
There are three sub-languages of SQL:
- Data Definition Language (DDL): This sub-language deals with the underlying databases and schemas of data (i.e. the structure of data), and not the data itself (though data may be affected as a side-effect, like dropping a database). Commands associated with DDL include `CREATE`, `DROP` and `ALTER`.
- Data Manipulation Language (DML): This sub-language is concerned with interaction with the data contained within relations, and less about the schemas that house the data. Common commands within DML include `SELECT`, `DELETE`, `INSERT` and `UDPDATE`.
- Data Control Language (DCL): This sub-language is primarily concerned with the access privileges to the database or individual relations wtihin those databases. Common commands in DCL include `GRANT` and `REVOKE`.

### What is the difference between data and a schema?
_Schemas_ refer to the underlying structure that houses data, and govern the types of data and any constraints that affect what data can be inserted/updated within a relation. Databases, tables and columns are schema-level concerns. _Data_ relates to the actual content within these schemas - the rows within a relation are usually data-specific concerns. When combined, data and schemas can create relations, which can then be modelled into a relational model of data, which facilitates the consumption, creation and changing of data by a user or application.

### What is a constraint? What purpose does it serve?
A constraint is a limitation on what type of data can be inserted/updated/deleted from a relation, as well as the relationships between these relations (i.e. how these relations are able to interact). They are introduced to the schemas to improve data integrity, by helping to ensure that only values that are in-line with expectation and business logic can be inserted into relations.

### What is `NULL` in SQL? Why do we have to be careful with it?
Unlike most other languages, `NULL` in SQL usually means an "unknown" value. When designing relations, it is important to define whether `NULL` values should be accepted within a relation, as this can have implications on how data is accessed and returned. As an example, `NULL` values always return `NULL` when used as part of comparison operators, making the use of the comparison operator less useful if there are lots of `NULL` entries. Another example is that when sorting the values of a column by a `ORDER BY` clause, `NULL` values are usually returned before other results when performing a descending sort, and last when performing an ascending sort.

### What is normalisation? Why would we use it?
Normalisation is the process of splitting up larger relations into multiple smaller relations for the purposes of reducing data duplication, ensuring referential integrity, and making the underlying information to parse by a user or application. Normalisation usually involves splitting up data into multiple relations, and defining the points of interaction between those relations through the use of primary and foreign keys, The use of primary and foreign keys help achieve referential integrity - i.e. that values within one relation exist in another relation where a relationship exists between the two relations. Database normalisation also reduces the risk of anomalies, due to specifying the different locations where data must exist (e.g. across two tables), and potentially reducing the dependencies of that data on other data to be shown (e.g. data only needs to be updated in one place, reducing the risk of an update anomaly).

### What are anomalies?
An anomaly is a violation of the principles of normalisation, which can lead to lower data integrity and increased data duplication. Three examples of anomalies include:
- Update Anomaly: An update anomaly can occur when two or more entries exist in the data that are intended to refer to the same thing - e.g. a typo in the name of a book would likely be treated as two different books, and it would be difficult to determine which is the correct title after the fact. 
- Insertion Anomaly: This type of anomaly usually occurs when a relation is not normalised. For insertion anomalies, less granular information cannot be inserted into a relation, where the grain of that data is at a different level. An example would be a wide 'call log' table; without normalisation, basic information about a customer could not appear in that table if they had not previously made a call (again, assuming the data is not normalised).
- Deletion Anomaly: This is the opposite of an insertion anomaly - in a non-normalised table, deleting the more detailed information will also result in the more basic, less granular information being deleted. In our previous example, if we deleted all call logs relating to a particular customer, we would lose the basic customer information if the table is not normalised.

### What is database design? What are the considerations behind it?
Database design refers to architecting different relations to represent data of different real world objects, and how these relations should interact with each other. It can involve determining how data should be broken up into relations, how these relations should or can interact with each other, and the cardinality and modality of the relationships.

### What is an Entity Relationship Diagram? Why would we use it?
An Entity Relationship Diagram (ERD) is a graphical representation of different relations, and what relationships exist between the relations. An ERD is usually displayed at a fairly high level of abstraction (a conceptual level diagram) to make it easier to design the overall picture of relations and how they interact.

### What is a database diagram? What are the different levels at which it can be shown?
A database diagram is a visual representation of what different relations in a database exist and how they should interact with one another. The level of detail contained within a database diagram can depend on the use-case, but there are generally three level of granularity at which a database diagram is shown:
1. Conceptual level: These diagrams usually show the lowest level of detail. They are more focused on defining what relations exist and the general relationship between these relations. More specific implementation details, such as attributes (columns) and types of these attributes are not shown.
2. Logical level: This is a 'mid-level' database diagram in respect of detail. It may show attributes of relations and even their data types, but won't typically include detail that's specific to a database.
3. Physical level: This database diagram usually shows the most granular level of detail for relations. It can show what attributes exist within a relation, the data types of those attributes, as well as constraints applied to those attributes or relations. This is most useful when it's time to implement the relations in an application.

### What are keys? Why would we use them?
Keys are a way that we can establish relationships between relations and facilitate referential integrity. A primary-foreign key pair indicates that the data in the different relations is intended to interact with each other in a specific way, and can contain constraints and instructions on how to deal with deleted/non-existent data. 

### What is a primary key?
A primary key acts as a unique identifier for individual rows within a relation. They cannot be `NULL` and must be unique. They can be paired with foreign keys to create relationships between different relations, according to business logic or application requirements, and can act as a way to ensure referential integrity - e.g. an entry in a relation that serves as a foreign key should have a value in another relation where the foreign key has a corresponding primary key.

### What is a foreign key?
A foreign key is a constriant that can be applied to a column in a relation. When applied, the foreign key helps facilitate referential integrity - i.e. that the values for a given foreign key should exist within another relation where the other relation has the correpsonding primary key. Foreign keys are not inherently unique across different rows, and can even take `NULL` values, so some care is required when inferring relationship characteristics between relations.

### What is a natural key?
A natural key is a value that is intended to act as a primary key, but uses an existing value in the relation. Natural keys tend not to be good unique identifiers of rows within a relation due to their reliance on context or a particular state in time. E.g. a mobile phone number might be a good candidate for a primary key, but not all people have mobile phone numbers, and a person's mobile phone number may change over time.

### What is a surrogate key?
A surrogate key is a value that is generated specifically for the purposes of acting as a unique identifier for a row in a relation. They are typically more reliable than primary keys generated from natural keys, since they are less dependent on business logic, context or states in time to generate their uniqueness.

### What is a sequence? Why would we use it? How do we access it?
A sequence is a relation that generates a sequential series of numbers. They are useful constructs to generate surrogate primary keys for relations, since once a sequence returns a number, it cannot return that same number again. We can generate a sequence using the `CREATE SEQUENCE seq_name;` and access the sequence using `SELECT nextval('seq_name')`.

### What is referential integrity?
Referential integrity is the assurance that all column values in one relation reference existing values in another relation, where a relationship exists between the two relations. It is a way to ensure that data is correctly normalised across different entities, and that there are fewer gaps in the data stored.

### What is cardinality?
Cardinality refers to the number of objects on one side of a relationship between two relations. We typically refer to a relationship as having 'one' or 'many' objects per object in the other relation.

### What is modality?
Modality refers to the minimum number of objects that are required when a relationship exists between two relations. We typically refer to a relation as requiring either 'at least 0' (where the relation does not need to have an entry for every entry in the other relation), or 'at least 1' (where each entry in one relation must have at least one entry in the other relation) for modality.

### What are the three types of relationships that can exist between relations?
In respect of cardinality, relations generally fall into three categories:
1. One-to-one: Each entry in one relation corresponds to exactly one entry in the other relation. This relationship is somewhat unusual, in that it may make sense to simply combine the two relations together.
2. One-to-many: One entry in a relation should correspond to multiple entries in the second relation. The relation is not implied in the other direction (e.g. an entry in Relation A may correspond to multiple entries in Relation B, but this does not imply that a single entry in Relation B should have multiple entries in Relation A).
3. Many-to-many: One entry in a relation should correspond to multiple entries in the second relation. The relation is also implied in the other direction (e.g. an entry in Relation A may correspond to multiple entries in Relation B, and a single entry in Relation B can also have multiple entries in Relation A).

### What are joins? What are the different types of joins?
Joins are a mechanism through which we can match primary and foreign keys in different relations to combine data for a query, that would otherwise not exist in a single, normalised table. There are 5 types of joins we normally see:
1. `INNER JOIN` - Only rows that have matched primary and foreign keys are returned by the query.
2. `LEFT JOIN` - All entries in the 'left' table are returned, while entries in the 'right' table are only returned if the foreign keys match the primary keys in the 'left' table.
3. `RIGHT JOIN` - All entries in the 'right' table are returned, while entries in the 'left' table are only returned if the foreign keys match the primary keys in the 'right' table.
4. `FULL OUTER JOIN` - All entries are returned from both relations. This combines the `INNER`, `LEFT` and `RIGHT` joins in the execution of the join. First, rows that have matching primary and foreign keys are returned. Secondly, all entries in the left table are returned, that don't have a corresponding foreign key in the right table, followed by entries in the right table that don't have a corresponding foreign key in the left table.
5. `CROSS JOIN` - Every combination of row values (i.e. the cross-product) is returned in the results (known as a cartesian join). No `ON` clause is required, since nothing is 'joined'.

### What are indexes?
Indexes are a mechanism which allow for faster read queries. They work by storing distinct values of a column in a table-like structure and link to specific rows in a table. The values themselves are retrieved through a search algorithm. They provide faster read speeds, since the SQL engine no longer has to sequentially scan through every row in a table.

### When might we use an index?
We would use an index when a sequential scan of the relation is not sufficient; indexing foreign keys can be a good way to improve the speed at which joins can be executed, and columns where the values frequently make use of `ORDER BY` or `WHERE` are also good candidates. While it may be tempting to create indexes for every column, this may result in poorer overall performance of a database, since indexes need to be updated every time new data is inserted into a relation, which slows down write speeds.

### What are the different types of index?
Aside from the 'standard' index that can be created, it is possible to create _multi-column_ indexes through the `CREATE INDEX (col1, col2)` syntax. This allows multiple columns to create a single value that can be indexed, though whether this is supported depends on the search algorithm implemented (the index type). There is also a limit on the number of columns that can be used in a multi-column index. 

Partial indexes also exist - these are indexes that are only applied to certain values within a column; this can be beneficial when certain values in a column are frequently used to filter results (through a `WHERE` clause), providing improved read speeds.

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`?
The `EXPLAIN` commands provides a step-by-step breakdown of the different steps the SQL engine will take to execute a query, but does not execute the query. The output will generally provide an estimated start-up and total cost to execute the overall query (measured in arbitrary units), as well as a breakdown of the costs on different nodes (we can regard a 'node' as a 'step' or component of a query). This provides an estimated overview of the resources and complexity of executing a query. The `EXPLAIN` command output also produces an overview of how many rows will be returned, as well as the average width of the returned query (in bytes).

The `EXPLAIN ANALYZE` command provides the same estimates as the `EXPLAIN` command, but with the added step of running the appended query. This allows the output to provide the actual time taken to start up and execute the query, which can be helpful when comparing different queries for the purposes of optimising database performance.
