# 1) Write a program that reads the content of a text file and then prints the longest sentence in the file based on number of words. Sentences may end with periods (.), exclamation points (!), or question marks (?). Any sequence of characters that are not spaces or sentence-ending characters should be treated as a word. You should also print the number of words in the longest sentence.
def text_reader
  text = File.read('sample_text.txt')
  sentences = text.split(/\.|\?|!/)
  largest_sentence = sentences.max_by { |sentence| sentence.split.size }
  largest_sentence = largest_sentence.strip
  number_of_words = largest_sentence.split.size

  puts "#{largest_sentence}"
  puts "Containing #{number_of_words} words"
end

# 2) Write a method that returns true if the word passed in as an argument can be spelled from this set of blocks, false otherwise. This limits the words you can spell with the blocks to just those words that do not use both letters from any given block. Each block can only be used once.
=begin
B:O   X:K   D:Q   C:P   N:A
G:T   R:E   F:S   J:W   H:U
V:I   L:Y   Z:M
=end
=begin
block_word?('BATCH') == true
block_word?('BUTCH') == false
block_word?('jest') == true
=end
def block_word?(string)
  eligible_pairs = [['b', 'o'], ['x', 'k'], ['d', 'q'], ['c', 'p'], ['n', 'a'], ['g', 't'], 
                    ['r', 'e'], ['f', 's'], ['j', 'w'], ['h', 'u'], ['v', 'i'], ['l', 'y'], 
                    ['z', 'm']]
  character_array = string.downcase.chars
  matched_letters = []

  character_array.each do |letter|
    eligible_pairs.each do |pair|
      if pair.include?(letter)
        matched_letters << letter
        eligible_pairs.delete(pair)
      end
    end
  end

  matched_letters.join == string.downcase
end

# Suggested solution
def block_word?(string)
  blocks = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze
  up_string = string.upcase
  blocks.none? { |block| up_string.count(block) >= 2 }
end

# 3) Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the percentage of characters in the string that are lowercase letters, one the percentage of characters that are uppercase letters, and one the percentage of characters that are neither. You may assume that the string will always contain at least one character.
=begin
letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }
=end
def letter_percentages(string)
  string_contents = { uppercase: 0,
                      lowercase: 0,
                      neither: 0
  }
  uppercase_letters = ('A'..'Z').to_a
  lowercase_letters = ('a'..'z').to_a
  string_array = string.chars
  string_length = string_array.size

  string_array.each do |letter|
    if uppercase_letters.include?(letter)
      string_contents[:uppercase] += 1
    elsif lowercase_letters.include?(letter)
      string_contents[:lowercase] += 1
    else
      string_contents[:neither] += 1
    end
  end

  string_contents.each { |key, value| string_contents[key] = 100 * value / string_length.to_f}
  
  string_contents
end

# 4) Write a method that takes a string as argument, and returns true if all parentheses in the string are properly balanced, false otherwise. To be properly balanced, parentheses must occur in matching '(' and ')' pairs. Note that balanced pairs must each start with a (, not a ).
=begin
balanced?('What (is) this?') == true
balanced?('What is) this?') == false
balanced?('What (is this?') == false
balanced?('((What) (is this))?') == true
balanced?('((What)) (is this))?') == false
balanced?('Hey!') == true
balanced?(')Hey!(') == false
balanced?('What ((is))) up(') == false
=end
def balanced?(string)
  string.chars.count('(') == string.chars.count(')')
end

# 5) Write a method that takes the lengths of the 3 sides of a triangle as arguments, and returns a symbol :equilateral, :isosceles, :scalene, or :invalid depending on whether the triangle is equilateral, isosceles, scalene, or invalid.
=begin
A triangle is classified as follows:

  equilateral All 3 sides are of equal length
  isosceles 2 sides are of equal length, while the 3rd is different
  scalene All 3 sides are of different length

