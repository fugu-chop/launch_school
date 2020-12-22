# https://www.codewars.com/kata/55953e906851cf2441000032/train/ruby
def scramble(word)
  word = word.chars.select do |letter|
    ('a'..'z').include?(letter)
  end.join
  first_letter = word[0]
  last_letter = word[-1]
  mid = word[1...-1].chars.sort.join
  first_letter + mid + last_letter
end

def scramble_words(sentence)
  sentence = sentence.split
  sentence.map do |word|
    scrambled = scramble(word).chars
    word.chars.map do |letter|
      if ('a'..'z').include?(letter)
        scrambled.shift
      else
        letter
      end
    end.join
  end.join(' ')
end

# https://www.codewars.com/kata/51e056fe544cf36c410000fb/train/ruby 
def cleaner(word)
  word.chars.each do |letter|
    if !('a'..'z').include?(letter)
      word.sub!(letter, '')
    else
      break
    end
  end

  return word if word.empty?

  end_idx = -1
  loop do 
    break if ('a'..'z').include?(word[end_idx])
    word.sub!(word[end_idx], '') if !('a'..'z').include?(word[end_idx])
    end_idx -= 1
  end

  word
end

def top_3_words(sentence)
  return [] if sentence.empty?
  sentence = sentence.downcase.split.map do |word|
    cleaner(word)
  end

  return [] if sentence.empty?

  word_counts = sentence.each_with_object(Hash.new(0)) do |word, hash|
    hash[word] += 1 if !word.empty?
  end

  word_counts.keys.max_by(3) do |key|
    word_counts[key]
  end
end

# https://www.codewars.com/kata/5a7f58c00025e917f30000f1
def longest(input)
  current_str = ''
  alpha_chars = []
  input.chars.each_index do |idx|
    if input.chars[idx + 1] != nil && input.chars[idx] <= input.chars[idx + 1]
      current_str << input.chars[idx]
    else
      current_str << input.chars[idx]
      alpha_chars << current_str
      current_str = ''
    end
  end
  alpha_chars << current_str
  alpha_chars.sort_by { |element| -element.length }.first
end

# https://www.codewars.com/kata/5b1b27c8f60e99a467000041
def anagram_difference(str1, str2)
  str1_dup, str2_dup = str1.dup, str2.dup
  str1_arr = str1.chars
  str2_arr = str2.chars

  str1_arr.each do |letter1|
    str2_dup.sub!(letter1, '') if str2_arr.include?(letter1)
  end

  str2_arr.each do |letter2|
    str1_dup.sub!(letter2, '') if str1_arr.include?(letter2)
  end

  str1_dup.length + str2_dup.length
end

# https://www.codewars.com/kata/53bb1201392478fefc000746
def find_suspects(suspects, allowed_items)
  return nil if suspects.empty?
  illegals = suspects.each_with_object([]) do |pair, arr|
    next if pair[1] == nil
    arr << pair[0] if pair[1].any? { |item| !allowed_items.include?(item) }
  end

  illegals.empty? ? nil : illegals
end

# https://www.codewars.com/kata/5894318275f2c75695000146/train/ruby
def alphabetized(input)
  input.chars.select do |letter|
    ('a'..'z').include?(letter.downcase)
  end.sort_by { |char| char.downcase }.join
end

# https://www.codewars.com/kata/58539230879867a8cd00011c/train/ruby
def find_children(people)
  people.chars.sort_by do |person|
    [person.downcase, person]
  end.join
end

# https://www.codewars.com/kata/56b5afb4ed1f6d5fb0000991
def reverse_it?(chunk_string)
  chunk_num = chunk_string.chars.map do |char|
    char.to_i
  end
  chunk_num.map do |digit|
    digit ** 3
  end.reduce(:+) % 2 == 0
end

def revrot(str, sz)
  return '' if sz <= 0 || str.length == 0 || sz > str.length
  str.chars.each_slice(sz).map do |slice|
    if slice.length < sz
      next
    elsif reverse_it?(slice.join)
      slice.reverse.join
    else 
      a = slice.shift
      slice << a
      slice.join
    end
  end.compact.join
