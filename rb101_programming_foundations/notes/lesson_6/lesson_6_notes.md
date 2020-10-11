# Slightly Larger Problems
## Table of Contents
- [Debugging with pry](#debugging-with-pry)

### Debugging with pry
We need to get good at identifying and fixing errors in our code. 
1. Identify the problem
2. Understand the problem
3. Implement a solution

We typically have two types of errors we need to fix:
1. Syntax errors (non-conformance with programming language grammar, code doesn't run)
2. Logical errors (code logic - the code runs, but unexpected results)

We can use `pry` to debug our code. We can put `require: 'pry'` at the top of our code, then insert `binding.pry` in our code, above where the error occurs. When the code reaches that line, a `pry` session is invoked. This stops the program from executing further, but gives us access to the program (e.g. access variables). 