### What is a closure? What are some examples of closures?
A closure is a 'snippet' of code that can be passed around within a program. They are unique (when compared to say, methods) in that closures are able to bind to surrounding artefacts when they are created. Examples of closures include:
1. Blocks
2. Procs
3. Lambdas

If we're being strict with our definitions, a block is technically not a closure, since it cannot be passed around without converting it to a Proc object first (it is effectively a 'single use' snippet of code passed directly as an argument to a method) - we cannot assign blocks to local variables (attempting to do so will raise a `SyntaxError`, since Ruby will assume we are trying to create a Hash object).

### What is a binding?
In the context of a closure, a binding refers to the methods and variables that are instantiated before the closure is created at the time that the closure is created, such that when executed, the closure has context of what those methods and variables are. 

It's important to note that in a binding, the binding is referencing the variables and methods themselves, not the underlying values they return. This allows bindings to be flexible when a closure is used after the values referenced by local variables or method definitions have changed after the closure has been created. 

```ruby
# Provide example of local variable and method changing
def execute_proc(proc)
  proc.call
end

def some_method
  "I am defined before the proc is created"
end

a = 'hello'

proc_a = Proc.new { puts "The local variable a returns #{a}!" }
proc_b = Proc.new { puts "The local variable b returns #{b}!" }
proc_c = Proc.new { some_method }

a = 'goodbye'
b = 'yo!'

def some_method
  "I am defined after the proc is created"
end

execute_proc(proc_a)
# The local variable a returns goodbye!

execute_proc(proc_b)
# NameError (undefined local variable or method `b' for main:Object)

execute_proc(proc_c)
# I am defined after the proc is created
```
In our example above, we define a method `execute_proc`, which takes a Proc object as an argument and calls the `Proc#call` method. This is a generic method that takes advantage of closures in that it does not actually care what the Proc returns when executed - it defers that implementation code to the Proc object itself. 

We then define a `some_method` method, which returns a string `"I am defined before the proc is created"`. We also define a local variable `a`, which returns the `'hello'` string object. When we instantiate proc objects `proc_a`, `proc_b` and `proc_c` using `Proc.new`, we append a block, which defines what that proc should do when executed. 

When we instantiate `proc_a`, `proc_b` and `proc_c`, the local variable `a` and method `some_method` are both part of those proc objects' binding, since they have been initialised/defined respectively before the proc object is instantiated. Since the binding of a closure points to variables and methods themselves (rather than their referenced values), we are able to reassign value that local variable `a` is pointing to and redefine the `some_method` method. Therefore, when we call `execute_proc(proc_a)` and `execute_proc(proc_c)`, those method calls return values that were different to the referenced values when `proc_a` and `proc_c` were instantiated.

In the case of `proc_b`, we initialise the local variable `b` to point to the string object `'yo!'` __after__ the proc object referenced by the local variable `proc_b`. As such, the local variable `b` is __not__ part of `proc_b`'s binding - this is why a `NameError` is raised when calling `execute_proc(proc_b)` - `proc_b` does not have context of what the local variable `b` is.

### What is a block?
A block is a closure denoted by a pair of curly braces `{}` or `do..end` reserved word pair immediately following a method call. They act as an argument passed to a method when that method is called, allowing us to add additional flexibility to a method, since we can defer some implementation code to the block instead of having to define it explicitly within the method. 

Note that every method in Ruby implicitly accepts a block, though whether that method does anything with the block depends on that method's implementation. Blocks can return values, just like methods.

```ruby
def method_one
  puts "Hello!"
end

def method_two
  yield
  puts "Done!"
end

method_one { puts "Do something!" }
# Hello!
# => nil

method_two { puts "Do something!" }
# Do something!
# Done!
# => nil
```
In our example above, we define two methods, `method_one` and `method_two`. With `method_one`, we have not provided the ability to deal with a block - passing `method_one` a block as an implicit argument when calling it does nothing (note that it still _accepts_ the block), and the block is ignored. 

