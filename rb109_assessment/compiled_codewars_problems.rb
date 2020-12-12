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

# 6) 
=begin
Problem
  Given a string of integers, return the number of odd-numbered substrings that can be formed. For example, in the case of "1341", they are 1, 1, 3, 13, 41, 341, 1341, a total of 7 numbers. 

  Inputs
    A string of integers

  Outputs
    An integer object

  Rules
    We are taking substrings, so we need to preserve the order of the numbers in which they appear (e.g. in the above example 431 is not a listed odd number).
    Individual odd numbers "don't have to align to order" - e.g. in our example above, 1 appears twice, despite the second 1 appearing as the last element in the array.

  Questions
    Do we have to deal with empty strings? Strings that contain no numbers?

Examples
  solve("1341") == 7
  solve("1357") == 10
  solve("13471") == 12
  solve("134721") == 13
  solve("1347231") == 20
  solve("13472315") == 28

Data Structures
  We probably want to iterate through an array to check if numbers are odd

Algorithm
  We need to break up our input string object into an array of digits (digit_arr)
  We then need to iterate through this array
    We start from the first digit, check if it's odd (converting it to an integer along the way)
      If it's odd, append it to an array (odd_arr)
      If not, continue looping
    We then capture the first and second digits (probably with index notation), convert this to a integer
      We'll use 'end_index', which will be initialised as the integer as start_index initially
      Repeat above steps.
    We continue capturing more digits, until we reach the length of the digit_arr
    We then change our starting index (start_index) to 1, and then repeat the above
    We then check the length of our odd_arr, returning it. 
=end

def solve(num_string)
  odd_arr = []
  start_index = 0
  end_index = 0
  digit_arr = num_string.chars
  loop do
    break if end_index == digit_arr.length
    loop do
      break if end_index == digit_arr.length
      odd_arr << digit_arr[start_index..end_index].join if digit_arr[start_index..end_index].join.to_i.odd?
      end_index += 1
    end
    start_index += 1
    end_index = start_index
  end
  odd_arr.length
end

# 7) https://www.codewars.com/kata/565b112d09c1adfdd500019c/train/ruby
=begin
Problem
  Complete the function that takes an array of words. You must concatenate the nth letter from each word to construct a new word which should be returned as a string, where n is the position of the word in the list.

  Input
    Array of strings (could be empty)

  Output
    A string (could be empty)

  Rules
    Test cases contain valid input only - i.e. a string array or an empty array; and each word will have enough letters.

Examples
  nth_char(['yoda', 'best', 'has']) == 'yes'
  nth_char([]) == ''
  nth_char(['X-ray']) == 'X'
  nth_char(['No', 'No']) == 'No'
  nth_char(['Chad', 'Morocco', 'India', 'Algeria', 'Botswana', 'Bahamas', 'Ecuador', 'Micronesia']) == 'Codewars'

Data Structures
  Input is an array, which we'll have to iterate through

Algo
  Our input array (input), iterate through this (map)
  On each iteration, we need to reference the index
  We take the index of our word that's passed to the block
  Afterwards, we join the mapped array back together (return this)
=end

def nth_char(input)
  input.map.with_index do |word, index|
    word[index]
  end.join
end

# 8) https://www.codewars.com/kata/5491689aff74b9b292000334/train/ruby
=begin
Problem
  For a given nonempty string s find a minimum substring t and the maximum number k, such that the entire string s is equal to t repeated k times. The input string consists of lowercase latin letters. Your function should return an array, [t, k].

  Input
    A string

  Output
    An array of two elements
      the first element is a string
      2nd element is an integer

  Rules
    Our input string is not empty
    If the substring cannot be repeated, return the string, and 1


Examples
  f("ababab") == ["ab", 3]
  f("abcde") == ["abcde", 1]

Data Structures
  Our input will be string
  Our output will be a string
  We'll probably ned to iterate through the input string, so we'll need to use another array

