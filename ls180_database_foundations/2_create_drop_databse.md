1) From the Terminal, create a database called database_one

`createdb database_one`

2) From the Terminal, connect via the psql console to the database that you created in the previous question.

`psql -d database_one`

3) From the psql console, create a database called database_two.

`CREATE DATABASE database_two;`

4) From the psql console, connect to database_two

`\c database_two`

5) Display all of the databases that currently exist

`\list`

6) From the psql console, delete database_two

`DELETE DATABASE database_two`

7) From the Terminal, delete the database_one and ls_burger databases

`dropdb database_one`
`dropdb ls_burger`
