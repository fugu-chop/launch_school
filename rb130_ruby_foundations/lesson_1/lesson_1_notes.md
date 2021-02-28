# Lesson 1

## Table of Contents
- [Closures](#closures)
- [Calling Methods with Blocks](#calling-methods-with-blocks)
- [Writing Methods that take Blocks](#writing-methods-that-take-blocks)
- [Yielding](#yielding)
- [Passing execution to the block](#passing-execution-to-the-block)

### Closures
A __closure__ is a general programming concept that allows programmers to *save a "chunk of code"* and execute it at a later time. It's called a "closure" because it's said to __bind its surrounding artifacts__ (i.e. variables, methods, objects, etc) and build an "enclosure" around everything so that they can be referenced when the closure is later executed. 

It's sometimes useful to think of a closure as a method that you can _pass around and execute_, but it's __not defined with an explicit name__. Different programming languages implement closures in different ways. Some languages will have first class support for it, while other languages won't deal with it at all.

The idea of having an unnamed "chunk of code" that we can pass around is very handy, especially when we pass them into _existing methods_. The only thing to remember is that this "chunk of code" retains _references to its surrounding artifacts_ - its __binding__.

There are three main ways to work with closures in Ruby:
1. Instantiating an object from the `Proc` class
2. Using __lambdas__
3. Using __blocks__

### Calling Methods with Blocks
In the below code snippet:
1. We are working with an `Array` object
2. The method we're calling on that object is `Array#each`
3. The part that's a __block__ is the `do` ... `end` part
```ruby
[1, 2, 3].each do |num|
  puts num
end
```
The __block is an argument__ to the method call. In other words, `[1, 2, 3].each { |num| puts num }`, is actually passing in the block of code to the `Array#each` method.

The entire block is passed in to the method like any other argument, and it's _up to the method implementation to decide what to do with the block_, or chunk of code, that you passed in. The method could take that block and execute it, or just as likely, it could completely ignore it -- it's up to the method implementation to decide what to do with the block of code given to it.

### Writing Methods that take Blocks
In Ruby, _every method can take an optional block as an implicit parameter_. You can just tack it on at the end of the method invocation.
```ruby
def echo(str)
  str
end

echo                                          
# => ArgumentError: wrong number of arguments (0 for 1)

echo("hello!")
# => "hello!"
echo("hello", "world!")
# => ArgumentError: wrong number of arguments (2 for 1)

# this time, called with an implicit block
echo { puts "world" }
# => ArgumentError: wrong number of arguments (0 for 1)

echo("hello!") { puts "world" }
# => "hello!"

echo("hello", "world!") { puts "world" }
# => ArgumentError: wrong number of arguments (2 for 1)
```
It's almost as if the block wasn't even being passed to the method.

### Yielding
One way that we can invoke the passed-in block argument from within the method is by using the `yield` keyword.
```ruby
def echo_with_yield(str)
  yield
  str
end

echo_with_yield { puts "world" }
# => ArgumentError: wrong number of arguments (0 for 1)

echo_with_yield("hello!") { puts "world" }
# world
# => "hello!"

echo_with_yield("hello", "world!") { puts "world" }
# => ArgumentError: wrong number of arguments (2 for 1)
```
Notice the first method call and the last method call generated errors. The second method call -- the one with a string parameter as well as a block -- did what we expected. That is, it *printed* out the string `"world"` and then *returned* the string `"hello!"`. 

Seeing these results tells us two things:
1. The number of arguments at method invocation needs to match the method definition, regardless of whether we are passing in a block.
2. The `yield` keyword executes the block.

If your method implementation contains a `yield`, a developer using your method can come in after this method is fully implemented and *inject additional code in the middle of this method* (without modifying the method implementation), by passing in a block of code. This is indeed one of the major use cases of using blocks.

Let's take a look at a common edge case. Let's continue using our `echo_with_yield` method from above, but we're now calling it like this:
```ruby
echo_with_yield("hello!")
# => LocalJumpError: no block given (yield)
```
If you ever see a `LocalJumpError` error message, you should guess that the method implementation has a `yield` in it somewhere, but *we didn't include a block at method invocation*. 

In order to allow calling the method with or without a block, we must somehow wrap the `yield` call in a *conditional*: only call `yield` __when a block is passed to the method__ and don't call `yield` when there's no block. We can achieve this with the `Kernel#block_given?` method. And because it's in `Kernel`, it's available everywhere.
```ruby
def echo_with_yield(str)
  yield if block_given?
  str
end

echo_with_yield("hello!")
# => "hello!"

echo_with_yield("hello!") { puts "world" }
# world
# => "hello!"
```
Now, we can call `echo_with_yield` with or without a block. If a block is passed in, the `block_given?` will be `true`, and our *code will `yield` to the block* (i.e. execute the block of code). If a block is not passed in, the `block_given?` will be `false`, and the only thing the method will do is return `str`.

### Passing execution to the block
Before we begin tracing the execution flow, we have to be clear that the `def say` code is the __method implementation__, and the `say` code is the __method invocation__. There is __only one method here__: `say`. 

Sometimes, when we're passing in a block of code, the method invocation can contain more code than the method implementation, which makes it easy to confuse the two -- don't get mixed up by this.
```ruby
# method implementation
def say(words)
  yield if block_given?
  puts "> " + words
end

# method invocation
say("hi there") do
  system 'clear'
end                                                
# clears screen first, then outputs "> hi there"
```
1. Execution starts at method invocation, on line 8. The `say` method is invoked with two arguments: a string and a block (the block is an __implicit parameter and not part of the method definition__).
2. Execution goes to line 2, where the method local variable `words` is assigned the string `"hi there"`. The __block is passed in implicitly, without being assigned to a variable__.
3. Execution continues into the first line of the method implementation, line 3, which immediately yields to the block.
4. The block, line 9, is now executed, which clears the screen.
5. After the block is done executing, execution continues in the method implementation on line 4. Executing line 4 results in output being displayed.
6. The method ends, which means the last expression's value is returned by this method. The last expression in the method invokes the `puts` method, so the return value for the method is `nil`.
