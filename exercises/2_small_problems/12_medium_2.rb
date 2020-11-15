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