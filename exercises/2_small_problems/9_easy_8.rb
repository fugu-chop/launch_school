# 1) Write a method that takes an Array of numbers and then returns the sum of the sums of each leading subsequence for that Array. You may assume that the Array always contains at least one number.
=begin
sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
sum_of_sums([4]) == 4
sum_of_sums([1, 2, 3, 4, 5]) == 35
=end
def sum_of_sums(array)
  array.map.with_index do |_, index|
    array[0..index].reduce(:+)
  end.reduce(:+)
end

# 2) Create a simple mad-lib program that prompts for a noun, a verb, an adverb, and an adjective and injects those into a story that you create.
=begin
Enter a noun: dog
Enter a verb: walk
Enter an adjective: blue
Enter an adverb: quickly

Do you walk your blue dog quickly? That's hilarious!
=end

def madlibs
  puts "Please enter a noun:"
  noun = gets.chomp
  puts "Please enter a verb:"
  verb = gets.chomp
  puts "Please enter an adjective:"
  adjective = gets.chomp
  puts "Please enter an adverb:"
  adverb = gets.chomp

  puts "When do I #{verb} a #{adjective} #{noun} #{adverb}? Never!"
end

# 3) Write a method that returns a list of all substrings of a string that start at the beginning of the original string. The return value should be arranged in order from shortest to longest substring.
=begin
leading_substrings('abc') == ['a', 'ab', 'abc']
leading_substrings('a') == ['a']
leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']
=end
def leading_substrings(string)
  string_array = string.chars
  string_array.map.with_index do |_, index|
    string_array[0..index].join
  end
end

# 4) Write a method that returns a list of all substrings of a string. The returned list should be ordered by where in the string the substring begins. This means that all substrings that start at position 0 should come first, then all substrings that start at position 1, and so on. Since multiple substrings will occur at each position, the substrings at a given position should be returned in order from shortest to longest. You may (and should) use the leading_substrings method you wrote in the previous exercise
=begin
substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]
=end
def substrings(string)
  string_array = string.chars
  string_array.map.with_index do |_, index|
    leading_substrings(string[index..-1])
  end.flatten
end

# 5) Write a method that returns a list of all substrings of a string that are palindromic. That is, each substring must consist of the same sequence of characters forwards as it does backwards. The return value should be arranged in the same sequence as the substrings appear in the string. Duplicate palindromes should be included multiple times. You may (and should) use the substrings method you wrote in the previous exercise. For the purposes of this exercise, you should consider all characters and pay attention to case; that is, "AbcbA" is a palindrome, but neither "Abcba" nor "Abc-bA" are. In addition, assume that single characters are not palindromes.
=begin
palindromes('abcd') == []
palindromes('madam') == ['madam', 'ada']
palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]
=end
def palindromes(string)
  substring_array = substrings(string)
  substring_array.select do |substring|
    substring.length > 1 && substring == substring.reverse
  end
end

# 5b) Can you modify this method (and/or its predecessors) to ignore non-alphanumeric characters and case? Alphanumeric characters are alphabetic characters(upper and lowercase) and digits.
def palindromes_new(string)
  substring_array = substrings(string)
  substring_array.select do |substring|
    substring = substring.downcase.scan(/\w+/).join
    substring.length > 1 && substring == substring.reverse
  end
end