end

# https://www.codewars.com/kata/56b861671d36bb0aa8000819/train/ruby
def reverse_word(pair)
  pair.map do |word|
    word.reverse
  end.join
end

def reverse_and_combine_text(string)
  string = string.split

  loop do 
    string = string.each_slice(2).map do |slice|
      reverse_word(slice)
    end
    break string.first if string.length == 1
  end
end

# https://www.codewars.com/kata/59fd6d2332b8b9955200005f/ruby
def solve(num, times)
  num = num.to_s

  times.times do |_|
    removal_digit = ''
    dig_arr = num.chars
    dig_arr.each_with_index do |digit, index|
      if dig_arr[index + 1] != nil && dig_arr[index] <= dig_arr[index + 1]
        next
      else
        break removal_digit = dig_arr[index]
      end
    end
    removal_digit == '' ? dig_arr.pop : num.sub!(removal_digit, '')
  end
  
  num
end

# Launch School Small Problems (Medium 1, Rotation Part 3)
=begin
Problem
  Write a method that takes an integer as argument, and returns the maximum rotation of that argument. 

  Input
    Integer object

  Output
    Integer object with the same digits, in different places

  Rules
    Note that you do not have to handle multiple 0s.
    Leading zeroes get dropped
    Take the first digit, put it at the end of the number
    Hold the new first digit constant, put the new first digit to the end
    Repeat utnil you can't hold a digit constant any more

Examples
  max_rotation(735291) == 321579
  max_rotation(3) == 3
  max_rotation(35) == 53
  max_rotation(105) == 15 # the leading zero gets dropped
  max_rotation(8_703_529_146) == 7_321_609_845

Data Structures
  Array

Algorithm
  Initialise a variable, first_chars = []
  Break up our input integer into an array of digits (remember to reverse) - digit_arr
  Create a loop
    Shift the first element, to the end of the digits_arr
    first_char = shift the first element of first_digit_hold
    Append to first_chars
    Repeat the process until first_chars length is equalt to digits_arr
  Return first_chars, joined, converted to integer
=end
def max_rotation(input)
  first_chars = []
  digit_arr = input.digits.reverse
  orig_length = digit_arr.length
  while first_chars.length < orig_length
    first = digit_arr.shift
    digit_arr << first
    first_chars << digit_arr.shift
  end
  first_chars.join.to_i
end

# Launch School Small Problems (Medium 1, Now I Know My ABCs)
=begin
Problem
Write a method that returns true if the word passed in as an argument can be spelled from this set of blocks, false otherwise.
B:O   X:K   D:Q   C:P   N:A
G:T   R:E   F:S   J:W   H:U
V:I   L:Y   Z:M

  Input
    String object

  Output
    Boolean

  Rules
    The block of words is not case sensitive
      A block can only be used once to spell a word - e.g. if you 'use up' "B", the method will not return true if that word 'O'

Examples
  block_word?('BATCH') == true
  block_word?('BUTCH') == false
  block_word?('jest') == true

Data Structures
  Array
  Hash

Algo
  Break up our input into an array of characters (str_arr)
  We put our text block, into a hash (permitted_blocks)
  We iterate through str_arr
    On each iteration, we check if the letter is among the keys of permitted_blocks
      If so, delete that key-value pair from permitted blocks
      If not, return false
    end
  return true otherwise
=end
def block_word?(input)
  permitted_blocks = { 'B' => 'O', 'X' => 'K', 'D' => 'Q', 'C' => 'P', 
    'N' => 'A', 'G' => 'T', 'R' => 'E', 'F' => 'S', 'J' => 'W', 'H' => 'U',
    'V' => 'I', 'L' => 'Y', 'Z' => 'M' }
  str_arr = input.chars
  str_arr.each do |letter|
    if permitted_blocks.keys.include?(letter.upcase) 
      permitted_blocks.delete(letter.upcase)
    elsif permitted_blocks.values.include?(letter.upcase)
      permitted_blocks.delete(permitted_blocks.select { |_, value| value == letter.upcase }.keys.first)
    else
      return false
    end
  end
  true
