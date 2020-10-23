# The Basics
Welcome to Ruby! Why are we learning Ruby?
- High level: Designed for humans and readability
- Interpreted: We don't need a compiler to write and run Ruby
- Object oriented: We can define data structures ourselves, like what type they are, and any methods that can be applied.  

## Table of Contents
- [Playing with Code](#playing-with-code)
- [Style Guidelines](#style-guidelines)
- [Syntactic Sugar](#syntactic-sugar)
- [Where does code come from?](#where-does-code-come-from)
- [Documentation](#documentation)
- [Types](#types)
- [Operations](#operations)
- [Data Structures](#data-structures)
- [Puts versus Return](#puts-v-return)
- [Puts versus Print versus P](#puts-v-print-v-p)

### Playing with Code
Execute Ruby code in the terminal via
`ruby ruby_file.rb` 

We can also enter `irb` in the terminal for a Ruby environment which executes code and can return values. 

### Style Guidelines
- 2 spaces for tabs
- `#` to comment out code
- Use `=begin =end` to comment out multiple lines of code.
- Use `snake_case` for methods, variables and files
- Use `PascalCase` for classes
- Constants should be `SCREAMING_SNAKE_CASE` (i.e. variables that do not change in the program, once assigned)
- When using `{ }` brackets for methods, try to have it on one line. If that's not possible, use a `do end` structure.
- Don't terminate expressions with `;`
- Use spaces __around__ operators, and __after__ commas, semicolons and colons.

### Syntactic Sugar
Ruby is a very expressive language, which allows it to be written to do many things whilst simultaneously being 'readable' by humans. However, it does create some situations where what the code is doing might not be exactly clear (i.e. it could be doing one of multiple things) - we are making syntax 'pretty', at the cost of being certain as to what the syntax is doing. 

As an example, in Ruby, parentheses after method invocations are *optional* - e.g. for `puts 'hello'`, the `puts` method call doesn't require parentheses to print a string given to it as an argument. This can make it confusing to determine whether an isolated bit of code is a method call/invocation, or a variable.

If we have two objects named the same thing, we can force Ruby to execute the method by adding parentheses.
```
str = 'A string'

def str
  'A method'
end

p str()
=> A method
```
If we comment out the `str` method and try to run `str()`, Ruby will throw a `NoMethodError` message. If we rant the code above without parentheses on the `p str`, Ruby would default to *printing the variable first*.

### Where does code come from?
There are two main parts to where code in Ruby comes from:
- Core API - this is what is loaded into the Ruby runtime, that allows us to invoke methods, which are organised into classes. 
  - One of the most important classes is `Kernel`, as it provides methods available to all Ruby objects (e.g. `puts`). 
- Standard API - This contains another set of classes, but is not automatically loaded (to reduce bloat). These set of methods aren't necessarily considered essential. We have to load these into our Ruby code via the `require: "x"` syntax at the top of our script.

### Documentation
Our most up-to-date documentation can be found here: https://docs.ruby-lang.org/en. 

For now, the main part of each page contains descriptions for all methods associated with the class or module you are viewing. They are also listed on the left under the Methods header.

There are two main types of methods: *instance methods*, which you will use most often, and *class methods*, which will become more important later. For now, you are mostly interested in the instance methods.

On the left-hand side, __instance methods__ are identified with a `#`, e.g., `#size`, while __class methods__ and module methods are identified with a `::`, e.g., `::new`. This is merely a documentation convention; the `#` and `::` are not part of the method names, nor are they used to refer to methods in your programs.

Sometimes, you just need to scan through the method names until you see something that sounds like it might do the trick. Other times, you will need to use your browser's in-page search capability to find something. On other occasions, you may be forced to scan through the entire page, or followup in the class's Parent or Included Modules (both of which we will see later).

As an example, let's take the `upcase` documentation: https://docs.ruby-lang.org/en/master/String.html#method-i-upcase

`upcase → new_str` - The part to the left of the → represents how the method is called, while the part to the right shows what the method returns. 

In this case, the method call reads simply "upcase". Since `#upcase` is an instance method, we also know that it needs to be __applied to the string we want to operate on__. To do this, we prepend the string and a `.` to the method name.

Reading the description of the method, we also see that the method
> Returns __a copy__ of str with all lowercase letters replaced with their uppercase counterparts. 

Reading "between the lines", this means the original String is not being modified, so we need to get the result by examining the return value.

### Types
In Ruby, we commonly hear that __everything is an object__. This is because we can call methods on basically everything. In some other languages, Integers and Strings are primitive types, which themselves __cannot__ have methods called on them. Ruby itself *does not have* primitive types. 
```
# We can call a method directly on an integer
2.times { puts 'hello!' }

# Again, we call a method directly on a string
'hi'.capitalize
```
###### Strings
__Strings__ are a list of characters in a specific sequence. They are surrounded by single or double quotes. If we want to use the same quote type within another quote type, we have to escape the character with a `\`.
```
# Ex. 1: with double quotes
"The man said, 'Hi there!'"

# Ex 2: with single quotes and escaping
'The man said, \'Hi there!\''
```
Double quotes allow string interpolation, which lets us paste in variables into a string
```
a = 'ten'
"My favorite number is #{a}!"

=> "My favorite number is 10!"
```
We can also use `%Q()` to wrap a string in double quotes, or `%q()` to wrap a string in single quotes.
```
%Q(I am the best)
=> "I am the best"
```
We can replace instances of text with `.gsub()` (including being able to use regex), or mutate an existing string in a variable with `.replace`.
```
name = "Dean"
name.gsub!("Dean", "Garry")
=> "Garry"

name.replace "Dean"
=> "Dean"
```
###### Symbols
__Symbols__ can be thought of as names. Only one copy of a symbol can exist at any time, and are *immutable*. We normally use them if we don't intend to print the contents of a symbol or change it. 
```
# Examples of symbols
:name
:a_symbol
:"surprisingly, this is also a symbol"
```
Symbols must be valid Ruby variable names - the first letter after the colon has to be an underscore, or letter. 

###### Numbers
__Numbers__ typically fall under:
- __integers__: This is a whole number only, with *no decimal point*
- __floats__: This is a number with a decimal point. 
```
# Example of integers
1, 2, 3, 50, 10, 4345098098

# Example of floats
1.2345, 2345.4267, 98.2234
```

###### nil
__nil__ represents 'nothing', 'completely empty', or 'not a specific type'. A situation where this may occur is where output is expected but none is returned, like with a `puts` statement. 

The `puts` method prints out a string and returns nothing, so we see `nil` being returned after the string is displayed.
```
puts "Hello, World!"
Hello, World!
=> nil
```
It is possible to check if something is a nil type by using `.nil?`
```
"Hello, World".nil?
=> false
```
Another important property is that `nil` is treated as a `false` boolean value (though `false` != `nil`) and can be used in a conditional statement.
```
if nil
  puts "Hello world!"
end
=> nil
```

### Operations
###### Arithmetic
We can apply the `+, -, *, /` signs to perform arithmetic on integers, floats, as well as strings (concatenation and duplication). We can't add strings and integers together, however. 

Note that with *integers*, we only ever get a whole number returned when using `*` or `/`. To get decimal places, we need to use *floats*. When we use a float in an operation, a float will be returned, even if the other operand is an integer. 

We can also use the `%` operator, to give us the remainder of a division operator as an integer. __Be very careful if you're dealing with negative numbers__, as the `%` can return some odd results. 

In general though, modulo operations return a __positive__ integer when the __second operand is positive__, and a negative integer when the second operand is negative, though the value can be counter-intuitive. 

###### Comparisons
We can test conditions between operands using comparison operators, which return *booleans*.
- `==`
- `!=`
- `&&`: Return true only if both conditions are true
- `||`: Return true if one or both of the conditions are true (inclusive or).

###### Type Conversion
Ruby provides a list of methods that we can use to convert between types:
- `x.to_s` will convert `x` to a string
- `x.to_i` will convert `x` to an integer
- `x.to_f` will convert `x` to a float
- `x.to_sym` will convert `x` to a symbol

### Data Structures
Data structures are ways of organising other data types.

###### Arrays
An array is used to organize information into an __ordered__ list. The list can be made up of strings, integers, floats, booleans, or any other data type. 

In Ruby, an array is denoted by square brackets `[ ]`. Inside the brackets you can create a list of elements separated by commas.

Each element in an array can be accessed via an *index*. The indexes are numbered starting at zero.
```
[1, 2, 3, 4, 5][1]
=> 2
```

###### Hashes
Hashes are key-value pairs. They are denoted by `{ }`. 

We can have multiple items in a hash if we separate them with commas, but they will __not necessarily be in any specific order__.
```
my_hash = {:dog => 'barks', :cat => 'meows', :pig => 'oinks'}
my_hash[:dog]
=> 'barks'
```

### Puts v Return
When we call the `puts` method, we're telling Ruby to print something to the screen. 

However, `puts` does not `return` what is printed to the screen. Expressions do something, but they *also return* something. The value returned is not necessarily the action that was performed. If we look in irb:
```
puts 'stuff'
stuff
=> nil
```
The word stuff was printed to the console and then a `nil`, which is Ruby's way of saying 'nothing', was returned. See this:
```
a = puts "stuff"
puts a
=> nil
```
`a` is assigned to the value returned by `puts "stuff"`, which is `nil`. Therefore, puts a results in `nil` being printed out. 

### Puts v Print v P
`puts` will show something, then *add a new line* after whatever is shown. However, `puts` will print out each __element in an array on a new line__. `puts` attempts to convert everything into a string (by calling `to_s`). 

This is important because if you’re trying to `puts` an array with nil values, `puts` will show __blank lines__. Also note that `puts` returns `nil`.

If we want to `puts` an array, it's a good idea to add the `.inspect` method onto it, to ensure an intact printable version of the array.
```
puts 123
puts 456

123
456

# puts on an array
puts [1, 2]

1
2

# puts with nil values
puts [1,nil,nil,2]

1


2

# puts on an array with the inspect method
puts [1, 2].inspect

[1, 2]
```
`print` will show something, but __not__ add a new line after whatever is shown. `p` returns `nil`.
```
print 123
print 456

123456
```
`p` is a more *raw* method of displaying something. It doesn't attempt to convert the output to a string, and is useful for debugging, since it both __displays and returns__ whatever object you pass to it. This makes it particularly useful for *displaying arrays and hashes*. 
```
puts "Ruby Is Cool"
Ruby Is Cool

p "Ruby Is Cool"
"Ruby Is Cool"
```