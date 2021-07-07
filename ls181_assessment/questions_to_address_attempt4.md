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

### What are keys? Why would we use them?

### What is a primary key?

### What is a foreign key?

### What is a natural key?

### What is a surrogate key?

### What is a sequence? Why would we use it? How do we access it?

### What is referential integrity?

### What is cardinality?

### What is modality?

### What are the three types of relationships that can exist between relations?

### What are joins? What are the different types of joins?

### What are indexes?

### When might we use an index?

### What are the different types of index?

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`?
