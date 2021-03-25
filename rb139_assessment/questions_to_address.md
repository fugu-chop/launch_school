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
In our example above, we define a method `execute_proc` on `lines 1-3`, which takes a Proc object as an argument and calls the `Proc#call` method. This is a generic method that takes advantage of closures in that it does not actually care what the Proc returns when executed - it defers that implementation code to the Proc object itself. 

We then define a `some_method` method on `lines 5-7`, which returns a string `"I am defined before the proc is created"`. We also define a local variable `a` on `line 9`, which returns the `'hello'` string object. When we instantiate proc objects `proc_a`, `proc_b` and `proc_c` using `Proc.new` on `lines 11-13`, we append a block, which defines what that proc should do when executed. 

When we instantiate `proc_a`, `proc_b` and `proc_c`, the local variable `a` and method `some_method` are both part of those proc objects' binding, since they have been initialised/defined respectively before the proc object is instantiated. Since the binding of a closure points to variables and methods themselves (rather than their referenced values), we are able to reassign the value that local variable `a` is pointing (`line 15`) to and redefine the `some_method` method (`lines 18-20`). Therefore, when we call `execute_proc(proc_a)` and `execute_proc(proc_c)` on `lines 22` and `28`, those method calls return values that were different to the referenced values when `proc_a` and `proc_c` were instantiated.

In the case of `proc_b`, we initialise the local variable `b` to point to the string object `'yo!'` __after__ the proc object referenced by the local variable `proc_b` (`line 16`). As such, the local variable `b` is __not__ part of `proc_b`'s binding - this is why a `NameError` is raised when calling `execute_proc(proc_b)` - `proc_b` does not have context of what the local variable `b` is.

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
In our example above, we define two methods, `method_one` (`lines 1-3`) and `method_two` (`lines 5-8`). With `method_one`, we have not provided the ability to execute a block as there is no `yield` keyword - passing `method_one` a block as an implicit argument when calling it does nothing (note that it still _accepts_ the block), and the block is ignored, on `line 10`.

With `method_two`, we use `yield` to allow the method to accept a block. When calling `method_two` on `line 14`, the `yield` keyword allows the block to execute - `method_two` yields execution to the block, waiting until the block finishes executing (outputs a string `"Do something!"`), and then resumes execution (outputs the string `"Done!"` and returns `nil`).

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
In our example above, we define a `time_logger` method on `lines 1-7`. When we call `time_logger` on `line 9`, we initialise two local variables - `prior_time`, which captures a timestamp prior to the block execution, and `end_time`, which captures the timestamp after the block completes execution.

`time_logger` returns `nil` (due to the `puts` method call) and outputs a string indicating how long it takes for the provided block to return by subtracting `prior_time` from `end_time`. The `time_logger` method is generic in that it doesn't require a block to return a specific value or do a specific thing, but still retains it's core functionality (displaying how long the block took to execute), irrespective of what the block does or returns.

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
In our `select` method above, we iterate through a collection passed as an argument to the `select` method, passing each element (in the case of an array) or key-value pair (in the case of a hash) to a block through the `yield` keyword. 

The `select` method doesn't care what the block is doing - it only cares whether the block returns `true` or not. If the block returns `true`, the `select` method adds that element/key-value pair to the collection referenced by the `items` local variable, returning that collection once the collection has been iterated through completely. We only need to worry what object type is being passed to the method as an argument.

