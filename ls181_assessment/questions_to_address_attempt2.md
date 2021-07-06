### What is the relational model of data?
The relational model of data represents the relationship between relations, where a relation represents a table, view or sequence, through the use of primary and foreign keys in order to allow for interaction between these relations.

### What is a relational database?
A relational database is a construct that persists relations, where a relation contains data. These relations are often modelled using a relational model of data, meaning that each relation may interact with other relations, depending on whether a foreign and primary key pair exists between the two.

### What is a RDBMS?
A RDBMS (Relational Database Management System) is an application that allows for the interfacing with a relational database. It enables users or applications to access the data contained within the relational database using syntax that conforms to a specification (e.g. the Postgres variant of SQL), abstracting away the implementation details of how such queries or commands are executed, allowing users/applications to focus on _what_ they want to interface with.

### What is a relation?
A relation is an entity that can represent a real world object in respect of it's data (e.g. a 'user' or a 'product'). Relations can have relationships with other relations as part of the relational model of data, through the use of primary and foreign keys and normalisation. Examples of relations include tables, views and sequences.

### What is SQL? What is Postgres?
SQL (Structured Query Language) is a special purpose language that is designed for the purpose of querying relations in a database. It is declarative in nature, meaning that the user or application writing the SQL does not need to worry about the implementation details of how to execute a query (this is usually abstracted away by the RDBMS), instead focusing on _what_ data to return from the query itself.

### What are the three sub-languages of SQL?
SQL has three sub-languages that reflect different aspects of interfacing with relations:
- Data Definition Language (DDL): This sub-language focuses on interacting with the _schema_ that data exists inside of; the tables, views and columns that underpin relations. Common commands in DDL include `CREATE`, `ALTER` and `DROP`.
- Data Manipulation Language (DML): This sub-language focuses on interaction with the _data_ inside schemas. Common commands of DDL include `INSERT`, `UPDATE`, `SELECT` and `DELETE`.
- Data Control Language (DCL): This sub-language focuses on the access privileges a user or application may have to interface with the database. Common commands in DCL include `GRANT` and `REVOKE`.

### What is the difference between data and a schema?
A _schema_ relates to the structure of data; e.g. the database, tables and columns that define what data should be contained within a relation. The _data_ refers to the actual values or contents of the relations. Combining data and schemas allow for the creation of useful relational databases where data can be consumed, created or deleted.

### What is a constraint? What purpose does it serve?
A constraint is a specification of the type or format of data that can be inserted into a table or database. One of the key purposes of constraint is to provide data integrity - ensuring that data conforms to a specific format so that it is consistent and useful for decision making. 

### What is `NULL` in SQL? Why do we have to be careful with it?
In SQL, `NULL` represents an unknown value. This can be problematic if `NULL` values are present in a column where comparison operators are used to filter results; `NULL` values return `NULL` when used as an operand for comparison operators, meaning that some rows of data may not be returned. `NULL` values might also appear in unexpected places; when using an `ORDER BY` clause, `NULL` values will appear first when sorting descending, and last when sorting ascending, which may impact the output of any applications that rely on non-`NULL` values.

### What is normalisation? Why would we use it?
Normalisation is the process of splitting a relation across multiple tables and defining relationships between them in order to reduce data duplication and anomalies that may occur through large, non-normalised tables. As relations are normalised, we have to ensure that referential integrity is maintained as these larger relations are split into smaller ones by defining the relationships of these relations through primary and foreign keys.

### What is referential integrity?
Referential integrity is the assurance that values in one relation have corresponding entries in another relation, where a relationship exists between the two. It is a way to reduce the number of 'gaps' in our data and a way to help achieve accurate normalisation of relations.