Algo
  We should iterate through our string (input)
  We can grab a substring using indexing, starting at 0, ending at 1 (minimum substring length)
    input[0..substr_length]
    if input[0..substr_length] * input / input[0..substr_length].length == input[0..substr_length], push it to the success_arr
=end
def f(input)
  success_arr = [[input, 1]]
  substr = 2
  loop do
    break if input[0...(input.length / substr)].length == 1
    success_arr << [input[0...(input.length / substr)], substr] if input[0...(input.length / substr)] * substr == input
    substr += 1
  end
  success_arr.last
end

def f(input)
  substr_length = 1
  length = (input.length / input[0..substr_length].length)
  loop do
    break [input, 1] if substr_length == input.length - 1
    return [input[0..substr_length], length] if input[0..substr_length] * length == input
    substr_length += 1
    length = (input.length / input[0..substr_length].length)
  end
end

# 9) https://www.codewars.com/kata/55953e906851cf2441000032/train/ruby
=begin
Problem
  Return a string where:
  1) the first and last characters remain in original place for each word
  2) characters between the first and last characters must be sorted alphabetically
  3) punctuation should remain at the same place as it started, for example: shan't -> sahn't

  Input
    A string

  Output
    A string

  Rules
    words are seperated by single spaces
    only spaces separate words, special characters do not,
    special characters do not take the position of the non special characters
    puctuation is limited to 4 characters: hyphen(-), apostrophe('), comma(,) and period(.) 
    ignore capitalisation
    We could have single letter or empty strings

Examples
  scramble_words('professionals') == 'paefilnoorsss'
  scramble_words('i') == 'i'
  scramble_words('') == ''
  scramble_words('me') == 'me'
  scramble_words('you') == 'you'
  scramble_words('card-carrying') == 'caac-dinrrryg'
  scramble_words("shan't") == "sahn't"
  scramble_words('-dcba') == '-dbca'
  scramble_words('dcba.') == 'dbca.'
  scramble_words("you've gotta dance like there's nobody watching, love like you'll never be hurt, sing like there's nobody listening, and live like it's heaven on earth.") == "you've gotta dacne like teehr's nbdooy wachintg, love like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like it's haeevn on earth."

Data Structures
  We will need to iterate through our string, so we need an array

Algo
  We're given a string
  We should split this via spaces, into an array (so the code can handle multiple words)
  On each iteration, we have a word
    We should only sort letters in between the first and last letter, so we can handle this by indexing [1...-1]
  # We need to sort the remaining characters, alphabetically
    # We need to convert remaining characters to an array to sort them
    # We need to deal with punctuation - how?

=end
def scramble_words(words)
  words.split(' ').map { |word| scramble(word) }.join(' ')
end

def scramble(word)
  chars = word.chars
  letters = chars.select { |char| letter?(char) }
  scrambled_letters = scramble_letters(letters.join).chars
  chars.map do |char|
    letter?(char) ? scrambled_letters.shift : char
  end
    .join
end

def scramble_letters(word)
  return word if word.length <= 2
  
  word[0] + word[1...-1].chars.sort.join + word[-1]
end

def letter?(char)
  char.match? /[a-z]/
end

# 10) https://www.codewars.com/kata/51e056fe544cf36c410000fb/train/ruby
=begin
Problem
  Write a function that, given a string of text (possibly with punctuation and line-breaks), returns an array of the top-3 most occurring words, in descending order of the number of occurrences.

  Input
    A string

  Output
    An array, of three string objects

  Rules
    Matches should be case-insensitive, and the words in the result should be lowercased.
    Ties may be broken arbitrarily.
    If a text contains fewer than three unique words, then either the top-2 or top-1 words should be returned, or an empty array if a text contains no words.

Examples
  top_3_words("a a a  b  c c  d d d d  e e e e e") == ["e", "d", "a"]
  top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e") == ["e", "ddd", "aa"]
  top_3_words("  //wont won't won't ") == ["won't", "wont"]
  top_3_words("  , e   .. ") == ["e"]
  top_3_words("  ...  ") == []
  top_3_words("  '  ") == []
  top_3_words("  '''  ") == []
  top_3_words(In a village of La Mancha, the name of which I have no desire to call to mind, there lived not long since one of those gentlemen that keep a lance in the lance-rack, an old buckler, a lean hack, and a greyhound for coursing. An olla of rather more beef than mutton, a salad on most nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra on Sundays, made away with three-quarters of his income.) == ["a", "of", "on"]

Data Structures
  Need to work with an array
  Hash?

Algo
  We need to split up our input string into 'words' - i.e. we define 'words' as integer objects separated by spaces
  Once we have our words, we need to verify:
    Is it a word? i.e. does it contain at least one alphabetic character? (e.g. see test case 5)
      # If not, we just return an empty array
    Once we've verified it's an actual word, we need to strip out any non-alphabetic characters from the start or end of the word - see test case 2

    Helper method
      We could iterate through the word
      If the start of the word is non-alphabetical, move to the next character, incrementing an index (this is where we know to start capturing the word)
      Break this iterator once we hit an alphabetical character
      We do the same thing, but iterate from the end of the string
      We return the word, cleaned of trailing/leading punctuation

    Once we've removed all the trailing/starting punctuation, we then count the number of times a word occurs in the word array (possibly via a hash)
    We return the top three hash keys as assessed by the maximum three values
=end
def cleaner(word)
  start_index = 0
  word.chars.each do |letter|
    if letter.downcase.match(/[a-z]/)
      break
    else
      start_index += 1
    end
  end

  end_index = -1
  word.chars.reverse.each do |letter|
    if letter.downcase.match(/[a-z]/)
      break
    else
      end_index -= 1
    end
  end

  word[start_index..end_index]
end

def top_3_words(sentence)
  clean_sentence = sentence.split.map do |word|
    cleaner(word).downcase
  end.select { |word| !word.empty? }

  word_counts = clean_sentence.each_with_object({}) do |word, hash|
    hash.keys.include?(word) ? hash[word] += 1 : hash[word] = 1
  end

  word_counts.keys.max_by(3) { |key| word_counts[key] }
end

# 11) https://www.codewars.com/kata/514a024011ea4fb54200004b/train/ruby
=begin
Problem 
  Write a function that when given a URL as a string, parses out just the domain name and returns it as a string.

  Input
    A string

  Output
    A string

  Rules
    The domain name will be preceeded by 'http://', 'www.' or 'https://'
    The domain name will always be following by '.x'

Examples
  domain_name("http://google.com") == "google"
  domain_name("http://google.co.jp") == "google"
  domain_name("www.xakep.ru") == "xakep"
  domain_name("https://youtube.com") == "youtube"

Data Structure
  An array, 

Algo
  Take our input string (url)
  split on a number of possible fields 
    'w.'
    '//
    .
  Create an array of delimiters
  Iterate through this array of delimiters
    We want to save our split url to split_url
    ON each iteration, we want to split the split_url by the delimiter, rewriting the variable each time
    In The returned array, the domain should exist at index 1
    We then delimit again by '.', which should leave the clean domain at index 0
=end
def domain_name(url)
  delimiters = ['www.', 'https://', 'http://', 'http://www.', 'https://www.']
  leading_removed = delimiters.map do |delimiter|
    url.split(delimiter) if url.include?(delimiter)
  end.compact.flatten.last

  leading_removed == nil ? url.split('.').first : leading_removed.split('.').first
end

# 12) https://www.codewars.com/kata/545cedaa9943f7fe7b000048/train/ruby
=begin
Problem
  Given a string, detect whether or not it is a pangram.

  Input
    String

  Output
    Boolean (true if string is a pangram)

  Rules
    A pangram is a sentence that contains every single letter of the alphabet at least once.

Examples
  panagram?("The quick brown fox jumps over the lazy dog.") == true
  panagram?("This is not a pangram.") == false

Data Structures
  Array
  Hash

Algo
  We break up our input string into an array for iteration
  We iterate through this array of letters, counting how many times a letter appears (each_with_object)
  We then have a comparison array of 'a' to 'z' (alphabet)
  We take the keys of our hash and compare to alphabet (returning a boolean)
=end
def panagram?(sentence)
  alphabet = ('a'..'z').to_a
  sentence = sentence.downcase.split
  letter_count = sentence.each_with_object({}) do |word, hash|
    word.chars.each do |letter|
      hash.keys.include?(letter) ? hash[letter] += 1 : hash[letter] = 1 if alphabet.include?(letter)
    end
  end

  letter_count.keys.sort == alphabet
end

# 13) https://www.codewars.com/kata/57f8ff867a28db569e000c4a/train/ruby
=begin
Problem
  Modify the kebabize function so that it converts a camel case string into a kebab case.

  Input
    A string
  
  Output
    A string
  
  Rules
    Kebab case has all lowercase words, where each word is separated by a dash
    Numbers are removed

Examples
  kebabize('myCamelCasedString') == 'my-camel-cased-string'
  kebabize('myCamelHas3Humps') == 'my-camel-has-humps'

Data Structures
  String
  Array

Algo
  We need to remove all numbers from our string (string_clean)
  Once we've removed numbers, we need to iterate through (string_clean), converting our string to an array of characters
  We'll want to iterate through these characters, checing if each character is lowercase (map)
    # check if n = n.downcase
    # if it's lowercase, next
    # if it's uppercase, replace with '-' and lowercase version of the string
  # Map will return an array of strings, which we can join (return this)
=end
def kebabize(input)
  string_clean = input.chars.reject do |letter|
    !('a'..'z').include?(letter.downcase)
  end.join

  (string_clean[0] + string_clean[1..-1].chars.map do |character|
    character == character.downcase ? character : "-#{character}"
  end.join).downcase
end

# 14) https://www.codewars.com/kata/551dc350bf4e526099000ae5/train/ruby
=begin
Problem
  We're given a string, and we have to replace any instances of 'WUB' with a single space

  INput
    String

  Output
    String

  Rules
    If there are multiple WUBs, we only have a single space (not one for each WUB)

Examples
  song_decoder("AWUBBWUBC") == "A B C"
  song_decoder("AWUBWUBWUBBWUBWUBWUBC") == "A B C"
  song_decoder("WUBAWUBBWUBCWUB") == "A B C"

Data Structures
  String

Algo
  We want to take our string, and replace 'WUB' with a ' '.
  We can then squeeze any duplicate spaces to return a single space
=end
def song_decoder(string)
  new_string = string.gsub('WUB', ' ').squeeze(' ').strip
end

# 15) https://www.codewars.com/kata/54da539698b8a2ad76000228/train/ruby
=begin
Problem
We need to establish whether all of the directions in our array, will return us to our starting direction, but also if there are 10 elements in the array

  Input
    Array of string elements

  Output
    Boolean

  Rules
    We can only walk in 4 directions
    Each direction takes one minute
    Array won't be empty
    There must be 10 elements in the array (otherwise you'll be early or late)
    The count of each direction must be equal (otherwise you won't end up where you started)

Examples
is_valid_walk(['n','s','n','s','n','s','n','s','n','s'] == true
is_valid_walk(['w','e','w','e','w','e','w','e','w','e','w','e'] == false
is_valid_walk(['w']) == false  
is_valid_walk(['n','n','n','s','n','s','n','s','n','s']) == false

Data Structures
  Our input is an array
  A hash, so we can keep track of the counts of our directions

Algo
  First, check if the array is 10 elements. If not, just return false straight away. 
  Otherwise, we need to iterate through our array of directions.
  We will initialise a hash and use the directions as keys, incrementing the values for each time it occurs
  We then check if the values of n == s, e == w
=end
def is_valid_walk(directions)
  return false if directions.length != 10
  direction_count = directions.each_with_object({}) do |direction, hash|
    hash.keys.include?(direction) ? hash[direction] += 1 : hash[direction] = 1
  end

  direction_count['n'] == direction_count['s'] && direction_count['e'] == direction_count['w']
end
