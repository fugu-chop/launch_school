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

# Study Group Problem
=begin
Problem 
  You have to create a function that takes a positive integer number and returns the next bigger number formed by the same digits.

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
=end

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

Algorithm
  

=end
def common_chars(input)

end