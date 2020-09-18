# The Basics
Welcome to Ruby! Why are we learning Ruby?
- High level: Designed for humans and readability
- Interpreted: We don't need a compiler to write and run Ruby
- Object oriented: We can define data structures ourselves, like what type they are, and any methods that can be applied.  

## Table of Contents
- [Playing with Code](#playing-with-code)
- [Style Guidelines](#style-guidelines)
- [Types](#types)
- [Operations](#operations)
- [Data Structures](#data-structures)
- [Puts versus Return](#puts-v-return)

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

### Types
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