With `method_two`, we use `yield` to allow the method to accept a block. The `yield` keyword allows the block to execute - `method_two` waits until the block finishes executing (outputs a string `"Do something!"`), and then resumes execution (outputs the string `"Done!"` and returns `nil`).

### When would we use a block?
We can use blocks to add additional flexibility to our code. Some instances where we might want to use a block as an argument to a method include:

_'Sandwich' code_, where we want a method to execute some generic code before and after a closure finishes executing, irrespective of what that closure actually does or returns. Examples include logging values and opening/closing files or database connections.

An example of sandwich code might be:
```ruby
def time_logger
  prior_time = Time.now
  yield if block_given?
  end_time = Time.now

  puts "The action took #{end_time - prior_time} seconds."
end

time_logger { puts "I'm a puts statement and I return nil!" }
# I'm a puts statement and I return nil!
# The action took 1.8e-05 seconds.
# => nil
```
In our example above, we define a `time_logger` method, which returns `nil` (due to the `puts` method call) and outputs a string indicating how long it takes for a block to return by subtracting the local variable `prior_time` from the local variable `end_time`. The `time_logger` method is generic in that it doesn't require a block to return a specific value or do a specific thing, but still retain's it's core functionality, irrespective of what the block does or returns. 

_Deferring implementation code to the method's caller_. Blocks can be flexible in what they return, so it is possible to write generic methods that accept a block that will change in functionality depending on what the block returns. Thus, blocks allow us to write generic methods that can do different things based on the block's return value, adding significant flexibility to that generic method. 

An example of deferring implementation code to the method's caller might be:
```ruby
def select(collection)
  items = collection.class.new
  if block_given?
    for i in collection
      if items.class == Array
        items.push(i) if yield(i)
      elsif items.class == Hash
        items[i.first] = i.last if yield(i)
      end
    end
  end
  items
end

select([1, 2, 3, 4]) { |element| element <= 3 }
# => [1, 2, 3]

select({ a: 3, b: 2, c: 4 }) { |key, value| value <= 3 }
# => { a: 3, b: 2 }
```
In our method above, we iterate through a collection passed as an argument to the `select` method, passing each element (in the case of an array) or key-value pair (in the case of a hash) to a block through the `yield` keyword. 

The `select` method doesn't care what the block is doing - it only cares whether the block returns `true` or not. If the block returns `true`, the `select` method adds that element/key-value pair to the collection referenced by the `items` local variable, returning that collection once the collection has been iterated through completely.

### What is the `yield` keyword and what does it do?
The `yield` keyword is something we can use within a method definition to allow the method to accept a block. During method execution, the method will execute until it reaches the `yield` keyword, at which point, the block passed as an argument to that method will execute. Once the block completes it's execution, the method will resume. Note that calling `yield` without passing a block will return a `LocalJumpError`, unless we use the `Kernel#block_given?` method, which skips executing the block if a block is not passed as an argument to the method.

### Explain the arity rules for a block.
Arity refers to the ability of a closure to react when it is accepts a different number of arguments to what the calling methods provides. Blocks have lenient arity rules, meaning we are able to pass in a different number of arguments to a block than what the method is equipped to do, without raising an error.
```ruby
def hello(str)
  yield(str)
end

def hello_many(str1, str2, str3)
  yield(str1, str2, str3)
end

hello("Jack") { |friend1, friend2| puts "My friends are #{friend1} and #{friend2}!" }
# "My friends are Jack and !"
# => nil

hello_many("Jack", "Jill", "Bill") { |friend1, friend2| puts "My friends are #{friend1} and #{friend2}!" }
# "My friends are Jack and Jill!"
# => nil
```
In our example above, we define a `hello` method to accept a `str` parameter. When we call the `hello` method, we pass the string object passed as an argument to the block. Because blocks have lenient arity rules, no error is raised, despite the block expecting two arguments and only being provided one. 

