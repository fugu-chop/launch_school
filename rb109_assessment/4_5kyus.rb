# 1) Move the first letter of each word to the end of it, then add "ay" to the end of the word. Leave punctuation marks untouched.
=begin
pig_it('Pig latin is cool') == 'igPay atinlay siay oolcay'
pig_it('This is my string') == 'hisTay siay ymay tringsay'
=end
def pig_it(sentence)
  sentence.split.map do |word|
    word_var = word.chars
    if !('a'..'z').include?(word_var.first.downcase)
      word_var
    else
      first = word_var.shift
      word_var << first << 'ay'
      word_var.join
    end
  end.join(' ')
end

# 2) Write a function called that takes a string of parentheses, and determines if the order of the parentheses is valid. The function should return true if the string is valid, and false if it's invalid. Along with opening (() and closing ()) parenthesis, input may contain any valid ASCII characters. Furthermore, the input string may be empty and/or not contain any parentheses at all. Do not treat other forms of brackets as parentheses (e.g. [], {}, <>).
=begin
valid_parentheses("  (") == false
valid_parentheses(")test") == false
valid_parentheses("") == true
valid_parentheses("hi())(") == false
valid_parentheses("hi(hi)()") == true
valid_parentheses("((())()())")
=end

def valid_parentheses(string)
  return false if (string.count(')') != string.count('('))
  parentheses_arr = []
  string.each_char do |char|
    if char == '('
      parentheses_arr << char
    elsif char == ')'
      parentheses_arr.last == '(' ? parentheses_arr.pop : parentheses_arr << char
    end
  end
  parentheses_arr.empty?
end

# This is smart
def valid_parentheses(string)
  open = 0
  string.chars.each do |c|
    open += 1 if c == "("
    open -= 1 if c == ")"
    return false if open < 0
  end
  open == 0
end

# 3) Write a function that will find all the anagrams of a word from a list. You will be given two inputs a word and an array with words. You should return an array of all the anagrams or an empty array if there are none. 
=begin
anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']
anagrams('laser', ['lazing', 'lazy',  'lacer']) == []
=end
def anagrams(search_string, search_words)
  search_words.select do |word|
    word if word.chars.sort == search_string.chars.sort
  end
end

# 4) I can't be bothered writing this. See this: https://www.codewars.com/kata/550f22f4d758534c1100025a
=begin
dirReduc(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]) == ["WEST"]
dirReduc(["NORTH", "WEST", "SOUTH", "EAST"]) == ["NORTH", "WEST", "SOUTH", "EAST"]
=end
def dirReduc(directions)
  opposites = {
  "NORTH" => "SOUTH",
  "SOUTH" => "NORTH",
  "EAST"  => "WEST",
  "WEST"  => "EAST"
}

  reduced_directions = []
  directions.each do |direction|
      reduced_directions.last == opposites[direction] ? reduced_directions.pop : reduced_directions << direction
  end
  reduced_directions
end

# 4) ROT13 is a simple letter substitution cipher that replaces a letter with the letter 13 letters after it in the alphabet. ROT13 is an example of the Caesar cipher. Create a function that takes a string and returns the string ciphered with Rot13. If there are numbers or special characters included in the string, they should be returned as they are. Only letters from the latin/english alphabet should be shifted.
=begin
rot13("test") == "grfg"
rot13("Test") == "Grfg"
=end
def rot13(string)
  origin = ('a'..'z').to_a.join + ('A'..'Z').to_a.join
  cipher = ('a'..'z').to_a.rotate(13).join + ('A'..'Z').to_a.rotate(13).join
  string.tr(origin, cipher)
end

# 5) The maximum sum subarray problem consists in finding the maximum sum of a contiguous subsequence in an array or list of integers. Easy case is when the list is made up of only positive numbers and the maximum sum is the sum of the whole array. If the list is made up of only negative numbers, return 0 instead. Empty list is considered to have zero greatest sum. Note that the empty list or array is also a valid sublist/subarray.
=begin
max_sequence([]) == 0
max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
max_sequence([11]) == 11
max_sequence([-32]) == 0
max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12
=end
def max_sequence(array)
  return 0 if array.length == 0 || array.all? { |num| num < 0 }
  combos = []

  array.each_with_index do |_, start_idx|
    array.each_with_index do |_, end_idx|
      combos << array[start_idx..end_idx] if start_idx <= end_idx
    end
  end
  
  combos.map do |subarr|
    subarr.reduce(:+)
  end.max  
end

# 6) Generate a function that calculates whether the input number can be obtained by multiplying two consecutive Fibonacci numbers. It should return the two Fibonacci numbers, and a boolean (depending on whether the numbers are consecutive), in an array. If you can't multiply consecutive Fibonacci numbers to get to the input number, return the two closest consecutive Fibonacci numbers.
=begin
productFib(714) # should return (21, 34, true), 
                # since F(8) = 21, F(9) = 34 and 714 = 21 * 34

productFib(800) # should return (34, 55, false), 
                # since F(8) = 21, F(9) = 34, F(10) = 55 and 21 * 34 < 800 < 34 * 55
-----
productFib(714) # should return [21, 34, true], 
productFib(800) # should return [34, 55, false], 
-----
productFib(714) # should return {21, 34, 1}, 
productFib(800) # should return {34, 55, 0},        
-----
productFib(714) # should return {21, 34, true}, 
productFib(800) # should return {34, 55, false}, 

productFib(4895) == [55, 89, true]
productFib(5895) == [89, 144, false]
=end
def productFib(num)

end
