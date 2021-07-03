### What is the relational model of data?
The relational model of data maps out the relationships between structured data (relations, or entities that can be queried or altered by users or applications) by using keys in each relation (which could be a table or view, in this context) to determine how these entities can interact with each other. 

### What is a relational database?
A relational database is a construct that stores multiple relations using a relational model of data. 

### What is a RDBMS?
A relational database management system (RDBMS) is a software application that allows interaction with a relational database. Their role is to allow users or applications to interact with the relations within that relational database using syntax that conforms to a specified convention.

### What is a relation?
A relation is an entity that represents data, that can be interacted with by a user or application through a RDBMS. Relations can interact with each other by defining the relations in a relational model of data, through a series of keys.

### What is SQL? What is Postgres?
SQL (Structured Query Language) is a special purpose language designed to allow users or applications to interact with relations within a RDBMS, It is a declarative language, meaning that the actual implementation of _how_ a query is executed by a RDBMS is abstracted away from the end user, and handled by the specific RDBMS, allowing users to focus on writing syntax that specifies _what_ data they want from the RDBMS.

### What are the three sub-languages of SQL?
SQL has three sub-languages that control different aspects of interacting with relations in a RDBMS.
- Data Definition Language, which deals with the creation, alteration and deletion of schemas (i.e. tables, databases, or columns within relations).
- Data Manipulation language, which deals with the creation, updating, deletion and reading of data stored within relations.
- Data Control Language, which deals with access privileges of users or applications interacting with the RDBMS - i.e. controlling what level of interaction that users can have with the database.

### What is the difference between data and a schema?
_Schemas_ define how data is structured within a relation - a schema relates to the underlying table structure (columns) and constraints or requirements of what data can be stored within a relation. _Data_ relates to the actual values within columns in a relation. Data must be combined with a schema to create a relation that can be interacted with by a user or application.

### What is a constraint? What purpose does it serve?
A constraint provides restrictions on what kind of data can be stored within a relation, or how that data can interact with data in another relation (in the case of foreign keys). They are useful in establishing _data integrity_, by ensuring that only data that follows a consistent format is allowed to be input into a relation, as well as _referential integrity_, meaning that data that is intended to reference data in another relation does have a corresponding entry in the other relation (in the case of foreign keys).

### What is `NULL` in SQL? Why do we have to be careful with it?
`NULL` in SQL represents an unknown value. When designing a schema for a relation, it is important to think about whether unknown values should be allowed to exist within that relation, according to business logic. `NULL` values need to be treated carefully when using comparison operators; unlike other data types in SQL, when used as an operand for a comparison operator, a `NULL` value will always be returned. 

This may be problematic when a value in a column may be intended to reference another entry in another relation (which may violate referential integrity), or create strange behaviours (such as affecting the ordering of data when using an `ORDER BY` clause, depending on which direction the data is sorted in, or allowing three values in a BOOLEAN type column).

### What is normalisation? Why would we use it?
Normalisation is the process of breaking up the data within a given relation into multiple relations, and defining the relationships between those relations (i.e. how those relations can interact with one another). Normalisation is useful in removing duplicate information within a relation (reducing data redundancy), as well as reducing the potential for anomalies to occur when data is inserted or deleted from those relations (improving data integrity).

### What are anomalies?
In the context of SQL, anomalies represent adverse impacts on data quality or usability when tables are not normalised. There are several types of anomalies:
- Update anomalies: This refers to a violation of data integrity, when there may be updates to entries that are inconsistent with existing data (e.g. inserting an entry into a relation where the value is 'The 2nd Coming' versus a value of 'The Second Coming' that already exists within the database).
- Insert anomalies: Basic information can only be inserted into a non-normalised table if it contains more detailed information (e.g. for a relation that models phone calls, a user can only exist in that relation if they have made a phone call in the first place).
- Deletion anomalies: This is the opposite of an insertion anomaly. If all detailed information about more basic data is deleted, the basic information ceases to exist within that relation (e.g. using our earlier example, if we delete all previous call logs of a user, less granular information about that user will no longer exist in the relation)

### What is database design? What are the considerations behind it?
Database design is the process of determining how data should be modelled as entities, and how those entities should interact with one another through the use of primary and foreign keys. Entities can be regarded as real world objects represented by data, in the form of relations.

### What is an Entity Relationship Diagram? Why would we use it?
An entity relationship diagram is a graphical representation of the data entities that exist within a database, and the relations between those entities. It is a relatively high view, regarded as a conceptual diagram. Implementation details, such data types, attributes of the entities are not represented, for the purpose of simplifying the overall design process.

### What is a database diagram? What are the different levels at which it can be shown?
Database diagrams are graphical representations of the entities that exist within a database, and the relations between those entities. There are typically three levels of database diagrams, which vary in the amount of detail they represent:
- Conceptual level: This is a very high level abstraction of entities and how they relate to other entities. Details like data types and attributes (columns) are typically not shown in this level of diagram.
- Logical level: This level generally shows a level of detail between the conceptual and physical level. It will show relations and their relationships to other relations, but may also show the attributes of the individual relations. It typically does not show database specific details of an implementation.
- Physical level: This is the most detailed of database diagrams. It will not only show the entities and the relationships between them, but also the attributes (columns), data types, cardinality and modality of the relationships. This is most useful when designing the actual implementation of a database.

### What are keys? Why would we use them?
Keys are a mechanism through which we can establish relationships _between_ relations through the use of priamry and foreign keys. Keys also enable the unique identification of a row within a relation (using the primary key). They are a way that referential integrity can be enforced - i.e. by ensuring that all columns values in a relation reference existing values in other relations, where a relationship exists between those two relations.

