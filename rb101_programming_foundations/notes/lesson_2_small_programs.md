
# Lesson 2 - Small Programs
## Table of Contents
- [Style for Lesson 2 Only](#style-for-lesson-2-only)
- [Truthiness](#truthiness)
- [What is truthiness?](#what-is-truthiness)
- [Syntactic sugar](#syntactic-sugar)
- [Pseudo-code](#pseudo-code)
- [Rubocop](#rubocop)
- [Debugging](#debugging)
- [Precedence](#precedence)

### Style for Lesson 2 Only
In this lesson we're going to always use parentheses when invoking a method. Example: we will use `gets().chomp()` instead of `gets.chomp`, just so we're clear on what is a method invocation and what is a local variable. 

In this lesson, we are going to call `gets` and `puts` methods with their module, like this: `Kernel.puts()` or `Kernel.gets()`. Doing this shows that these are module methods in the `Kernel` module.

When we write Ruby code that's not in a class, we are working within an object called `main`, which is an instance of Object. The Kernel module is automatically loaded by Object, giving us access to all of its methods.

### Truthiness
In Ruby, booleans are represented by the `true` and `false` objects. Like everything else in Ruby, boolean objects also have real classes behind them, and you can call methods on `true` and `false`.
```
true.class          # => TrueClass
true.nil?           # => false
true.to_s           # => "true"
true.methods        # => list of methods you can call on the true object

false.class         # => FalseClass
false.nil?          # => false
false.to_s          # => "false"
false.methods       # => list of methods you can call on the false object
```
You can use the two boolean objects in conditionals.
```
if true
  puts 'hi'
else
  puts 'goodbye'
end

hi
=> nil
```
###### Expressions & conditionals
In real code, you won't use the `true` or `false `objects directly in a conditional. Instead, you'll likely be evaluating some expression or method call in a conditional. Whatever the expression, it should evaluate to a `true` or `false` object.
```
num = 5

if (num < 10)
  puts "small number"
else
  puts "large number"
end

small number
=> nil
```
You can substitute the code expression with a method call too. When using method calls as a conditional expression in this way, you'll generally want the method to *return a boolean* rather than relying on the truthiness or falsyness of a non-boolean return value.
```
# This will output "it's true!" if some_method_call returns a truthy value.
puts "it's true!" if some_method_call
```
###### Logical Operators
Logical operators will return either a truthy or falsey value when evaluating two expressions.
- `&&` will return `true` if both expressions being evaluated are `true`.
- `||` will return `true` if *either or both* expressions evaluated are `true`.

The `&&` and `||` operators exhibit a behavior called *short circuiting*, which means it will stop evaluating expressions once it can guarantee the return value.
- The `&&` will short circuit when it encounters the first `false` expression.
- The `||` will short circuit when it encounters the first `true` expression.

### What is truthiness?
Truthiness differs from `true` in that Ruby considers more than the `true` object to be "truthy". In fact, Ruby is a very liberal language and *considers everything to be truthy other than `false` and `nil`*.

This means that we can use *any expression in a conditional, or with logical operators*, and as long as it __doesn't__ evaluate to `false` or `nil`, it is considered true (even the integer `0`!). Note that an expression that Ruby considers true is __not the same as the `true` object__. This is what "truthiness" means. 

### Syntactic Sugar
In Ruby, parentheses are optional when invoking a method call. This means we can reduce the amount of typing we do, but it also means they sometimes look like variables. Also, we don't also have to reference the module that method calls come from - e.g. `puts`, when typed out fully, looks like `Kernel.puts()`.

### Pseudo-code
This is a human readable form of the logic that we want our program to perform. This allows us to load the problem into our brain first, and decompose the problem, without having to write syntax at the same time. 

This enables us to separate the problem into two layers:
1. The logical problem domain layer.
2. The syntactical programming language layer.

When you're not yet fluent in a programming language, doing both at the same time can be very difficult and frustrating. This might be an example of pseudo-code:
```
while user wants to keep going
  - ask the user for a collection of numbers
  - extract the largest one from that collection and save it
  - ask the user if they want to input another collection

return saved list of numbers
```
That seems reasonable, but you can see the line `extract the largest one from that collection` is a sub-process that itself contains a lot of logic. The functionality there is pretty self-contained, so it's a great candidate for a *sub-process*.

The problem with pseudo-code, however, is that we cannot verify its logic. In order to verify its logic, we have to translate the pseudo-code into programming code.

###### Formal Pseudo-code
Before we can take our pseudo-code and translate it to program code, we need to first formalize the pseudo-code a little bit more. We'll still use English, but we'll use some keywords to help us break down the program logic into concrete commands, which will then make translating to program code much easier.

We'll use the below keywords to assist us, along with their meaning.
__*keyword*__ 	        __*meaning*__
`START` 	              start of the program
`SET` 	                sets a variable we can use for later
`GET` 	                retrieve input from user
`PRINT` 	              displays output to user
`READ` 	                retrieve value from variable
`IF / ELSE IF / ELSE` 	show conditional branches in logic
`WHILE` 	              show looping logic
`END` 	                end of the program

This could be an example of formal pseudo-code in practice:
```
START

SET large_numbers = []
SET keep_going = true

WHILE keep_going == true
  GET "enter a collection"
  SET collection
  SET largest_number = SUBPROCESS "extract the largest one from that collection"
  large_numbers.push(largest_number)
  GET "enter another collection?"
  IF "yes"
    keep_going = true
  ELSE
    keep_going = false
  IF keep_going == false
    exit the loop

PRINT large_numbers

END
```
Notice that we have a `SUBPROCESS` keyword to show that there's some other thing that will take care of extracting the largest number out of a collection. 

We could have included the entire formal pseudo-code, but that would have made it very long, and our confidence in such long pseudo-code cannot be very good. Extracting to sub-processes helps us focus on a well defined narrowly scoped set of pseudo-code.

When pseudo-code gets long, it becomes very hard to trust the accuracy of the logic (remember, you can only verify the logic by running actual program code). Therefore, it's prudent to extract a logical grouping into a sub-process, and to tackle the various pieces separately.

### Rubocop
Rubocop is a static code analyzer. This means that it analyzes your code and offers advice about its style format as well as possible logical errors. Rubocop itself is a modular framework using a pluggable architecture to insert enforcement rules. In Rubocop parlance, these rules are called `cops`. Cops are further grouped into `departments`.

###### Style Format
The first department we care about centers around enforcing good coding style. Coding style is a matter of opinion, but, in general, Rubyists have settled on a set of conventions. A document called the Ruby Style Guide captures these conventions. Many of Rubocop's style cops enforce the styles in that guide.

For example, if your code isn't indented with 2 spaces, the `IndentationWidth` cop will complain.

###### Code Linting
The other department we're interested in is around code linting. A code linter is a program that inspects your code for possible logical errors or code smells. This isn't foolproof, but can serve as a first level of defense against obvious problems. Rubocop has some basic code linting functionality built-in.

For example, if your code instantiates an unused local variable, the `UselessAssignment` cop will complain.

### Debugging
We need to develop the correct temperament and procedure for debugging code. 

###### How do we debug?
By focusing on one error at a time!
1. Reproduce the error
  -  We need a deterministic way to consistently reproduce the problem, and only then can we start to isolate the root cause. 
2. Determine the boundaries of the error
  - What we're trying to do is modify the data or code that causes the error, to get an idea of the scope of the error and determine the boundaries of the problem.
3. Trace the code
  - Basically, we work our way up the stack trace and see where the source of the error is. 
4. Understand the problem well
5. Implement a fix
6. Test the fix

###### Techniques for debugging
1. Line by Line 
  - Lots of bugs result from typos or missed details. We need to develop the patience and ability to accurately scan code line by line, word by word, character by character.
2. Rubber Duck
  - Talk through the problem with an inanimate object to test your own understanding of the problem.
3. Walking away
  - Chill out. Take 5. This only really works if you actually make the effort to load the problem into your brain beforehand. 
4. Using `pry`
  - This is a debugging tool.
  - To use it, add `require "pry"` to the top of your code, then insert `binding.pry` below any line of code, and execution will stop, allowing us to debug. 
  - In order to continue execution of the program, press `Ctrl + D`.
  - Alternatively, we can exit the program by entering `exit-program`.  

###### Stack Traces
Stack traces are one of our best tools for debugging code. The error message will include the first hint at where to start looking - specifically, we are looking for what type of error (e.g. a `NoMethodError`) and a location. Thus we can follow the error 'up the stack' - specifically, what inputs feed into other inputs, which will allow us to find where the error occurs. 

### Precedence
The meaning of an expression in Ruby is determined by what is called *operator precedence*. It’s a set of rules that dictate how Ruby determines what operands each operator takes. In an expression, operators with __higher__ precedence are prioritized over those with __lower__ precedence. __Parentheses__ override the default evaluation order, and can be thought of having the highest possible precedence.

An operator that has higher precedence than another is said to __bind__ more tightly to its operands. In the expression `3 + 5 * 7`, the `*` operator __binds more tightly to its operands__, `5` and `7`, than does the `+` operator. Thus, `+` binds to `3` and the return value of `5 * 7` instead of `3` and `5`.

###### Evaluation order
Consider this code and the output it displays:
```
def value(n)
  puts n
  n
end

puts value(3) + value(5) * value(7)

3
5
7
38
```
From the first 3 lines of output, you might conclude that Ruby is evaluating the expression left-to-right. However, the final result says otherwise -- you can only get that result if `value(5) * value(7)` gets evaluated first. 

The issue here is that operators like `+` and `*` need values that they can work with. Method invocations like `value(5)` and `value(7)` __are not values__. We can't invoke the `*` operator until we know what values those methods return. 

In an arithmetic expression, Ruby first goes through an expression *left-to-right* and evaluates everything it can __without calling any operators__. Thus, here it evaluates `value(3)`, `value(5)`, and `value(7)` first, in that order. Only when it has those values does it deal with precedence and re-evaluate the result.

The ternary operator (`?:`) and the short-circuit operators `&&` and `||` are a common source of unexpected behavior where precedence is concerned.
```
3 ? 1 / 0 : 1 + 2  # raises error ZeroDivisionError
5 && 1 / 0         # raises error ZeroDivisionError
nil || 1 / 0       # raises error ZeroDivisionError
```
What happens, though, if we modify things so that 1 / 0 isn't needed?
```
nil ? 1 / 0 : 1 + 2  # 3
nil && 1 / 0         # nil
5 || 1 / 0           # 5
```
In all 3 cases, `1 / 0` never gets executed, even though operator precedence would suggest that it should be evaluated first. In all 3 expressions, this is simply the way Ruby works - it treats `?:`, `&&`, and `||` differently from other operators and doesn't evaluate subexpressions unless it needs them.

###### Weird edge cases
Ruby has some weirdly specific edge cases when it comes to precedence. Compare the following - a `.map` method called on an array. 
```
array = [1, 2, 3]

array.map { |num| num + 1 }     # => [2, 3, 4]

p array.map { |num| num + 1 }      #  outputs [2, 3, 4]
                                   #  => [2, 3, 4]

array.map do |num|
  num + 1
end                                 #   => [2, 3, 4]

p array.map do |num|
  num + 1                   #  outputs #<Enumerator: [1, 2, 3]:map>
end                           #  => #<Enumerator: [1, 2, 3]:map>
```
Why did we get a different result? *Blocks have the lowest precedence of all operators*. But between the two, `{ }` has slightly higher precedence than `do...end`. This has an effect on which method call the block gets passed to. 

How exactly did we get `#<Enumerator: [1, 2, 3]:map>`? With `do...end` being the “weakest” of all the operators, `array.map` gets bound to `p`, which first invokes `array.map`, returning an `Enumerator` object. The `Enumerator` is then passed to `p`, along with the block. `p` prints the `Enumerator`, but doesn't do anything with the block.

Note that `p` doesn’t take a block. As with all methods called with a block that don’t accept one, __the block just gets ignored__.

In other words, the binding of an argument to a method and the method name (`p` and the return value of `array.map`) is slightly *tighter* than the binding between a method call and a `do...end` block. Thus, `array.map` gets executed first, then the return value and the block get passed to `p` as separate arguments.

A `{ }` block, on the other hand, has higher priority which means that it binds *more tightly* to `array.map`. Therefore, when we use `{}`, `array.map` is called with the block, then the return value of `array.map` gets passed to `p`.

The code below is equivalent to the code above, but this time we use parentheses to visualize the order.
```
array = [1, 2, 3]

p(array.map) do |num|
  num + 1                           #  <Enumerator: [1, 2, 3]:map>
end                                 #  => <Enumerator: [1, 2, 3]:map>

p(array.map { |num| num + 1 })      # [2, 3, 4]
                                    # => [2, 3, 4]
```
###### The `tap` method
There is an Object instance method, `tap`. It passes the calling object into a block, then returns that object. It allows you do something with an object inside of a block, and *always have that block return the object itself*.
```
array = [1, 2, 3]

mapped_array = array.map { |num| num + 1 }
mapped_array.tap { |value| p value }              # => [2, 3, 4]
```
`array.map { |num| num + 1 }` resolves to `[2, 3, 4]`, which then gets used to call `tap`. `tap` takes the calling object and passed it to the block argument, then returns that same object. Typically, you will do something like print the object inside that block.
```
mapped_and_tapped = mapped_array.tap { |value| p 'hello' }   # ‘hello’

mapped_and_tapped                                            # => [2, 3, 4]
```
One other use case for this method is to __debug intermediate objects__ in method chains. The transformation performed and the resulting object at every step is now visible to us by just using `tap`.
```
(1..10).tap { |x| p x }.to_a.tap { |x| p x }.select {|x| x.even? }.tap { |x| p x }.map {|x| x*x }

# Broken up, we can see that calling the .tap method lets us see what that step of the chain returns
(1..10).tap { |x| p x }                   # 1..10
.to_a.tap { |x| p x }                     # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
.select { |x| x.even? }.tap { |x| p x }   # [2, 4, 6, 8, 10]
.map { |x| x*x }.tap { |x| p x }          # [4, 16, 36, 64, 100]
```
Otherwise, we would have to add the `pry` debugger above the expression and execute each method in the chain one by one in order to see the output.