### What are anomalies?
Anomalies are idiosyncracies that affect the accuracy or availability of data when relations are not normalised. There are typically three types of anomalies associated with non-normalised relations:
- Update anomaly: This anomaly occurs when data that is supposed to represent an existing value is inserted with a different value, leading to confusion about the canonical value (e.g. inserting '2nd Book' instead of 'Second Book' as a value).
- Insertion anomaly: This type of anomaly means that basic, less granular information can only exist in an unnormalised table if accompanied by more granular levels of data (e.g. in an unnormalised table of phone call logs with customer details, a customer's details won't be present in the table unless they first make a call).
- Deletion anomaly: This type of anomaly is related to an insertion anomaly; basic, less granular information will cease to exist in an unnormalised table if all the detailed, more granular information is deleted. In our previous example, if we delete all logs of a customer's phone calls, we will lose the details of that customer altogether.

### What is database design? What are the considerations behind it?
Database design is the process of defining entities that represent data of real world constructs and the relationships that might occur between those entities to model data. At a very granular level, database design can involve considerations about what type of relations should exist, the cardinality and modality of relationships between relations and what attributes and types should exist within relations. At higher level abstraction, it might involve thinking about what entities should exist at all and how they interact with each other, at a very basic level.

### What is an Entity Relationship Diagram? Why would we use it?
An entity relationship diagram (ERD) is a conceptual-level graphical representation of relations and their relationships to one another. It is a useful aid in the high-level modelling of data, until a time where more detail about implementation specifics is required.

### What is a database diagram? What are the different levels at which it can be shown?
A database diagram is a graphical representation of the various relations and their relationships with one another in the context of a database. They assist in the overall modelling of data, and can be shown at varying levels of granularity:
- Conceptual Level: This is the highest level of abstraction - generally, only the high level entities and their relationships are shown in this type of diagram. More specific details, such as the attributes of tables or their types is left out for simplicity.
- Logical level: This is a 'mid-ground' between the conceptual and physical level. The level of detail may include relation attributes and attribute types, but not at a database specific level.
- Physical level: This is the most granular level of diagram; in these types of diagrams, the relations, their attributes, constriants and attribute types might all shown in the diagram, to a database specific level of detail. 

### What are keys? Why would we use them?
Keys are a mechanism by which we can create relationships between relations and enforce referential integrity. Primary and foreign keys can act as a link, allowing information held in numerous relations to be accessed at once; it is a key tool in the normalisation of relations. Referential integrity is achieved though the pairing of primary and foreign keys and constraints on top of those foreign keys, ensuring that data that exists in one relation references existing data in another relation.

### What is a primary key?
A primary key is a unique identifier for a row in a relation (i.e. should never be `NULL`). When combined with a foreign key, the primary and foreign key establish a relationship between two relations, allowing data from two relations to be retrieved at the same time. The key pair can also enforce referential integrity - i.e. ensuring that a value that exists in one relation has a corresponding entry in another relation, where a relationship exists between the two.

### What is a foreign key?
A foreign key is a mechanism that can be used to establish a relationship between two relations, where one of the relations has a primary key. A foreign key should always reference a primary key, though there is no guarantee that a foreign key will always exist for a primary key (foreign keys might take a `NULL` value, unless a constriant is set to explicitly prevent this). When paired with a primary key, foreign keys help establish referential integrity between relations (by ensuring that a value in the relation with a foreign key has a corresponding value in the other relation with a primary key).

### What is a natural key?
A natural key is a value derived from an existing value in the data for the purpose of using it as a specific identifier for a row of data in a relation. Natural keys tend not to be very good unique identifiers of rows, since they can be highly dependent on context or changing values. For example, mobile phone numbers seem like a good unique identifier for people, until we realise that not everyone has a mobile phone number and that people can change mobile phone numbers.

### What is a surrogate key?
A surrogate key is a value that has been generated specifically for the purpose of uniquely identifying a row of data in a relation. Since they are uniquely generated specifically for identification purposes, they are not tied to some context or potentially changing state that a natural key might be tied to.

### What is a sequence? Why would we use it? How do we access it?
A sequence is a relation that generates a series of incrementing numeric values. They are usually used to generate primary keys for a relation, since once a sequence returns a number, it will not return that number again, regardless of whether that number has been 'used' as a primary key.

