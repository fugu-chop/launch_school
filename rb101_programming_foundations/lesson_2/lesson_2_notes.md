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
- [Scoping with Constants](#scoping-with-constants)
- [More on variable scope](#more-on-variable-scope)
- [Pass by reference v pass by value](#pass-by-reference-v-pass-by-value)
- [Immutability](#immutability)
- [Mutability](#mutability)
- [Coding tips](#coding-tips)

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

__*keyword*__:__*meaning*__
- `START`: start of the program
- `SET`: sets a variable we can use for later
- `GET`: retrieve input from user
- `PRINT`: displays output to user
- `READ`: retrieve value from variable
- `IF / ELSE IF / ELSE`: show conditional branches in logic
- `WHILE`: show looping logic
- `END`: end of the program

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
Stack traces are one of our best tools for debugging code. An error message will include the first hint at where to start looking - specifically, we are looking for what type of error (e.g. a `NoMethodError`) and a location. Thus we can follow the error 'up the stack' - specifically, what inputs feed into other inputs, which will allow us to find where the error occurs. 

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
From the first 3 lines of output, you might conclude that Ruby is evaluating the expression left-to-right. However, the final result says otherwise - you can only get that result if `value(5) * value(7)` gets evaluated first. 

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
Why did we get a different result? *Blocks have the lowest precedence of all operators*. But between the two, `{ }` has slightly higher precedence than `do...end`. This has an effect on *which method call* the block gets passed to. 

How exactly did we get `#<Enumerator: [1, 2, 3]:map>`? With `do...end` being the “weakest” of all the operators, `array.map` gets bound to `p`, which first invokes `array.map`, returning an `Enumerator` object. The `Enumerator` is then passed to `p`, along with the block. `p` prints the `Enumerator`, but doesn't do anything with the block.

Note that `p` doesn’t take a block. As with all methods called with a block that don’t accept one, __the block just gets ignored__.

In other words, the binding of an argument to a method and the method name (the return value of `array.map` and `p`) is slightly *tighter* than the binding between a method call and a `do...end` block. Thus, `array.map` __gets executed first, then the return value and the block get passed to `p` as separate arguments__. 

Basically, because of the low precedence of the `do...end` block, `p` sees two arguments being passed to it, rather than one. `p` displays the `Enumerator` object because Ruby has __strict evaluation__ - i.e. every expression is evaluated and converted to an object before it is passed along to a method (`p`).

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
There is an Object instance method, `tap`. It passes the calling object into a block, then returns that __calling__ object itself. It allows you do something with an object inside of a block, and *always have that block return the object itself*.
```
array = [1, 2, 3]

mapped_array = array.map { |num| num + 1 }
mapped_array.tap { |value| p value }              # => [2, 3, 4]
```
`array.map { |num| num + 1 }` returns `[2, 3, 4]`, which then gets used to call `tap`. `tap` takes the calling object and passed it to the block argument, then returns that same object. Typically, you will do something like print the object inside that block.
```
mapped_and_tapped = mapped_array.tap { |value| p 'hello' }   # ‘hello’

mapped_and_tapped                                            # => [2, 3, 4]
```
One use case for this method is to __debug intermediate objects__ in method chains. The transformation performed and the resulting object at every step is now visible to us by just using `tap`.
```
(1..10).tap { |x| p x }.to_a.tap { |x| p x }.select {|x| x.even? }.tap { |x| p x }.map {|x| x*x }.tap { |x| p x }

# Broken up, we can see that calling the .tap method lets us see what that step of the chain returns
(1..10).tap { |x| p x }                   # 1..10
.to_a.tap { |x| p x }                     # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
.select { |x| x.even? }.tap { |x| p x }   # [2, 4, 6, 8, 10]
.map { |x| x*x }.tap { |x| p x }          # [4, 16, 36, 64, 100]
```
Otherwise, we would have to add the `pry` debugger above the expression and execute each method in the chain one by one in order to see the output.

### Scoping with Constants
Constants are said to have *lexical scope*, which will have more meaningful consequences when we get to object oriented programming. For now, just remember that constants have different scoping rules from local variables.

The scoping rules for constants is __not__ the same as local variables. In procedural style programming, constants behave like *globals*.
```
USERNAME = 'Batman'

def authenticate
  puts "Logging in #{USERNAME}"
end

authenticate    # => Logging in Batman
```
The rules for local variables apply in the same way to constants when dealing with method invocations with a block. 
```
FAVORITE_COLOR = 'taupe'

1.times do
  puts "I love #{FAVORITE_COLOR}!"  # => I love taupe!
end
```
We can access constants, even when they are initialised in an inner scope. 
```
loop do
  MY_TEAM = "Phoenix Suns"
  break
end

puts MY_TEAM    # => Phoenix Suns
```
### More on variable scope
__Method definition__ is when, within our code, we define a Ruby method using the `def` keyword.
```
def greeting
  puts "Hello"
end
```
__Method invocation__ is when we call a method, whether that happens to be an existing method from the Ruby Core API or the Standard Library, or a custom method that we've defined ourselves using the `def` keyword, like `greeting` above.

We've also seen examples of methods being called with blocks. 
`[1, 2, 3].each { |num| puts num }`

Technically __any__ method can be called with a block, but the block is only executed if the method is *defined in a particular way*. We'll cover this in more detail in the future, but for now, we want to remember that __a block is part of the method invocation__. 

Method invocation followed by `{}` or `do..end` is the way in which we *define a block* in Ruby. Essentially the block *acts as an argument to the method*. 

In the same way that a local variable can be passed as an argument to a method at invocation, *when a method is called with a block it acts as an argument to that method*.

The way that an argument is used, whether it is a method parameter or a block, depends on how the method is defined.
```
# Block tacked on to the end of the greetings method is not executed
def greetings
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end

Goodbye

# Block on the end of the greetings method is executed
def greetings
  yield
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end

Hello
Goodbye
```
The `yield` keyword is what controls the interaction with the block, in this case it executes the block once. Since the block has access to the local variable word, `Hello` is output when the block is executed. Don't focus here on what `yield` is or how it works.

The important take-away for now is that blocks and methods can interact with each other; the level of that interaction is set by the method definition and then used at method invocation.

When invoking a method with a block, we aren't just limited to executing code within the block; depending on the method definition, the method can use the *return value of the block* to perform some other action.
```
a = "hello"
[1, 2, 3].map { |num| a } 

["hello", "hello", "hello"]
```
The `Array#map` method is defined in such a way that it uses the return value of the block to perform transformation on each element in an array. In the above example, `#map` doesn't have direct access to `a` but it can use the value of `a` to perform transformation on the array since the block can access `a` and returns it to `#map`.

*In summary:*
1. We can think of __method definition__ as __setting a certain scope__ for any local variables in terms of the parameters that the method definition has, what it does with those parameters, and also how it interacts (if at all) with a block. 
2. We can then think of __method invocation__ as __using the scope set by the method definition__. If the method is defined to use a block, then the scope of the block can provide additional flexibility in terms of how the method invocation interacts with its surroundings.

### Pass by reference v pass by value
This is a discussion about what happens to *objects when passed into methods*. 

Every computer programming language uses some sort of evaluation strategy when passing objects. This strategy determines *when* expressions are evaluated, and what a method can do with the resulting objects. 

The most common strategies are known as *strict evaluation* strategies. With strict evaluation, every expression is evaluated and converted to an object __before__ it is passed along to a method. Ruby uses strict evaluation exclusively.

When dealing with objects passed into methods, we can either treat these arguments as:
1. "references" to the original object; or
2. "values", which are copies of the original

In Ruby, when an object is passed to a *method call as an argument*, the parameter assigned to it acts as a *pointer to the original object*. Ruby __does not__ create a copy of the object for that method. The object that gets passed is a __reference__ to some object. 

###### Pass by value
With pass by value, a copy of an object is created, and it is that copy that gets passed around. Since it is merely a copy, it is impossible to change the original object; any attempt to change the object just changes the copy and leaves the original object unchanged. 

When you "*pass (an object) by value (as an argument to a method)*", the method only has __a copy of the original object__. Operations performed on the object within the method have __no effect on the original object__ outside of the method.
```
def change_name(name)
  name = 'bob'
end

name = 'jim'
change_name(name)
puts name           

jim
```
The code example above has two different local variables named `name`. There is one scoped *within* the method, and there is one in the *main scope*. 

This is __not__ variable shadowing, because the main scope variable is __not accessible to the method__. Within the method, we could have named the variable something other than `name`. We are only passing the __value__. 

When we passed the `name` variable into the `change_name` method, it looks like the variable was *passed by value*, since re-assigning the variable only affected the *method-level variable*, and __not__ the *main scope variable*.

###### Pass by reference
With pass by reference, a *reference to an object is passed around*. This establishes an *alias between the argument and the original object*, just like we saw when we set `a = b`. Both the argument and object refer to the __same location in memory__. With pass by reference, if you modify the argument’s state, you also modify the original object.

If Ruby was pure "pass by value", that means there should be no way for operations within a method to cause changes to the original object.
```
def cap(str)
  str.capitalize!
end

name = "jim"
cap(name)
puts name

Jim
```
This implies that Ruby is "pass by reference", because operations within the method __affected the original object__ when we passed the `name` variable into the `cap` method.

Another example: 
```
array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2

Moe
Larry
CURLY
SHEMP
Harpo
CHICO
Groucho
Zeppo
```
The first `#each` loop simply copies a bunch of references from `array1` to `array2`. When that first loop completes, both arrays not only contain the same values, they contain __the same String objects__. If you modify one of those Strings, that modification will show up in both Arrays.

###### Reconciling the two
```
def print_id(number)
  puts "In method object id = #{number.object_id}"
end

value = 33
puts "Outside method object id = #{value.object_id}"
print_id(value)

Outside method object id = 67
In method object id = 67
```
Here, `number` and `value` reference the same object despite the object being immutable. We can also see that `value` was not copied. Thus, Ruby is not using pass by value. It appears to be using *pass by reference*.

The key here is that __pass by reference isn’t limited to mutating methods or mutable objects__. A non-mutating method can use pass by reference as well, so pass by reference can be used with immutable objects. There may be a reference passed, but the reference isn’t a guarantee that the object can be modified.

__Assignment__ is the weird exception to the general 'pass by reference' strategy. The key is to remember that variables and constants aren’t objects, but are *references to objects*. Assignment merely changes __which__ object is bound to a particular variable. For __immutable objects and reassignment__, Ruby passes around __copies of the references__.

While we can change which object is bound to a variable *inside* of a method, __we can’t change the binding of the original arguments__. We can change the *objects* if the objects are *mutable*, but the __references themselves are immutable__ as far as the method is concerned. 

Since pass by value (again, __variable reassignment and immutable objects__) passes copies of arguments into a method, Ruby appears to be making copies of the references, then passing those copies to the method. The method can use the references to modify the referenced object, but since the reference itself is a copy, the original reference cannot be changed.

### Immutability
Methods can be either mutating or non-mutating. As you might expect, mutating methods change something; non-mutating methods do not. The object that may or may not be mutated is of concern when discussing whether a method is mutating or non-mutating. 

For example, the method `String#sub!` is mutating with respect to the String used to *call it*, but non-mutating with respect to its arguments - the arguments being the pattern and the replacement string.

As a side note, blocks are an argument, but __blocks are immutable__, so every method that takes a block is *non-mutating with respect to the block*. Mostly, though, you can ignore the blocks when talking about mutation of arguments.

In Ruby, numbers and boolean values are immutable. Objects of some complex classes, such as `nil` (the only member of the `NilClass` class) and `Range` objects (e.g., `1..10`) are immutable. Any class can establish itself as immutable by simply __not providing any methods that alter its state__.

Once we create an immutable object, we cannot change it. We can only perform variable reassignment.
```
number = 3
=> 3

number
=> 3

number = 2 * number
=> 6

number
=> 6
```
As we saw above, this is reassignment which, as we learned, doesn’t change the object. Instead, it binds a new object to the variable. In this case, we create a new `Integer` with a value of `6` and assign it to `number`. 

There are, in fact, __no methods available that let you alter the value of any immutable object__. All you can do is *reassign the variable so it references a different object*. 

This disconnects the original object from the variable, which makes it available for garbage collection unless another reference to the object exists elsewhere.

A method is said to be *non-mutating with respect to an argument* or its calling object if it __does not modify it__. Most methods you will encounter do not mutate their arguments or caller. Some do mutate their *caller*, but few methods in the Core API or Standard Library mutate the *arguments* - most of these methods reassign their arguments to *different address spaces* and are thus non-mutating.
```
test = 'hello'
test.object_id
=> 70209269130840

test[4]
=> 'o'

test[4].object_id
=> 70209269164880

test.sub!('o', 'y')
=> "helly"

test.object_id
=> 70209269130840

test[4]
=> 'y'

test[4].object_id
=> 70209298117720
```
All methods are non-mutating with respect to immutable objects. A method simply can’t modify an immutable object. Thus, *any method that operates on numbers and boolean values is guaranteed to be non-mutating with respect to that value* - the returned variable or value will exist in a different address space.

### Mutability
Most objects in Ruby are mutable; they are objects of a class that __permit modification of the object’s state__ in some way. 

A method is said to be mutating with respect to an argument or its caller if it modifies it.

Whether modification is permitted by setter methods or by calling methods that perform more complex operations is unimportant; as long as you __can__ modify an object, it is mutable. Mutable objects can be modified __without creating new objects__ (and hence the reference to the object, or the `object_id` remains the same). Only the __state__ of the original object has been changed.

A *setter method* (or simply, a setter) is a method defined by a Ruby object that allows a programmer to explicitly change the value of *part of an object*. Indexed assignment is a subset of setter methods.

Note that setter methods for *class instance variables and indexed assignment* are __not the same__ as assignment. Setter methods and indexed assignment usually mutate the calling object. 

Many, but not all, methods that mutate their caller use `!` as the last character of their name. However, this is not guaranteed to be the case. For instance, `String#concat` is a mutating method, but it does not include a `!`.

###### Indexed assignment is mutating
```
str[3] = 'x'
array[5] = Person.new
hash[:age] = 25
```
This looks exactly like assignment, which is non-mutating, but is, in fact, mutating. `#[]` modifies the *original* object (the String, Array, or Hash). It __doesn’t change the binding__ of each variable.

Consider this example:
```
a = [3, 5, 8]
[3, 5, 8]

a.object_id
70240541515340

a[1].object_id
11

a[1] = 9
9

a[1].object_id
19

a
[3, 9, 8]

a.object_id
70240541515340
```
We have mutated the Array `a` by assigning a new value to `a[1]`, but have not created a new Array. This assignment changes `a[1]` so that it __references the new object__ `9` (i.e. we are modifying `a`, but not  `a[1]`, which is not modified, but reassigned). 

You can see this by looking at how `a[1].object_id` changes before and after the assignment. Despite this change, though, `a` itself still points to the same (now mutated) Array we started with.

This is normal behavior when working with objects that support indexed assignment: the assignment does cause a new reference to be made, but it is the __collection element__ (e.g. `a[1]`) that is bound to the new object, __not the collection__ (enclosing object) itself.

###### Concatenation is mutating
The `#<<` method used by collections like Arrays and Hashes, as well as the String class, implements concatenation; this is very similar to the `+=` operator. However, there is a major difference; `+=` is non-mutating, but __`#<<` is mutating__. 

Note that when we use the `#<<` method on __individual elements within an array__, we __aren't mutating the underlying object__. That is, we aren't adding to or removing elements from the array. But we're in fact __mutating each element__ within the array. 

In any case, it is bad practice to mutate the *collection* as you're iterating through it (i.e. adding or removing elements). You're free to mutate the *collection elements*, however. 

###### Setters are mutating
Setters are very similar to indexed assignment; they are methods that are defined to __modify the state of an object__. Both employ the `something = value` syntax, so they superficially look like assignments. 

With indexed assignment, the elements of a collection (or the characters of a String) are replaced; with setters, __the state of the object is modified__, usually by modifying an instance variable.

Setter invocation looks like this:
```
person.name = 'Bill'
person.age = 23
```
This looks exactly like assignment, which is non-mutating, but, since these are setter calls, they actually __mutate the object bound to `person`__. Like indexed assignments, we can observe that the values associated with a given key have *different `object_ids`* once reassigned (the value associated with that key now references a *different object*), but the underlying hash has the *same* `object_id` - it has been permanently mutated. 

It’s possible to define setter methods that don’t mutate the original object. Such setters should still be treated as mutating since they __don’t create new copies of the original object__.

### Coding Tips
We need to learn to organize chunks of code to make it easier to read. In terms of where to insert blank lines, think of it like writing paragraphs. One way to think about where to insert lines is to divide out code into functionality, e.g. 
1. Variable initialization
2. User input and validation
3. Using the variable

This assists us in code legibility, but also debugging. 

Other tips include:
###### Name methods appropriately
We should be able to tell what they do without having to refer to the code everytime we see it. 

###### Methods should either return or produce a side effect
A method should either return a value, or produce a side effect (e.g. printing something, mutating the caller), __not__ both. It makes our methods more difficult to reuse and interpret in the future. 

###### Don't mutate the caller during iteration
Don't mutate the caller during iteration (i.e. add or subtract elements). It's ok to mutate *collection elements* themselves, but not the *collection itself* while you're iterating through it.  

###### Don't variable shadow
It prevents our blocks from accessing variables from outside the block scope, and is confusing to read. 
```
name = 'johnson'

['kim', 'joe', 'sam'].each do |name|
  # We cannot access the outer scoped "name" due to variable shadowing
  puts "#{name} #{name}"
end

kim kim
joe joe
sam sam
```
###### Don't use assignments in conditionals
It's not clear whether we intend to assign a value to a variable (`=`), or test for equality (`==`). If you absolutely have to use assignment, wrap it in parentheses. 
```
# bad
if some_variable = get_a_value_from_somewhere
  puts some_variable
end

# good
some_variable = get_a_value_from_somewhere
if some_variable
  puts some_variable
end

# ok, not the best
numbers = [1, 2, 3, 4, 5]

while (num = numbers.shift)
  puts num
end
```
###### Use underscores for unused variables
Suppose you have an array of names, and you want to print out a string for every name in the array, but you __don't care about the actual names__. In those situations, use an *underscore* to signify that we don't care about this particular parameter.
```
names = ['kim', 'joe', 'sam']

names.each { |_| puts "got a name!" }
```
Or, if you have an unused parameter when there are multiple parameters:
```
names = ['kim', 'joe', 'sam']

names.each_with_index do|_, idx|
  puts "#{idx+1}. got a name!"
end
```
