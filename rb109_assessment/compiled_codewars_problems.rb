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

# 6) https://www.codewars.com/kata/59da47fa27ee00a8b90000b4/train/ruby
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

# *9) https://www.codewars.com/kata/55953e906851cf2441000032/train/ruby
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
    # The solution hinges on this particular line. On the original string, if our sorted string doesn't contain that character (in this use case, it can only be a punctuation character), use the character. Otherwise, use the sorted letter (the scrambled_letters don't have any punctuation).
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

# *10) https://www.codewars.com/kata/51e056fe544cf36c410000fb/train/ruby
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

# 16) https://www.codewars.com/kata/5264d2b162488dc400000001
=begin
Problem
  Write a function that takes in a string of one or more words, and returns the same string, but with all five or more letter words reversed (Just like the name of this Kata). Strings passed in will consist of only letters and spaces. Spaces will be included only when more than one word is present.

  Input
    A string

  Output
    A string

  Rules

Examples
  spinWords("Hey fellow warriors") == "Hey wollef sroirraw"

Data Structures
  An array so we can iterate through words in a sentence

Algo
  Convert our sentence into an array of words
  Iterate through our words
    If the legnth of the word is >= 5, reverse the word
    If not, just return the word
  Join the words back together to get a string output
=end
def spinWords(sentence)
  sentence.split.map do |word|
    word.length >= 5 ? word.reverse : word
  end.join(' ')
end

# 17) https://www.codewars.com/kata/5842df8ccbd22792a4000245
=begin
Problem
  You will be given a number and you will need to return it as a string in Expanded Form.

  Input
    Integer object

  Output
    String object

  Rules
    All numbers will be whole numbers greater than 0.
    If a number includes a zero, don't return that

Examples
  expanded_form(12) == '10 + 2'
  expanded_form(42) == '40 + 2'
  expanded_form(70304) == '70000 + 300 + 4'

Data Structure
  Integer
  String
  Array 

Algo
  Break up our integer object into digits (remember that digits reverses the order) - an array
  Capture the length of the digits array (digits_len) - 1
  Map through the array (with index)
    On each iteration, multiply the digit by 10 ** (digits_len - index)
    Convert to string
  Join the resultant array with ' + '
=end
def expanded_form(number)
  digits_idx = number.digits.reverse.length - 1
  number.digits.reverse.map.with_index do |digit, index|
    digit != 0 ? (digit * 10 ** (digits_idx - index)).to_s : nil
  end.compact.join(' + ')
end

# 18) https://www.codewars.com/kata/55bf01e5a717a0d57e0000ec/train/ruby
=begin
Problem
  Write a function, persistence, that takes in a positive parameter num and returns its multiplicative persistence, which is the number of times you must multiply the digits in num until you reach a single digit.

  Input
    Positive integer object

  Output
    >= 0 integer object

  Rules
    We're having to break up the number into it's digits and multiplying them down until the result of multiplying those digits is a single digit. We're keeping track of the number of times we have to do this (this is the integer object returned)

Examples
  persistence(39) == 3
  persistence(4) == 0
  persistence(25) == 2
  persistence(999) == 4

Data Structures
  An array, where we keep track of the digits in a number?

Algo
  Initialise a variable, persistence_count = 0
  Return persistence_count if input number (input) < 10 == 0

  Otherwise:
    Increment persistence_count
    Break up our number into digits
    We need to multiply all the digits
    
    Check if the multiplication of those digits is < 10
      If so, return persistence count
      If not, loop through again
      Break the loop once our multiplication result < 10
=end
def persistence(input)
  persistence_count = 0
  loop do
    return persistence_count if input < 10
    persistence_count += 1
    input = input.digits.reverse.reduce(:*)
  end
end

# 19) https://www.codewars.com/kata/5202ef17a402dd033c000009
=begin
Problem
  Write a function that will convert a string into title case, given an optional list of exceptions (minor words). The list of minor words will be given as a string with each word separated by a space. Your function should ignore the case of the minor words string -- it should behave in the same way even if the case of the minor word string is changed.

  Input
    A string to titlecase
    (Optional) String to exclude from titlecasing

  Output
    String

  Rules
    A string is considered to be in title case if each word in the string is either (a) capitalised (that is, only the first letter of the word is in upper case) or (b) considered to be an exception and put entirely into lower case unless it is the first word, which is always capitalised.

