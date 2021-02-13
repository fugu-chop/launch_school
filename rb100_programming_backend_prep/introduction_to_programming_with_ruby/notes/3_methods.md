# Methods

## Table of Contents
- [What is a method?](#what-is-a-method)
- [Parameters and Arguments](#parameters-and-arguments)
- [Calling a method](#calling-a-method)
- [Method definition and local variable scope](#method-definition-and-local-variable-scope)
- [Mutating the caller](#mutating-the-caller)
- [Puts versus Return](#puts-versus-return)
- [Chaining methods](#chaining-methods)
- [Method calls as arguments](#method-calls-as-arguments)

### What is a method
You'll often have a piece of code that needs to be executed many times in a program. Instead of writing that piece of code over and over, there's a feature in most programming languages called a procedure, which allows you to extract the common code to one place. 

In Ruby, we call it a __method__. Before we can use a method, we must first define it with the reserved word `def`. After the `def` we give our method a name. At the end of our method definition, we use the reserved word `end` to denote its completion. 
```ruby
def say(words)
  puts words
end

say("hello")
# => "hello"
```
We *call (or invoke)* the method by typing its name and passing in arguments.  

### Parameters and Arguments
You'll notice that there's a `(words)` after `say` in the method definition. This is what's called a __parameter__. 

Parameters are used when you have data *outside of a method definition's scope*, but you need access to it *within* the method definition. If the method definition does not need access to any outside data, you do not need to define any parameters.

__Arguments__ are pieces of information that are sent to a method invocation to be modified or used to return a specific result. We *pass* arguments to a method when we call it. 

The `parameter` is a term that should only be used to describe the name of inputs listed in the `def` statement.  To refer to the value (or data passed in) of that parameter, you should refer to the `argument`. Methods are *defined* with parameters, but they are *called* with arguments.

To be even more precise:
- Parameters are named variables you define as part of a method definition or block (e.g. a block parameter)
- Arguments are values that you pass into a method (including for blocks)

In our example above, we are using an argument to pass the word, or string of words, that we want to use in the `say` method definition. 

When we pass those words into the method definition, they're assigned to the *local* variable `words` and we can use them however we please from within the method definition. Note that the `words` local variable is scoped at the *method definition level*; that is, you __cannot__ reference this local variable outside of the `say` method definition.

###### Describing what's happening
Take this example:
```ruby
def example(str)
  i = 3
  loop do
    puts str
    i -= 1
    break if i == 0
  end
end

example('hello')
```
On lines 1–8 we are defining the method `example` which takes 1 __parameter__. 

On line 2 of this code we are initializing the local variable `i` and assigning to it an integer with value `3`.

On line 3 we are calling the method `loop` (`loop` is a method of the `Kernel` module) and passing in the `do..end` block as an argument. The block here is __passed to a method call as an argument__.  We are also calling the method `puts` and passing in __local variable__ `str` to it as an argument. 

On line 5 the local variable `i` is reassigned. `-=` is reassignment; syntactical sugar for `i = i — 1` . Also note that `—` is __not an operator__ but a __method__ and that code can also be written as `i = i.-(1)`; another example of syntactical sugar. So inside of this code we are reassigning the local variable `i` to the return value of a method call `Integer#-` on a local variable `i` with integer `1` passed to it as an argument.

On line 6 we are breaking out of the loop by using the keyword `break` if the __value of the object__ that local variable `i` is *referencing* is equal to `0`.

On line 10 we are calling the method `example` and passing in string `hello` as an argument.

Finally, this code __outputs__ the string `hello` 3 times and __returns__ `nil`. The last evaluated expression is returned since we don’t have an explicit `return` inside of the method definition. That last evaluated expression is `break if i == 0` in this case, which returns `nil`.

###### Default parameters
Sometimes, we just want to make sure our program runs, even if a necessary parameter isn't given to the method. We can use default parameters for this purpose:
```ruby
def say(words="Hello")
  puts words
end

say()
# => Hello!
```
### Method Definition and Local Variable Scope
A method definition __creates its own scope__ outside the regular flow of execution. Method parameters (assigned as local variables within the method definition) are scoped at the *method definition level*, and are __not__ available *outside* of the method definition.

This is why local variables *within* a method definition cannot be referenced from outside of the method definition. It's also the reason why local variables within a method definition cannot access data outside of the method definition (unless the data is passed in as an argument).
```ruby
a = 5

def some_method
  a = 3
end

puts a
# => 5
```
`a` is still 5, because method definitions create their own scope that's entirely outside of the execution flow.

Make sure you don't mix up *method invocation with a block* and *method definition* when you're working with local variable scope issues. They have different behaviors when it comes to local variable scope.
```ruby
# Method definition
def print_num(num)
  puts num
end

# Method invocation with a block
[1, 2, 3].each do |num|
  puts num
end
```
### Calling a method
There are two ways to call methods that we will discuss. 
- The `some_method(obj)` format is when you send *arguments to a method call*; in the previous example, we are passing an argument to the `obj` parameter in the `some_method` method. 
- Sometimes, you will see methods called with an explicit caller, like this `a_caller.some_method(param)`. For now it's best to think of the previous code as `some_method` modifying `a_caller`.

### Mutating the caller
When calling a method, the *argument* can be altered permanently. We call this *mutating the caller*. 

Integers are immutable, and so cannot be mutated by methods.
```ruby
def some_method(number)
  number = 7 # this is implicitly returned by the method, regardless of what we put in as a number
end

some_method(4)
# => 7

a = 5
some_method(a)
puts a
# => 5
```
`number` is scoped at the method definition level and `a`'s value is unchanged. Therefore, we proved that method definitions *cannot modify arguments passed in to them permanently*. The exception is when we perform some action on the argument that mutates the *caller*, we can in fact permanently alter variables __outside the method definition's scope__.
```ruby
a = [1, 2, 3]

# Example of a method definition that modifies its argument permanently
def mutate(array)
  array.pop
end

p "Before mutate method: #{a}"
# => "Before mutate method: [1, 2, 3]"

mutate(a)
# => 3

p "After mutate method: #{a}"
# => "After mutate method: [1, 2]"
```
We have permanently modified the local variable `a` by passing it to the `mutate` method, even though `a` is outside the method definition's scope. This is because the `pop` method mutates the caller (the array).

A note on terminology:
```ruby
# This is an example of mutating the caller
"Winner".sub!('r', 'y')

# This is an example of mutating an argument
def upcase(str)
  str.upcase!
end
```
The __`upcase` method definition does not have an explicit caller__ - it takes an argument, and mutates that argument. The `.sub!` method mutates it's caller, because the `Winner` string is *calling* the method. Method __definitions do not have callers__ - they take arguments. 

There's no obvious way to tell if a method will mutate the caller, other than referencing the documentation or trial and error. 

###### p versus puts
As a sidenote, we used `p` to print the string. This is different to `puts`, since there was no `nil` after the string was printed, as well as printing the quotes around the string. By default, `puts` returns `nil`. 

### Puts versus return
Ruby methods __always__ return the evaluated result of the __last line__ of the expression unless an explicit `return` comes before it (which will stop further execution of the method). The `return` reserved word is not required in order to return something from a method.
```ruby
a = [1, 2, 3]

# Example of a method definition that modifies its argument permanently
def mutate(array)
  array.pop
end

mutate(a)
# => 3
```
Note how the `mutate` function prints a `3` to the console, even though we didn't specify a print command anywhere in the method. 

Look at this example:
```ruby
def add_three(number)
  return number + 3
  number + 4
end

add_three(4)
# => 7
```
Here, the explicit `return` stops the method from evaluating subsequent code. 
```ruby
def just_assignment(number)
  foo = number + 3
end

just_assignment(3)
# => 6
```
We didn't specify a `return` keyword, or a print command, but Ruby still returned the variable. 

###### Good practice
Your goal should be to build small methods that are like LEGO blocks: they should be stand-alone pieces of functionality that you can use to piece together larger structures. 

You don't want these methods to be mentally taxing to use. Interesting structures are comprised of many hundreds or thousands of atomic LEGO pieces. Likewise, large programs are comprised of hundreds or thousands of small methods.

It's generally recommended to have methods __either__ return a value, __or__ have a side effect (i.e. __something other than returning a value__), and __not both__. Examples of side effects:
- Writing to a file,
- Printing output (e.g. `puts 'hello'`),
- Raising an exception, and
- Mutating a non-local variable.

Other good practices include:
- Method names should provide some level of inkling as to what it does - either returning a value, or producing a side effect (e.g. `total`, `update_total`, `print_hello`).
- Methods should be at the same level of abstraction. E.g. We should be able to compartmentalise our methods, and for them to be fairly similar in respect of what they do or how they do them. 
  - An example would be `deal()`, `hit()`, `stay()` and `iterate_through_cards()`. The first three methods are verbs in the context of the game, whereas the last method is a programming concern. 

### Chaining methods
Because we know for certain that every method call returns something, we can chain methods together, which gives us the ability to write extremely expressive and succinct code.
```ruby
def add_one(n)
  n + 1
end

add_one(1).times { puts "this should print something 2 times" }

# this should print something 2 times
# this should print something 2 times
# => 2
```
Our ability to chain methods depends entirely on the method's ability to return a value. 
```ruby
def add_three(n)
  puts n + 3
end

add_three(1).times { puts "This won't work" }
# => NoMethodError (undefined method `times' for nil:NilClass)
```
This returned an error, because `puts` returns `nil` (and we aren't explicitly returning another value). Therefore, the `.times` method has nothing to run against.

We could fix our above method like so:
```ruby
def add_three(n)
  new_value = n + 3
  puts new_value
  new_value
end

add_three(1).times { puts "This should now print 4 times" }
This should now print 4 times
This should now print 4 times
This should now print 4 times
This should now print 4 times
# => 4
```
### Method calls as arguments
Ruby allows us to pass a method call as an argument to other methods. 
```ruby
def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def multiply(num1, num2)
  num1 * num2
end

multiply(add(1, 2), subtract(4,2))
# => 6
```
### The Call Stack
The call stack helps Ruby keep track of __what__ method is executing as well as __where__ execution should resume when it returns. 

To do that, it works like a stack of books: if you have a stack of books, you can put a new book on the top or remove the topmost book from the stack. In much the same way, the call stack puts information about the *current method on the top of the stack*, then *removes* that information when the method __returns__. It operates on a last in, first out basis.  

Note that blocks, procs, and lambdas also use the call stack; in fact, they all use the same call stack as Ruby uses for methods. 

Take the following example:
```ruby
def first
  puts "first method"
end

def second
  first
  puts "second method"
end

second
puts "main method"
```
When this program starts running, the call stack initially has one item (called a __stack frame__) that represents the global (top-level) portion of the program. The initial stack frame is sometimes called the `main` method. Ruby uses this frame to keep track of what part of the main program it is currently working on.
```
  Call Stack
      -
      -
      -
     main
```
When program execution reaches the method invocation at `second`, it first updates the `main` stack frame with the current program location. Ruby will use this location later to determine where execution should resume when `second` finishes running.

After setting the location in the current stack frame, Ruby creates a new stack frame for the `second` method and places it on the top of the call stack: we say that the __new frame is pushed onto the stack__. 
```
  Call Stack
      -
      -
    second
  main: line 10
```
The frame for the `second` method is now stacked on top of the main frame. While the `second` frame is still on the stack, `main` remains stuck beneath it, *inaccessible*. At the same time, the `main` method becomes dormant and the `second` method becomes active.

The `second` method calls the `first` method on line 6. That action causes Ruby to update the `second` frame so that Ruby will know where to resume execution later. It then creates a new stack frame for the `first` method and pushes it to the call stack.
```
  Call Stack
      -
    first
second: line 6
 main: line 10
```
Once the `first` method begins executing, it invokes the `puts` method. All Ruby methods, including the built-in ones like `puts`, share the __same call stack__. Therefore, we need to record our current location and then push a new frame to the stack.
```
  Call Stack
    puts
 first: line 2
 second: line 6
 main: line 10
```
When `puts` __returns__, Ruby removes (pops) the top frame from the call stack. That's the frame for `puts` for this example. That leaves the previous stack frame exposed. Ruby uses this frame to determine where execution should resume. In this case, execution resumes immediately. Note we skipped a few `puts` steps - let's just assume only one occurs in this example. 
```
  Call Stack
      -
 first: line 2
 second: line 6
 main: line 10
```
Eventually, the `first` method will __return__. When that happens, the `first` frame gets popped from the stack. That exposes the stack frame for `second`, and that, in turn, tells Ruby that it should resume execution.
```
  Call Stack
      -
      -
second: line 6
  main: line 10
```
When `second` finishes executing, the stack frame for `second` gets popped from the call stack, exposing the stack frame for `main`. The `main` frame tells Ruby to resume execution.
```
  Call Stack
      -
      -
      -
 main: line 10
```
Eventually, the `main` method has no more code to run. When this happens, the main `frame` gets popped from the stack, and the program ends.
```
  Call Stack
      -
      -
      -
      -
```
The call stack has a limited size that varies based on the Ruby implementation. That size is usually sufficient for more than 10000 stack entries. If the stack runs out of room, you will see a `SystemStackError` exception.
