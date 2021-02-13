# Slightly Larger Problems
## Table of Contents
- [Debugging with pry](#debugging-with-pry)
- [Splats](#splats)

### Debugging with pry
We need to get good at identifying and fixing errors in our code. 
1. Identify the problem
2. Understand the problem
3. Implement a solution

We typically have two types of errors we need to fix:
1. Syntax errors (non-conformance with programming language grammar, code doesn't run)
2. Logical errors (code logic - the code runs, but unexpected results)

We can use `pry` to debug our code. We can put `require 'pry'` at the top of our code, then insert `binding.pry` in our code, above where the error occurs. 
- A `binding` is something that contains references to any variables that were in scope at the point where it was created. Pry can *see* subsequently created variables, will not have access to their referenced objects (due to a concept named *hoisting*). 
- `pry` interrupts execution and pries open the binding, so we can have a look around.

When the code reaches that line, a `pry` session is invoked. This stops the program from executing further, but gives us access to the program (e.g. access variables). 
- If `binding.pry` is located in a loop or a method invocation with a block, it will be called multiple times, for each iteration.  
- We can use `whereami` to show the code block where `pry` is invoked. `whereami` also takes an optional argument, which tells it how many lines above and below to show.
- We can use `Ctrl + b` to step to the next instance of `binding.pry` in our code. 

We can also type `pry` into our command line, which initiates a REPL. At a basic level, it enables us to evaluable Ruby code, just like in `irb`. However, there are additional debugging capabilities.

One useful function is to change the scope level in our code. 
- We can do this via the `cd` command
- We can exit the scope to a higher level via `cd ..`
- We can switch back to the last scope context via `cd -`
- We go back to the root scope via `cd /`
- We exit `pry` entirely via `exit!`

We can then use the `ls` method to give context about methods available in that scope, on that object. 

We can also use the `show-source method_name -d` method to give us a snapshot of the documentation on an available method. 
```ruby
arr = [1, 2, 3]
cd arr

pry(#<Array>): 1> first
# => 1
```
We can press `q` to exit out of the documentation.

`pry-byebug` is another Ruby gem that extends the functionality of `pry`, allowing us to step through code line by line.  

We need to `require: 'pry-byebug'` in order to use it in our scripts (but we also require `pry`, but also a `binding.pry` in our code). 

Useful commands include:
  - `next`, which jumps to the next executed line of the code (e.g. that our variables goes into as an argument, or is evaluated via an expression).
  - `step`, which will move into the subsequent line of code, whether or not it is executed for our variable (e.g. a value doesn't meet criteria and is not assigned to a new variable)
  - `continue`, which continues program execution and ends the `pry` session.

### Splats
The splat (`*`) operator has a few functions.

*Catch-all* <br/>
When calling a method, we can use the splat operator to act as a 'catch-all' variable for *multiple values*.
```ruby
def go(x, *args)
  puts args.inspect
end

go("a", "b", "c")

['b', 'c']
# => nil
```
In our above example, `'a'` is passed to the `go` method as an argument, via the `x` parameter, as it is the first value passed. The `*args` parameter will capture the rest of any values we pass in to `go`.

*Using an array to pass multiple arguments* <br/>
They let you pass an array into a function expecting multiple arguments. The first item in the array becomes the first argument, the second item becomes the second argument and so on.
```ruby
def go(x, y)
  puts x.inspect
  puts y.inspect
end

point = [12, 10]
go(*point)

# 12
# 10
# => nil
```
The splat operator here is effectively acting as a wildcard - it is effectively creating a variable to hold each element in the array. It allows us to *destructure* an array - it is basically the same as calling `.flatten(1)` on an array, meaning it will only unnest __one__ level (won't unnest subarrays, etc).