Examples
  title_case('') == ''
  title_case('a clash of KINGS', 'a an the of') == 'A Clash of Kings'
  title_case('THE WIND IN THE WILLOWS', 'The In') == 'The Wind in the Willows'
  title_case('the quick brown fox') == 'The Quick Brown Fox'

Data Structures
  An array

Algo
  Check if there is a list of optional (exclusions) (set as boolean) - set up as optional parameter
      If it exists, break up into array of words (downcase)
  Take our list of input strings (input)
    Downcase our string
    Break up into an array of words
      Check if the downcased word appears in the exclusions
        If not, capitalise it
        If so, return the original word
      We end up with a new array of strings
      Capitalise the first word, just in case
      Return the joined array (output string)
=end
def title_case(input, exclusions = '')
  return '' if input.length < 1
  exclusions = exclusions.downcase.split
  input = input.downcase.split.map do |word|
    exclusions.include?(word) ? word : word.capitalize
  end
  input[0].capitalize!
  input.join(' ')
end

# 20) https://www.codewars.com/kata/528d9adf0e03778b9e00067e/train/ruby
=begin
Problem
  Write a function mineLocation that accepts a 2D array, and returns the location of the mine. 

  Input
    An array of subarrays, containing 1's or 0's

  Output
    A single array, with the indexes of the mine (i.e. where the 1 occurs)

  Rules
    The mine is represented as the integer 1 in the 2D array. 
    Areas in the 2D array that are not the mine will be represented as 0s. 
    First element is the row index, and the second element is the column index of the bomb location (both should be 0 based). 
      First number is which subarr
      Second number is which element in that subarr
    All 2D arrays passed into your function will be square (NxN)
    There will only be one mine in the array.

Examples
  mineLocation([ [1, 0], [0, 0] ]) == [0, 0]
  mineLocation([ [1, 0, 0], [0, 0, 0], [0, 0, 0] ]) == [0, 0]
  mineLocation([ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 0] ]) == [2, 2]

Data Structures
  Given an array, also need to output an array

Algo
  We are given our input (minefield)
  Initialise a row_index, col_index variable
  We need to iterate through minefield, with an index
    We pass each subarray to the block
    Test if it contains 1
    If it does, assign the index to a variable (row_index)
  We do the same thing within the index, except with col_index
=end
def mineLocation(minefield)
  row_idx, col_idx = 0, 0
  minefield.each_with_index do |row, idx_row|
    row.each_with_index do |col, idx_col|
      row_idx, col_idx = idx_row, idx_col if row.include?(1) && col == 1
    end
  end
  [row_idx, col_idx]
end

# 21) https://www.codewars.com/kata/55c04b4cc56a697bb0000048/train/ruby
=begin
Problem
  Complete the function scramble(str1, str2) that returns true if a portion of str1 characters can be rearranged to match str2, otherwise returns false.

  Input
    Two strings - one to search through, one 'searcher'

  Output
    Boolean

  Rules
    We return true if the str2 characters are found in str1, otherwise return false
    Each letter of str2 must occur in str1
    Only lower case letters will be used (a-z). 
    No punctuation or digits will be included.
    The character in str1 must occur >= str2

Example
  scramble('rkqodlw','world') == true
  scramble('cedewaraaossoqqyt','codewars') == true
  scramble('katas','steak') == false
  scramble('scriptjava','javascript') == true
  scramble('scriptingjava','javascript') == true
  scramble("scriptjavx", "javascript") == false
  scramble("javscripts", "javascript") == false

Data Structures
  Array

Algo
  Iterate through our str2, by converting it to an array
  Create a duplicate copy of str1 to avoid mutating input (str1_dup)
  ON each iteration, see if the letter is contained in str1
    If yes, remove that character from str1_dup
    If not, return false

=end
def scramble(str1, str2)
  str1_dup = str1.dup.chars
  str2.chars.each do |letter|
    if str1_dup.include?(letter)
      str1_dup.delete_at(str1_dup.index(letter))
    else
      return false
    end
  end
  true
end

# *22) https://www.codewars.com/kata/5a7f58c00025e917f30000f1
=begin
Problem
  Find the longest substring in alphabetical order.

  Input
    String

  Output
    String
  
  Rules
    The input will only consist of lowercase characters and will be at least one letter long.
    If there are multiple solutions, return the one that appears first.

    If a letter is the same as the previous one, that counts as being 'in alphabetical order'
    If nothing is in order, just return the first character
    If there's only one character, just return that character

    I assume that reverse is not alphabetical order

