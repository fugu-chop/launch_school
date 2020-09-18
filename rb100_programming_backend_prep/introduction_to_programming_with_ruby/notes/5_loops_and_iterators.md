# Loops and Iterators

## Table of Contents
- [What is a loop?](#what-is-a-loop)
- [Break](#break)
- [Next](#next)
- [While loops](#while-loops)
- [Until loops](#until-loops)
- [Do-While loops](#do-while-loops)
- [For loops](#do-while-loops)
- [Conditional within loops](#conditional-within-loops)
- [Iterators](#iterators)
- [Blocks](#blocks)
- [Recursion](#recursion)

### What is a loop?
A loop is the *repetitive execution of a piece of code* for a given amount of repetitions or until a certain condition is met. We will cover `while` loops, `do/while` loops, and `for` loops.

The simplest way to create a loop in Ruby is using the `loop` method. `loop` takes a block, which is denoted by `{ ... }` or `do ... end`. 

A loop will execute any code within the block (again, that's just between the `{ }` or `do ... end`) until you manually intervene with `Ctrl + C` or insert a `break` statement inside the block, which will force the loop to stop and the execution will continue after the loop.
```
# This loop will continue to run, since there's no break statement
loop do
  puts "This will keep printing until you hit Ctrl + c"
end
```
### Break
To stop the execution of a loop, we can use the `break` keyword. The `break` keyword allows us to exit a loop at any point, so any code after a `break` __will not be executed__. Note that `break` will __not__ exit the program, but only exit the loop and execution will continue on from after the loop.
```
i = 0
loop do
  i += 2
  puts i
  if i == 10
    break       # this will cause execution to exit the loop
  end
end

=> 2
=> 4
=> 6
=> 8
=> 10 
```
### Next
Similar to how we use `break` to exit a loop, we can use the keyword `next` to skip the rest of the current iteration and start executing the next iteration. 
```
i = 0
loop do
  i += 2
  if i == 4
    next        # skip rest of the code in this iteration
  end
  puts i
  if i == 10
    break
  end
end

=> 2
=> 6
=> 8
=> 10
```

### While loops
A `while` loop is given a parameter that evaluates to a boolean. Once that boolean expression becomes `false`, the while loop is not executed again, and the program *continues after the `while` loop*. 
```
x = gets.chomp.to_i

while x >= 0
  puts x
  x = x - 1
end

puts "Done!"
```
### Until loops
These are basically the equivalent of a `while` loop, just expressed in the negative.
```
x = gets.chomp.to_i

until x < 0
  puts x
  x -= 1
end

puts "Done!"
```
### Do While loops
A `do/while` loop works in a similar way to a `while` loop. One important difference is that the code within the loop gets executed one time, __prior__ to the conditional check to see if the code should be executed. In a `do/while` loop, the __conditional check is placed at the end of the loop__ as opposed to the beginning.
```
loop do
  puts "Do you want to do that again?"
  answer = gets.chomp
  if answer != "Y"
    break
  end
end
```
### For loops
`for` loops are used to loop over a collection of elements. `for` loops have a definite end since it's looping over a finite number of elements. 

It begins with the `for` reserved word, followed by a variable, then the `in` reserved word, and then a collection of elements. 
```
x = gets.chomp.to_i

# A range is a special type in Ruby that captures a range of elements. For example 1..3 is a range that captures the integers 1, 2, and 3.

for i in 1..x do
  puts i
end

puts "Done!"
```
### Conditional within loops
To make loops more effective and precise, we can add conditional flow control within them to alter their behavior.
```
x = 0

while x <= 10
  if x == 3
    x += 1
    next            # Once the next word is used, the program jumps back up to the top. We avoid printing 3.
  elsif x.odd?      # The .odd? method checks if x is odd
    puts x
  end
  x += 1
end
```
Note how if you place the `next` reserved word in a loop, it will jump from that line to the next loop iteration without executing the code beneath it. If you place the `break` reserved word in a loop, it will exit the loop immediately without executing any more code in the loop.

### Iterators
Iterators are methods that naturally loop over a given set of data and allow you to operate on each element in the collection.
```
names = ['Bob', 'Joe', 'Steve']

names.each { |name| puts name }
=> Bob
=> Joe
=> Steve
```
We have called the `each` method using the dot operator (`.`) on our array. 

What this method does is loop through each element in our array, in order, starting from 'Bob'. Then it begins executing the code within the block. The block's starting and ending points are defined by the curly braces `{ }`. 

Each time we iterate over the array, we need to assign the value of the element to a variable. In this example we have named the variable `name` and placed it in between two pipes (`|`). After that, we write the logic that we want to use to operate on the variable, which represents the current array element. 

### Blocks
A block is just some lines of code ready to be executed. When working with blocks there are two styles you need to be aware of. 

By convention, we use the curly braces (`{}`) when everything can be contained in one line. We use the words `do` and `end` when we are performing *multi-line operations*.
```
names = ['Bob', 'Joe', 'Steve', 'Janice', 'Susan', 'Helen']
x = 1

names.each do |name|
  puts "#{x}. #{name}"
  x += 1
end
```
### Recursion
Recursion is the act of calling a method from within itself. This effectively continues to run the loop until it reaches a predefined end point (usually through an `if` clause, and modifying the original argument). 

This is a way we can sense check our method to ensure it's not an endless loop - does the *recursion modify the original argument?* And have we returned an argument (after it's been subjected to all the recursion)?
```
# Define our method
def doubler(start)
  puts start * 2
end

# Use the method, within itself
def doubler(start)
  puts start
  if start < 10
    doubler(start * 2) 
  end
end

doubler(2)
2
4
8
16
=> nil
```
The logic behind the above project is this:
1. We input `start` = 2 in `doubler`. The method starts to execute.
2. We print 2 to the console
3. We hit the `if` statement -> 2 is less than 10, and so we enter the loop
4. We print `start` * 2 as per line 173 (as if we're running the method fresh, but now `start` is 2 * 2)
5. `start` * 2 is less than 10. 
6. We print `start` * 2 * 2 (which is 8)
7. `start` * 2 * 2 is less than 10.
8. We print `start` * 2 * 2 * 2 (16)
9. `start` now exceeds 10, and so the loop is exited. Since there's no more code in the method, the method ends as well. Phew!