end

# Launch School Small Problems (Medium 1, Matching Parentheses)
=begin
Problem
  Write a method that takes a string as argument, and returns true if all parentheses in the string are properly balanced, false otherwise. 

  Input
    String object

  Output
    Boolean

  Rules
    To be properly balanced, parentheses must occur in matching '(' and ')' pairs.
    Note that balanced pairs must each start with a (, not a ).
    If the number of parentheses is not even, false
    If number of left parentheses != number of right parentheses, false

Examples
  balanced?('What (is) this?') == true
  balanced?('What is) this?') == false
  balanced?('What (is this?') == false
  balanced?('((What) (is this))?') == true
  balanced?('((What)) (is this))?') == false
  balanced?('Hey!') == true
  balanced?(')Hey!(') == false
  balanced?('What ((is))) up(') == false

Data Structures
  Array

Algo
  Break up our string into an array of characters (str_arr)
  we initialise an empty array to the variable (parens)
  We iterate through str_arr
    If there is a left parentheses, append to parens
    If there is a right parentheses, pop parens
  Test if parens is empty (will return a boolean)
=end
def balanced?(input)
  return false if input.count('(') != input.count(')')
  parens = []
  input.each_char do |letter|
    parens << '(' if letter == '('
    parens.pop if letter == ')'
  end
  parens.empty?
end

# Launch School Small Problems (Medium 2, Next Featured Number Higher than a Given Value)
=begin
Problem
A featured number (something unique to this exercise) is an odd number that is a multiple of 7, and whose digits occur exactly once each. 
So, for example, 49 is a featured number, but 98 is not (it is not odd), 97 is not (it is not a multiple of 7), and 133 is not (the digit 3 appears twice).

Write a method that takes a single integer as an argument, and returns the next featured number that is greater than the argument. 
Return an error message if there is no next featured number.

  Input
    Integer object

  Output
    Integer object, or a string if there is no featured number

  Rules
    A featured number is odd, a multiple of 7 and only has distinct digits

Examples
  featured(12) == 21
  featured(20) == 21
  featured(21) == 35
  featured(997) == 1029
  featured(1029) == 1043
  featured(999_999) == 1_023_547
  featured(999_999_987) == 1_023_456_987
  featured(9_999_999_999) # -> There is no possible number that fulfills those requirements

Data Structures
  Array?

Algo
  Given an integer object, which will start our range
  Loop this
    We add one to the start range
      Test if this number is
        Odd
        Divisible by 7
        Digits are uniq (num.digits.uniq.length == num.digits.length)
        =end
  Break loop if we hit 999999988 without returning a number
  Print a string "There is no possible number that fulfills those requirements"
=end
def featured(input)
  start_range = input + 1
  loop do 
    break if start_range >= 9_999_999_999
    return start_range if start_range.odd? && 
      start_range % 7 == 0 && 
      start_range.digits.uniq.length == start_range.digits.length
    start_range += 1
    
  end
  "There is no possible number that fulfills those requirements"
end

# Launch School Small Problems (Medium 2, Next Featured Number Higher than a Given Value)
=begin
Problem
  Write a method that computes the difference between the square of the sum of the first n positive integers and the sum of the squares of the first n positive integers.

  Input
    Positive integer object

  Output
    Positive integer object

  Rules
    We could get zero as an output
    Calculate the sum of the numbers up to the input, square it (a)
    Calculate the square of each of the numbers up to input integer, adding them up (b)
    Subtract b from a

Examples
  sum_square_difference(3) == 22
    # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
  sum_square_difference(10) == 2640
  sum_square_difference(1) == 0
  sum_square_difference(100) == 25164150

Data Structures
  Array

Algo
  Create a range of numbers from 1 up to the input number (num_range)
  (a) Reduce all of the numbers in num_range, and square it (sum_square)
  (b) Square all of the numbers in num_range and add them together (digits_squared)
  Subtract b from a (return this value)
=end
def sum_square_difference(input)
  num_range = 1.upto(input).to_a
  sum_square = num_range.reduce(0, &:+) ** 2
  digits_squared = num_range.map do |digit|
    digit ** 2
  end.reduce(0, &:+)
  sum_square - digits_squared