Examples
  longest('asd') == 'as'
  longest('nab') == 'ab'
  longest('abcdeapbcdef') == 'abcde'
  longest('asdfaaaabbbbcttavvfffffdf') == 'aaaabbbbctt'
  longest('asdfbyfgiklag') == 'fgikl'
  longest('z') == 'z'
  longest('zyba') == 'z'

Data Structures
  Array to capture all the strings that occur by alphabet

Algo
  Break up our input string to characters for iteration
  We need some method to compare the alphabetical order
    # We need to replace our letters with their alphabetical number values
    # We need to compare current with next character (each_cons)
      If the current character == next character, or next character is equal to current_character.succ, increment a counter (streak)
      If test condition above isn't met, 
        Append streak to an empty array (streaks)
        reset streak to 0

  Find the max value of streaks array
=end
def longest(string)
  current_substring = ''  
  longest_substring = '' 
  
  string.each_char.with_index do |char, index|
    if index == 0
      current_substring << char
    elsif char >= current_substring[-1]  
      current_substring << char
    else
      longest_substring = current_substring if current_substring.size > longest_substring.size
      current_substring = char
    end
  end

  if current_substring.size > longest_substring.size
    longest_substring = current_substring
  end
  
  longest_substring
end

# 23) https://www.codewars.com/kata/525c65e51bf619685c000059/train/ruby
=begin
Problem
  Write a function cakes(), which takes the recipe (object) and the available ingredients (also an object) and returns the maximum number of cakes Pete can bake (integer). 

  Input
    Two hashes
      One represents the recipe
      One represents the ingredients available

  Output
    An integer object, represneting how many cakes can be baked with the ingredients available

  Rules
    For simplicity there are no units for the amounts (e.g. 1 lb of flour or 200 g of sugar are simply 1 or 200). 
    Ingredients that are not present in the objects, can be considered as 0.

Examples
  cakes({"flour"=>500, "sugar"=>200, "eggs"=>1},{"flour"=>1200, "sugar"=>1200, "eggs"=>5, "milk"=>200}) == 2
  cakes({"cream"=>200, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>1700, "flour"=>20000, "milk"=>20000, "oil"=>30000, "cream"=>5000}) == 11
  cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000}) == 0
  cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000, "apples"=>15, "oil"=>20}) == 0
  cakes({"eggs"=>4, "flour"=>400},{}) == 0
  cakes({"cream"=>1, "flour"=>3, "sugar"=>1, "milk"=>1, "oil"=>1, "eggs"=>1},{"sugar"=>1, "eggs"=>1, "flour"=>3, "cream"=>1, "oil"=>1, "milk"=>1}) == 1

Data Structures
  Hashes

Algos
  We're given two hashes, one represents the ingredients we have, one represents the recipe
  We need to divide the recipe by the quantities present, finding the smallest divided result.
  We need to access each hash key in both the recipe and the ingredients
    We divide the ingredients by the recipe
    Append the result to an array (mins)
  If we can't find the a key in the ingredient hash, return 0
  After finish iterating, find the min of mins and return it
=end
def cakes(recipe, ingredients)
  mins_arr = []
  recipe.each do |key, value|
    if ingredients.keys.include?(key)
      mins_arr << ingredients[key] / value 
    else
      return 0
    end
  end
  mins_arr.min
end

# 24) https://www.codewars.com/kata/51edd51599a189fe7f000015/train/ruby
=begin
Problem
  Complete the function that
    accepts two integer arrays of equal length
    compares the value each member in one array to the corresponding member in the other
    squares the absolute value difference between those two values
    and returns the average of those squared absolute value difference between each member pair.

  Input
    two arrays, of equal length

  Output
    Integer object
  
  Rules
    Array will have same number of elements, 
    Only given two array

Examples
  solution([1, 2, 3], [4, 5, 6]) == 9
  solution([10, 20, 10, 2], [10, 25, 5, -2]) == 16.5
  solution([-1, 0], [0, -1]) == 1

Data Structures
  Arrays 

Algo
we are given two arrays
we need to iterate through an array (arr1)
  We need to capture the equivalent element at the same index in the second array (arr2)
  On each iteration, we
    Subtract arr_1[x] - arr_2[x]
    Take the absolute value of this
    Square it
    Append to a new array, called (squares)
  We then reduce the squares array, and divid by the length of the str_1 array
