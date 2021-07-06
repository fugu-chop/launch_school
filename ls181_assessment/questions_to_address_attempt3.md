### What is the relational model of data?
The relational model of data is a way of modelling the data generated from real world entities (e.g. a 'user' or a 'product') into different models, and then define the interactions between those relations using relationships (achieved through the use of primary and foreign keys in each relation).

### What is a relational database?
A relational database is a construct that persists data in 'relations', allowing users to interface with data from across multiple relations where a relationship exists between those relations.

### What is a RDBMS?
An RDBMS (relational database maangement system) is a software application that houses potentially relational databases, and allows users to interface with that data using syntax that conforms to some convention (e.g. Postgres). It abstracts a lot of the implementation details about how a SQL engine executes a query; users/applications accessing the RDBMS only need to worry about _what_ data a query returns, not _how_ the query is executed (though this too can be changed if necessary).

### What is a relation?
A relation is an object that represents data from an entity, which can be interfaced with by a user or application. Relations can also have relationships established with other relations, allowing users/applications to access data from across multiple relations, through the use of primary and foreign keys.

### What is SQL? What is Postgres?
SQL (Structured Query Language) is a special purpose language designed for the purpose of interacting with relations in a RDBMS. It is a declarative language, meaning that users are primarily concerned with _what_ the SQL returns, rather than _how_ the SQL returns a given set of results. RDBMS may have their own dialects of SQL.

### What are the three sub-languages of SQL?
SQL can generally be divided into several sub-languages, each focussing on a different aspect of interfacing with relations in a RDBMS.
- Data Definition Language (DDL): This is concerned with the underlying schemas that house data - e.g. databases, tables, columns and their types. DDL defines what data can be entered into a relation, what relations can be created, and even what databases exist within a RDBMS. Common DDL commands include `CREATE`, `ALTER` and `DROP`.
- Data Manipulation Language (DML): This is concerned with interfacing with the data inside of a relation (the column values for a given row of a relation). Common DML commands include `INSERT`, `UPDATE`, `DELETE` and `SELECT`.
- Data Control Language (DCL): This is concerned with user privileges when interfacing with a relation or database. Common DCL commands include `REVOKE` and `GRANT`.

### What is the difference between data and a schema?
A _schema_ determines the shape or structure to which data in a relation must conform. It controls aspects of data such as what types of data are allowed in a relation, what relations exist in a database, and what databases exist in a RDBMS. The data relates to the actual values within a schema. A schema without data would be an empty table, whilst data without a schema would be unstructured, and difficult to use in a consistent, scalable manner.

### What is a constraint? What purpose does it serve?
A constraint is a limitation that can be set over the data. This can help ensure data quality, so that only data that meets certain criteria (e.g. a format, or data type) can exist within a relation. Constraints can be set at the column, table or even database level.

### What is `NULL` in SQL? Why do we have to be careful with it?
Within a SQL context, a `NULL` value in a relation can mean 'unknown', or 'yet to occur', depending on the business context. We have to be careful in interpreting `NULL` values, as it's meaning can change from relation to relation, depending on the business logic governing that relation.

We also have to be careful of using certain operations or commands in SQL, which can treat `NULL` values in different ways. For example, when a `NULL` value is used as an operand as part of comparison operator, a `NULL` value will always be returned. This can result in some unexpected results when filtering for non-`NULL` results within a relation (since `NULL` values may not be returned). `NULL` values are also treated differently in sort operations - when a column is sorted ascending, `NULL` values are returned last, while when sorting descending, `NULL` values are returned first.

### What is normalisation? Why would we use it?
Normalisation is the process of splitting a relation into multiple relations and creating relationships between those relations through keys, creating referential integrity across those relations. Normalisation is used to reduce data duplication in a given relation, and can avoid certain anomalies that result of having non-normalised tables. 