As a second argument is not provided, the block parameter `friend2` is `nil`, which is why there is an empty space in the output string `"My friends are Jack and !"` - string interpolation calls `to_s` on `nil`, which returns an empty string. 

We also define a `hello_many` method, which accepts three arguments. When we call `hello_many`, while we `yield` three arguments to the block, the block is only equipped to take two arguments. Again, since blocks have lenient arity rules, no error is raised, and the last argument passed to the block is simply ignored.

### What are the scoping rules for a block?
Blocks are able to access local variables defined outside of the block. However, blocks have their own scope, meaning that variables initialised within a block cannot be accessed outside of the block.

```ruby
a = 'hello!'

def greeting
  yield("I say ")
end

greeting do |str| 
  c = "local block variable"
  puts "#{str + a}"
end
# I say hello!
# => nil

c
# NameError (undefined local variable or method `c' for main:Object)
```
In our example above, we initialise the local variable `a` and assign it to the string object `'hello!'`. We then define a `greeting` method, which passes the string object `"I say "` as an argument to a block on execution. 

When we call the `greeting` method, we pass a block (denoted by the `do..end` reserved word pair immediately following the `greeting` method call) as an argument. The `greeting` method then passes the string object `"I say "` to the block, and the block executes. 

Within the block, a block local variable `c` is initialised, and assigned to the string object `"local block variable"`. The block accesses the string object passed as an argument to the block parameter `str` by the `greeting` method (`"I say "`), as well as the local variable `a` that was initialised outside of the block to output `"I say hello!"` and return `nil`.

However, when we attempted to return the value of local variable `c`, a `NameError` was raised. Since blocks create their own scope, attempting to access local variables defined inside of a block outside of that block scope will raise a `NameError`. 

### How do blocks interact with methods?
All methods in Ruby can be passed a block as an implicit argument. This does not guarantee that the method will execute whatever code is contained within the block - a method must make use of the `yield` keyword in order to interact with a block. 
```ruby
```

### How do we pass arguments to a block?
A block can be passed an argument by a method by adding block parameter(s) to the block, and within the method definition, passing arguments through the `yield` keyword.
```ruby
def method_name(str)
  yield(str)
end

method_name("hello") { |string| puts "The block says #{string}!" }
# The block says hello!
# => nil
```
In our above example, we define a method `method_name` with a single `str` parameter. When we call `method_name`, we pass it the string object `"hello"` as an argument. Within our method definition, we use `yield(str)`, which enables us to pass the string object `"hello"` as an argument to the block. The block is defined to take a `string` parameter - `yield(str)` enables us to pass the string object `"hello"` that was passed to the `method_name` method to the block. The block is then able to access the value referenced by the block parameter `string`, which it uses through string interpolation to output `"The block says hello!"` and return `nil`.

### What is an explicit block parameter?

### Explain the difference between an explicit block and implicit block parameter?

### What is a Proc object? How do we call it? When do we need to pass arguments to the Proc#call method?

### How do we access methods defined in the `main` scope in custom classes we create and why?

### Explain how Symbol#to_proc works.

### Explain the limitations of Symbol#to_proc, and how we can get around them.

### Explain what the `&` symbol in different contexts, and what it does.

### What is regression testing?

### What is a testing framework? What are the associated steps?

### What is the difference between assertion and expectation syntax?

### What's the difference between Minitest and RSpec?

### What are some of the limitations with `assert` when testing?

### What is the SEAT approach in testing? Why is it beneficial?

### When do we need the `setup` and `teardown` methods for testing? What do they do?

### What is code coverage? What does it measure?

### What is Rbenv/RVM? What do they do? Why would we use them?

### What is the difference between Rbenv and RVM?

### What is the `PATH` variable? How is it used in the context of Rbenv versus RVM?

### What is a gem? Why might we use gems?

### What is Bundler? What does it do?

### What is `bundle-exec`? How is it different from `binstubs`?

### How does Bundler work?

### What is Rake? What does it do?

### How does Rake work?