### What is cardinality?
Cardinality refers to the number of objects on one side of a relationship between two entities. We regard one side of the relationship as having either 'one' or 'many' objects in relation to the other entity; we generally classify relationships as either 'one-to-one', 'one-to-many' or 'many-to-many'.

### What is modality?
Modality refers to the minimum number of objects that must exist in a relationship between two relations. We typically describe modality in respect of a relation requiring 'at least 0' (there is no requirement that there be a corresponding entry in the other relation) or 'at least one' (there must be at least one entry in a relation, relative to the other relation).

### What are the three types of relationships that can exist between relations?
Relationships between relations typical fall under three categories:
- One-to-one: One entry in a relation can correspond to precisely one entry in another relation
- Many-to-one: One entry in a relation can correspond to many entries in another relation. The opposite is not true; i.e. a single entry in the second relation does not correspond to multiple relations in the first relation.
- Many-to-many: One entry in a relation can correspond to many entries in another relation, and the opposite is true; one entry in the second relation can correspond to many entries in the first relation.

### What are joins? What are the different types of joins?
Joins are a method to retrieve information from across multiple relations, where a relationship exists between the two. Joins are achieved by the `JOIN` keyword, linking two relations that have an associated primary and secondary key. There are multiple types of joins available, depending on the use case:
- Inner Joins: This join will only return entries from both relations where the primary and secondary key can be linked. Other entries are not returned.
- Left Outer Joins: This join will return all entries from the first relation (the 'left' relation) with entries from the second relation (the 'right' relation) where a key can be linked to the primary key of the left relation.
- Right Outer Joins: This is the opposite version of the left outer join. All entries from the 'right' relation are returned with entries from the 'left' relation where the key of the right relation can be matched to the key of the 'left' relation.
- Full Outer Join: This returns all entries from the relations; first by returning entries where the primary and foreign keys can be matched between the two relations, then all entries from the first relation where there are no matching keys in the second relation, then all relations from the second relation where there are no matching keys in the first relation.
- Cross Join (Cartesian Join): This returns all combinations of row values in the two relations (i.e. the cross-product of the two relations).

### What are indexes?
Indexes are a mechanism available in SQL engines that allow for faster retrieval of data within relations. Indexes can be set on columns, and store values from that column in a table-like structure, and link to specific rows within that relation. They allow faster querying of values in a column than without indexes, since the SQL engine does not have to sequentially scan through all rows in a relation to locate the rows where a column matches a particular value; instead using a search algorithm (the index type) to quickly fetch the relevant rows.

### When might we use an index?
Indexes can be used wherever sequential scanning of rows might not be sufficient. Primary keys automatically have indexes applied on them; however foreign key columns can also benefit from indexing (they are not indexed by default). Indexes might also be useful on columns where those columns are frequently sorted by value, or a filtered using a `WHERE` clause.

While it might be tempting to index all columns, this often comes at a performance cost when writing or updating data in a relation, since the index has to rebuilt with the new column values.

### What are the different types of index?
Aside from the standard index, _multi-column indexes_ can be created, though there is a limit to the number of columns that can be combined for a single index, and not all index types support multi-column indexes. 

_Partial indexes_ also exist, which index specific values in a column (instead of all values). This can be useful when a column is frequently used to filter for a specific value. 

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`?
The `EXPLAIN` command (when prepended to a SQL query) provides a step-by-step analysis of the query execution within a SQL engine. It provides a list of 'nodes' in a node tree, which we can regard as the different 'steps' in a query, and provides a start up and total 'cost' for executing those nodes (these are often provided in arbitrary units), which provide an indication or estimate of the resources and cost of executing a given query. `EXPLAIN` also provides the number of rows that would be returned by a given query, as well as the average width of the columns returned (in bytes).

`EXPLAIN ANALYZE` provides the same output as `EXPLAIN`, with the addition of the total time taken to execute queries. This can be a useful tool in benchmarking queries when attempting to optimise query speeds in an application.
