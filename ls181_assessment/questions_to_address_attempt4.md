### What is the relational model of data?
The relational model of data is a structure for expressing structured data as relations and how those relations can interact with each other through through establishing relationships using keys.

### What is a relational database?
A relational database is a construct where structured data is persisted using the relational model of data, such that data is represented as relations, and the interactions between those relations are established through relationships using keys.

### What is a RDBMS?
A relational database management system (RDBMS) is software that enables users or applications to interface with the data housed in relational databases using syntax that conforms to some standard (some particular dialect of SQL). 

### What is a relation?
A relation is some construct that potentially houses some data, that can be interfaced with by a user or application. Examples of relations include views, tables or sequences. Relations can have relationships with other relations, allowing data from multiple locations to be accessed in the single query.

### What is SQL? What is Postgres?
SQL (Structured Query Language) is a special purpose language designed to allow users or applications to interface with a relational database management system, including the databases and relations within those databases. It is a declarative language, meaning it is designed in such a way that abstracts away the implementation details of _how_ a query is executed (this is usually handled by the RDBMS), allowing users to focus on writing SQL to return _what_ data they want.

### What are the three sub-languages of SQL?
SQL has three broad 'sub-languages' that control different aspects of interfacing with relations:
- Data Definition Language (DDL): This sub-language is concerned with the schema of data, or how relations are structured, what databases and/or relations should exist and the constraints on those relations. Common DDL commands include `CREATE`, `ALTER` and `DROP`.
- Data Manipulation Language (DML): This sub-language controls how users or applications can interface with the data inside relations. Common DML commands include `INSERT`, `DELETE`, `UPDATE` and `SELECT`.
- Data Control Language (DCL): This sub-language is concerned with access privileges for relations, controlling what databases, relations or even attributes within those relations users/applications can access. Common commands include `GRANT` and `REVOKE`.

### What is the difference between data and a schema?
A __schema__ relates to the _structure_ of the objects that house data; this can be the underlying databases, tables, views, or even the columns within the tables/views. __Data__ relates to the _values_ inside the schema. A schema without data is an empty structure, whilst data without a schema is unstructured and very difficult to interface with.

### What is a constraint? What purpose does it serve?
In the context of the relational model of data, a constraint is a limiter on what values can be accepted within a column or table. They ensure that data entered into a relation conforms to some expected format or standard determined by business logic. They assist in achieving data integrity, and can assist with referential integrity when primary-foreign key constraints are established between relations.

### What is `NULL` in SQL? Why do we have to be careful with it?
`NULL` values in SQL can represent an 'Unknown' value. When interfacing with columns that have `NULL` values, we need to be careful, since `NULL` values can have peculiar properties:
- `NULL` values are not considered in most aggregate functions like `SUM` or `COUNT`.
- `NULL` values, when used as operands in comparison operators, return `NULL`, rendering these comparison operators useless (we would need to use `IS NULL` instead).
- `NULL` values can show up at different places when column values are sorted. In PostgreSQL, `NULL` values show up first when sorting descending, and show up last when sorting ascending.

### What is normalisation? Why would we use it?
Normalisation is the process of splitting up large relations into multiple, smaller relations and establishing relationships between those relations through the use of primary and foreign keys. Normalisation has the benefit of reducing the amount of duplicate data within a single relation, and reduce the likelihood of anomalies from occuring when interfacing with relations due to data being housed at different levels of granularity, which can improve data integrity.

### What are anomalies?
Anomalies are idiosyncracies that occur due to having unnormalised relations, and data of different granularities stored within those relations. Examples include:
- Update anomaly: In a non-normalised table, there is a risk of inserting data that is intended to represent the same value as an existing entry, but is expressed with a different value (e.g. '7 Book Street' versus '7 Book St'), which causes confusion about what the canonical value should be and increases the variability of the data, making it harder to aggregate. 
- Insertion anomaly: In a non-normalised table, we cannot represent data at lesser levels of granularity without also having data at higher levels of granularity. E.g. in a table of product sales that contains customer details, we cannot access customer data, like their name, unless they have a corresponding sale that would allow them to show up in this product sales table.
- Deletion anomaly: This is the opposite of the insertion anomaly - if more granular data is deleted, then the less granular data will be lost. In our product sales example, if we delete all of the sales information associated with a customer, that customer's details (e.g. name, address) will also be lost, despite those details not being directly relevant to sales.
Anomalies are reduced by normalisation, since data at different levels of granularity are spread across different relations. In our product sales example, this means we don't have to enter less granular data like customer address every time we want to record a sale, reducing the risk of a update anomaly and negating the risk of an insertion and deletion anomaly.

