# Flow Control

## Table of Contents
- [What is flow control?](#what-is-flow-control)
- [Conditionals](#conditionals)
- [Comparisons](#comparisons)
- [Combining expressions](#combining-expressions)
- [Ternary Operator](#ternary-operator)
- [Case Statements](#case-statements)
- [True and False](#true-and-false)

### What is flow control?
Flow control is conditional logic that we put in our program to make sure it executes the right decision in the right circumstances. 

### Conditionals
Conditionals are how we implement logic in our program. 

They are formed using a combination of `if` statements and comparison and logical operators (`<, >, <=, >=, ==, !=, &&, ||`). They are basic logical structures that are defined with the reserved words `if, else, elsif`, and `end`. 
```
puts "Put in a number"
a = gets.chomp.to_i

if a == 3
  puts "a is 3"
elsif a == 4
  puts "a is 4"
else
  puts "a is neither 3, nor 4"
end
```
Note when none of the conditions in an `if` statement evaluates as `true`, or *nothing is returned*, __the `if` statement itself returns__ `nil`.

###### Other shenanigans
We can shorten simple `if` statements to a single line, but we must use the `then` word:

`if x == 3 then puts "x is 3" end`

We can also change the order, if we want to have the `if` word at the end of the expression:

`puts "x is 3" if x == 3`

We can also use the `unless` word if we want to change the phrasing of our expression. 

`puts "X is not 3" unless x == 3`

### Comparisons
A comparison operators _always return a boolean value_. We use `==, >, <, <=, >=, !=` to assess whether an expression is true or not. 

### Combining expressions
`&&` is the "and" operator. Expressions to the left and to the right of this operator __both have to be true__ for the entire expression to be evaluated to `true`.
```
(4 == 4) && (5 == 5)
=> true

(4 == 5) && (5 == 5)
=> false
```

`||` is the "or" operator. __Either__ the expression to the left has to be true, or the expression to the right has to be true for the entire expression to be evaluated to true. If __both__ expressions are true, `||` will return `true`.
```
(4 == 4) || (5 == 5)
=> true

(4 == 5) || (5 == 5)
=> true

(4 == 5) || (5 == 6)
=> false
```

`!` is the "not" operator. When you add this in front of a boolean expression it will change that boolean value to its *opposite*.
```
!(4 == 4)
=> false
```
Note that `!!` is used to convert values to booleans.
```
!!nil
=> false

!!"abc"
=> true

!!false
=> false
```
###### Order of precedence
Ruby follows an order of precedence when deciding how to evaluate multiple expressions. The following is a list of operations from highest order of precedence (top) to lowest (bottom).

1. `<=, <, >, >=` - Comparison
2. `==, !=` - Equality
3. `&&` - Logical AND
4. `||` - Logical OR
```
if x && y || z
  # do something
end
```
In the above code block, the `x && y` will be evaluated first. 
1. If that statement is `true`, it will execute the rest of the code. 
    - This is because Ruby can be lazy in evaluation, since `true || false` is always `true`, it doesn't have to do the comparison.
2. If that statement is `false`, it will compare the output to `z`.
3. If `z` is true, the rest of the code will be executed.
4. If `z` is false, the code will exit the `if` statement.

### Ternary Operator
The ternary operator is a common Ruby idiom that makes a quick `if/else` statement easy and keeps it all on one line, using the `?` and `:` symbols.
```
true ? "this is true" : "this is not true"
=> "this is true"

false ? "this is true" : "this is not true"
=> "This is not true"
```

### Case Statements
`Case` statements use the reserved words `case, when, else`, and `end`. You create one by first defining a case and then evaluating the value of the case and what operation to complete if that case is true. A `case` statement will __return__ a value from it's evaluation. 
```
a = 5

case a
when 5
  puts "a is 5"
when 6
  puts "a is 6"
else
  puts "a is neither 5, nor 6"
end
```
If we're aiming for fewer lines of code and we only have one line of code as an output from an evaluation, we can have the output on the same line as the evaluation, if we use a `then` keyword.
```
a = 5

case a
when 5 then puts "a is 5"
when 6 then puts "a is 6"
else puts "a is neither 5, nor 6"
end
```
We are able to save our `case` statements to a variable. This can help us reduce the amount of typing `puts`. 

We are also able to save the results of our `if/else` statements, so long as we don't `return` something at each stage of our evaluation. Technically we can use `puts`, but that will result in the evaluation returning `nil` or a blank line. 
```
a = 5

answer = case a
  when 5
    "a is 5"
  when 6
    "a is 6"
  else
    "a is neither 5, nor 6"
  end

puts answer

alt_answer = if a == 5
    "a is 5"
  elsif a == 6 
    "a is 6"
  else
    "a is neither 5, nor 6"
  end

puts alt_answer
```
### True and False
In Ruby, __every expression evaluates to `true` when used in flow control (truthy), except for `false` and `nil` (falsy).__
```
if a == 5
    "a is 5"
  elsif a == 6 
    "a is 6"
  else
    "a is neither 5, nor 6 
  end
  ```
  