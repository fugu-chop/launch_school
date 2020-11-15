# 1) Write a method that rotates an array by moving the first element to the end of the array. The original array should not be modified. Do not use the method Array#rotate or Array#rotate! for your implementation.
=begin
rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true
=end
def rotate_array(array)
  new_array = array.map { |element| element }
  first_char = new_array.shift
  new_array << first_char
  new_array
end

# Alternate method
def rotate_array(array)
  array[1..-1] + [array[0]]
end

# 2) Write a method that can rotate the last n digits of a number. You may assume that n is always a positive integer. Note that rotating just 1 digit results in the original number being returned.
=begin
rotate_rightmost_digits(735291, 1) == 735291
rotate_rightmost_digits(735291, 2) == 735219
rotate_rightmost_digits(735291, 3) == 735912
rotate_rightmost_digits(735291, 4) == 732915
rotate_rightmost_digits(735291, 5) == 752913
rotate_rightmost_digits(735291, 6) == 352917
=end
def rotate_rightmost_digits(number, digits)
  num_array = number.to_s.chars
  spin_digit = num_array.delete(num_array[-digits])
  num_array << spin_digit
  num_array.join.to_i
end

# 3) If you take a number like 735291, and rotate it to the right, you get 352917. If you now keep the first digit fixed in place, and rotate the remaining digits, you get 329175. Keep the first 2 digits fixed in place and rotate again to 321759. Keep the first 3 digits fixed in place and rotate again to get 321597. Finally, keep the first 4 digits fixed in place and rotate the final 2 digits to get 321579. The resulting number is called the maximum rotation of the original number. Write a method that takes an integer as argument, and returns the maximum rotation of that argument. Note that you do not have to handle multiple 0s.
=begin
max_rotation(735291) == 321579
max_rotation(3) == 3
max_rotation(35) == 53
max_rotation(105) == 15 # the leading zero gets dropped
max_rotation(8_703_529_146) == 7_321_609_845
=end
def max_rotation(number)
  num_array = number.to_s.chars
  index = 0

  while index < num_array.length - 1
    spin_digit = num_array.delete(num_array[index])
    num_array << spin_digit
    index += 1
  end

  num_array.join.to_i
end

# 4) You have a bank of switches before you, numbered from 1 to n. Each switch is connected to exactly one light that is initially off. You walk down the row of switches and toggle every one of them. You go back to the beginning, and on this second pass, you toggle switches 2, 4, 6, and so on. On the third pass, you go back again to the beginning and toggle switches 3, 6, 9, and so on. You repeat this process and keep going until you have been through n repetitions. Write a method that takes one argument, the total number of switches, and returns an Array that identifies which lights are on after n repetitions.
=begin
Example with n = 5 lights:

round 1: every light is turned on
round 2: lights 2 and 4 are now off; 1, 3, 5 are on
round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
round 5: lights 2, 3, and 5 are now off; 1 and 4 are on

The result is that 2 lights are left on, lights 1 and 4. The return value is [1, 4].

With 10 lights, 3 lights are left on: lights 1, 4, and 9. The return value is [1, 4, 9].
=end
def lights(switches)
  switchboard = Array.new(switches, 1)
  light_indices = []
  lights_on = []
  first_switch_change = 2

  first_switch_change.upto(switches) do |switch|
    light_indices = (switch..switches).to_a.select { |element| element % switch == 0 }.map { |number| number - 1 }
    light_indices.each do |index|
      switchboard[index] += 1
    end
  end

  switchboard.each_with_index do |light, index|
    lights_on << index + 1 if light.odd?
  end

  lights_on
end

# 5) Write a method that displays a 4-pointed diamond in an n x n grid, where n is an odd integer that is supplied as an argument to the method. You may assume that the argument will always be an odd integer.
=begin
diamond(1)

*

diamond(3)

 *
***
 *

 diamond(9)

    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
=end
def diamond(integer)
  spaces = integer / 2
  stars = 1
  loop do 
    puts ' ' * spaces + '*' * stars 
    spaces -= 1
    stars += 2
    break if stars > integer
  end

  spaces = 1
  stars = integer - 2
  loop do 
    puts ' ' * spaces + '*' * stars
    spaces += 1
    stars -= 2
    break if stars < 1
  end