### What is database design? What are the considerations behind it?
Database design is the process of evaluating all real world entities that are generating data, and modelling the data into relations, and how those relations should be able to interact through establishing primary-foreign key relationships. Considerations could include the cardinality and modality of the relations, what specific information should be contained within a relation (and what level of normalisation should exist), and what format data should be stored in, including constraints.

### What is an Entity Relationship Diagram? Why would we use it?
An Entity Relationship Diagram (ERD) is a conceptual-level graphical representation of a relational model of data. It will generally show high level objects, and how those objects interact with other objects. It is generally useful during earlier stages of application design, since it will not likely show more specific implementation details such as the columns and data types within those relations.

### What is a database diagram? What are the different levels at which it can be shown?
A database diagram is a visual representation of a relational model of data. The amount of detail shown can vary according to the different levels at which a database diagram can be shown:
- Conceptual level: This is the database diagram with the highest level of abstraction. The focus is on high level entities and their relations to other entities, and will typically forgo implementation details such as the attributes of each relation, and what their database types are. It is most useful during the earlier stages of application design process.
- Logical level: This is the 'mid-level' database diagram in respect of details shown. Relation attributes may be specified, as well as their types. Database-specific implementation details might not be shown in such a diagram.
- Physical level: This is the most detailed level of database diagram. This will typically show all the planned relations, their attributes, the types of each attribute, and the relationships with other relations. This is most useful during the implementation stage of building an application, where it is necessary to plan out the details of the schemas used to house data generated from an application.

### What are keys? Why would we use them?
Keys are constraints that can be applied to relations in order to establish relationships between them. Primary keys serve as unique identifiers for records within relations, which can match with foreign keys in other relations, thus creating a relationship between records in different entities. This is useful when retrieving data that exists across multiple relations, as well as establishing referential integrity between table (i.e. ensuring that a particular value in one relation references an existing value in another relation).

### What is a primary key?
A primary key is a constraint on a relation that serves as a unique, non-`NULL` identifier for records within a relation, and is how we establish relationships between different relations, by pairing a primary key with a foreign key on another relation. This allows a single query to retrieve data from across multiple relations.

### What is a foreign key?
A foreign key is a constraint on a relation that enables particular records to be matched with a primary key in another relation. The primary-foreign key pair is how relationships between relations are established. Foreign keys, in and of themselves, do not serve as unique identifiers of records within a table (otherwise creating one-to-many or many-to-many relationships would not be possible), and can be `NULL`, unless another constraint is added to the foreign key column within a relation.

### What is a natural key?
A natural key is intended to serve as a unique identifier for a record within a relation by using a value that already exists within a relation. Use of natural keys as unique identifiers can be unreliable, as they rely on business logic or context which can change over time, or may not necessarily be applicable to all use cases - e.g. when a mobile number is used as a natural key to identify people, certain people may not have a mobile number, and some people's mobile number may change over time, which limits it's effectiveness in uniquely identifying all people.

### What is a surrogate key?
A surrogate key is a unique identifier for records in a relation, whose values are generated specifically for the purpose of uniquely identifying a record. They do not rely on existing values, and as such, are less sensitive to changes in business logic, context or unavailability of a value to serve as an identifier (in contrast with a foreign key).

### What is a sequence? Why would we use it? How do we access it?
A sequence is a relation that generates a series of unique sequential numbers. After a sequence returns a value, that value will not be returned again, irrespective of whether that value is used or not. They are frequently used a surrogate key for records in a table to uniquely identify them. A sequence can be accessed by querying it like another relation; e.g. `SELECT nextval('seq_name')`.

### What is referential integrity?
Referential integrity is the assurance that a record within a relation references an existing record within another relation, where a relationship exists between the two relations. It is a way to establish that two normalised relations are able to link together and that a relationship does exist.

### What is cardinality?
Cardinality refers to the number of objects on one side of a relationship between two entities. We typically refer to the cardinality of a relationship as either 'one' (one object on one side of the relationship relates to one or many objects in the other relation) or 'many' (many objects link to another one or more objects in another relation).