### What is the `yield` keyword and what does it do?
The `yield` keyword is something we can use within a method definition to allow the method to accept a block. During method execution, the method will execute until it reaches the `yield` keyword, at which point, the block passed as an argument to that method will execute. Once the block completes it's execution, the method will resume. Note that calling `yield` without passing a block will return a `LocalJumpError`, unless we use the `Kernel#block_given?` method, which skips executing the block if a block is not passed as an argument to the method.
```ruby
def method_no_yield
end

def method_yield
  puts "I am yielder!"
  yield
  puts "Done yielding!"
end

def method_yield_condition
  puts "I am yielder!"
  yield if block_given?
  puts "Done yielding!"
end

method_no_yield { puts "Hello!" }
# => nil

method_yield
# LocalJumpError (no block given (yield))

method_yield_condition
# I am yielder!
# Done yielding!
# => nil
```
On `line 1`, we define a method `method_no_yield`, which returns `nil` when called. While we do not explicitly include the `yield` keyword within the definition, like all other methods within Ruby, it is still able to accept a block as an implicit parameter when called, per `line 16` - however, as there is no `yield` keyword within the method definition, `method_no_yield` does not do anything with the block passed to it and simply returns `nil`, as if we had not passed a block as an argument.

We also define a method `method_yield` on `lines 4-8`, which __does__ include a `yield` keyword. This means that the `method_yield` method expects a block as an argument when it is called. Per `line 19`, calling `method_yield` without a block will raise a `LocalJumpError`. 

On `lines 10-14` we define the `method_yield_condition` method. This method does include a `yield` keyword, which means it will pass execution to the block when `method_yield_condition` is called. Since we also add a conditional with the `Kernel#block_given?` method, the method no longer __requires__ a block - per `line 22`, calling `method_yield_condition` without a block means that when executing the code within `method_yield_condition`, Ruby will identify that a block has not been passed to the method, and will not `yield` to a block. Instead, it will execute the rest of the code within the method definition, outputting the strings `"I am yielder!"` and `"Done yielding!"`, and return `nil` (the `puts` method always returns `nil`).

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
In our example above, we define a `hello` method to accept a `str` parameter on `lines 1-3`. When we call the `hello` method on `line 9`, we pass the string object passed as an argument to the block. Because blocks have lenient arity rules, no error is raised, despite the block expecting two arguments and only being provided one. 

As a second argument is not provided, the block parameter `friend2` is `nil`, which is why there is an empty space in the output string `"My friends are Jack and !"` - string interpolation calls `to_s` on `nil`, which returns an empty string. 

We also define a `hello_many` method on `lines 5-7`, which accepts three arguments. When we call `hello_many` on `line 13`, while we `yield` three arguments to the block, the block is only equipped to take two arguments. Again, since blocks have lenient arity rules, no error is raised, and the last argument passed to the block is simply ignored.

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
In our example above, on `line 1`, we initialise the local variable `a` and assign it to the string object `'hello!'`. We then define a `greeting` method on `lines 3-5`, which passes the string object `"I say "` as an argument to a block on execution. 

When we call the `greeting` method on `line 7`, we pass a block (denoted by the `do..end` reserved word pair immediately following the `greeting` method call) as an argument. The `greeting` method then passes the string object `"I say "` to the block, and the block executes. 

Within the block, a block local variable `c` is initialised on `line 8`, and assigned to the string object `"local block variable"`. The block accesses the string object passed as an argument to the block parameter `str` by the `greeting` method (`"I say "`), as well as the local variable `a` that was initialised outside of the block to output `"I say hello!"` and return `nil`.

However, when we attempted to return the value of local variable `c` on `line 14`, a `NameError` was raised. Since blocks create their own scope, attempting to access local variables defined inside of a block outside of that block scope will raise a `NameError`. 

### How do blocks interact with methods?
All methods in Ruby can be passed a block as an implicit argument. This does not guarantee that the method will execute whatever code is contained within the block - a method must make use of the `yield` keyword in order to interact with a block (i.e. temporarily halt execution of the code defined within the method and execute the block). 
```ruby
def method_yield
  yield
end

def method_no_yield
end

method_yield { puts "I yield!" }
# I yield!
# => nil

method_no_yield { puts "I do not yield" }
# => nil
```
In our example above, we define two methods - on `line 1-3` we define the `method_yield` method, which is able to execute a block by virtue of the `yield` keyword on `line 2`. Thus we see on `line 8`, we call `method_yield`, passing a block. Since the `method_yield` method definition contains the `yield` keyword, when calling `method_yield`, execution will pass to the block, which outputs the string `"I yield!"` and returns `nil`.