end

# Launch School Small Problems (Medium 2, Bubble Sort)
=begin
Problem 
Write a method that takes an Array as an argument, and sorts that Array using the bubble sort algorithm.

  Input
    Array of objects

  Output
    Array of objects (input object mutated)

  Rules
    You will mutate the Array passed as an argument. 
    You may assume that the Array contains at least 2 elements.
    We know the sort is finished, when nothing gets swapped in the array

Examples
  array = [5, 3]
  bubble_sort!(array)
  array == [3, 5]

  array = [6, 2, 7, 1, 4]
  bubble_sort!(array)
  array == [1, 2, 4, 6, 7]

  array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
  bubble_sort!(array)
  array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

Data Structures
  Array

Algo
  Receive array object as input
  num_swaps = 0
  Iterate through this input array in pairs
    If the first object is larger than the next object
      Swap the two elements in place
      Increment num_swaps
    Otherwise
      Next
  Repeat this process (loop)
    Reset num_swaps
    Break this loop if num_swaps = 0 after the entire iteration is done
  Return the array object
=end
def bubble_sort!(array)
  num_swaps = 0
  start_idx = 0
  end_idx = 1

  loop do
    loop do 
      if array[start_idx] > array[end_idx]
        array[start_idx], array[end_idx] = array[end_idx], array[start_idx]
        num_swaps += 1
      end
      start_idx += 1
      end_idx += 1
      break if end_idx > array.length - 1
    end
    start_idx = 0
    end_idx = 1
    break if num_swaps == 0
    num_swaps = 0
  end

  array
end

# Study Group Problem 1
=begin
Problem 
  You have to create a function that takes a positive integer number and returns the next bigger number formed by the same digits.

  Input
    Integer object

  Output
    Integer object

  Rules
    We have to return the next largest number (not the max!)
    We return -1 if no larger number can be returned

Examples
  next_bigger(12) == 21
  next_bigger(513) == 531
  next_bigger(2017) == 2071
  next_bigger(2071) == 2107
  next_bigger(1990) == 9019
  next_bigger(414) == 441
  next_bigger(144) == 414
  next_bigger(9) == -1
  next_bigger(111) == -1
  next_bigger(531) == -1

Data Structures
  Array

Algorithm
  Increment our number, until the digits match the digits of the input
  Find the max number possible of our input
    If the input matches the max, return -1
=end
def next_bigger(input)
  max_num = input.digits.reverse.sort.reverse.join.to_i
  return -1 if input == max_num
  loop do 
    input += 1
    break input if input.digits.sort == max_num.digits.sort
  end
end

# Study Group Problem 2
=begin
Problem 
  Given an array of n positive integers and a positive integer s, find the minimal length of a contiguous subarray of which the sum ≥ s. If there isn't one, return 0 instead.

  Input
    An array object of integer objects as elements
    Integer object

  Output
    Integer object

  Rules
    If there is no contiguous subarray where sum >= s, return 0
    A contiguous subarray means the numbers need to be next to each other (i.e. preserve array order)
    The integer object is the target we're aiming to sum up to (or over)

Examples
  minSubLength([2,3,1,2,4,3], 7) == 3
  minSubLength([1, 10, 5, 2, 7], 9) == 1
  minSubLength([1, 11, 100, 1, 0, 200, 3, 2, 1, 250], 280) == 4
  minSubLength([1, 2, 4], 8) == 0

Data Structures
  Array

Algorithm
  Create an empty array called lengths
  Iterate through our given array
  Start at index 0 (start_idx)
  Take a range of elements, using an end index (end_idx)
  Check if summing that range of elements is >= s
    If so, append the length of that subarray to lengths
  Otherwise, continue iterating end_idx
  If that still doesn't find a relevant contiguous subarray, 
    increment start_idx
    Reassign end_idx to start_idx
    Repeat the above
  Break when we reach start_idx = array.length - 1
  Return 0 if lengths is empty, otherwise return the min of lengths