=end
def solution(arr1, arr2)
  squares = []
  arr1.each_index do |index|
    squares << ((arr1[index] - arr2[index]).abs) ** 2
  end

  squares.reduce(0, &:+) / arr1.length.to_f
end

# 25) https://www.codewars.com/kata/5251f63bdc71af49250002d8/train/ruby
=begin
Problem
  Create a method called "power" that takes two integers and returns the value of the first argument raised to the power of the second. 

  Input
    Two integers (could be zero) - that sounds like an edge case

  Output
    An integer

  Rules
    Note: The ** operator has been disabled.
    Return nil if the second argument is negative.

Examples
  power(2, 3) # 8
  power(10, 0) # 1
  power(-5, 3) # -125
  power(-4, 2) # 16

Data Structure
  Integers

Algo
  Return 0 if 2nd arg (power) is zero
  Need to multiply the first number (base) by itself, power times - returning this integer

=end
def power(base, power)
  cumulative = 1
  return 0 if power == 0
  return nil if power < 0
  power.times do |_|
    cumulative *= base
  end
  cumulative
end

# 26) 
=begin
Problem
  Write a function that will find all the anagrams of a word from a list. 
  
  Inputs
    You will be given two inputs a word and an array with words. 

  Outputs
    Array of strings
  
  Rules  
    You should return an array of all the anagrams or an empty array if there are none. 

Examples
anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']
anagrams('laser', ['lazing', 'lazy',  'lacer']) == []

Data Structures
  An array

