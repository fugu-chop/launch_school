# Closures and Blocks

## Table of Contents
- [Closures](#closures)
- [Calling Methods with Blocks](#calling-methods-with-blocks)
- [Writing Methods that take Blocks](#writing-methods-that-take-blocks)
- [Yielding](#yielding)
- [Passing execution to the block](#passing-execution-to-the-block)
- [Yielding with an argument](#yielding-with-an-argument)
- [Block Arity](#block-arity)
- [Return value of yielding to the block](#return-value-of-yielding-to-the-block)
- [When should we use blocks?](#when-should-we-use-blocks)
- [Methods with an explicit block parameter](#methods-with-an-explicit-block-parameter)
- [Summary](#summary)

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

### Yielding with an argument
Sometimes, the block we pass in to a method requires an argument. Note that the _block itself is an argument into a method_, so the fact that the block requires an argument adds an additional layer of complexity.

In the below code:
1. `3` is the calling object
2. `times` is the method being called
3. The `do ... end` is the block. 
```ruby
3.times do |num|
  puts num
end
```
The `num` variable between the two `|`'s is a parameter for the block, or, more simply, a __block parameter__. Within the block, `num` is a __block local variable__. This is a special type of local variable where the _scope is constrained to the block_.

It's important to make sure the block parameter has a _unique name_ and doesn't conflict with any local variables _outside the scope of the block_. Otherwise, you'll encounter __variable shadowing__, which makes it impossible to access the variable defined in the outer scope, which is usually not what you want.

Suppose we want to write a method called `increment` that takes a number as an argument, and returns the argument incremented by 1. At implementation time, we don't want to output the incremented number, because we aren't sure how users will use this method. The only thing we can be sure of is that the method should take an argument and return the argument plus 1.

But we want to allow users to possibly take some action on the newly incremented number at method invocation time. For example, maybe some users want to print it out or others want to log it to a file, or send it to Twitter. We want to allow for some flexibility at method usage or invocation time. Blocks are perfect for this.
```ruby
# method implementation
def increment(number)
  if block_given?
    yield(number + 1)
  end
  number + 1
end

# method invocation
increment(5) do |num|
  puts num
end
```
The above method invocation outputs `6`. Notice the use of `block_given?`, which allows us to continue to call the method without a block.
1. Execution starts at method invocation on line 10.
2. Execution moves to the method implementation on line 2, which sets `5` to the local variable `number`, and the block is _not set to any variable_; it's just __implicitly available__.
3. Execution continues on line 3, which is a conditional.
4. Our method invocation has indeed passed in a block, so the conditional is true, moving execution to line 4.
5. On line 4, execution is yielded to the block (or the block is called), and we're passing `number + 1` to the block. This means we're calling the block with `6` as the block argument.
6. Execution jumps to line 10, where the block local variable `num` is assigned `6`.
7. Execution continues to line 11, where we output the block local variable `num`.
8. Execution continues to line 12, where the end of the block is reached.
9. Execution now jumps back to the method implementation, where we just finished executing line 4.
10. Execution continues to line #5, the end of the `if`.
11. Line 6 returns the value of the incremented argument to line 10.
12. The program ends (the return value of `#increment` is not used)

### Block Arity
What happens if we pass in an extra argument to the block?
```ruby
# method implementation
def test
  # passing 2 block arguments at block invocation time
  yield(1, 2)
end

# method invocation
test { |num| puts num }
# expecting 1 parameter in block implementation
```
The above code outputs `1`. The __extra block argument is ignored__. If we pass in one _fewer_ argument to the block:
```ruby
# method implementation
def test
  # passing 1 block argument at block invocation time
  yield(1)
end

# method invocation
test do |num1, num2|
  # expecting 2 parameters in block implementation
  puts "#{num1} #{num2}"
end
```
This also outputs `1`. But this output is different from the previous one. In this case, the `num2` block local variable is `nil`, so the string interpolation converted that to an empty string, which is why we get `1` (there's an extra space).

The rules regarding the number of arguments that you can pass to a block, `Proc`, or lambda in Ruby is called its __arity__. In Ruby, blocks have _lenient arity rules_, which is why it doesn't complain when you pass in different number of arguments; `Proc` objects and lambdas have different arity rules. For now, just remember that __blocks don't enforce argument count, unlike normal methods in Ruby__.

### Return value of yielding to the block
Suppose we want to write a method that outputs the before and after of manipulating the argument to the method.
```ruby
def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

# method invocation
compare('hello') { |word| word.upcase }

# Before: hello
# After: HELLO
# => nil
```
We can see that the after local variable in the `compare` method implementation is assigned the *return value from the block*. This is yet another behavior of blocks that's similar to normal methods: they have a return value, and that return value is determined based on the *last expression in the block*. 

This implies that just like normal methods, blocks *can either mutate the argument with a destructive method call or the block can return a value*. Just like writing good normal methods, writing good blocks requires you to keep this distinction in mind. 

Note that the last line, `=> nil`, is the return value of the `compare` method, and isn't related to what we're doing in the block. The last expression in the compare method is a `puts`, and therefore the return value of calling compare is always `nil`.

We could further call this `compare` method with a variety of different implementations.
```ruby
def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

compare('hello') { |word| word.slice(1..2) }
# Before: hello
# After: el
# => nil

compare('hello') { |word| "nothing to do with anything" }
# Before: hello
# After: nothing to do with anything
# => nil
```
In the above two examples, pay attention to the *return value from the block*. That's what the `compare` method implementation is relying on to display in the "After" scenario.

In our below example, the return value of the block is `nil` - `puts` always returns `nil`, and when calling `to_s` on `nil` through string interpolation, we get an empty string.
```ruby
def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

compare('hello') { |word| puts "hi" }
# Before: hello
# hi
# After:
# => nil
```
### When should we use blocks?
The two main use cases are:

#### Defer some implementation code to method invocation decision
There are two roles involved with any method: the __method implementor__ and the __method caller__ (note that this could be the same person/developer). There are times when the method implementor is not 100% certain of how the method will be called. Maybe the method implementor is 90% certain, but wants to leave that 10% decision up to the method caller at method invocation time.

Without using blocks, the method implementor can allow method callers to pass in some flag. For example, take our `compare` method above. Suppose we don't use blocks. We can still achieve similar functionality, like this:
```ruby
def compare(str, flag)
  after = case flag
          when :upcase
            str.upcase
          when :capitalize
            str.capitalize
          # etc, we could have a lot of 'when' clauses
          end

  puts "Before: #{str}"
  puts "After: #{after}"
end

compare("hello", :upcase)
# Before: hello
# After: HELLO
# => nil
```
This isn't nearly as flexible as allowing method callers a way to refine the method implementation, without actually modifying the method implementation for everyone else. By using blocks, the method implementor can *defer the decision of which flags to support* and let the method caller decide at method invocation time. 

Many of the core library's most useful methods are useful precisely because they are __built in a generic sense__, allowing us (the method callers) to refine the method through a block at invocation time. For example, take the `Array#select` method. We love the `select` method because we can pass in any expression that evaluates to a boolean in the block parameter. 

Imagine that instead of a flexible `select` method, we had `select_odds` or `select_greater_than(num)`. The latter methods would still work, but not be nearly as flexible and we'd have to memorize all the method names for that specific scenario. Instead, the `select` method is built in a generic way, allowing us (the method callers) to pass in the refinement to the method implementation.

If you encounter a scenario where you're calling a method from multiple places, with one little tweak in each case, it may be a good idea to try implementing the method in a generic way by yielding to a block.

#### Methods that need to perform some "before" and "after" actions - sandwich code
There will be times when you want to write a generic method that performs some _"before" and "after" action_. Before and after what? That's exactly the point -- the method implementor doesn't care: __before and after anything__.

Suppose we want to write a method that outputs how long something takes. Our method doesn't care what that _something_ is; our method just cares about displaying how long it took.
```ruby
def time_it
  time_before = Time.now
  # do something
  time_after= Time.now

  puts "It took #{time_after - time_before} seconds."
end
```
As the method implementor, __we don't care what "do something" is__. The responsibility for our method starts and stops at timing the action, without regard to what the actual action is. This is a good use case for blocks. Using blocks, we can allow method callers to specify any action, and use our method to time that action.
```ruby
def time_it
  time_before = Time.now
  # execute the implicit block
  yield
  time_after= Time.now

  puts "It took #{time_after - time_before} seconds."
end

time_it { sleep(3) }                    
# It took 3.003767 seconds.
# => nil

time_it { "hello world" }
# It took 3.0e-06 seconds.
# => nil
```
The `sleep` method pauses execution for however many seconds you pass in. You can see that our `time_it` method does exactly what we want: it times the code passed in to it. In order to time it, we need to capture the time before execution, then compare it with the time after execution. 

There are many useful use cases for "sandwich code". Timing, logging, notification systems are all examples where before/after actions are important.

Another area where before/after actions are important is in resource management, or interfacing with the operating system. Many OS interfaces require you, the developer, to first allocate a portion of a resource, then perform some clean-up to free up that resource. Forgetting to do the clean-up can result in dramatic bugs -- system crashes, memory leaks, file system corruption. Wouldn't it be great if we can automate this clean-up?

This is exactly what the `File::open` method does for us.
```ruby
my_file = File.open("some_file.txt", "w+")
# creates a file called "some_file.txt" with write/read permissions
# write to this file using my_file.write
my_file.close
```
That last line closes the file and releases the `my_file` object from hanging on to system resources -- specifically, the file `"some_file.txt"`. Since we always want to close files, `File::open` can also take a block, and will *automatically close the file after the block is executed*.
```ruby
File.open("some_file.txt", "w+") do |file|
  # write to this file using file.write
end
```
We don't currently understand exactly how blocks work, and so we can't exactly say why we don't have the close the file. However, we can guess that the method implementor of `File::open` opens the file, yields to the block, then closes the file. This means the method caller only needs to pass in the relevant file manipulation code in the block without worrying about closing the file.

### Methods with an explicit block parameter
Until now, we've passed blocks to methods __implicitly__. Every method, regardless of its definition, takes an implicit block. It may *ignore the implicit block, but it still accepts it*. However, there are times when you want a method to take an __explicit block__; you do that by defining a parameter prefixed by an `&` character in the method definition. 

The block must always be referenced by the __last parameter in the method definition prepended by a `&` symbol__. This syntax signals that any block passed into the method upon method invocation can be used as a `Proc` (but is optionally passed in - not passing in a block in our below method does not result in an error). __The block is converted to a `Proc` object__ and will no longer be anonymous inside the method definition.
```ruby
def test(&block)
  puts "What's &block? #{block}"
end
```
The `&block` is a special parameter that *converts the optional block argument* to what we call a "simple" `Proc` object (the exact definition of a simple `Proc` object isn't important at this time). Notice that we drop the `&` when referring to the parameter inside the method. 
```ruby
test { sleep(1) }
# What's &block? #<Proc:0x007f98e32b83c8@(irb):59>
# => nil
```
__The `block` local variable is now a `Proc` object__. Note that we can name it whatever we please; it doesn't have to be `block`, just as long as we define it with a leading `&`.

Why do we now need an explicit block instead? Chiefly, the answer is that it _provides additional flexibility_. Before, we didn't have a handle (a variable) for the implicit block, so we couldn't do much with it except yield to it and test whether a block was provided. Now we have a variable that represents the block, so we can __pass the block to another method__:
```ruby
def test2(block)
  puts "hello"
  # calls the Proc object that was originally passed to test()
  block.call
  puts "good-bye"
end

def test(&block)
  puts "1"
  # The & symbol converts the block to a Proc object, which is passed as an argument to test2
  test2(block)
  puts "2"
end

# Note how the method invocation syntax is the same as if we had an implicit block
test { puts "xyz" }
# => 1
# => hello
# => xyz
# => good-bye
# => 2
```
Note that you only need to use `&` for the block parameter in `#test`. Since `block` is already referencing a `Proc` object when we call `test2`, no additional conversion is needed.

Note that we also use `block.call` inside `test2` to invoke the `Proc` instead of `yield`. If you wanted to invoke the `Proc` from `test`, you would do the same thing: `block.call`). It's not often that you need to pass a block around like this, but the need does arise.

The above discussion of explicit blocks is simplified from reality. Things get a bit more complicated if the caller passes in a `Proc` object, a lambda, or some other object to a method that takes an explicit block. For now, you just need to know that __Ruby converts blocks passed in as explicit blocks to a simple `Proc` object__ (this is why we need to use `#call` to invoke the `Proc` object).

### Summary
- Blocks are one way that Ruby implements closures. Closures are a way to pass around an unnamed "chunk of code" to be executed later.
- Blocks can take arguments, just like normal methods. But unlike normal methods, it won't complain about wrong number of arguments passed to it (based on lenient arity rules).
- Blocks return a value, just like normal methods.
- Blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.
- Blocks are a good use case for "sandwich code" scenarios, like closing a `File` automatically.
