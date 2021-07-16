1) What is the largest value that can be stored in the amount column? Use psql to illustrate what it is.
```sql
INSERT INTO expenses (amount, memo)
  VALUES (10000, 'largest amount value possible');
/*
ERROR:  numeric field overflow
DETAIL:  A field with precision 6, scale 2 must round to an absolute value less than 10^4.
*/
```
2) What is the smallest value that can be stored in the amount column? Use psql to illustrate what it is.
```sql
INSERT INTO expenses (amount, memo)
  VALUES (-10000, 'smallest amount value possible');
/*
ERROR:  numeric field overflow
DETAIL:  A field with precision 6, scale 2 must round to an absolute value less than 10^4.
*/
```
3) Add a check constraint to the expenses table to ensure that amount only holds a positive value.
```sql
ALTER TABLE expenses
  ADD CHECK(amount > 0.01);

INSERT INTO expenses (amount, memo)
  VALUES(0, 'zero amount');
/*
ERROR:  new row for relation "expenses" violates check constraint "expenses_amount_check"
DETAIL:  Failing row contains (1, 0.00, zero amount, 2021-07-16).
*/
```
