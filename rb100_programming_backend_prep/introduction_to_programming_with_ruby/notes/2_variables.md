# Variables

## Table of Contents
[What is a variable?](#what-is-a-variable)
[Scope](#Scope)
[Types of Variables](#types-of-variables)

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

In Ruby, variable scope is defined by a __block__. A block is a *piece of code following a method invocation*, usually delimited by either curly braces `{}` or `do end`. 

__Inner scope can access variables initialized in an outer scope, but not vice versa.__
```
a = 5             # variable is initialized in the outer scope

1.times do        # method invocation with a block
  a = 3           
end

puts a
=> 3
```
`a` is available to the inner scope created by `1.times do ... end`, which allowed the code to re-assign the value of `a`.

Contrast that with:
```
a = 5

1.times do        # method invocation with a block
  a = 3
  b = 5           # b is initialized in the inner scope
end

puts a
puts b

=> 3
=> NameError (undefined local variable or method `b' for main:Object)
```
This is because the variable `b` is not available outside of the method invocation with a block where it is initialized. When we call `puts b` it is not available within that outer scope.

The key distinguishing factor for deciding whether code delimited by `{ }` or `do end` is considered a block (and thereby creates a new scope for variables), is seeing if the `{ }` or `do end` *immediately follows a method invocation*.
```
arr = [1, 2, 3]

for i in arr do
  a = 5      # a is initialized here
end

puts a
=> 5
```
`a` is accessible here since `for...do end` code __did not create a new inner scope__, since for is part of Ruby language and __not a method invocation__. When we use `each`, `times` and other method invocations, followed by `{ }` or `do end`, that's when a new block is created.

### Types of Variables
###### Constants
`CONSTANTS` are declared by capitalizing every letter in the variable's name. They are used for storing data *that never needs to change*. 

While most programming languages do not allow you to change the value assigned to a constant, Ruby does. It will however throw a warning, letting you know that there was a previous definition for that variable.

Constants __cannot__ be declared in method definitions (i.e. *you can't assign a constant in the body of a method*), and are available throughout your application's scopes.

###### Global
`$global` variables are declared by starting the variable name with the `$`. These variables are available throughout your entire app, overriding all scope boundaries. 

We tend to stay away from global variables as there can be unexpected complications when using them.

###### Class
`@@class` variables are declared by starting the variable name with two `@` signs. These variables are accessible by instances of your class, *as well as the class itself*. 

When you need to declare a variable that is related to a class, but each instance of that class does not need its own value for this variable, you use a class variable. 

Class variables __must be initialized at the class level__, outside of any method definitions. They can then be altered using class or instance method definitions.

###### Instance
`@instance` variables are declared by starting the variable name with one `@` sign. These variables are available throughout the current instance of the parent class. Instance variables can cross some scope boundaries, but not all of them. 

We'll learn more when we get to OOP. 

###### Local
Local variables are the most common variables you will come across and *obey all scope boundaries*. These variables are declared by starting the variable name with neither `$` nor `@`, as well as not capitalising the entire variable name.