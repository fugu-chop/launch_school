# Fake Operators

## Table of Contents
- [List of fake operators](#list-of-fake-operators)
- [Element getter and setter methods](#element-getter-and-setter-methods)

### List of fake operators
Below is a table that shows which operators are real operators, and which are methods disguised as operators (listed by order of precedence; highest first).

|Method |	Operator | Description |
|-----|------|------|
|yes | [], []=  |  Collection element getter and setter. |
|yes | **  |  Exponential operator |
|yes | !, ~, +, -  |  Not, complement, unary plus and minus (method names for the last two are +@ and -@) |
|yes |	*, /, %  |  Multiply, divide, and modulo |
|yes |	+, - |  Plus, minus |
|yes |	>>, << |  Right and left shift |
|yes |	&  |  Bitwise "and" |
|yes |	^, \| | Bitwise exclusive "or" and regular "or" (inclusive "or") |
|yes |	<=, <, >, >= |  Less than/equal to, less than, greater than, greater than/equal to |
|yes |	<=>, ==, ===, !=, =~, !~ |  Equality and pattern matching (!= and !~ cannot be directly defined) |
|no |	&& |  Logical "and" |
|no |	\|\|  |  Logical "or" |
|no |	.., ... |  Inclusive range, exclusive range |
|no |	? : |  Ternary if-then-else |
|no |	=, %=, /=, -=, +=, |=, &=, >>=, <<=, *=, &&=, ||=, **=, { |	Assignment (and shortcuts) and block delimiter |

The operators marked with a "yes" in the "Method" column means that these operators are in fact methods. That means we _define them in our classes to change their default behaviors_. 

This appears to be a useful feature, but the other side is that since any class can provide their own fake operator methods, reading code like `obj1 + obj2` means we have no idea what will happen.

Because they are methods, we can implement them in our classes and take advantage of the special syntax for our own objects. If we do that, we must be careful to follow conventions established in the Ruby standard library. Otherwise, using those methods will be very confusing (e.g. follow convention of returning a string object when using the `+` method - return an instance of an object when using `+` in an instance of an object).

### Element getter and setter methods
These are some pretty extreme examples of syntactical sugar. 
```
my_array = %w(first second third fourth)    # ["first", "second", "third", "fourth"]

# element reference
my_array[2]                                 # => "third"
my_array.[](2)                              # => "third"

# element assignment
my_array[4] = "fifth"
puts my_array.inspect                       # => ["first", "second", "third", "fourth", "fifth"]

my_array.[]=(5, "sixth")
puts my_array.inspect                       # => ["first", "second", "third", "fourth", "fifth", "sixth"]
```
If we want to use the element setter and getter methods in our class, we first have to make sure we're working with a class that represents a collection, following the pattern established by the Core API within Ruby. 
```
class Team
  # ... rest of code omitted for brevity

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end
```