On `line 5-6` we define the `method_no_yield` method, which does not contain the `yield` keyword. As such, while `method_no_yield` will implicitly accept a block as an argument, it will not yield to the block (it will not execute whatever code is in the block). As `method_no_yield` is an empty method, it just returns `nil`.

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
In our above example, we define a method `method_name` with a single `str` parameter on `lines 1-3`. When we call `method_name` on `line 5`, we pass it the string object `"hello"` as an argument. Within our method definition, we use `yield(str)` (`line 2`), which enables us to pass the string object `"hello"` as an argument to the block. 

The block is defined to take a `string` parameter - `yield(str)` enables us to pass the string object `"hello"` that was passed to the `method_name` method to the block. The block is then able to access the value referenced by the block parameter `string`, which it uses through string interpolation to output `"The block says hello!"` and return `nil`.

### What is an explicit block parameter?
While blocks are 'closures' in the sense that they are a snippet of code that can be passed to a method, they are actually implicit parameters - they cannot be assigned to local variables and passed to multiple methods/'reused' (and so strictly speaking, blocks are not closures). However, when we define a method, we can make use of the `&` symbol to convert a block passed as an argument to the method to a simple `Proc` object. 
```ruby
a = { puts "I am a string object!" }
# SyntaxError ((irb):1: syntax error, unexpected '}', expecting =>)

def call_proc(str, &block1, &block2)
  block1.call(str)
  block2.call(str)
end

call_proc("Joe") { |str| puts "#{str}, I am a string object!" }
# I am a string object
# => nil
``` 
In our above example, we demonstrate on `line 1` that blocks cannot be assigned to local variables - Ruby will interpret the 'block' as an attempt to create a hash object, and thus raise a `SyntaxError`. However, on `line 4-6`, we define a `call_proc` method with an `str` parameter and a `&block` parameter. 

On `line 8`, we call the `call_proc` method, passing in a string object `"Joe"` as an argument. We also pass a block as an argument to the `call_proc` method, defining the block with a block parameter `str`. Within the method definition, the `&block` syntax allows us to pass a block to the method, and convert that method to a simple `Proc` object as we pass the block to the `call_proc` method. As a side note, in order for this to work, the `&` syntax must be applied to the __last__ parameter in the method (only a single block can be passed to the method in this fashion).

As we convert the block to a `Proc` object, the `Proc` object is assigned to the method local variable `block`. The `block.call(str)` syntax then is a call to `Proc#call`, which executes the newly converted `Proc` object, outputting `"Joe, I am a string object!"` and returning `nil`.

Unlike blocks, `Proc` objects can be assigned to local variables and executed numerous times across different methods. In order to execute a `Proc` object, we don't use the `yield` keyword like we do with blocks; instead, we use the `Proc#call` method. 
```ruby
def some_method(a_proc, str)
  a_proc.call(str)
end

proc_obj = Proc.new { |str| puts "Hi there, your name is #{str}" }

some_method(proc_obj, "Bill")
# Hi there, your name is Bill
# => nil

some_method(proc_obj, "Jim")
# Hi there, your name is Jim
# => nil
```
In our example above, on `lines 1-3`, we define a method `some_method` with two parameters, `a_proc` and `str`. The object passed as an argument to the `a_proc` parameter is expected to be a `Proc` object, since we are using the `Proc#call` instance method to execute the proc. 

On `line 5`, we instantiate a `Proc` object with an `str` parameter, that we can pass as an argument to our `some_method` method. The `Proc` object takes a block as an argument, which is the code that will be executed once the `Proc#call` instance method is invoked.

On `line 7`, we call the `some_method` method, passing in the `proc_obj` Proc object, and the string object `"Bill"` as an argument. The `Proc#call` instance method is called, which executes the block, outputting the `"Hi there, your name is Bill"` (using string interpolation to use the object referenced by the `str` argument to populate the string) and output `nil`.