=end
def minSubLength(array, target)
  lengths = []
  start_idx = 0
  end_idx = 0
  loop do 
    loop do 
      lengths << array[start_idx..end_idx].length if array[start_idx..end_idx].reduce(:+) >= target
      end_idx += 1
      break if end_idx == array.length - 1
    end
    start_idx += 1
    end_idx = start_idx
    break if start_idx == array.length - 1
  end
  lengths.empty? ? 0 : lengths.min
end

# Study Group Problem 3
=begin
Problem
  Write a method that takes a string argument and returns a new string that contains the value of the original string with all consecutive duplicate characters collapsed into a single character.

  Input
    String object (could be empty)

  Output
    String object (could be empty)

  Rules

Examples
  collapse('bbbbbbbbb') == 'b'
  collapse('wwooonndeerrfull woorrlldd') == 'wonderful world'
  collapse('222xyzxyzyx') == '2xyzxyzyx'
  collapse('Q') == 'Q'
  collapse('AAbbCC') == 'AbC'
  collapse('') == ''

Data Structure
  Array 

Algorithm
  Initialise empty array (reduced_letters)
  Break up string input into array of characters (arr_char)
  Iterate through arr_char
    If the character passed to the block is equal to the last element of reduced_letters
      Next
    Otherwise
      Append the character to reduced_letters
  Join the characters in reduced_letters and return
=end
def collapse(input)
  reduced_letters = []
  arr_char = input.chars
  arr_char.each do |letter|
    reduced_letters << letter if reduced_letters.last != letter
  end
  reduced_letters.join
end

# Watch Others Code, Part 1
=begin
Problem
  Given a non-empty string, check if it can be constructed with a substring of it and appending multiple copies of that substring together. You may assume that the string contains lowercase English letters only.

  Input
    String object

  Output
    Boolean

  Rules
    String is lowercase English letters only
    Input string is not empty
    Our substring can be a single character

Examples
  repeated_substring_pattern('abab') == true
  repeated_substring_pattern('aaa') == true
  repeated_substring_pattern('aba') == false
  repeated_substring_pattern('aabaaba') == false
  repeated_substring_pattern('abaababaab') == true
  repeated_substring_pattern('abcabcabc') == true

Data Structures
  Array

Algorithm
  Break up input into an array of letters (arr_char)
  Take a n-sized chunk of arr_char
  Look at the length of our string (input_length)
  Calculate the 'multiplier' variable (input_length / n)
  Check if multiplier * chunk (joined together) == string
    return true if it does
  Otherwise, increment n
    Repeat
  Break if n > input_length / 2
=end
def repeated_substring_pattern(input)
  end_idx = 0
  input_length = input.length
  arr_char = input.chars
  loop do 
    multiplier = input.length / arr_char[0..end_idx].length
    return true if arr_char[0..end_idx].join * multiplier == input
    end_idx += 1
    return false if end_idx == input.length - 1
  end
end

# Watch Others Code, Part 1
=begin
Problem
  Given an array of strings only made of lowercase letters, return an array of all characters that show up in all strings within the given array (including duplicates).

  Input
    An array of string objects

  Output
    An array of single length string objects

  Rules
    We have to count letters that appear multiple times in each string (i.e. duplicates)

Examples
  common_chars(['bella', 'label', 'roller']) == ['e', 'l', 'l']
  common_chars(['cool', 'lock', 'cook']) == ['c', 'o'] 
  common_chars(['hello', 'goodbye', 'booya', 'random']) == ['o'] 
  common_chars(['aabbaaaa', 'ccdddddd', 'eeffee', 'ggrrrrrr', 'yyyzzz']) == [] 

Data Structures
  Array

Algorithm
  Initialise an empty array (common)
  Duplicate our array (arr_dup)
  We want to remove the first element of our array (compare)
  Break up compare into an array of characters
  Iterate through these characters
    Check if that character is contained within all the other elements in arr_dup
    If yes
      Append that letter to common
      Delete that letter from each word in arr_dup
  Return common