### What are anomalies?
Anomalies are idiosyncracies with the data that can be contained within an unnormalised table. Some types of anomalies include:
- Update anomaly: This occurs when a value is inserted into a relation that is supposed to represent data that already exists, but is inserted with a different value (e.g. '7 Cool Street' versus '7 Cool St.'). This can create confusion as to which is the canonical value. This can be alleviated through constraints on a particular column, but isn't necessarily an anomaly that can be solved through normalisation.
- Insertion anomaly: When a non-normalised table contains data at different levels of granularity, less granular data cannot be inserted into a relation unless it contains more granular data (e.g. if we have an un-normalised table of sales of various products, basic product data won't be shown unless an instance of a particular product is sold first).
- Deletion anomaly: This is the opposite of an insertion anomaly - if all the instance of more detailed, granular data is deleted, then the less granular data is lost and no longer appears in the unnormalised table. 

### What is database design? What are the considerations behind it?
Database design is the process of looking at real world entities, and separating the data generated from these entities into relations, and defining the relationships between these relations. Considerations within database design include how the relationships should function between entities, as well as cardinality and modality of those relationships.

### What is an Entity Relationship Diagram? Why would we use it?
An entity relationship diagram is a conceptual level graphical representation of the various entities whose data is being modelled, and the relationships between those entities. Given the high level of abstraction for an ERD, it is typically used when doing high level, initial designs of the data generated.

### What is a database diagram? What are the different levels at which it can be shown?
A database diagram is a graphical representation of entities and how they relate to one another. More or less detail can be shown, depending on the use case. We can broadly group database diagrams into three different levels of abstraction:
1. Conceptual Level: These types of database diagrams generally don't show much implementation specific detail. They generally show the entities (and not necessarily how many relations those entities are split into), and their relationships with other entities. This is most useful at an early stage of application design, to plan out where data should be captured within an application.
2. Logical level: This is a 'mid-level' diagram, often showing more detail than a conceptual level diagram, such as the actual relations themselves and the attributes of those relations, but will often omit database specific details.
3. Physical level: This type of database diagram typically shows the most granular level of detail, and often contains database level concerns. It will often show the actual relations to be modelled, attributes (columns) of those relations, as well as the data types of those relations. They can be useful when actually implementing the databases and other relations during the creation of an application.

### What are keys? Why would we use them?
Keys are a method through which we can establish relationships between relations. They are used as part of data normalisation to split up data into multiple relations, and one of the tools through which referential integrity can be established between relations. They can help when a user/application is querying data from across different relations, by linking the data from two relations together by matching a primary and foreign key.

### What is a primary key?
A primary key is a unique identifier for individual records within a relation. They cannot be `NULL` by design. They are often paired with foreign keys to link data from different relations to ensure referential integrity, and allow users/applications to return data from multiple relations in a single query.

### What is a foreign key?
A foreign key is a constraint that can be applied to a particular column in a relation, that links it to a record in another relation, thus establishing a relationship between two relations. By default, there is no stipulation that a foreign key has to be unique (in the case of many-to-one relationships), or that it has to be populated, unless additional constraints are applied.

### What is a natural key?
A natural key is a value that is intended to serve as a unique identifier for a record in a relation, where that value is derived from an existing value in the data. They tend not to be the most reliable identifiers in respect of uniqueness and applicability, since the values rely on business context, and might not always be available or may change over time.

### What is a surrogate key?
A surrogate key is a unique identifier for a record in a relation, whose value is generated specifically for the purpose of identifying a record within a relation. Since the value used is not dependent on business context, they tend to be more widely applicable and reliable than using a natural key as a unique identifier.

### What is a sequence? Why would we use it? How do we access it?
A sequence is a relation that generates a series of numbers that is generally used for the purpose of being a unique identifier for a record in a table or view (i.e. generating a surrogate key for use as a primary key). Sequences only ever generate a given value once, whether or not that value is used. This is how the value generated remains unique. However, sequences themselves do not ensure that all values within a column are unique, as those values could be manually inserted via other means. This needs to be achieved by using a `UNIQUE` constraint within a column.

### What is referential integrity?
Referential integrity is the assurance that a record in one relation references an existing record in another relation, where a relationship exists between the two. It is a way of ensuring data accuracy when relations are normalised.

### What is cardinality?
Cardinality refers to the number of objects on one side of a relationship between two relations. We typically think of cardinality of a relationship as being 'one' (a single object is referenced in a given relation relative to the other relation) or 'many' (multiple records can be referenced in a given relation relative to the other relation).

### What is modality?
Modality refers to the minimum number of objects that need to exist when a relationship exists between two relations. We can think of modality as being expressed as 'at least 0' (there is no requirement that every entry in one relation references an entry in another relation) or 'at least 1' (there needs to be at least corresponding entry per entry in the relation).

### What are the three types of relationships that can exist between relations?
There are typically three types of relationships that exist between relations:
- One-to-one: A single record in a relation should only reference a single record in another relation.
- One-to-many: A single record in a relation could reference multiple records in another relation, but the same is not true in the opposite direction (i.e. a single record in the second relation will not reference multiple records in the first relation)
- Many-to-many: A single record in a relation could reference multiple records in another relation, while the same is true in the opposite direction (a single relation in the second reference could also reference multiple records in the first relation).

### What are joins? What are the different types of joins?
Joins are a method by which we can retrieve data across multiple relations, where a relationship exists between the two relations. They are achieved through the use of primary and foreign keys; these are values that should match between two relations. There are a number of joins that can be used to retrieve data, according to the use case:
- Inner Join: This type of join only returns records in both relations where the primary and foreign keys can be matched. All other unmatched records are not returned.
- Left Outer Join: This type of join returns all results from the first relation (the 'left' relation), while entries from the second relation (the 'right' relation) are only returned if the key values from the right relation can be matched with the key values from the left relation.
- Right Outer Join: This is the opposite to a Left Outer Join. This type of join returns all results from the first relation (the 'right' relation), while entries from the second relation (the 'left' relation) are only returned if the key values from the left relation can be matched with the key values from the right relation.
- Full Outer Join: This returns all entries from both relations, joined where possible. Firstly, an inner join is applied, returning records from both relations where the key values can be matched. Next, a left outer join is applied, returning records from the 'left' relation that are unmatched with the 'right' relation, followed by a right outer join, where records that are unmatched with the 'left' relation are returned.
- Cross Join (Cartesian Join): This returns the cross-product of the two relations - i.e. every combination of each distinct column value is returned as a row in the resulting output. No matching of keys occurs in this join.

### What are indexes?
Indexes are a mechanism by which read speeds of certain columns in a relation are improved. When an index is applied to a column, the unique values are stored in a table-like structure, and link back to the specific rows of that relation. The SQL engine uses a search algorithm to find those values instead of sequentially scanning each row of the table for specific values, resulting in faster retrieval of data.

### When might we use an index?
We would most commonly use an index when sequential scanning of all records in a relation is undesirable. This could be useful on columns where those values serve as foreign keys, which allow faster retrieval of specific values when joining relations. They are also useful on columns that are frequently sorted by value, or are used as filters (e.g. in a `WHERE` clause).

While tempting to index all columns, this can result in overall slower performance, since when new data is inserted or updated in a relation, the index needs to be re-scanned, resulting in slower write speeds.

### What are the different types of index?
Multi-column indexes can be used, which is an index created from a combination of multiple columns. This isn't supported by all search algorithms (index types), and there are limits to the number of columns that can be combined for a multi-column index. 

Partial indexes also exist, which only index specific values in a column (not all). This might be particularly useful for columns that are frequently used to filter to a specific value (like in a `WHERE` clause).

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`?
The `EXPLAIN` command (when prepended to a SQL query) provides a step-by-step breakdown of the various steps that a SQL engine will execute to process a query. The output will typically show a node-tree, where each 'node' represents a 'step' of the query. The output will also show a start-up and total cost for each node (in arbitrary units), which represents the estimated resource and cost of a given query. `EXPLAIN` will also show the number of rows returned, as well as the average width of the columns returned, in bytes.

The `EXPLAIN ANALYZE` command provides the same output as the `EXPLAIN` command; however, it will also execute the query and provide the actual time taken to execute the various nodes of the query, which can be useful when benchmarking different queries that achieve the same thing when optimising for performance.
