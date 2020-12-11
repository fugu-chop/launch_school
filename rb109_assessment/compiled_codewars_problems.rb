# 1) https://www.codewars.com/kata/5808ff71c7cfa1c6aa00006d/train/ruby
=begin
Problem
Count lowercase letters in a given string and return the letter count in a hash with 'letter' as key and count as 'value'. The key must be 'symbol' instead of string in Ruby.
  Questions
    Will the string be empty?
    Do we need to sort our hash?
  Inputs
    String
  Outputs
    Hash
  Rules/Requirements
    Keys must be symbols
    Values must be integer objects
    We must return a hash

Examples
  letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
  letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
  letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}

Data Structures
  String input
  Integers as values
  Hash output

Algo
  We need to break up our string into an array so we can iterate through it (string_arr)
  
  We initialise an empty hash (letter_hash), testing for whether the letter being passed to the block exists as a key in the hash (note we'll need to convert the letter from string to symbol)
    # if it exists, increment the value by 1
    # If it doesn't exist, create a key-value pair, with the key being a symbol, and the value being 1 (integer object)
  
  Return the hash object
=end

def letter_count(string)
  string.chars.each_with_object({}) do |letter, hash|
    hash.keys.include?(letter.to_sym) ? hash[letter.to_sym] += 1 : hash[letter.to_sym] = 1
  end
end

# 2) https://www.codewars.com/kata/5c55ad8c9d76d41a62b4ede3/train/ruby
=begin
Problem
You are given array of integers, your task will be to count all pairs in that array and return their count.
  
  Inputs
    An array of integers

  Outputs
    Integer object (count of pairs in the array)

  Rules/Requirements
    Arrays could be empty or only contain a single number. If this is the case, return 0
    If there are more pairs of a certain number, count each pair only once. E.g.: for [0, 0, 0, 0] the return value is 2 (= 2 pairs of 0s)

Examples
pairs([1, 2, 5, 6, 5, 2]) == 2
pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) == 4
pairs([0, 0, 0, 0, 0, 0, 0]) == 3 
pairs([1000, 1000]) == 1
pairs([]) == 0
pairs([54]) == 0

Data Structures
  Array input
  Integer output
  Array as an intermediate step?

Algo
  We need to iterate through our array
  We return 0 if the array.length < 2
  We should select all elements that have a count of < 2 
  This will return an array of all the numbers with > 1 count (pairs)
  How do we deal with test case 2 & 3? 
  We can create a hash with counts of all the numbers with more than a pair
  We then map over an array of the hash values (hash_values)
    If the number is odd, we subtract 1 and divide by two
    If the number is even, divide by two
    Sum up the remaining array
=end

def pairs(nums)
  return 0 if nums.length < 2
  pairs = nums.select { |num| nums.count(num) > 1 }

  return 0 if pairs.empty?
  counts = pairs.each_with_object({}) do |number, hash|
    hash.keys.include?(number) ? hash[number] += 1 : hash[number] = 1
  end

  counts.values.map do |count|
    count.even? ? count / 2 : (count - 1) / 2
  end.reduce(:+)
end

# 3) https://www.codewars.com/kata/5168b125faced29f66000005/train/ruby
=begin
Problem
  Complete the solution so that it returns the number of times the search_text is found within the full_text. 

  Inputs
    A string

  Outputs
    An integer object

  Questions
    The example looks like the string could have non-alphanumeric characters in it - do we have to remove this?
    Will our input string contain non-alphanumeric string objects?

  Rules/reqs
    We need to account for the search_text showing up multiple times in the full_text


Examples
  solution('abcdeb','b') == 2
  solution('abcdeb', 'a') == 1
  solution('abbc', 'bb') == 1

Data Structures
  An array for iterating through

Algo
  Get our search string (search_text) and find it's length
  Convert our full_text into an array so we can iterate through it (full_text_arr)
  Take search_text.length slices out of the full_text_arr
  Increment a variable every time we have a match (matches)
  Return matches
=end
def solution(full_text, search_text)
  search_length = search_text.length
  matches = 0
  full_text.chars.each_cons(search_length) do |segment|
    matches += 1 if segment.join == search_text
  end
  matches
end

# 4) https://www.codewars.com/kata/59d9ff9f7905dfeed50000b0
=begin
Problem
  Given an array of words, return an array of the number of letters that occupy their positions in the alphabet for each word.

  Inputs
    An array, where elements are strings

  Outputs
    An array of integers

  Questions
    Can the array be empty?

  Rules/reqs

Examples
  solve(["abode","ABc","xyzD"]) == [4,3,1]
  solve(["abide","ABc","xyz"]) == [4,3,0]
  solve(["IAMDEFANDJKL","thedefgh","xyzDEFghijabc"]) == [6,5,7]
  solve(["encode","abc","xyzD","ABmD"]) == [1, 3, 1, 3]

Data Structures
  Array (that's what we'll return, and what we need to iterate through)
  Hash (to capture the positions of letters in the alphabet)

Algo
  Initialise a hash, where the letters are the keys, and the values are the position in the alphabet (alphabet) - we can go from 0 to 25 to match index numbering
  Iterate through our input array (arr)
    iterate through each letter of word (downcase it), with an index
      if the index of the letter == hash[letter], increment a counter (counter)
    push our counter value to an array (output_arr)
    reset our counter
=end
def solve(arr)
  alphabet = ('a'..'z').zip(0..25).to_h
  output_arr = []
  arr.each do |word|
    counter = 0
    word.downcase.chars.each_with_index do |letter, index|
      counter += 1 if alphabet[letter] == index
    end
    output_arr << counter 
  end
  output_arr
end

# 5) https://www.codewars.com/kata/59c5f4e9d751df43cf000035/train/ruby
=begin
Problem
  The vowel substrings in the word codewarriors are o,e,a,io. The longest of these has a length of 2. Given a lowercase string that has alphabetic characters only (both vowels and consonants) and no spaces, return the length of the longest vowel substring. Vowels are any of aeiou. 

  Inputs
    String input

  Outputs
    INteger object

  Rules/Reqs
    String input with no spaces, alphabetic characters only. Lowercase only
    Must contain a vowel?

Examples
  solve("codewarriors") == 2
  solve("suoidea") == 3
  solve("iuuvgheaae") == 4
  solve("ultrarevolutionariees") == 3
  solve("strengthlessnesses") == 1
  solve("cuboideonavicuare") == 2
  solve("chrononhotonthuooaos") == 5
  solve("iiihoovaeaaaoougjyaw") == 8

Data Structures
  Array to iterate through our string?

Algo
  Convert our string to an array
  Iterate through our string
  Check if the start_index equals a vowel
    # If yes, increment a counter (vowel_count)
      # check if next index is a vowel
        # If yes, continue to increment vowel_count
        # If no, 
            push vowel_count to vowel_lengths array,
            Reset vowel_count
    # If no increment start_index
=end
def solve(string)
  start_index = 0
  counter = 0
  counter_storage = []
  loop do
    break counter_storage << counter if start_index == string.length
    p string[start_index]
    if 'aeiou'.include?(string[start_index])
      counter += 1
    else
      counter_storage << counter
      counter = 0
    end
    start_index += 1
  end
  counter_storage.max
end