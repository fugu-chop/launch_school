# Variables

## Table of Contents
- [What is a variable?](#what-is-a-variable)
- [Scope](#Scope)
- [Types of Variables](#types-of-variables)

### What is a variable
Variables are used to store information in memory, to be referenced and manipulated in a computer program, acting as containers. 

We assign variables using the `=` symbol. Note that we have to be careful as to what we're assigning to a variable. Only expressions that __return a value__ can be usefully stored in a variable. 

Take this example:
```
my_var = puts "a"
my_var1 = "a"

my_var
=> nil

my_var1
=> "a"
```
Since `puts` does not return anything, we are assigning `nil` to `my_var`. However, since `"a"` returns itself as a value, `my_var` stores the `"a"` value. 

The point about variables being stored in memory is pertinent - they are not linked in some deeper fashion when other variables change. Take the following example:
```
a = 4
b = a
a = 7
puts b
=> 4
```
### Getting user input
We can use `gets` to obtain user input. We chain the `.chomp` method to remove the newline (`\n`) that gets added to `gets`. Note that `gets` __always gives us a string__.
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

arr.each do |element|
  a = element      # a is initialized here
end

puts a
=> NameError (undefined local variable or method `a` for main:Object)
```
Here, we get a `NameError`, as we have a method invocation (`.each`) with a block (`do end`), which creates it's own scope. This means that variables (`a`) defined within the block are not accessible outside of it. 

Contrast with this example:
```
arr = [1, 2, 3]

for i in arr do
  a = 5      # a is initialized here
end

puts a
=> 5
```
`a` is accessible here since `for...do end` code __did not create a new inner scope__, since `for` is part of Ruby language and __not a method invocation__. When we use `each`, `times`, `loop` and other method invocations, followed by `{ }` or `do end`, that's when a new block is created.

Peer blocks cannot reference variables initialized in other blocks. This means that we could use the same variable name `a` in the block of code that follows the loop method invocation. However, it's __not the same variable as in the first block__.
```
2.times do
  a = 'hi'
  puts a      # 'hi' <= this will be printed out twice due to the loop
end

loop do
  puts a      # => NameError: undefined local variable or method `a' for main:Object
  break
end

puts a        # => NameError: undefined local variable or method `a' for main:Object
```
Nested blocks follow the same rules of inner and outer scoped variables. When dealing with nested blocks, our usage of what's "outer" or "inner" is going to be relative. We'll switch vocabulary and say "first level", "second level", etc.
```
a = 1           # first level variable

loop do         # second level
  b = 2

  loop do       # third level
    c = 3
    puts a      # => 1
    puts b      # => 2
    puts c      # => 3
    break
  end

  puts a        # => 1
  puts b        # => 2
  puts c        # => NameError
  break
end

puts a          # => 1
puts b          # => NameError
puts c          # => NameError
```
###### Method definitions & scope
Reassignment, including assignment operators like `+=`, `=`, do not mutate a variable in the context of a *method definition*; instead, it binds the variable to a new object. That is, the assignment operator sets the variable to point to a different object.

Method definitions are *self-contained* with respect to local variables. Local variables outside the method definition are __not visible__ *inside* the method definition, __unless passed in as arguments__ (at which point, the variable is assigned as a method parameter and made available to the method body as a local variable). Furthermore, local variables *inside* the method definition are not visible outside the method definition.

In this example, the `a` variable defined outside the `my_value` method is __not visible__ to the `a` defined within the method, and vice versa. `a` is also an integer, which is __immutable__.
```
a = 7

def my_value(a)
  a += 10
end

my_value(a)
puts a
```
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