=end
def common_chars(input)
  common = []
  arr_dup = input.map { |word| word.dup }
  compare = arr_dup.shift
  compare.chars.each do |letter|
    if arr_dup.all? { |word| word.include?(letter) }
      common << letter
      arr_dup.each { |word| word.sub!(letter, '') }
    end
  end
  common
end

# Watch Others Code, Part 3
=begin
Problem
  Find the maximum sum of a contiguous subsequence in an array of integers. If the entire array consists of negative numbers, return 0. If the entire array is positive, sum all the digits.
  max_sequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
  Should be 6: [4, -1, 2, 1]

  Input
    Array (could be empty, integer objects, positive or negative)
  
  Output
    Integer object

  Rules
    If the entire array is negative numbers, return 0
    If the entire array is positive numbers, we can sum up all the elements
    Contiguous means we have to preserve the order of our array

Examples
  max_sequence([]) == 0
  max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
  max_sequence([11]) == 11
  max_sequence([-32]) == 0
  max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12

Data Structures
  Array

Algorithm
  Initialise an empty array called sums
  Initialise a start_idx (0)
  Initialise an end_idx (0)

  Check if all elements are negative
    If they are, return 0
  We iterate through input array, at input[start_idx..end_idx]
  We sum the elements, append to sums, if it's larger than the largest item in sums, and if start_idx >= end_idx
  Increment end_idx - loop through the rest of the array
  Then, increment start_idx + 1
  Set end_idx to start_idx

  We return the max of sums
=end
def max_sequence(input)
  sums = []
  start_idx = end_idx = 0

  return 0 if input.all? { |element| element < 0 }

  loop do 
    break if start_idx > input.length - 1
    loop do 
      break if end_idx > input.length - 1
      sums << input[start_idx..end_idx].reduce(:+) if start_idx <= end_idx
      end_idx += 1
    end
    start_idx += 1
    end_idx = start_idx
  end

  sums.max
end

# Watch Others Code, Part 3
=begin
Problem
  Write a method to find the largest common prefix amongst an array of strings. If there is no common prefix, return an empty string. All given inputs are in lowercase letters a-z.

  Input
    An array of string objects which are all lowercase, a-z
  
  Output
    A string object

  Rules
    If the first letter of each item is not the same, return empty string

