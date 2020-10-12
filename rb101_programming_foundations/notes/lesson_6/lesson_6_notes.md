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

We can use `pry` to debug our code. We can put `require: 'pry'` at the top of our code, then insert `binding.pry` in our code, above where the error occurs. 
- A `binding` is something that contains references to any variables that were in scope at the point where it was created. Pry can *see* subsequently created variables, will not have access to their referenced objects (due to a concept named *hoisting*). 
- `pry` interrupts execution and pries open the binding, so we can have a look around.

When the code reaches that line, a `pry` session is invoked. This stops the program from executing further, but gives us access to the program (e.g. access variables). 
- If `binding.pry` is located in a loop or a method invocation with a block, it will be called multiple times, for each iteration.  
- We can use `whereami` to show the code block where `pry` is invoked. `whereami` also takes an optional argument, which tells it how many lines above and below to show.

We can also type `pry` into our command line, which initiates a REPL. At a basic level, it enables us to evaluable Ruby code, just like in `irb`. However, there are additional debugging capabilities.

One useful function is to change the scope level in our code. 
- We can do this via the `cd` command
- We can exit the scope to a higher level via `cd ..`
- We can switch back to the last scope context via `cd -`
- We go back to the root scope via `cd /`
- We exit `pry` entirely via `exit!`

We can then use the `ls` method to give context about methods available in that scope, on that object. 

We can also use the `show-source method_name -d` method to give us a snapshot of the documentation on an available method. 
```
arr = [1, 2, 3]
cd arr

pry(#<Array>): 1> first
=> 1
```
We can press `q` to exit out of the documentation.

`pry-byebug` is another Ruby gem that extends the functionality of `pry`, allowing us to step through code line by line.  

We need to `require pry-byebug` in order to use it in our scripts (but we also require `pry`, but also a `binding.pry` in our code). 

Useful commands include:
  - `next`, which jumps to the next executed line of the code (e.g. that our variables goes into as an argument, or is evaluated via an expression).
  - `step`, which will move into the subsequent line of code, whether or not it is executed for our variable (e.g. a value doesn't meet criteria and is not assigned to a new variable)
  - `continue`, which continues program execution and ends the `pry` session.