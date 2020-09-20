# More Stuff

## Table of Contents
- [Regex](#regex)
- [Standard Classes](#standard-classes)
- [Variables as pointers](#variables-as-pointers)
- [Blocks and procs](#blocks-and-procs)
- [Exception handling](#exception-handling)
- [Exceptions & Stack Traces](#exceptions-&-stack-traces)

### Regex
Regex stands for regular expression. A regular expression is a *sequence of characters that form pattern matching rules*, and is then applied to a string to look for matches. If you encounter a string pattern matching problem, remember to look into using regex.

Creating regular expressions starts with the forward slash character (`/`). Between __two forward slashes__ you can place any characters you would like to match with the string.

We can use the `=~` operator to see if we have a match in our regular expression. 
```
"powerball" =~ /b/
=> 5

"powerball" =~ /z/
=> nil
```
This means that the first match that took place was at the fifth index of the string. Remember indices start counting from zero. Since 5 is a `truthy` value (i.e., in Ruby, 5 evaluates to true), we can use it as a boolean to check for matches.
```
def has_a_b?(string)
  if string =~ /b/
    puts "We have a match!"
  else
    puts "No match here."
  end
end

has_a_b?("basketball")
We have a match!
=> nil

has_a_b?("hockey")
No match here.
=> nil
```
On top of the `=~` operator, we can use the `match` method to perform regex comparisons as well. This method returns a `MatchData` object that describes the match or `nil` if there is no match. We can also use the returned value of the `matchData` method as a boolean. 
```
/b/.match("powerball")
=> #<MatchData "b">

# This prints out the same thing as our previous if statement
def has_a_b?(string)
  if /b/.match(string)
    puts "We have a match!"
  else
    puts "No match here."
  end
end
```
### Standard Classes
When you have a specific action that you need to perform, look for it first among Ruby's *standard classes*. Using libraries like the Math module can help you solve problems more efficiently.

As an example, Ruby's `Math` module has a method called `sqrt` that you can use right away. `Math` also contains Pi.

Note: why is it `Math.sqrt` and not `math.sqrt`? This is because `sqrt` is a __"class method"__, and not an "instance method". So far, we've been dealing mostly with instance methods, and this is one of the few times where we use a class method. 
```
Math.sqrt(25)
=> 5.0

Math::PI
=> 3.141592653589793
```
What if you wanted to calculate what specific day July 4th occurred in 2008? You can use Ruby's built-in `Time` class.
```
t = Time.new(2008, 7, 4)
=> 2008-07-04 00:00:00 -0400
t.monday?
=> false
t.friday?
=> true
```
### Variables as pointers
Variables are pointers to __physical space in memory__. In other words, variables are essentially labels we create to refer to some physical memory address in your computer. 
```
a = "hi there"
b = a
a = "not here"

a
=> "not here"
b
=> "hi there"
```
Reassigning a variable means it takes up a different address in memory. It's important to understand that *different memory space can in fact hold the same value*, but they are still different places in memory. 

For example, if our last line of code was `a = "hi there"`, the result would still be the same: `a` and `b` in that case would still point to __different addresses__ in memory; they would just happen to have the same value.

Contrast this:
```
a = "hi there"
b = a
a << ", Bob"
```
The line of code `a << ", Bob"` _did not result in reassigning `a` to a new string_. Rather, it __mutated the caller (`a`)__ and modified the existing string, which is also pointed to by the variable `b`. This explains why in this code, `b` reflects the changes to `a` - they're both pointing to the same thing.

This is the major point of this section: __some operations mutate the address space in memory, but others simply change the variable to point to a different address space.__

This also applies to variables that point to *arrays, hashes, or any data structure that has methods that mutate the caller*. If you call a method that mutates the caller, it will change the value in that address space, and any variables also pointing there will be affected. 
```
a = [1, 2, 3, 3]
b = a
c = a.uniq

a 
=> [1, 2, 3, 3]
b
=> [1, 2, 3, 3]
c
=> [1, 2, 3]

c = a.uniq!

a 
=> [1, 2, 3]
b 
=> [1, 2, 3]
c 
=> [1, 2, 3]
```
Therefore, always pay attention whether your variables are pointing to the same object (space in memory) or if they are dealing with copies that occupy different address space in memory.

### Blocks and procs
*Blocks*, like parameters, can be passed into a method just like normal variables.
```

def take_block(number, &block)
  block.call(number)
end

number = 42
take_block(number) do |num|
  puts "Block being called in the method! #{num}"
end

Block being called in the method! 42
=> nil
```
The ampersand (`&`) in the method definition tells us that the argument is a block. You could name it anything you wanted. __The block must always be the last parameter in the method definition.__ We also need to use the `.call` method to ensure that the block is accepted by the method.

When we're ready to use the method, we call it like any other method: `take_block`. The only difference is that because this method can accept a block, we can pass in a block of code using `do/end`.

*Procs* are blocks that are wrapped in a proc object and stored in a variable to be passed around. Using procs gives us the added flexibility to be able to *reuse blocks in more than one place* without having to type them out every time.
```
# Define a proc
talk = Proc.new do
  puts "I am talking."
end

talk.call
```
Procs can also *take arguments* if specified.
```
talk = Proc.new do |name|
  puts "I am talking to #{name}"
end

talk.call("Bob")
```
Procs can also be *passed to methods*.
```
def take_proc(proc)
  [1, 2, 3, 4, 5].each do |number|
    proc.call number
  end
end

proc = Proc.new do |number|
  puts "#{number}. Proc being called in the method!"
end

take_proc(proc)
```

### Exception handling
Exception handling is a specific process that deals with errors in a manageable and predictable way. 

When your programs are interacting with the real world, there is a large amount of unpredictability. If a user enters bad information or a file-manipulating process gets corrupted, your program needs to know what to do when it runs into these exceptional conditions.

Ruby has an `Exception` class that makes handling these errors much easier. It also has a syntactic structure using the reserved words `begin`, `rescue`, and `end` to signify exception handling.
```
begin
  # perform some dangerous operation
rescue
  # do this if operation fails; for example, log the error
end
```
One common occurrence of this is when a `nil` value makes its way into our program. We have to be prepared for this reality.
```
names = ['bob', 'joe', 'steve', nil, 'frank']

names.each do |name|
  begin
    puts "#{name}'s name has #{name.length} letters in it."
  rescue
    puts "Something went wrong!"
  end
end
```
When an exception, or error, is raised, the `rescue` block will execute and then the program *will continue to run as it normally would*. If we didn't have the `rescue` block there, our program would stop once it hit the exception.

You can also use the `rescue` reserved word in-line like so:
```
zero = 0
puts "Before .each call"
zero.each { |element| puts element } rescue puts "Can't do that!"
puts "After .each call"

Before .each call
Can't do that!
After .each call
```
We can also rescue *pre-existing errors* when we are writing our code.
```
def divide(number, divisor)
  begin
    answer = number / divisor
  rescue ZeroDivisionError => e
    puts e.message
  end
end

puts divide(16, 4)
puts divide(4, 0)
```
Here we are rescuing the `ZeroDivisionError` and saving it into a variable `e`. We then have access to the message method that the `ZeroDivisionError` object has available.

### Exceptions & Stack Traces
For the purposes of this section an exception can be viewed as *synonymous with an error*. During the course of program execution, many things can go wrong for a variety of reasons, and when something does go wrong, usually we say "an exception is raised".

When an exception is raised, it is usually accompanied by a large output of text of what looks like gibberish. It's in this gibberish that you'll find the clues to the source of the problem, and it's important to start developing an eye for scanning and parsing this gibberish output.
```
'1' + 1
TypeError: no implicit conversion of Integer into String
```
We see a `TypeError` because the two types don't match - one is a `String`, one is an `Integer` - and Ruby doesn't know how to add them together. In Ruby terms, an exception is raised, which will __halt execution__ unless there is code in place to rescue the exception. 

When Ruby invokes a method, the method is added to Ruby's *stack*. 
```
# greeting.rb

def greet(person)
  puts "Hello, " + person
end

greet("John")
greet(1)
```
When we execute `greet("John")`, execution looks like `main -> greet -> puts -> exit and return to main`. When we run `greet(1)`, we get a `TypeError`. Execution looks like `main -> greet -> puts`.

More specifically, the error we get is:
```
greeting.rb:2:in `+': no implicit conversion of Integer into String (TypeError) from greeting.rb:2:in `greet'
from greeting.rb:6:in `<main>'
```
The stack trace first tells us where the error occurred and why: *line 2 of our code*, and the error was because the *types don't match*. The error occured due to the call made in the `main` context on line 6, which contains the line that called the method with incorrect arguments, line 2.