### What is a primary key? *
A primary key is a type of constraint that can be placed on a column within a relation. It is a unique identifier for rows within a relation, and serves as a method to establish referential integrity with other relations, where those relations have a relationship (through the use of foreign keys).  All values in a primary key column should be unique, and not `NULL`.

### What is a foreign key? *
A foreign key is a type of constraint that can be applied to a column. It is intended to serve as a method to establish referential integrity between a pair of relations; the value in the foreign key column should reference the primary key in another relation. A foreign key column, unlike a primary key, can have `NULL` values (unless another constraint is specifically used to prevent this), and do not have to be unique (otherwise achieving referential integrity in one-to-many relationships would not be possible).

### What is a natural key?
A natural key is an identifier for a row of data (intended to establish referential integrity between relations) whose value is generated by using the data that already exists within a relation (e.g. using a person's mobile phone number as a key). Natural keys can be problematic, since they depend on a context being correct, which may change over time (e.g. a particular person may change mobile phone number), or they might not be necessarily applicable (not everyone might have a mobile phone number).

### What is a surrogate key?
A surrogate key is an identifier for a row of data using a value sepcifically generated for the purposes of identifying that row. It mitigates many of the issues associated with using a natural key.

### What is a sequence? Why would we use it? How do we access it?
A sequence is a relation that generates sequential numbers. Once the sequence has returned a number, that number will not be returned again, regardless of whether or not it is used. Sequences can be useful in generating primary keys, since sequences will only ever generate a number once, ensuring uniqueness. We can access the next number generated by a sequence using the `nextval('sequence_name')` syntax.

### What is referential integrity? *
Referential integrity is an assurance that all the values in a column reference existing values in another relation exist, where a relationship exists between the two relations. It is a way to ensure data integrity between relations as normalisation occurs. We typically achieve referential interity through the use of primary and foreign keys.

### What is cardinality?
Cardinality refers to the number of objects on one side of a relationship between two relations. Cardinality (on one side of the relationship) is usually regarded as either one (only one row corresponds to another) or many (one row corresponds to many rows).

### What is modality?
Modality refers to the minimum number of objects that need to occur in each relation when a relationship exists between two relations. We typically regard relationships as having a modality of at least 0 (i.e. a corresponding entry does not have to exist in another relation) or at least 1 (when a relationship exists, each relation must have a row that references at least one row in another relation).

### What are the three types of relationships that can exist between relations?
There are typically three types of relationships that occur between relations (in respect of cardinality):
- One-to-one: A single row in one relation only corresponds to a single row in another relation. These are fairly rare, as when a one-to-one relationship occurs, it may be easier to ahve all the data in a single relation, rather than split out into two.
- One-to-many: A single row in a relation corresponds to multiple rows in another relation. This usually means that there are multiple foreign keys for each primary key.
- Many-to-many: Multiple rows in a relation can correspond to multiple rows in the other relation. This is usually achieved using a join table between two tables.

### What are joins? What are the different types of joins?
Joins are a mechanism in SQL that we can use to retreive data from across multiple relations that have been normalised. There are typically 4 types of joins:
- `INNER JOIN`: This type of join returns rows that exist in both relations (i.e. rows where a foreign key exists for the primary key).
- `LEFT OUTER JOIN`: This type of join returns all rows in the left table, as well as rows in the right table that can be matched with the left table (i.e. rows where the foreign key in the right table can be matched with the primary key in the left table).
- `RIGHT OUTER JOIN`: This type of join returns all rows in the right table, as well as rows in the left table that can be matched with the right table (i.e. rows where the foreign key in the left table can be matched with the primary key in the right table).
- `FULL OUTER JOIN`: This type of join returns all rows from both tables, joined where possible. An inner join is first performed, returning rows that have corresponding primary and foreign keys. A left join is then performed, reutrning all entries in the left table that don't have a corresponding entry in the right table. Finally, a right join is performed, returning rows in the right table that don't have a corresponding entry in the left table.

### What are indexes? *
Indexes are a mechanism that allow fast retrieval of data in relations. Indexed data is stored within table like structures, and link back to specific rows in a relation where those indexed values occur. They are fetched using specific search algorithms. The speed increase in retrieval occurs due to removing the need to sequentially scan through every row in the database to find the appropriate values.

### When might we use an index?
Columns that benefit from indexing are typically those where sequential scanning of rows is insufficient, such that primary and foreign keys, columns that are frequently sorted using `ORDER BY` clauses, as well as those columns that frequently filtered using `WHERE` clauses.

Indexes should not be overused though; where they increase read speeds, having more indexes slows down write speeds, since the index must be updated every time a new entry is added to the relation.

### What are the different types of index?
One type of index is the multi-column index, which combines values from multiple columns to generate an index. There are limits to the number of column that can be combined for a single index, and the search algorithm types (index types) supported are limited. 

There are also partial indexes, which only index a specific subset of values within a column. This allows much faster reads for specific values that are frequently used (e.g. in a `WHERE` clause).

### What does the `EXPLAIN` command do? How is it different from `EXPLAIN ANALYZE`? *
The `EXPLAIN` command provides a step-by-step query plan in respect of how an SQL engine will execute a particular query, as well as the start-up and execution cost associated with the different components of that query, which represent an arbitrary measurement of the resource and effort cost required to execute a query. Note that with `EXPLAIN`, the query is not actually executed.

When `EXPLAIN ANALYZE` is used, as well as providing the same information as the `EXPLAIN` command, `EXPLAIN ANALYZE` will execute the actual query, returning how long each "node" of the query took to execute.