end

# 5b) Try modifying your solution or our solution so it prints only the outline of the diamond
=begin
diamond_outline(5)

  *
 * *
*   *
 * *
  *
=end

def diamond_outline(integer)
  spaces = integer / 2
  stars = 1
  star_output = ''

  loop do 
    star_output = '*' * stars
    if stars > 1
      star_output[1..-2] = star_output[1..-2].chars.map! { |asterisk| asterisk = ' ' }.join 
    end
    puts ' ' * spaces + star_output 
    spaces -= 1
    stars += 2
    break if stars > integer
  end

  spaces = 1
  stars = integer - 2
  loop do 
    star_output = '*' * stars
    if stars > 1
      star_output[1..-2] = star_output[1..-2].chars.map! { |asterisk| asterisk = ' ' }.join 
    end
    puts ' ' * spaces + star_output
    spaces += 1
    stars -= 2
    break if stars < 1
  end
end

# 6) Write a method that implements a miniature stack-and-register-based programming language that has the following commands. All operations are integer operations (which is only important with DIV and MOD).Programs will be supplied to your language method via a string passed in as an argument. Your program may assume that all programs are correct programs; that is, they won't do anything like try to pop a non-existent value from the stack, and they won't contain unknown tokens. You should initialize the register to 0.
=begin
    n Place a value n in the "register". Do not modify the stack.
    PUSH Push the register value on to the stack. Leave the value in the register.
    ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
    SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
    MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
    DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
    MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
    POP Remove the topmost item from the stack and place in register
    PRINT Print the register value
=end
=begin
minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)
end
=end
def minilang(command)
  register = 0
  stack = []
  command.split.each do |item|
    case item 
    when 'PUSH' then stack << register
    when 'ADD' then register += stack.pop
    when 'SUB' then register -= stack.pop
    when 'MULT' then register *= stack.pop
    when 'DIV' then register /= stack.pop
    when 'MOD' then register %= stack.pop
    when 'POP' then register = stack.pop
    when 'PRINT' then puts register
    else register = item.to_i
    end
  end
end

# 7) Write a method that takes a sentence string as input, and returns the same string with any sequence of the words 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' converted to a string of digits.
=begin
word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'
=end

def word_to_digit(words)
  digit_hash = {
  'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
  'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
}.freeze

  digit_hash.keys.each do |word|
    words.gsub!(/\b#{word}\b/, digit_hash[word])
  end
  words
end

# 8) Write a recursive method that computes the nth Fibonacci number, where nth is an argument to the method.
=begin
fibonacci(1) == 1
fibonacci(2) == 1
fibonacci(3) == 2
fibonacci(4) == 3
fibonacci(5) == 5
fibonacci(12) == 144
fibonacci(20) == 6765
=end

# In essence, this recursive method will give you a bunch of zeros and ones at the lowest depth of the function (i.e. where number is either zero or one due to number - 1 and number - 2). Ruby will keep track of all the fibonacci(1) instances in the call stack. So, this function really adds up a very large number of ones - e.g. for fibonacci(12), we end up with 144 instances of fibonacci(1).
def fibonacci(number)
  if number < 2
    number
  else
    fibonacci(number - 1) + fibonacci(number - 2)
  end
end

# 9) Rewrite your recursive fibonacci method so that it computes its results without recursion (procedural)
def fibonacci_proc(number)
  num_sequence = [1, 1]
  while num_sequence.length < number 
    num_sequence << num_sequence[-1] + num_sequence[-2]
  end
  num_sequence.last
end

# 10) In this exercise, you are going to compute a method that returns the last digit of the nth Fibonacci number.
=begin
fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
fibonacci_last(123456789) # -> 4
=end
def fibonacci_last(number)
  num_sequence = [1, 1]
  while num_sequence.length < number 
    num_sequence << num_sequence[-1] + num_sequence[-2]
  end
  num_sequence.last.to_s[-1].to_i
end