Examples
  common_prefix(['flower', 'flow', 'flight']) == 'fl'
  common_prefix(['dog, 'racecar', 'car']) == ''
  common_prefix(['interspecies', 'interstellar', 'interstate']) == 'inters'
  common_prefix(['throne', 'dungeon']) == ''

Data Structures
  Array

Algorithm
  Initialise an empty array (common_letters)
  Duplicate our input array (arr_dup)
  Remove the first element of our arr_dup (comparer)
  Iterate through letters of comparer, with the index
    if the letter is contained in each of the other words in the array at the same index
      Append that letter to common_letters
  Check if common_letters is empty
      If yes, return empty string
      Otherwise, return joined array
=end
def common_prefix(input)
  common_letters = []
  arr_dup = input.map { |word| word.dup }
  comparer = arr_dup.shift
  comparer.chars.each_with_index do |letter, idx|
    common_letters << letter if arr_dup.all? { |word| word[idx] == letter }
  end
  common_letters.empty? ? '' : common_letters.join
end

# Watch Others Code, Part 4
=begin
Problem
  Given 2 strings, your job is to find out if there is a substring that appears in both strings. You will return true if you find a substring that appears in both strings, or false if you do not. We only care about substrings that are longer than one letter.

  Input
    Two string objects

  Output
    Boolean

  Rules
    Either or both string object could be empty (return false if this is the case)
    Substrings are case insensitive
    Substring order does not matter

Examples
  substring_test('Something', 'Fun') == false
  substring_test('Something', 'Home') == true
  substring_test('Something', '') == false
  substring_test('', 'Something') == false
  substring_test('BANANA', 'banana') == true
  substring_test('test', '111t') == false
  substring_test('', '') == false
  substring_test('1234567', '541265') == true
  substring_test('supercalifragilisticexpialidocious', 'SoundOfItIsAtrociou') == true

Data Structures
  Arrays

Algorithm
  Given two string input objects (str1 and str2)
  return false if str1 or str2 is empty
  Downcase both
  Break both str1 and str2 into array of characters (str1_arr, str2_arr)
  Iterate through the longer string array
    If the letter occurs in str2_arr, delete that letter from str2_arr
      str2_arr.delete_at(str2_arr.index(letter))
  Check if str2 is empty?
    If it is, return true
    Otherwise, return false
=end
def substring_test(str1, str2)
  common_chars = []
  return false if str1.empty? || str2.empty?
  str1_arr, str2_arr = str1.downcase.chars, str2.downcase.chars
  str1_arr.each do |letter|
    if str2_arr.include?(letter)
      common_chars << letter
      str2_arr.delete_at(str2_arr.index(letter)) 
    end
  end
  common_chars.length > 2
end

# Watch Others Code, Part 4
=begin
Problem
  Write a method scramble(str1, str2) that returns true if a portion of str1 characters can be rearranged to match str2, otherwise return false. Only lowercase alphabetic characters will be used (no punctuation or digits).

  Input
    Two string objects

  Output
    Boolean

  Rules
    Only lowercase alphabetic characters will be used (no punctuation or digits).
    See if str2 characters occur in str1
    Order of strings does not matter

Examples
  scramble('javaass', 'jjss') == false
  scramble('rkqodlw', 'world') == true
  scramble('cedewaraaossoqqyt', 'codewars') == true
  scramble('katas', 'steak') == false
  scramble('scriptjava', 'javascript') == true
  scramble('scriptingjav', 'javascript') == false

Data Structures
  Arrays

Algorithm
  Break up str1 and str2 into arrays of characters (str1_arr, str2_arr)
  Initialise an empty array (common_chars)
  We want to iterate through str2_arr, character by character (each)
    If str1_arr includes a given character, 
      Append that letter to common_chars
      delete that character from str1_arr
  Join common_chars, test for equality with str2
=end
def scramble(str1, str2)
  str1, str2 = 'cedewaraaossoqqyt', 'codewars'
  common_chars = []
  str1_arr, str2_arr = str1.chars, str2.chars
  str2_arr.each do |letter|
    if str1_arr.include?(letter)
      common_chars << letter
      str1_arr.delete_at(str1_arr.index(letter))
    end
  end
  common_chars.sort == str2_arr.sort
end

# Watch Others Code, Part 5
=begin
Problem
  Find the length of the longest substring in the given string, that is the same in reverse. If the length of the input string is 0, return 0.

  Input
    String object (but could be empty)

  Output
    Integer object

  Rules
    If the length of the input string is 0, return 0.
    There is no minimum substring length (other than 0)
    Returning the longest palindrome

Examples
  longest_palindrome('a') == 1
  longest_palindrome('aa') == 2
  longest_palindrome('aab') == 2
  longest_palindrome('baa') == 2
  longest_palindrome('baabcd') == 4
  longest_palindrome('baablkj12345432133d') == 9

Data Structures
  String

Algorithm
  Given an input string (input)
  REturn 0 if input is empty
  Initialise an array (longest_sub) with 1 in it
  Iterate through the characters of input
    Initialise a variable called start_idx and end_idx (both 0)
    Start from input[0..0]
    Check if this indexed selection is equal to it's reverse
      If yes, append the length of this indexed selection to longest_sub (array) if it's larger than the largest item in longest_sub 
    Increment end_idx until you finish looping through the string (i.e. end_idx reaches the end of the string)
    Once this has finished, increment start_idx, and reassign end_idx to start_idx
    Break this loop once start_idx reaches the end of the string
=end
def longest_palindrome(input)
  return 0 if input.empty?
  longest_sub = [1]
  start_idx = end_idx = 0
  loop do
    break if start_idx > input.length - 1
    loop do 
      break if end_idx > input.length - 1 
      if input[start_idx..end_idx] == input[start_idx..end_idx].reverse
        longest_sub << input[start_idx..end_idx].length if input[start_idx..end_idx].length > longest_sub.max
      end
      end_idx += 1
    end
    start_idx += 1
    end_idx = start_idx
  end
  longest_sub.max
end