Algo
  At least for the test cases we have, we can iterate through our array of strings
    We test for whether the sorted version of this is equal to the sorted string of our search_string (they need to be the same length if they're an anagram)
  Return this array of matches
=end
def anagrams(search, string_array)
  string_array.select do |string|
    string.chars.sort == search.chars.sort
  end
end

# 27) https://www.codewars.com/kata/515de9ae9dcfc28eb6000001/train/ruby
=begin
Problem
  Complete the solution so that it splits the string into pairs of two characters. 
  If the string contains an odd number of characters then it should replace the missing second character of the final pair with an underscore ('_').

  Input
    String (could be empty)

  OUtput
    An array of string elements, each of which should be length 2

Examples
  solution("abcdef") == ["ab", "cd", "ef"]
  solution("abcdefg") ==  ["ab", "cd", "ef", "g_"]
  solution("") ==  []

Data Structures
  An array

Algo
  Return [] if string.length < 1
  We break our string into an array, so we can iterate through it
  We can use the each_slice(2) method, to take two elements at a time, returning a new array (map)
  We save this array
  We map through this array
    If the element's length is less than two, we append '_'
  We return this mapped array
=end
def solution(string)
  return [] if string.length < 1
  paired_arr = string.chars.each_slice(2).map do |slice|
    slice.join
  end

  paired_arr.map do |pair|
    pair.length < 2 ? pair + '_' : pair
  end
end

# *28) https://www.codewars.com/kata/5b1b27c8f60e99a467000041
=begin
Problem
  Given two words, how many letters do you have to remove from them to make them anagrams?

  Input
    Two string objects
    Either or both could be blank
    
  Output
    One integer object

  Rules
    All inputs will be lowercase.
    The integer object should be the sum of the letters removed from str1 and str2

Examples
  anagram_difference('', '') == 0
  anagram_difference('a', '') == 1
  anagram_difference('', 'a') == 1
  anagram_difference('ab', 'a') == 1
  anagram_difference('ab', 'ba') == 0
  anagram_difference('ab', 'cd') == 4
  anagram_difference('aab', 'a') == 2
  anagram_difference('a', 'aab') == 2
  anagram_difference('codewars', 'hackerrank') == 10

Data Structures
  An array

Algo
  We convert each string to an array
  We subtract an array from the other to show the common elements
=end
def anagram_difference(str1, str2)
  str1_dup = str1.chars
  str2_dup = str2.chars
  str1.each_char do |char|
    str2_dup.delete_at(str2_dup.index(char)) if str2.include?(char) && str2_dup.index(char) != nil
  end

  str2.each_char do |char|
    # Can use str1_dup.sub!(char, '') instead of this very long code, as sub only deletes the first instance, much like how our .index(char) method works. 
    str1_dup.delete_at(str1_dup.index(char)) if str1.include?(char) && str1_dup.index(char) != nil
  end

  str1_dup.length + str2_dup.length
end

# Alternate solution
def anagram_difference(string1, string2)
  same_chars_count = 0
  string1.chars.each do |char|
    if string2.include?(char)
      string2.sub!(char, '')
      same_chars_count += 1
    end
  end
  string2.size + (string1.size - same_chars_count)
end

# 29) https://www.codewars.com/kata/529eef7a9194e0cbc1000255
=begin
Problem
  Complete the function to return true if the two arguments given are anagrams of each other; return false otherwise.

  Input
    Two strings - non-blank?

  Output
    Boolean

  Rules
    Anagrams are not case sensitive

Examples
  is_anagram('Creative', 'Reactive') == true
  is_anagram("foefet", "toffee") == true
  is_anagram("Buckethead", "DeathCubeK") == true
  is_anagram("Twoo", "WooT") == true
  is_anagram("dumble", "bumble") == false
  is_anagram("ound", "round") == false
  is_anagram("apple", "pale") == false

Data Structures
  Array to sort our strings

Algo
  convert each string to an array
  Sort each string
  Compare each string
=end
def is_anagram(word1, word2)
  word1.downcase.chars.sort == word2.downcase.chars.sort
end

# 30) https://www.codewars.com/kata/57eb8fcdf670e99d9b000272
=begin
Problem
  Given a string of words, you need to find the highest scoring word. Each letter of a word scores points according to its position in the alphabet. You need to return the highest scoring word as a string.

  Input
    A string of words, separated by spaces

  Output
    A single string object

  Rules
    If two words score the same, return the word that appears earliest in the original string.
    All letters will be lowercase and all inputs will be valid.

Examples
  high('man i need a taxi up to ubud') == 'taxi'
  high('what time are we climbing up the volcano') == 'volcano'
  high('take me to semynak') == 'semynak'
  high('aaa b') == 'aaa'

Data Structures
  Hash to keep track of letter scores
  Array when we split up our words

Algo
  Create a hash with alphabet as keys, alphabet position as values
  Split up our input string into an array of words
  Map through this array, providing a word to the block
    Map through each word - replace with the value in the hash
    Reduce the returned letter arrays

  On the returned array, find the highest value, and it's index
  Reference the original string array, with that saved index
=end
def high(sentence)
  alphabet = ('a'..'z').zip(1..26).to_h
  values = sentence.split.map do |word|
    [word, word.chars.map do |letter|
      alphabet[letter]
    end.reduce(0, &:+)]
  end
  values.max_by do |subarr|
    [subarr[1], subarr[0]]
  end.first
end

# 31) https://www.codewars.com/kata/546f922b54af40e1e90001da
=begin
Problem
  Given a string, replace every letter with its position in the alphabet.

  Input
    Sentence

  Output
    String

  Rules
    If anything in the text isn't a letter, ignore it and don't return it.

Examples
  alphabet_position("The sunset sets at twelve o' clock.") == "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11"
  alphabet_position("-.-'") == ""

Data Structures
  Hash to keep track of alphabet position associated with letters
  Arrays (we'll need to split up our sentence to iterate through it)

Algo
  Set up a hash of letters and their position in the alphabet
  Split up our sentence into an array of words
  Iterate through this array of words
  Split up each word into characters
  Iterate each through each character
    Replace each letter with the position in the alphabet (reference via the hash)
      If the key doesn't exist, ignore it
    Join the array
=end
def alphabet_position(sentence)
  alphabet = ('a'..'z').zip('1'..'26').to_h
  sentence.downcase.split.map do |word|
    word.chars.map do |letter|
      alphabet[letter]
    end.compact
  end.join(' ').squeeze(' ').strip
end

# *32) https://www.codewars.com/kata/53bb1201392478fefc000746
=begin
Problem
  Write a method which helps Sherlock to find suspects. 

  Input
    A hash

  Output
    An array of symbols (hash keys)

  Rules
    If no suspect is found or there are no pockets (pockets == nil), the method should return nil.
    We need to verify whether the values for each key match the input.
      If not, return that person

Examples
  find_suspects({}, [1, 3]) == nil
  find_suspects({ tom: [2], bob: [2], julia: [3], meg: [3] }, [2, 3]) == nil
  find_suspects({ meg: [1, 3], tom: [5, 3] }, [1, 3]) == [:tom]
  find_suspects({ meg: [3], tom: [5] }, []) == [:meg, :tom]

Data Structures
  Array (that's our output)
  Hash (we need to reference hash key and values)

Algo
  Check for edge cases - if pockets is empty, return nil
    If allowed_items is empty, return pockets.keys
  
  Otherwise, iterate through our hash
    We should select the keys where the values != the allowed_items
    This should return an array.
=end
def find_suspects(pockets, allowed_items)
  return nil if pockets.empty? || pockets.values.all? { |val| val == nil || val.empty? }

  return pockets.keys - pockets.keys.select do |key|
    pockets[key] == nil || pockets[key].empty?
  end if allowed_items.empty? 

  result = pockets.keys.select do |key|
    !(pockets[key] - allowed_items).empty?
  end

  result.empty? ? nil : result
end

# Alt solution - the any? method helps us quickly iterate through each element in items
def find_suspects(pockets, allowed_items)
  culprits = []
  pockets.each do |suspect, items|
    next unless items
    culprits << suspect if items.any? { |item| !allowed_items.include?(item) }
  end
  return nil if culprits.empty?
  culprits
end

# 33) https://www.codewars.com/kata/58f5c63f1e26ecda7e000029/train/ruby
=begin
Problem
  your task is to create a function that turns a string into a Mexican Wave. 

  Input
    You will be passed a string

  Output
    Return the input string in an array where an uppercase letter is a person standing up. 

  Rules
    The input string will always be lower case but maybe empty.
    If the character in the string is whitespace then pass over it as if it was an empty seat

Examples
  wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
  wave("codewars") == ["Codewars", "cOdewars", "coDewars", "codEwars", "codeWars", "codewArs", "codewaRs", "codewarS"]
  wave("") == []
  wave("two words") ==  ["Two words", "tWo words", "twO words", "two Words", "two wOrds", "two woRds", "two worDs", "two wordS"]
  wave(" gap ") == [" Gap ", " gAp ", " gaP "]

Data Structures
  Array

Algo
  We have an input string
  return [] if there's a blank string
  want to iterate through each index of our string
    If the letter at a particular index is a space, we want to skip to the next iteration
    Otherwise, capitalise at that index, pass it to an empty array (wave)
    We can index from string[0...idx] + string[idx].capitalize + string[idx+1..-1]
  Return wave
=end
def wave(sentence)
  wave = []
  return wave if sentence.length < 1
  sentence.chars.each_index do |idx|
    next if sentence[idx] == ' '
    wave << sentence[0...idx] + sentence[idx].capitalize + sentence[idx+1..-1]
  end
  wave
end

# *34) https://www.codewars.com/kata/5894318275f2c75695000146/train/ruby
=begin
Problem
  Given an integer n, find the maximal number you can obtain by deleting exactly one digit of the given number.

  Input
    INteger object

  Output
    Integer object

  Rules
    10 ≤ n ≤ 1000000

Examples
  delete_digit(152) == 52
  delete_digit(1001) == 101
  delete_digit(10) == 1
  delete_digit(495421) == 95421
  delete_digit(646785) == 66785
  delete_digit(270246) == 70246
  delete_digit(888815) == 88885

Data Structures
  Array

Algo
  Split input integer into an array of digits (digits_arr)
    Remember to Reverse
  We iterate through our digits_arr
    We take pairs of digits
      If the first number is smaller than the second, 
      Delete that first number from digits_arr
      break the iteration
      return a join.to_i digits arr
      Otherwise, continue through our loop
      If we run into the case where the smallest number is at the end, we just delete the last number from digits_arr
=end
def delete_digit(number)
  num_arr = number.digits.reverse
  num_arr.each_cons(2) do |a, b|
    if a < b
      num_arr.delete_at(num_arr.index(a))
      return num_arr.join.to_i
    end 
  end
  num_arr.pop
  num_arr.join.to_i
end

# 35) https://www.codewars.com/kata/514b92a657cdc65150000006/train/ruby
=begin
Problem
  Finish the solution so that it returns the sum of all the multiples of 3 or 5 below the number passed in.

  Input
    AN integer object

  Output
    Integer object

  Rules
    If the number is a multiple of both 3 and 5, only count it once. 
    If a number is negative, return 0

Examples
  solution(10) == 23
  solution(20) == 78
  solution(200) == 9168

Data Structures
  Array

Algo
  Return 0 if input < 0
  We get a range of numbers from 0..input
    We test for divisibility of input by 3 or 5
    We get an array back of the factors (factor_arr)
    We then sum the elements of factor_arr
=end
def solution(input)
  factor_arr = (0...input).select do |num|
    num % 3 == 0 || num % 5 == 0
  end

  factor_arr.reduce(0, &:+)
end

# 36) https://www.codewars.com/kata/5878520d52628a092f0002d0/train/ruby
=begin
Problem
  Given a string, return a new string that has transformed based on the input: Change case of every character, ie. lower case to upper case, upper case to lower case. Reverse the order of words from the input.

  Input
    String

  Output
    String

  Rules
    You will have to handle multiple spaces, and leading/trailing spaces.

Examples
  string_transformer('Example string'), 'STRING eXAMPLE')
  string_transformer("You Know When  THAT  Hotline Bling") == "bLING hOTLINE  that  wHEN kNOW yOU"
  string_transformer(" A b C d E f G ") == " g F e D c B a "

Data Structures
  Array to reverse our string

Algo
  We apply the swapcase method to our input string, assign to variable (swapped)
  Break this up into an array of characters (swapped_chars)
  Iterate through swapped_chars
    Set up an empty string, string_block
    Set up an empty string, spaces
    Set up an empty array, final_string
    As we iterate through swapped_chars
      If the char is a letter (test through ('a'..'z').include?(char.downcase))
        append spaces to final_string
        reset spaces
        append that letter to string_block
      If it's a space
        Insert string_block to final_string
        reset string_block
        append a space to 'spaces'
    Join final_string, return it
=end
def string_transformer(input)
  swapped = input.swapcase
  final_string = []
  string_block = ''
  spaces = ''
  swapped.chars.each do |char|
    if ('a'..'z').include?(char.downcase)
      final_string << spaces
      spaces = ''
      string_block << char
    elsif char = ' '
      final_string << string_block
      string_block = ''
      spaces << char
    end
  end

  final_string << spaces
  final_string << string_block

  final_string.reverse.join
end

# 37) https://www.codewars.com/kata/529872bdd0f550a06b00026e/train/ruby
=begin
Problem
  Complete the greatestProduct method so that it'll find the greatest product of five consecutive digits in the given string of digits.

  Input
    String object

  Output
    Integer object

  Rules
    The input string always has more than five digits.
    We will take a group of five characters from our string, multiplying those digits
    Compare the products
    Return an integer object

Examples
  greatest_product("123834539327238239583") == 3240
  greatest_product("395831238345393272382") == 3240
  greatest_product("92494737828244222221111111532909999") == 5292
  greatest_product("92494737828244222221111111532909999") == 5292
  greatest_product("02494037820244202221011110532909999") == 0

Data Structures
  Array

Algo
  We're given a string object, min 5 characters
  We'll want to initialise an empty array (multiples), to capture all of our multiplications
  We'll want to break up our string object into an array
  Take 5 elements at a time
    Convert each of those elements into an integer 
    Multiply those 5 elements together
    Store the result in multiples array
    Max of the multiples array
=end
def greatest_product(number)
  multiples = []
  number.chars.each_cons(5) do |group|
    multiples << group.map do |integer|
      integer.to_i
    end.reduce(:*)
  end
  multiples.max
end

# 38) https://www.codewars.com/kata/54b42f9314d9229fd6000d9c/train/ruby
=begin
Problem 
The goal of this exercise is to convert a string to a new string where each character in the new string is "(" if that character appears only once in the original string, or ")" if that character appears more than once in the original string. 

  Input
    String object (assume it's non-empty)

  Output
    String object of left and right parenthesis

  Rules
    Ignore capitalization when determining if a character is a duplicate.
    Spaces are counted as characters for the purposes of counting

Examples
  duplicate_encode("din") == "((("
  duplicate_encode("recede") == "()()()"
  duplicate_encode("Success") == ")())())"
  duplicate_encode("(( @") == "))(("

Data Structures
  Array

Algo
  String input
  Break downcased string input into an array of characters
  Iterate through our characters (map)
  If the count of the character > 1, return ')'
  Else return '('
  This will return an array
  Join this array (returning it)
=end
def duplicate_encode(input)
  input.downcase.chars.map do |char|
    input.downcase.count(char) > 1 ? ')' : '('
  end.join
end

# 39) https://www.codewars.com/kata/5727bb0fe81185ae62000ae3/train/ruby
=begin
Problem
Assume "#" is like a backspace in string. This means that string "a#bc#d" actually is "bd". Your task is to process a string with "#" symbols.

  Input
    String object, with at least one #

  Output
    String object (might be empty)

  Rules
    We treat the # symbol as deleting the character immediately preceeding it

Examples
  clean_string('abc#d##c') == "ac"
  clean_string('abc####d##c#') == "" 

Data Structures
  Array

Algo
  String input
  Initialise an empty array (clean_letters)
  Break up our input string into an array
  Iterate through the array
  If the character passed to the block is not '#', append it to our clean_array
  If the character is '#', we apply the pop method to the clean_array
  We join clean_array, and return it
=end
def clean_string(input)
  clean_array = []
  input.chars.each do |char|
    char != '#' ? clean_array << char : clean_array.pop
  end
  clean_array.join
end

# 39) https://www.codewars.com/kata/51f41fe7e8f176e70d0002b9/train/ruby
=begin
Problem
Sort the given strings in alphabetical order, case insensitive

  Input
    Single array of string objects
    The single array might only have a single object

  Output
    Single array of sorted string objects

  Rules
    When sorting, ignore case
    

Example
  sortme(["Hello", "there", "I'm", "fine"]) == ["fine", "Hello", "I'm", "there"]
  sortme(["C", "d", "a", "B"]) == ["a", "B", "C", "d"]
  sortme(["CodeWars"]) == ["CodeWars"]

Data Structures
  Array

Algo
  Given input array of string
  Sort the downcased elements in that string
  Return the array, sorted
=end
def sortme(input)
  input.sort_by do |element|
    element.downcase
  end
end

# 40) https://www.codewars.com/kata/5a946d9fba1bb5135100007c/train/ruby
=begin
Problem
Given a List [] of n integers , find minimum number to be inserted in a list, so that sum of all elements of list should equal the closest prime number.

  Input
    An array of at least 2 integer objects (integers will be > 0)

  Output
    Integer object

  Rules
    List size is at least 2 .
    List's numbers will only positives (n > 0) .
    Repetition of numbers in the list could occur 
    The newer list's sum should equal the closest prime number .

Example 
  minimum_number([3,1,2]) == 1
  minimum_number([5,2]) == 0
  minimum_number([1,1,1]) == 0
  minimum_number([2,12,8,4,6]) == 5
  minimum_number([50,39,49,6,17,28]) == 2

Data Structures
  Array

Algo
  Given an array of integer objects
  We want to sum up the integer objects (arr_sum)
  Initialise a variable called additional_num = 0
  We want to verify whether arr_sum is prime?
    
  Prime? - Helper method
    If we divide by all the numbers from 2 up to that number and none of them divide evenly, it's a prime number

    If it is, return additional_num
  Otherwise, we increment additional_num by 1 and add it to arr_sum
    Check if it's prime
    If so, return additional_num
    Otherwise, continue iterating
=end
def prime?(num)
  (2..Math.sqrt(num)).all? do |integer|
    num % integer != 0
  end
end

def minimum_number(arr)
  additional_num = 0
  loop do
    return additional_num if prime?(arr.reduce(:+) + additional_num)
    additional_num += 1
  end
end

# 41) 
=begin
Problem
Write a function that will return the count of distinct case-insensitive alphabetic characters and numeric digits that occur more than once in the input string. 

  Input
    String (could be empty)

  Output
    Integer object

  Rules
    The input string can be assumed to contain only alphabets (both uppercase and lowercase) and numeric digits.

Examples
  duplicate_count("") == 0
  duplicate_count("abcde") == 0
  duplicate_count("abcdeaa") == 1
  duplicate_count("abcdeaB") == 2
  duplicate_count("Indivisibilities") == 2

Data Structures
  Array

Algo
  Downcase our string
  Break up our string into an array
  We iterate through this array
  We select the characters that have a count > 1
    We need to ensure that we are counting lowercase characters
  We'll get an array of letters that meet this criteria
  We return the length of this array
=end
def duplicate_count(string)
  duplicate_chars = string.downcase.chars.select do |char|
    string.downcase.count(char) > 1
  end
  duplicate_chars.uniq.length
end