To be a valid triangle, the sum of the lengths of the two shortest sides must be greater than the length of the longest side, and all sides must have lengths greater than 0: if either of these conditions is not satisfied, the triangle is invalid.
=end
=begin
triangle(3, 3, 3) == :equilateral
triangle(3, 3, 1.5) == :isosceles
triangle(3, 4, 5) == :scalene
triangle(0, 3, 3) == :invalid
triangle(3, 1, 1) == :invalid
=end
def triangle(side1, side2, side3)
  sides = [side1, side2, side3].sort
  return :invalid if sides[0] + sides[1] <= sides[2]
  return :equilateral if sides[0] == sides[1] && sides[2] == sides[0] && sides[1] == sides[0]
  return :scalene if sides[0] != sides[1] && sides[0] != sides[2] && sides[1] != sides[2]
  :isosceles
end

# 6) Write a method that takes the 3 angles of a triangle as arguments, and returns a symbol :right, :acute, :obtuse, or :invalid depending on whether the triangle is a right, acute, obtuse, or invalid triangle.
=begin
A triangle is classified as follows:

    right One angle of the triangle is a right angle (90 degrees)
    acute All 3 angles of the triangle are less than 90 degrees
    obtuse One angle is greater than 90 degrees.

To be a valid triangle, the sum of the angles must be exactly 180 degrees, and all angles must be greater than 0: if either of these conditions is not satisfied, the triangle is invalid.

You may assume integer valued angles so you don't have to worry about floating point errors. You may also assume that the arguments are specified in degrees.
=end
=begin
triangle(60, 70, 50) == :acute
triangle(30, 90, 60) == :right
triangle(120, 50, 10) == :obtuse
triangle(0, 90, 90) == :invalid
triangle(50, 50, 50) == :invalid
=end
def triangle(a, b, c)
  return :invalid if (a + b + c != 180) || [a, b, c].include?(0)
  return :right if [a, b, c].include?(90)
  return :obtuse if [a, b, c].select { |angle| angle > 90 }.size > 0
  :acute
end

# 7) Write a method that returns the number of Friday the 13ths in the year given by an argument. You may assume that the year is greater than 1752 (when the United Kingdom adopted the modern Gregorian Calendar) and that it will remain in use for the foreseeable future.
=begin
friday_13th(2015) == 3
friday_13th(1986) == 1
friday_13th(2019) == 2
=end
require 'date'
def friday_13th(year)
  thirteen_counter = 0
  1.upto(12) do |month|
    thirteen_counter += 1 if Date.new(year, month, 13).friday?
  end
  thirteen_counter
end

# 8) A featured number (something unique to this exercise) is an odd number that is a multiple of 7, and whose digits occur exactly once each. So, for example, 49 is a featured number, but 98 is not (it is not odd), 97 is not (it is not a multiple of 7), and 133 is not (the digit 3 appears twice). Write a method that takes a single integer as an argument, and returns the next featured number that is greater than the argument. Issue an error message if there is no next featured number.
=begin
featured(12) == 21
featured(20) == 21
featured(21) == 35
featured(997) == 1029
featured(1029) == 1043
featured(999_999) == 1_023_547
featured(999_999_987) == 1_023_456_987

featured(9_999_999_999) # -> There is no possible number that fulfills those requirements
=end
def featured(start)
  loop do 
    start += 1
    return start if start % 7 == 0 && start.odd? && start.to_s.chars.uniq.join == start.to_s
    if start >= 9_999_999_999
      puts "No eligible featured numbers."
      break
    end
  end
end

# 9) Write a method that takes an Array as an argument, and sorts that Array using the bubble sort algorithm as just described. Note that your sort will be "in-place"; that is, you will mutate the Array passed as an argument. You may assume that the Array contains at least 2 elements.
=begin
array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
=end
def bubble_sort!(array)
  loop do 
    sort_tracker = 0
    n = 0
    while n < array.size - 1
      case array[n] <=> array[n+1]
      when 1 
        array[n], array[n+1] = array[n+1], array[n]
        sort_tracker += 1
      end
      n += 1
    end
    break if sort_tracker == 0
  end
  array
end
