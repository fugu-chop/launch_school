# 1) Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.
=begin
repeat('Hello', 3)

Hello
Hello
Hello
=end

def repeat(str, times)
  times.times { puts str }
end

# 2) Write a method that takes one integer argument, which may be positive, negative, or zero. This method returns true if the number's absolute value is odd. You may assume that the argument is a valid integer value.
=begin
puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true
=end

def is_odd?(num)
  num.abs % 2 == 1
end

# 3) Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.
=begin
puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true
=end

def digit_list(num)
  num.to_s.split('').map { |num| num.to_i }
end

# We could also shorten this to:
def digit_list(number)
  number.to_s.chars.map(&:to_i)
end

# 4) Write a method that counts the number of occurrences of each element in a given array.
vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

=begin
count_occurrences(vehicles)
car => 4
truck => 3
SUV => 1
motorcycle => 2
=end

def count_occurrences(array)
  array_hash = Hash.new  
  list_of_keys = array.uniq.each { |item| array_hash[item] = 0 }.to_s
  array.each { |element| array_hash[element] += 1 }
  array_hash.each { |key, value| puts "#{key} => #{value}" }
end

# Suggested solution
def count_occurrences(array)
  occurrences = {}
  array.uniq.each { occurrences[element] = array.count(element) }
  occurrences.each { |element, count| puts "#{element} => #{count}" }
end

count_occurrences(vehicles)

# 4b) Try to solve the problem when words are case insensitive, e.g. "suv" == "SUV".
vehicles_new = [
  'car', 'car', 'truck', 'car', 'SUV', 'Truck',
  'motorcycle', 'motorcycle', 'Car', 'truck',
  'SUV', 'TRUCK'
]

def count_occurrences(array)
  array_hash = Hash.new
  lowered_elements = array.map { |item| item.downcase }
  list_of_keys = array.uniq.map { |item| item.downcase }.uniq.each { |item| array_hash[item] = 0 }
  lowered_elements.each { |element| array_hash[element] += 1 }
  array_hash.each { |key, value| puts "#{key} => #{value}" }
end

count_occurrences(vehicles_new)

# 5) Write a method that takes one argument, a string, and returns a new string with the words in reverse order.
=begin
puts reverse_sentence('') == ''
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
=end

def reverse_sentence(sentence)
  sentence.split.reverse.join(' ')
end

# 6) Write a method that takes one argument, a string containing one or more words, and returns the given string with words that contain five or more characters reversed. Each string will consist of only letters and spaces. Spaces should be included only when more than one word is present.
=begin
puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS
=end

def reverse_words(words)
  word_array = []
  words.split.each do |word|
    if word.length >= 5
      word_array.push(word.reverse)
    else
      word_array.push(word)
    end
  end
  word_array.join(' ')
end

# 7) Write a method that takes one argument, a positive integer, and returns a string of alternating 1s and 0s, always starting with 1. The length of the string should match the given integer.
=begin
puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
=end

def stringy(num)
  if num % 2 == 0
    '10' * (num / 2)
  elsif num % 2 == 1
    '10' * ((num-1) / 2) + '1'
  end
end

# Suggested solution
def stringy(size)
  numbers = []

  size.times do |index|
    number = index.even? ? 1 : 0
    numbers << number
  end

  numbers.join
end

# 7b) Modify stringy so it takes an additional optional argument that defaults to 1. If the method is called with this argument set to 0, the method should return a String of alternating 0s and 1s, but starting with 0 instead of 1.

def stringy(size, starting_digit = 1)
  numbers = []
  size.times do |index|
    number = index.even? ? starting_digit : starting_digit == 0 ? 1 : 0
    numbers << number
  end
  numbers.join
end

stringy(6, starting_digit = 0)

# 8) Write a method that takes one argument, an array containing integers, and returns the average of all numbers in the array. The array will never be empty and the numbers will always be positive integers. Your result should also be an integer.
=begin
puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40
=end

def average(arr)
  arr.reduce(:+) / arr.size
end

# 8b) Currently, the return value of average is an Integer. When dividing numbers, sometimes the quotient isn't a whole number, therefore, it might make more sense to return a Float. Can you change the return value of average from an Integer to a Float?

def average(arr)
  arr.reduce(:+) / arr.size.to_f
end

# 9) Write a method that takes one argument, a positive integer, and returns the sum of its digits.
=begin
puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45
=end

def sum(num)
  stringify = num.to_s.chars
  stringify.map(&:to_i).reduce(:+)
end

# 10) Write a method that takes two arguments, a positive integer and a boolean, and calculates the bonus for a given salary. If the boolean is true, the bonus should be half of the salary. If the boolean is false, the bonus should be 0.
=begin
puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
=end

def calculate_bonus(salary, bonus)
  bonus ? salary * 0.5 : 0
end
