# Variables

## Table of Contents
[What is a variable?](#what-is-a-variable)
[Scope](#Scope)

### What is a variable
Variables are used to store information in memory, to be referenced and manipulated in a computer program, acting as containers. 

We assign variables using the `=` symbol. 

The point about variables being stored in memory is pertinent - they are not linked in some deeper fashion when other variables change. Take the following example:
```
a = 4
b = a
a = 7
puts b
=> 4
```
### Getting user input
We can use `gets` to obtain user input. We chain the `.chomp` method to remove the newline (`\n`) that gets added to `gets`. 
```
name = gets 
"Bob"
puts name
=> "Bob\n"

name = gets.chomp
"Bob"
puts name
=> "Bob"
```
### Scope
A variable's scope determines *where* in a program a variable is available for use. A variable's scope is defined by *where the variable is initialized or created*. 

In Ruby, variable scope is defined by a __block__. A block is a piece of code following a method invocation, usually delimited by either curly braces `{}` or `do end`. Be aware that not all do/end pairs imply a block.

__Inner scope can access variables initialized in an outer scope, but not vice versa.__
```
a = 5             # variable is initialized in the outer scope

1.times do |n|    # method invocation with a block
  a = 3           
end

puts a
=> 3
```
`a` is available to the inner scope created by `1.times do ... end`, which allowed the code to re-assign the value of `a`.