### What is modality?
Modality is a term that describes the minimum number of objects that are required to exist in a relationship between two relations. We usually use the terms 'at least zero' (i.e. for every object on one side of the relationship, zero or more objects must exist in the other relation), or 'at least one' (for every object on one side of the relationship, there must be at least one corresponding object in the other relation).

### What are the three types of relationships that can exist between relations?
We typically classify relationships existing between relations as either (they are mutually exclusive):
- One-to-one: One object on one side of a relationship is expected to reference precisely one other object in another relation)
- Many-to-one: Many objects on one side of a relationship are expected to reference precisely one other object in the other relation. The relationship is not true in the other direction (i.e. it is not implied that a single object in the other relation are expected to reference many objects in the first relation).
- Many-to-many: Many objects on one side of a relationship are expected to reference potentially multiple objects in the other relation. The same assumption holds in the other direction of the relationship.

### What are joins? What are the different types of joins?
Joins are a mechanism that allow data to be retrieved from different relations, assuming that a relationship exists between those different relations. Joins are implemented by matching a primary key in one relation to a foreign key in another relation by using an `ON` clause (except in the case of a `CROSS JOIN`).

We can think of 5 major types of joins that link relations to each other.
- `INNER JOIN`: This type of join only returns records where the primary and foreign keys across two relations can be matched. Records where the keys cannot be matched are not returned as part of a query.
- `LEFT OUTER JOIN`: This type of join returns all records in the 'left' relation, and records from the 'right' relation where the primary and foreign keys can be matched. All other records from the 'right' relation will be disregarded
- `RIGHT OUTER JOIN`: This type of join operates in the same manner as a `LEFT OUTER JOIN`; except that all records are returned from the 'right' relation, while only records from the 'left' that can be matched to the 'right' relation via primary and foreign key will be returned. Other records from the 'left' relation will be disregarded.

### What are indexes?
Indexes are a mechanism by which a SQL engine can quickly retrieve values, speeding up the read speed of queries. They operate by storing unique values in a table-like structure with a reference to the location of records where those unique values occur, and are searched by use of a search algorithm (the index type). They are most frequently used when a sequential scan (the default method of locating particular records in a SQL query) is not sufficient/performant enough.

### When might we use an index?
We would typically use an index on columns where a sequential scan of all records is not performant enough/insufficient. For example, foreign key columns are good index candidates, as while primary keys automatically have an index placed on them when the primary key constraint is applied, foreign keys do not automatically benefit from this indexing operation. We might also choose to use an index on columns where there are frequent sort operations used by way of the `ORDER BY` clause, or when the values in a column are frequently used to filter results (e.g. through the `WHERE` clause).

We typically wouldn't use indexes on all available columns, as while indexes can speed up read speeds, every time a new value is inserted into/updated within a relation, the index needs to re-scan the values of that column and re-build the index, thus decreasing the overall write speeds within a relation.

### What are the different types of index?
Aside from the standard index, we can also make use of multi-column indexes, whereby the values of multiple columns can be combined to generate a single index. There are limits to the number of columns that can be used within a multi-column index, as well as the index types (i.e. search algorithms) that support multi-column indexes.

There are also partial indexes, where by only certain values within a column are indexed. This will result in improved read speeds, but only for records that contain the specifically indexed values. This is useful for columns that are frequently used to filter for specific values.

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`?
The `EXPLAIN` command, when prepended to a SQL query, will show a ordered, step-by-step analysis of the query that will be executed by a SQL engine. Each of these 'steps' represents a node in a node tree, which are all of the major 'parts' of a query. The `EXPLAIN` command will also provide an estimated start-up and total cost of executing the query (since the query itself is not run), which represent an arbitrary measurement of how expensive a particular query and all it's 'steps' are to run. A number of rows, and the average width of column values (in bytes) is also returned.

The `EXPLAIN ANALYZE` command, when prepended to a SQL query, will provide the same output as the `EXPLAIN` command, but will also execute the prepended SQL query, thereby providing an actual time taken to execute each node within the node tree (as well as the total time for a query, usually given in milliseconds). It is useful when we want to benchmark different queries that produce a given output in order to optimise performance.
