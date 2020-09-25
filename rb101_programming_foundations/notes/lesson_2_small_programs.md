# Lesson 2 - Small Programs

## Table of Contents
- [Style for Lesson 2 Only](#style-for-lesson-2-only)
- [Truthiness](#truthiness)
- [What is truthiness?](#what-is-truthiness)

### Style for Lesson 2 Only
In this lesson we're going to always use parentheses when invoking a method. Example: we will use `gets().chomp()` instead of `gets.chomp`, just so we're clear on what is a method invocation and what is a local variable. 

In this lesson, we are going to call `gets` and `puts` methods with their module, like this: `Kernel.puts()` or `Kernel.gets()`. Doing this shows that these are module methods in the `Kernel` module.

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