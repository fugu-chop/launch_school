# 1) Write a program that solicits 6 numbers from the user, then prints a message that describes whether or not the 6th number appears amongst the first 5 numbers.
=begin
==> Enter the 1st number:
25
==> Enter the 2nd number:
15
==> Enter the 3rd number:
20
==> Enter the 4th number:
17
==> Enter the 5th number:
23
==> Enter the last number:
17
The number 17 appears in [25, 15, 20, 17, 23].
=end

def solicit
  arr = []
  5.times do |num|
    puts "==> Please enter number #{num + 1}:"
    arr << gets.chomp.to_i
  end
  puts "==> Please enter number 6:"
  response = gets.chomp.to_i
  verb = arr.include?(response) ? 'appears' : 'does not appear'
  puts "The number #{response} #{verb} in #{arr}"
end

# 2) Write a program that prompts the user for two positive integers, and then prints the results of the following operations on those two numbers: addition, subtraction, product, quotient, remainder, and power. Do not worry about validating the input.
=begin
==> Enter the first number:
23
==> Enter the second number:
17
==> 23 + 17 = 40
==> 23 - 17 = 6
==> 23 * 17 = 391
==> 23 / 17 = 1
==> 23 % 17 = 6
==> 23 ** 17 = 141050039560662968926103
=end

def operations
  puts '==> Please enter the first number:'
  num1 = gets.chomp.to_i
  puts '==> Please enter the second number:'
  num2 = gets.chomp.to_i
  puts "#{num1} + #{num2} = #{num1 + num2}"
  puts "#{num1} - #{num2} = #{num1 - num2}"
  puts "#{num1} * #{num2} = #{num1 * num2}"
  puts "#{num1} / #{num2} = #{num1 / num2}"
  puts "#{num1} % #{num2} = #{num1 % num2}"
  puts "#{num1} ** #{num2} = #{num1 ** num2}"
end

# 3) Write a program that will ask a user for an input of a word or multiple words and give back the number of characters. Spaces should not be counted as a character.
=begin
Please write word or multiple words: walk
There are 4 characters in "walk".

Please write word or multiple words: walk, don't run
There are 13 characters in "walk, don't run".
=end

def num_chars
  puts 'Please write a word or multiple words:'
  input = gets.chomp
  puts "There are #{input.split.join.length} characters in \"#{input}\"."
end

# Could also have used num_char = input.delete(' ').size

# 4) Create a method that takes two arguments, multiplies them together, and returns the result.
# multiply(5, 3) == 15
def multiply(a, b)
  a * b
end

# 5) Write a method that computes the square of its argument (the square is the result of multiplying a number by itself).
# square(5) == 25
def square(num)
  multiply(num, num)
end

# 5b) What if we wanted to generalize this method to a "power to the n" type method: cubed, to the 4th power, to the 5th, etc. How would we go about doing so while still using the multiply method?
def power(num, power)
  multiply(num, 1) ** power
end

# 6) Write a function named xor that takes two arguments, and returns true if exactly one of its arguments is truthy, false otherwise. Note that we are looking for a boolean result instead of a truthy/falsy value as returned by || and &&.
def xor?(a, b)
  !!((a && !b) || (b && !a))
end

# 7) Write a method that returns an Array that contains every other element of an Array that is passed in as an argument. The values in the returned list should be those values that are in the 1st, 3rd, 5th, and so on elements of the argument Array.
=begin
oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
oddities(['abc', 'def']) == ['abc']
oddities([123]) == [123]
oddities([]) == []
=end

def oddities(arr)
  arr.select.with_index { |_, index| index % 2 == 0 }
end

# 7b) Please try two other methods that do the same thing.

def oddities1(arr)
  odd_arr = []
  arr.each_with_index { |el, index| odd_arr << el if index % 2 == 0 }
  odd_arr
end

def oddities2(arr)
  new_arr = []
  counter = 0
  while counter < arr.length 
    new_arr << arr[counter]
    counter += 2
  end
  new_arr
end

# 8) Write a method that returns true if the string passed as an argument is a palindrome, false otherwise. A palindrome reads the same forward and backward. For this exercise, case matters as does punctuation and spaces.
=begin
palindrome?('madam') == true
palindrome?('Madam') == false          # (case matters)
palindrome?("madam i'm adam") == false # (all characters matter)
palindrome?('356653') == true
=end

def palindrome?(str)
  str == str.reverse
end

# 8b) Write a method that determines whether an array is palindromic; that is, the element values appear in the same sequence both forwards and backwards in the array. 

def palindrome_arr?(arr)
  arr == arr.reverse
end

# 8c) Now write a method that determines whether an array or a string is palindromic; that is, write a method that can take either an array or a string argument, and determines whether that argument is a palindrome. You may not use an if, unless, or case statement or modifier.

def palindrome_any?(obj)
  obj == obj.reverse
end

# 9) Write another method that returns true if the string passed as an argument is a palindrome, false otherwise. This time, however, your method should be case-insensitive, and it should ignore all non-alphanumeric characters.

def real_palindrome?(str)
  str.gsub(/\W/, '').downcase == str.gsub(/\W/, '').downcase.reverse
end

# Suggested solution
def real_palindrome?(string)
  string = string.downcase.delete('^a-z0-9')
  palindrome?(string)
end

# 10) Write a method that returns true if its integer argument is palindromic, false otherwise. A palindromic number reads the same forwards and backwards.
def palindromic_number?(num)
  num.to_s == num.to_s.reverse
end

# 10b) Suppose your number begins with one or more 0s. Will your method still work? Why or why not? Is there any way to address this?
puts 'If the number starts with 0s, this may not work. I would warn the user to input a number without a zero. We can\'t reliably just strip zeros from the start of the number, as we can\'t necessarily be sure if the number is supposed to be in binary or a regular number.'