On `line 11`, we call the `some_method` method again, this time passing in a different string object to the `str` parameter, but passing in the same `Proc` object. This demonstrates that unlike blocks, `Proc` objects are "true closures", in that they can be assigned to local variables and passed to different method calls. 

### What is a Proc object? How do we call it? When do we need to pass arguments to the Proc#call method?
A `Proc` object is an object of the `Proc` class, which is effectively a block that has been converted to an object that is a "true" closure, in that it can be assigned to a local variable and passed around to different parts of the program. Like blocks, they can be passed as arguments to methods - however, instead of using the `yield` keyword to execute a block, we must make use of the `Proc#call` instance method to execute a `Proc` object. The `Proc#call` instance method is able to pass objects that were passed as arguments to the method to the `Proc` object as part of that `Proc` object's execution.
```ruby
def some_method(proc_obj, age)
  proc_obj.call(age)
end

a_proc = Proc.new { |int| puts "#{int} + 1 is equal to #{int + 1}!" }

some_method(a_proc, 5)
# => 5 + 1 is equal to 6!
# => nil
```
In our example above, we define the `some_method` method on `line 1-3`, with two parameters, `proc_obj` and `age`. In our method definition, the object passed to the `proc_obj` parameter is expected to be a `Proc` object, as we are calling the `Proc#call` instance method on that object on execution (per `line 2`).

On `line 5`, we instantiate a `Proc` object, passing it a block with a block parameter `int` as an argument. This is the code that will be executed when we invoke `proc_obj.call`. We assign this `Proc` object to the local variable `a_proc`.

On `line 7`, we invoke the `some_method` method, passing it the `Proc` object referenced by the local variable `a_proc`. The `Proc` object then invokes the `Proc#call` instance method, which executes the block that was passed as an argument when we instantiated the `Proc` object on `line 5`. This will output `"5 + 1 is equal to 6!"` and return `nil`. 

### How do we access methods defined in the `main` scope in objects instantiated from custom classes we create and why?
The `main` scope is part of the `Object` class, while simultaneously an instance of the `Object` class (as a general mental model - it's a bit more complex than this). When we define a method outside of a custom class, that method is accessible in the `main` scope. By default, methods defined in the `main` scope are private to the `main` scope. If we want to access them within custom classes, we must make those methods public. 
```ruby
class Robot
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

public

def say_hello
  puts "#{self.name} says hello!"
end

r = Robot.new("Bob")
r.say_hello
# Bob says hello!
# => nil
```
In our example above, on `lines 1-7`, we define a `Robot` class. This `Robot` class has access to two instance methods - an `initialize` method with a `name` parameter which is called on instantiation of an object from the `Robot` class, and a getter instance method that returns the object passed as an argunent to the `@name` instance variable. 

On `lines 11-13`, we define a `say_hello` method in the `main` scope (i.e. it is defined outside of a custom class). In order to make `say_hello` accessible to objects instantiated from the `Robot` class, we need to add the `public` keyword above the `say_hello` method definition, as methods defined in the `main` scope are private (i.e. they are otherwise inaccessible to objects of custom classes). As such, we are able to call the `say_hello` method on the object instantiated from the `Robot` class, per `line 16`.

### Explain how Symbol#to_proc works.
Similar to how we can convert blocks to `Proc` objects in a method definition, the `Symbol#to_proc` instance method allows us to apply a method that does not take an argument to each element of a collection. 

By prepending a `:` symbol to the method name, we turn that method into a symbol. When this symbol is passed to a method on __execution__, a `&` symbol is prepended to the symbol. As the method executes, Ruby will check whether the object following the `&` symbol is a `Proc` object. Since the `&` is followed by a symbol (i.e. not a `Proc` object), Ruby will attempt to call `Symbol#to_proc`, which will convert the symbol to a `Proc` object. Once a `Proc` object exists, the `&` symbol will convert that `Proc` object to a block.


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
