# 1) Create a method that takes 2 arguments, an array and a hash. The array will contain 2 or more elements that, when combined with adjoining spaces, will produce a person's name. The hash will contain two keys, :title and :occupation, and the appropriate values. Your method should return a greeting that uses the person's full name, and mentions the person's title and occupation.
=begin
greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
=> Hello, John Q Doe! Nice to have a Master Plumber around.
=end
def greetings(array, hash)
  "Hello, #{array.join(' ')}! Nice to have a #{hash[:title]} #{hash[:occupation]} around."
end

# 2) A double number is a number with an even number of digits whose left-side digits are exactly the same as its right-side digits. For example, 44, 3333, 103103, 7676 are all double numbers. 444, 334433, and 107 are not. Write a method that returns 2 times the number provided as an argument, unless the argument is a double number; double numbers should be returned as-is.
=begin
twice(37) == 74
twice(44) == 44
twice(334433) == 668866
twice(444) == 888
twice(107) == 214
twice(103103) == 103103
twice(3333) == 3333
twice(7676) == 7676
twice(123_456_789_123_456_789) == 123_456_789_123_456_789
twice(5) == 10
=end
def twice(number)
  string_num = number.to_s
  string_half_index = string_num.length / 2 - 1
  return number if string_num.length % 2 == 0 && 
  string_num[0..string_half_index] == string_num[string_half_index + 1..-1]
  number * 2
end

# 3) Write a method that takes a number as an argument. If the argument is a positive number, return the negative of that number. If the number is 0 or negative, return the original number.
=begin
negative(5) == -5
negative(-3) == -3
negative(0) == 0      # There's no such thing as -0 in ruby
=end
def negative(number)
  number * -1 < 0 ? number * -1 : number
end

# Suggested solution
def negative(number)
  -number.abs
end

# 4) Write a method that takes an integer argument, and returns an Array of all integers, in sequence, between 1 and the argument. You may assume that the argument will always be a valid integer that is greater than 0.
=begin
sequence(5) == [1, 2, 3, 4, 5]
sequence(3) == [1, 2, 3]
sequence(1) == [1]
=end
def sequence(number)
  (1..number).to_a
end

# 5) Write a method that takes a string argument, and returns true if all of the alphabetic characters inside the string are uppercase, false otherwise. Characters that are not alphabetic should be ignored.
=begin
uppercase?('t') == false
uppercase?('T') == true
uppercase?('Four Score') == false
uppercase?('FOUR SCORE') == true
uppercase?('4SCORE!') == true
uppercase?('') == true
=end
def uppercase?(string)
  string == string.upcase
end

# 6) Write a method that takes a string as an argument, and returns an Array that contains every word from the string, to which you have appended a space and the word length. You may assume that words in the string are separated by exactly one space, and that any substring of non-space characters is a word.
=begin
word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]

word_lengths("baseball hot dogs and apple pie") == ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

word_lengths("It ain't easy, is it?") == ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

word_lengths("Supercalifragilisticexpialidocious") == ["Supercalifragilisticexpialidocious 34"]

word_lengths("") == []
=end
def word_lengths(string)
  string.split.map do |word|
    word + " #{word.length}"
  end
end

# 7) Write a method that takes a first name, a space, and a last name passed as a single String argument, and returns a string that contains the last name, a comma, a space, and the first name.
=begin
swap_name('Joe Roberts') == 'Roberts, Joe'
=end
def swap_name(name)
  name.split.reverse.join(', ')
end

# 8) Create a method that takes two integers as arguments. The first argument is a count, and the second is the first number of a sequence that your method will create. The method should return an Array that contains the same number of elements as the count argument, while the values of each element will be multiples of the starting number. You may assume that the count argument will always have a value of 0 or greater, while the starting number can be any integer value. If the count is 0, an empty list should be returned.
=begin
sequence(5, 1) == [1, 2, 3, 4, 5]
sequence(4, -7) == [-7, -14, -21, -28]
sequence(3, 0) == [0, 0, 0]
sequence(0, 1000000) == []
=end
def sequence(count, start)
  num_array = []
  count.times { |number| num_array << start * (number + 1) }
  num_array
end

# Suggested solution
def sequence(count, first)
  (1..count).map { |value| value * first }
end

# 9) Write a method that determines the mean (average) of the three scores passed to it, and returns the letter value associated with that grade. Tested values are all between 0 and 100. There is no need to check for negative values or values greater than 100.
=begin
Numerical Score Letter 	Grade
90 <= score <= 100 	'A'
80 <= score < 90 	'B'
70 <= score < 80 	'C'
60 <= score < 70 	'D'
0 <= score < 60 	'F'
=end
=begin
get_grade(95, 90, 93) == "A"
get_grade(50, 50, 95) == "D"
=end
def get_grade(*args)
  score_hash = {
    'A' => (90..100).to_a,
    'B' => (80...90).to_a,
    'C' => (70...80).to_a,
    'D' => (60...70).to_a,
    'F' => (0...60).to_a
  }
  average = ([*args].reduce(:+) / [*args].size).round 
  
  score_hash.select do |_, value|
    value.include?(average)
  end.keys.join
end

# 9b) How would you handle this if there was a possibility of extra credit grades causing it to exceed 100 points?
# get_grade_extra(195, 190, 193) == 'A+'

def get_grade_extra(*args)
  score_hash = {
    'A' => (90..100).to_a,
    'B' => (80...90).to_a,
    'C' => (70...80).to_a,
    'D' => (60...70).to_a,
    'F' => (0...60).to_a
  }
  average = ([*args].reduce(:+) / [*args].size).round

  if score_hash.select do |_, value|
    value.include?(average)
  end.keys.join.length == 0
    'A+'
  else 
    score_hash.select do |_, value|
    value.include?(average)
  end.keys.join
  end
end

# 10) Write a method which takes a grocery list (array) of fruits with quantities and converts it into an array of the correct number of each fruit.
=begin
buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) == ["apples", "apples", "apples", "orange", "bananas", "bananas"]
=end
def buy_fruit(array)
  string_arr = []
  array.each do |element| 
    element[1].times { string_arr << element[0] }
  end
  string_arr
end

# Other sample solution
def buy_fruit(list)
  list.map { |fruit, quantity| [fruit] * quantity }.flatten
end
