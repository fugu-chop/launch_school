### What is a closure? What are some examples of closures?
A closure is a 'snippet' of code that can be passed around within a program and execute at a later time. They are unique (when compared to say, methods) in that closures are able to bind to surrounding artefacts when they are created, such that these artefacts can be referenced when the closure is executed. Examples of closures include:
1. Blocks
2. Proc objects
3. Lambdas

If we're being strict with our definitions, a block is technically not a closure, since it cannot be passed around without converting it to a Proc object first (it is effectively a 'single use' snippet of code passed directly as an argument to a method) - we cannot assign blocks to local variables (attempting to do so will raise a `SyntaxError`, since Ruby will assume we are trying to create a Hash object).

### What is a binding?
A binding is the series of artefacts that a closure has context of when it is created. This means that when the closure is executed at a later point in time (compared to when it was created), it still retains references to those artefacts (e.g. references to methods and local variables). 

It should be noted that it is the __reference__ to local variables and methods that is part of a binding, __not__ the underlying values. This means that if we change the definition of a method or assigned value of a local variable after a closure has been created (and it's binding set), those changes will be reflected in the execution of the closure (assuming those changes are done __before__ the closure is executed). This allows bindings to be flexible when a closure is used after the values referenced by local variables or method definitions have changed after the closure has been created. 
```ruby
def call_a_proc(proc_obj)
  proc_obj.call
end

a = 'hello'

proc_a = Proc.new { "#{a} is the greeting I'll give today!" }
proc_b = Proc.new { greetings }
proc_c = Proc.new { "#{b} isn't yet defined or assigned a value, so I'll raise an error" }

def greetings
  puts "I'm a method that greets!"
end

a = 'goodbye'
b = 'whatever'

call_a_proc(proc_a)
# Goodbye is the greeting I'll give today!
call_a_proc(proc_b)
# I'm a method that greets!
# => nil
call_a_proc(proc_c)
# NameError (undefined local variable or method `b` for main:Object)
```
On `lines 1-3`, we define a `call_a_proc` method that takes a `proc_obj` argument. We expect to pass `Proc` objects as arguments to `call_a_proc`, as well apply the `Proc#call` method on objects passed as arguments to `call_a_proc`. 

On `line 5`, we define a local variable `a` and assign the string object `'hello'` to it. On `line 7`, we instantiate a `Proc` object using `Proc.new`, passing in a block as an argument. Blocks are able to access the outer scope (i.e. local variables defined outside of the block), and since the local variable `a` has already been defined, it becomes part of the binding of the `Proc` object referenced by local variable `proc_a`. Therefore, even if we reassign the string object that local variable `a` is pointing to, per `line 15`, when we call `call_a_proc(proc_a)` on `line 18`, because a binding is a reference to a local variable (and not the underlying value), executing the block through `Proc#call` returns the string object `"Goodbye is the greeting I'll give today!"` - the change in string object referenced by `local variable a` is reflected when `Proc#call` is invoked.

On `line 8`, we instantiate another `Proc` object, this time passing a block that will invoke a `greetings` method. At this point in time, the `greetings` method has not yet been defined (the method itself isn't actually part of the binding of the `Proc` object referenced by local variable `proc_b` - however, the `proc_b` __name__ is part of the binding). 

Calling `call_a_proc(proc_b)` on `line 19` does __not__ raise a `NameError`, as for methods, so long as the method is defined __before__ the `Proc#call` method is invoked on the `Proc` object, the `Proc` object will execute. This is because in Ruby, if we do not define an explicit `self` or add parentheses after a name, Ruby will not know whether the name is a reference to a local variable or a method definition at execution time. As such, Ruby will first attempt to find whether a `proc_b` local variable has been created. There isn't such a local variable, so Ruby will prepend an implicit `self` to the `proc_b` name. There is such a method defined in the `main` scope (this is what the implicit `self` is referring to in this case), and so the method is able to execute, despite the method definition not explicitly being part of `proc_b`'s binding.

Finally, on `line 9`, we instantiate a third `Proc` object, assigning it to the local variable `proc_c`. In this `Proc` object, we pass a block as an argument, which is supposed to access a local variable `b` as part of it's execution. However, at the point at which is closure is created (i.e. when the `Proc` object is instantiated and block passed to it), the local variable `b` has not yet been defined - this only occurs later on `line 16`, __after__ the closure has been created. As such, local variable `b` is not part of the `Proc` object's binding. We can see this on `line 20` - when attempting call the `call_a_proc(proc_c)` method, a `NameError` is raised, since at the time of the creation of the closure, the local variable `b` was not yet defined. 

### What is a block?
A block is a closure denoted by a pair of curly braces `{}` or `do..end` reserved word pair immediately following a method call. They act as an argument passed to a method when that method is called, allowing us to add additional flexibility to a method, since we can defer some implementation code to the block instead of having to define it explicitly within the method. 

They are created as closures as they are passed to methods (since we can't assign them to local variables unlike Proc objects or lambdas).

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
In our example above, we define two methods, `method_one` (`lines 1-3`) and `method_two` (`lines 5-8`). With `method_one`, we have not provided the ability to interface with a block as there is no `yield` keyword - passing `method_one` a block as an implicit argument when calling it does nothing (note that it still _accepts_ the block), and the block is ignored, on `line 10`.

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
In our example above, we define a `time_logger` method on `lines 1-7`. When we call `time_logger` on `line 9`, we define two local variables - `prior_time`, which captures a timestamp prior to the block execution, and `end_time`, which captures the timestamp after the block completes execution.

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

select({ a: 3, b: 2, c: 4 }) { |_, value| value <= 3 }
# => { a: 3, b: 2 }
```
In our `select` method above, we iterate through a collection passed as an argument to the `select` method, passing each element (in the case of an array) or key-value pair (in the case of a hash) to a block through the `yield` keyword. 

The `select` method doesn't care what the block is doing - it only cares whether the block returns `true` or not. If the block returns `true`, the `select` method adds that element/key-value pair to the collection referenced by the `items` local variable, returning that collection once the collection has been iterated through completely. We only need to worry what object type is being passed to the method as an argument.

### What is the `yield` keyword and what does it do?
The `yield` keyword is something we can use within a method definition to allow the method to interface with a block. During method execution, the method will execute until it reaches the `yield` keyword, at which point, the block passed as an argument to that method will execute. Once the block completes it's execution, the method will resume. Note that calling `yield` without passing a block will return a `LocalJumpError`, unless we use the `Kernel#block_given?` method, which skips executing the block if a block is not passed as an argument to the method.
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

### Explain what is happening in this code.
```ruby
def say(words)
  yield if block_given?
  puts "> " + words
end

say("hi there") do
  system 'clear'
end           
```
On `line 1-4` we define a `say` method, which accepts a `words` parameter. On `line 6`, we call the `say` method, passing in a string object (`"hi there"`) as an argument to the `words` parameter, and a block (as denoted by the `do`...`end` reserved words immediately following the `say` method invocation). The block is an __implicit parameter__ and not assigned to a local variable within the method. 

On `line 2` in the `say` method definition, we can see that when `say` is called, the method will `yield` to a block if provided. In our method invocation on `line 6`, there is a block provided, and so execution of the rest of the `say` method is paused as the block is executed. The block has the effect of clearing the screen.

Once the block is finished executing, the rest of the `say` method can execute - this will output a string `"> hi there"` and return `nil` (since the `puts` method always returns `nil`).

### Describe what is happening in this code.
```ruby
def increment(number)
  if block_given?
    yield(number + 1)
  end
  number + 1
end

increment(5) do |num|
  puts num
end
```
In the above code, we define an `increment` method to accept a `number` parameter on `lines 1-6`. On `line 8`, we call the `increment` method, providing an integer object `5` as an argument to the `number` parameter, as well as a block (denoted by the `do`...`end` reserved words immediately following the `increment(5)` method invocation) as an implicit parameter (it is not assigned to a local variable inside during execution). The block itself has a block parameter, `num`, which generally means the block expects to be provided an argument at method execution time.

During execution, the `increment` method checks if a block has been provided on `line 2`, which it has. The `increment` method then calls the `Integer#+` method on the integer object `5` that was passed as an argument to the `increment` method on invocation, returning the integer object `6`. 

The method then yields this integer object `6` to the block through the `yield` keyword, passing to the block parameter `num`. The block is then executed, which outputs a string representation of the integer object `6` and returns `nil`. After the block is finished executing, the rest of the `increment` method executes on `line 5`, which returns `6` as a result of calling the `Integer#+` method on the integer object `5`.

### Explain the arity rules for a block.
Arity refers to the ability of a closure to deal with a different number of arguments passed from the calling methods provides, compared to what the closure is defined to take. Blocks have lenient arity rules, meaning we are able to pass in a different number of arguments to a block than what the method is equipped to do, without raising an error.
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
```ruby
def proc_caller_one(proc, str1)
  proc.call(str1)
end

def proc_caller_three(proc, str1, str2, str3)
  proc.call(str1, str2, str3)
end

a_proc = Proc.new { |str1, str2| puts "#{str1} and #{str2} are examples of string objects." }

proc_caller_one(a_proc, "Dog")
# Dog and  are examples of string objects.
# => nil

proc_caller_three(a_proc, "Dog", "Cat", "Plane")
# Dog and Cat are examples of string objects.
# => nil
```
We demonstrate that `Proc` objects have the same lenient set of arity rules as blocks, and treat missing block parameters as `nil` objects.

### What are the scoping rules for a block?
Blocks are able to access local variables defined outside of the block. However, blocks have their own scope, meaning that variables defined within a block cannot be accessed outside of the block. 

As Ruby resolves scope starting from the inner-most scope, we should be mindful to not name block parameters the same as local variables defined outside of the block - otherwise variable shadowing can occur, preventing block access to those externally defined local variables. 
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
In our example above, on `line 1`, we define the local variable `a` and assign it to the string object `'hello!'`. We then define a `greeting` method on `lines 3-5`, which passes the string object `"I say "` as an argument to a block on execution. 

When we call the `greeting` method on `line 7`, we pass a block (denoted by the `do..end` reserved word pair immediately following the `greeting` method call) as an argument. The `greeting` method then passes the string object `"I say "` to the block, and the block executes. 

Within the block, a block local variable `c` is defined on `line 8`, and assigned to the string object `"local block variable"`. The block accesses the string object passed as an argument to the block parameter `str` by the `greeting` method (`"I say "`), as well as the local variable `a` that was defined outside of the block to output `"I say hello!"` and return `nil`.

However, when we attempted to return the value of local variable `c` on `line 14`, a `NameError` was raised. Since blocks create their own scope, attempting to access local variables defined inside of a block outside of that block scope will raise a `NameError`. 

### How do blocks interact with methods?
All methods in Ruby can be passed a block as an implicit argument (i.e. they are not assigned to a local variable accessible within the method). This does not guarantee that the method will execute whatever code is contained within the block - a method must make use of the `yield` keyword in order to interact with a block (i.e. temporarily halt execution of the code defined within the method and execute the block). 
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

def call_proc(str, &block)
  block.call(str)
end

call_proc("Joe") { |str| puts "#{str}, I am a string object!" }
# Joe, I am a string object!
# => nil
``` 
In our above example, we demonstrate on `line 1` that blocks cannot be assigned to local variables - Ruby will interpret the 'block' as an attempt to create a hash object, and thus raise a `SyntaxError`. However, on `line 4-6`, we define a `call_proc` method with an `str` parameter and a `&block` parameter. 

On `line 8`, we call the `call_proc` method, passing in a string object `"Joe"` as an argument. We also pass a block as an argument to the `call_proc` method, defining the block with a block parameter `str`. Within the method definition, the `&block` syntax allows us to pass a block to the method, and convert that method to a simple `Proc` object as we pass the block to the `call_proc` method. 

As a side note, in order for this to work, the `&` syntax must be applied to the __last__ parameter in the method (only a single block can be passed to the method in this fashion).

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
A `Proc` object is an object of the `Proc` class and is a closure, in that it is a snippet of code that can be assigned to a local variable and passed around to different parts of the program and reused. Like blocks, they can be passed as arguments to methods. It usually 'wraps' around a block to enable that block to be reused and passed to other parts of the program.

However, instead of using the `yield` keyword to execute a block, we must make use of the `Proc#call` instance method to execute a `Proc` object. The `Proc#call` instance method is able to pass objects that were passed as arguments to the method to the `Proc` object's block parameters as part of that `Proc` object's execution.
```ruby
def some_method(proc_obj, age)
  proc_obj.call(age)
end

a_proc = Proc.new { |int| puts "#{int} + 1 is equal to #{int + 1}!" }

some_method(a_proc, 5)
# 5 + 1 is equal to 6!
# => nil
```
In our example above, we define the `some_method` method on `line 1-3`, with two parameters, `proc_obj` and `age`. In our method definition, the object passed to the `proc_obj` parameter is expected to be a `Proc` object, as we are calling the `Proc#call` instance method on that object on execution (per `line 2`).

On `line 5`, we instantiate a `Proc` object, passing it a block with a block parameter `int`. This is the code that will be executed when we invoke `proc_obj.call`. We assign this `Proc` object to the local variable `a_proc`.

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
```ruby
[1, 2, 3].map(&:to_s)
# => ["1", "2", "3"]
```
In our example above, we have prepended a `:` symbol to the `to_s` method name, thereby turning that method into a symbol. As the `map` method __executes__, as we have passed an argument prepended with a `&` symbol, Ruby will check whether the object following the `&` symbol is a `Proc` object. If it's not a `Proc` object, Ruby will raise a `TypeError (wrong argument type X (expected Proc))`.

As `:to_s` is a symbol (i.e. not a `Proc` object), Ruby will then attempt to call `Symbol#to_proc`, which will convert the symbol to a `Proc` object. Once a `Proc` object exists, the `&` symbol will convert that `Proc` object to a block at method invocation time. In our example above, the `(&:to_s)` syntax is equivalent to `{ |n| n.to_s }`.

### Explain the limitations of Symbol#to_proc, and how we can get around them.
The `Symbol#to_proc` instance method allows us to convert a symbol to a `Proc` object, which is useful during method execution if we want to apply a method to each element of a collection. It is a useful way of reducing the amount of code we write.

One key limitation however, is that `Symbol#to_proc` only works with methods that do not take an argument (e.g. `to_s`, `odd?`), as converting the argument passed to the method to a symbol doesn't really work here (a `SyntaxError` will be raised).

We can get around this limitation by using the `Method#to_proc` instance method.
```ruby
def appender(word)
  "Hello, my name is #{word}!"
end

appender_proc = method(:appender).to_proc

['James', 'Bill', 'Bob'].map(&appender_proc)
# => ["Hello, my name is James!", "Hello, my name is Bill!", "Hello, my name is Bob!"]
```
In our example above, we define an `appender` method with a `word` parameter on `lines 1-3`. Since we cannot use `Symbol#to_proc` on methods that take an argument, we need to use the `Method#to_proc` instance method to convert this method into a `Proc` object, per `line 5`. 

We cast our `appender` method as a symbol and pass it as an argument to the `method` method, which converts our local `appender` method into a `Method` object, giving it access to the `Method#to_proc` instance method. We assign this to the local variable `appender_proc`

On method invocation at `line 7`, we pass the `Proc` object assigned to the local variable `appender_proc` as an argument to the `map` method. Note that at invocation, we prepend a `&` symbol, which converts the `appender_proc` object into a block, which the `map` method is expecting. As such, the `map` method is able to apply the `appender` method to each string object in the array. Note that this only works with methods that take a single argument, as we cannot pass multiple arguments to the block with the shorthand syntax.

### Explain what the `&` symbol in different contexts, and what it does.
The `&` symbol has different functionality in respect of closures, depending on the context in which it is used. In a method __definition__, when a parameter has `&` prepended to it, this means that on method _execution_, the method will expect a block to be passed as an argument. The method will then convert that block to a `Proc` object and assign it to a local variable inside the method based on the parameter name. This is how we can create explicit block parameters, and pass `Proc` objects around to other methods. 

During method __execution__, if we prepend the `&` symbol to an argument, the method will expect to be passed a `Proc` object, and will then convert this to a block. If a non-`Proc` object is passed as an argument, Ruby will attempt to call `Symbol#to_proc` in order to convert the object to a `Proc` object, and then convert this converted `Proc` object to a block (if a non-`Symbol`, non-`Proc` object is passed as an argument, Ruby will raise a `TypeError`).
```ruby
def accept_block(str, &block)
  call_proc(block, str)
end

def call_proc(block, str)
  block.call(str)
end

accept_block('Joe') { |string| puts "The string object passed is #{string}" }
# The string object passed is Joe
# => nil
```
In our example above, we define a `accept_block` method with two parameters, `str` and `&block` on `line 1-3`. By prepending `&` to the `block` parameter, we are telling Ruby that the object passed as an argument to `block` should be a block. On `line 9`, we call the `accept_block` method, passing the string object `'Joe'` to the `str` parameter, and the block `{ |string| puts "The string object passed is #{string}" }` to the `block` parameter. As this method executes, the `&` symbol means that Ruby will try to convert the block to a `Proc` object and assign it to the local variable `block`. 

The conversion is successful - ordinarily, we cannot assign blocks to local variables - however, as the block is now converted to a `Proc` object, we can assign it to a local variable `block` and pass it as an object to the `call_proc` method. The `call_proc` method, defined on `lines 5-7` has two parameters, `block` and `str`. The `block` parameter expects to be passed a `Proc` object, as on execution, the `call_proc` method will attempt to invoke the `Proc#call` instance method, passing the string object `'Joe'` to the `str` parameter. As the `Proc` object executes, it executes the code that was originally in the block - it outputs a string `"The string object passed is Joe"` and returns `nil`.
```ruby
def some_method(str)
  yield(str)
end

a_proc = Proc.new { |input| puts "#{input} says hello!" }

some_method('Joe', &a_proc)
# Joe says hello!
# => nil
```
In our example above, we define a method `some_method` on `line 1-3` accepting a `str` parameter. On execution of `some_method`, it will `yield` to a block, passing the object assigned to the method parameter `str` to the block. 

On `line 5`, we instantiate a `Proc` object and assign it to the local variable `a_proc`, which when executed, will expect an object passed to a block parameter `input` and use this object as part of outputting a string, returning `nil`.

On `line 7`, we invoke `some_method`, passing in the string object `'Joe'` as an argument, as well as the `Proc` object referenced by the `a_proc` local variable, despite us not explicitly allowing `some_method` to take more than a single argument. What happens on execution is that by prepending the `&` symbol to the `Proc` object passed as an argument, Ruby converts this `Proc` object to a block. There's no `ArgumentError`, since all methods implicitly accept a block. As such, the `some_method` is able to `yield` to the newly converted block, and the string `"Joe says hello!"` is output, and `nil` is returned by the `puts` method call.

### What is regression testing?
Regression testing is the process of ensuring that once new code is added to a program/changed, no bugs are introduced as a result of this change/addition, by checking that existing functionality still works as expected through a test suite.

### What is a testing framework? What are the associated steps?
A testing framework is code that seeks to test the individual components of a program. It should be able to take inputs, use those inputs to test functionality/expected outputs and raise errors where appropriate. A good testing framework should be able to handle three key requirements:
1. Being able to describe the tests that should be run
2. Being able to execute these tests
3. Being able to compare the results of tests against expected outputs (i.e. reporting the output of tests)

Within the testing framework, there is a hierarchy to the framework:
1. Assertion - This is a verification step that validates whether a expression behaves as intended, compared to an expected value
2. Test - This could be a series of assertions, or a single assertion that assesses whether a particular piece of code intended within a specific situation or context
3. Test Suite - This is the combined series of tests

### What is the difference between assertion and expectation syntax?
Assertion and expectation syntax are two different styles of writing tests for our program. Which one we use is a matter of personal preference (or preferred company style), as they can achieve the same outcomes. In expectation syntax, we organise tests into `describe` blocks, with individual tests written with the `it` method. Instead of assertions, we use *expectation matchers* (e.g. `must_equal` in our example below).
```ruby
# Assertion syntax
def test_equal_value
  car = Car.new
  assert_equal(4, car.wheels)
end

# Expectation syntax
describe 'Car#wheels' do
  it 'has 4 wheels' do
    car = Car.new
    car.wheels.must_equal(4)
  end
end
```
In our above example, both tests are testing for the same thing (i.e. whether `car.wheels` returns the integer object `4`); they are just expressed in different ways.

### What's the difference between Minitest and RSpec?
Minitest is the testing framework that comes installed with the system version of Ruby. `RSpec` is another testing framework that is commonly used by developers. While both are capable of using expectation syntax (note that `RSpec` does __not__ have assertion syntax), `RSpec` can be more flexible in respect of the syntax it can write (such that it can read more like natural English), at the cost of simplicity. `RSpec` uses a domain specific language (DSL), and may be less interpretable to someone who is not familiar with `RSpec`. Contrast this with `minitest`, which uses standard Ruby syntax to write tests and can use assertion syntax. 

### What are some of the limitations with `assert` when testing?
The `assert` method assesses for truthiness. If a test fails, while we can provide an optional message to be displayed on failure as an argument, that message does not provide a lot of context-specific detail as to _why/in what way_ a test has failed, only that it has failed. An alternative is to use `assert_equal`, which provides a more verbose and context specific output if a test fails (e.g. the expected versus returned value).
```ruby
# Assume this test fails
def test_name_assert
  assert('Jelly', menu.dessert)
end
# Expected false to be truthy.

def test_name_assert_equal
  assert_equal('Jelly', menu.dessert)
end
# Failure:
# MenuTest#test_name_assert_equal [minitest_test.rb:10]:
# Expected: "Jelly"
# Actual: "Cake"
```
As we can see above in our example, the `test_name_assert` method uses the `assert` method - when the test fails, the error message raised is not particularly helpful - it does not tell us what the expected value is, only that the test failed. Contrast this with the `test_name_assert_equal` method, which provides a bit more context and verbose error logging, stating what the expected and actual values were, which can aid in debugging.

### Why do we need to take care to ensure our tests themselves don't raise errors?
When using Minitest, the testing file is still a Ruby script. That means that if any of our tests raise an unrescued exception, the script will terminate, meaning any tests that were yet to be run prior to the exception being raised are not run. 

As such, if we're not sure that a particular test will not raise an exception, we are better off using the `skip` keyword in the test definition to avoid running that particular test. 

### What is the SEAT approach in testing? Why is it beneficial?
The SEAT approach is a series of steps we adhere to when writing tests, ensuring that our tests have reduced repetition and there are no lingering artefacts after we finish running our tests. SEAT stands for:
1. (S)etup - this is the process of instantiating objects required to run tests upon
2. (E)xecuting the code against the object we're testing
3. (A)sserting the results of the execution
4. (T)eardown - removing and cleaning any artefacts that may exist as a result of our testing, freeing up system resources

### When do we need the `setup` and `teardown` methods for testing? What do they do?
The `setup` method within Minitest allows us to create a single instance of an object that we can execute our tests against. It is invoked each time a test is executed. This reduces the amount of code duplication required in our test methods. We usually assign the object to an instance variable, so that it can be accessed by other instance methods in our test class. The `teardown` method cleans up our program, by removing any remaining artefacts that may have been created as a result of testing. It also runs every time a test is completed, allowing us to free up system and/or network resources.
```ruby
require 'minitest'
require_relative 'text_analyser'

class FileReview
  def initialize(file_name)
    @file = File.open(file_name, 'r').read
  end

  def lines
    @file.split("\n").count
  end

  def close
    @file.close
  end
end

class FileReviewTest < MiniTest::Test
  def setup
    @new_file = FileReview.new('sample_text.txt')
  end

  def test_lines
    assert_equal(5, @new_file.lines)
  end

  def teardown
    @new_file.close
  end
end
```
In our example above, we define a `FileReview` class, with a number of instance methods. We also define a `FileReviewTest` class, where we write the methods that make up our test suite (inherits from the `MiniTest::Test` class). In our `FileReviewTest` class, we make use of the `setup` and `teardown` methods in order to open a file and close a file respectively, ensuring we don't have to instantiate a new instance of the `FileReview` class in each of our tests (we assign the `FileReview` instance to an instance variable so that subsequent test methods are able to access it), and that system resources are freed once each of our individual tests are completed by closing the file.

### What is code coverage? What does it measure?
In the context of testing, code coverage refers to the proportion of our code that is being tested through various means. It is a measure of code quality, in that a higher code coverage indicates that more of the program has been tested for bugs. 

We can use a gem called `simplecov` to provide us with a % of a code's methods (both private and public) that has been covered through tests. It is not foolproof, as it is unable to assess all the different edge cases that could exist within a program. Other ways we can improve code coverage is through other tools that test branching logic, etc.

### What is Rbenv/RVM? What do they do? Why would we use them?
Rbenv and RVM are Ruby version managers - they let us set different versions of Ruby in our programs depending on what versions of Ruby our program needs to support (e.g. there might be gems in use that require a particular version of Ruby, or there might be particular syntax that exists within specific versions of Ruby).

### What is the difference between Rbenv and RVM?
The main difference between Rbenv and RVM is how each ruby version manager changes the Ruby version. RVM defines a shell function `rvm`, which is used in preference to the disk-based command, as it can modify the environment in which a program is executed. As we use commands such as `rvm use 2.2.2`, RVM dynamically alters the `PATH` variable such that when we execute various commands in the CLI, RVM ensures we are using shell commands instead of disk based commands, allowing us to the right versions of Ruby and gems based on our project requirements (e.g. based on a `.ruby-version` file, if available).

With Rbenv, the `PATH` variable is not dynamically changed. The `PATH` variables is generally only altered once to include a reference to a `shims` directory before any other directories in the `PATH` variable to ensure it is looked through before any other Ruby related directories. Shims are executable scripts that Rbenv uses to run commands in the CLI. An Rbenv shim intercepts a Ruby related command in the CLI and calls `rbenv exec PROGRAM`, which determines what version of Ruby that should be used, and executes the appropriate program from the Ruby version-specific directories based on a `.ruby-version` file (if available).

The other main difference is the folder structure. In Rbenv, gems and executables are stored within folders labelled according to the version of Ruby, while in RVM, gems and rubies have their own directories, where different versions of gems or versions of Ruby are subfolders within those parent directories. 

### What is the `PATH` variable? How is it used in the context of Rbenv versus RVM?
The `PATH` variable stores a series of directories, which give context to any command run in the CLI that doesn't start with `/`, `~` or `.` (since those are paths to files or directories), such as `cd`, `ruby`, without having the user manually specify where that command comes from everytime they want to run that particular command. 

With RVM, the `PATH` variable is dynamically changed as different versions of Ruby are used. With Rbenv, the `PATH` variable usually has a `shims` directory added in front of other directories, to enable the shim scripts to execute version-specific commands based on the version of Ruby set.

### What is a gem? Why might we use gems?
A gem is packaged up code that can be downloaded and used within our own programs to extend it's functionality. We can install gems by running `gem install PACKAGE` in the CLI (works with all versions of Ruby after 1.9). Gems allow us to avoid having to 'reinvent the wheel' for common or useful functionality that could be in our own programs. 

### What is Bundler? What does it do?
Bundler is a gem that handles dependencies, meaning it allows us to manage the different version requirements of gems and Ruby within our project, allowing us to resolve dependency conflicts when issuing shell commands. It relies on a `Gemfile` to tell it what Ruby version, gems and their versions are used within a program. We then run `bundler install`, which scans the list of gems and installs them, as well as any other gems that the gems in the `Gemfile` are dependent on. 

The `bundler install` command also generates a `Gemfile.lock` file, which lists all the dependencies within our programs (including gems which depend on other gems not explicitly listed within our `Gemfile`). Once this `Gemfile.lock` file is generated, we can use `bundle exec GEM_NAME` to run versions of gems specific to our `Gemfile.lock` file, ignoring the other versions installed on our system. It also enables us to use `require bundler/setup` in our program to ensure that the correct versions of Ruby and gems are used when running our application. 

### What is `bundle exec`? How is it different from `binstubs`?
`bundle exec` is a shell command that allows us to run versions of gems specified in the `Gemfile.lock` file, ignoring other versions installed on our systems. It is a way to resolve dependency conflicts. We could use it when we are unable to add `require bundler/setup` to our code, or our program has conflicting needs when executing, or are testing particular parts of our code outside of the context of simply running the program where our system version of a gem that has been loaded is different to the version required in the `Gemfile`.

`binstubs` is an alternative of `bundle exec`. It installs a series of Ruby scripts with the same name as executables installed by gems, but __ignores__ gems not explicitly listed within the `Gemfile.lock` file, which can be problematic if we want to use gems that aren't directly used inside the program, but are used in conjunction with it (e.g. `rubocop` or `pry`).

### What is Rake? What does it do?
`Rake` is a gem that enables us to automate many tasks that may be required in the development process, like setting up directories and environments, running testing, Git commands and deployment of our program. It does this by executing a series of tasks contained in a `Rakefile`, where tasks are methods designed to execute some code using domain specific language.

### How does Rake work?
We can execute rake tasks by using `rake TASK_NAME` (it's recommended to use `bundle exec rake TASK_NAME` in the event we're using Bundler in our application to avoid version conflicts) in the CLI to run a particular task that's defined within a `Rakefile`. Otherwise, we can simply run `bundle exec rake` to execute the default task in the `Rakefile`. We can also use `rake -T` to display all the tasks that are in our `Rakefile`.
