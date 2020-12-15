# 26) https://www.codewars.com/kata/523a86aa4230ebb5420001e1
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

# Alt solution
def delete_digit(n)
  numbers = []
  n_array = n.to_s.chars
  n_array.each_with_index do |num, idx|
    numbers << n_array[0...idx] + n_array[idx + 1..-1]
  end
  numbers.max.join.to_i
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

# 41) https://www.codewars.com/kata/54bf1c2cd5b56cc47f0007a1/train/ruby
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

# *42) https://www.codewars.com/kata/5970df092ef474680a0000c9/train/ruby
=begin
Problem
Re-order the characters of a string, so that they are concatenated into a new string in "case-insensitively-alphabetical-order-of-appearance" order. 

  Input
    String object (Could be empty)

  Output
    String object that's sorted in alphabetical order with no spaces or punctuation (Could be empty)

  Rules
    Whitespace and punctuation shall simply be removed!
    The input is restricted to contain no numerals and only words containing the english alphabet letters.

Examples
  alphabetized("") ==  ""
  alphabetized(" ") ==  ""
  alphabetized(" a") == "a"
  alphabetized("a ") == "a"
  alphabetized(" a ") == "a"
  alphabetized("A b B a") == "AabB"
  alphabetized(" a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z") == "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"
  alphabetized("!@$%^&*()_+=-`,") == ""
  alphabetized("The Holy Bible") == "BbeehHilloTy"
  alphabetized("CodeWars can't Load Today") == "aaaaCcdddeLnooorstTWy"

Data Structures
  Array 

Algo
  We split up our string into an array of letters (arr_char), removing spaces in this step
  We then iterate through arr_char, checking if the letter passed to the block, when downcased, is included in the alphabet
    We can set an array of ('a'..'z') and check if the downcased letter is included in this.
  We sort our letters
  We return an array of letters
  We join these letters back together (no spaces)
=end
def alphabetized(input)
  input.chars.select do |char| 
    ('a'..'z').include?(char.downcase)
  end.sort_by do |char|
    # Here, we are converting our character to downcase purely for sorting purposes
    # If the letters are the same (i.e. once you downcase them), the order in which they appear is the next sort criteria. 
    char.downcase
  end.join
end

# Alt solution
ALPHA = ('a'..'z').to_a

def alphabetized(s)
  clean_str = s.delete("^a-zA-Z")
  result = ''
  # If the character DOWNCASED equals the current letter in the alphabet constant, push the character to a new string IN ITS ORIGINAL CASE
  clean_str.chars.each do |char|
    result << char if ALPHA.include?(char.downcase)
  end
  result
end

# 43) https://www.codewars.com/kata/541c8630095125aba6000c00/train/ruby
=begin
Problem
A digital root is the recursive sum of all the digits in a number. Given n, take the sum of the digits of n. If that value has more than one digit, continue reducing in this way until a single-digit number is produced. 
  
  Input
    Integer object

  Output
    Integer object

  Rules
    The input will be a non-negative integer.

Example
  digital_root(16) == 7
  digital_root(942) == 6
  digital_root(132189) == 6
  digital_root(493193) == 2

Data Structure
  Array

Algo
  Break up our input number into an array of digits
  We then add up all these digits
  Check if the answer is a single digit
    If so, return this answer
    If not, repeat the loop
=end
def digital_root(input)
  loop do 
    return input.digits.reduce(:+) if input.digits.reduce(:+) < 10
    input = input.digits.reduce(:+)
  end
end

# 44) https://www.codewars.com/kata/523f5d21c841566fde000009/train/ruby
=begin
Problem
Implement a difference function, which subtracts one list from another and returns the result. It should remove all values from list a, which are present in list b.

  Input
    Two arrays

  Output
    An array

  Rules
    If an element is present in b, remove ALL instances of that element in a.

Examples
  array_diff([1,2], [1]) == [2]
  array_diff([1,2,2], [1]) == [2,2]
  array_diff([1,2,2], [2]) == [1]
  array_diff([1,2,2], []) == [1,2,2]
  array_diff([], [1,2]) == []

Data Structures
  Array

Algo
  Subtract b from a
=end
def array_diff(a, b)
  a - b
end

# *44) https://www.codewars.com/kata/58539230879867a8cd00011c/train/ruby
=begin
Problem
Place all people in alphabetical order where Mothers are followed by their children, i.e. "aAbaBb" => "AaaBbb". 

  Input
    A string (could be empty)

  Output
    A string (could also be empty)

  Rules
    Uppercase letters stands for mothers, lowercase stand for their children, i.e. "A" mother's children are "aaaa".
    Function input: String contains only letters, uppercase letters are unique. 

Example
  find_children("abBA") == "AaBb"
  find_children("AaaaaZazzz") == "AaaaaaZzzz"
  find_children("CbcBcbaA") == "AaBbbCcc"
  find_children("xXfuUuuF") == "FfUuuuXx"
  find_children("") == ""

Data Structures
  Array

Algo
  We need to break up our string into an array of characters (char_arr)
  We can split up char_arr into two variables, capitals and lowers
  We iterate through lowers
    If the character in lower is equal to the corresponding character in capitals, insert it at the index of the capital letter + 1
    Return capital, joined together
  
=end
def find_children(dancing_brigade)
  # First we compare by downcased characters, which will group all the letters together. After this sort, we sort by char (where capitals come before lowercase letters)
  dancing_brigade.chars.sort_by { |char| [char.downcase, char] }.join
end

# The other method is to not sort, but generate an entirely new object
def find_children(dancing_brigade)
  letters = dancing_brigade.downcase.chars.uniq.sort
  result = []
  letters.each do |letter|
    str = ''
    dancing_brigade.downcase.count(letter).times { str << letter }
    result << str.capitalize
  end
  result.join
end

# 45) https://www.codewars.com/kata/5552101f47fc5178b1000050/train/ruby
=begin
Problem
Given a positive integer n written as abcd... (a, b, c, d... being digits) and a positive integer p, we want to find a positive integer k, if it exists, such as the sum of the digits of n taken to the successive powers of p is equal to k * n. 

  Input
    Two integer objects

  Output
    An integer object

  Rules
    If it is the case we will return k, if not return -1.
    n and p will always be given as strictly positive integers.

Example
  dig_pow(89, 1) ==  1
  dig_pow(92, 1) == -1
  dig_pow(46288, 3) ==  51

Data Structure
  Array

Algo
  We need to break up our number into an array of digits
  Based on the index of the digit, we need to raise that digit p, incrementing p by the number of digits
  We then add those 'powered_digits' up
  Divide the sum of powered_digits by input num
    If this evenly divides, return that result
    Otherwise, return -1
=end
def dig_pow(k, power)
  k_digits = k.digits.reverse
  counter_start = power
  powered_digits = []
  k_digits.each do |digit|
    powered_digits << digit ** power
    power += 1
  end
  powered_digits.reduce(:+) % k == 0 ? powered_digits.reduce(:+) / k : -1
end
