# 51) https://www.codewars.com/kata/550498447451fbbd7600041c
=begin
Problem
Given two arrays a and b write a function comp(a, b) that checks whether the two arrays have the "same" elements, with the same multiplicities. "Same" means, here, that the elements in b are the elements in a squared, regardless of the order.

  Input
    Two arrays of integer objects

  Output
    Boolean

  Rules
    "Same" means, here, that the elements in b are the elements in a squared, regardless of the order.
    a or b might be []
    If a or b are nil (could be nil), the problem doesn't make sense so return false.
    a and b will be the same length

Examples
  comp([121, 144, 19, 161, 19, 144, 19, 11], [11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19]) == true

Data Structures
  Array

Algo
  a as our input array
  b as our 'test' array
  we sort a and b
  Iterate through a, checking if that number squared exists in b at the same index (sorted)
  If this is true for all numbers, return true
  Return false if a or b are nil, or are empty
=end
def comp(a, b)
  return false if b == nil || a == nil
  a = a.sort
  b = b.sort
  a == a.select.with_index do |num, idx|
    num ** 2 == b[idx]
  end
end

# 52) https://www.codewars.com/kata/53a452dd0064085711001205
=begin
Problem 
Your goal is to write the group_and_count method, which should receive an array as unique parameter and return a hash. Empty or nil input must return nil instead of a hash. This hash returned must contain as keys the unique values of the array, and as values the counting of each value.

  Input
    Array (though this could be empty or nil)

  Output
    Hash, with numbers as keys, and counts as values

  Rules
    We cannot use Array#count or Array#length
    Empty or nil input must return nil instead of a hash.

Examples
  group_and_count([0,1,1,0]) == {0=>2, 1=>2}

Data Structures
  Array
  Hash

Algo
  Return false if the input array is nil or empty  
  If not, we want to iterate through our input array
    We set up an empty hash
    If the hash does not include the letter on a given iteration
      Create a key in the hash, and set the value to 1
    Else if the key does exist already, increment the value
  Return the hash
=end
def group_and_count(input)
  return nil if input == nil || input.empty?
  input.each_with_object(Hash.new(0)) do |element, hash|
    hash[element] += 1
  end
end

# 53) https://www.codewars.com/kata/5453dce502949307cf000bff
=begin
Problem
Complete the method that takes a hash of users, and find the nexus: the user whose rank is the closest/is equal to his honor. Return the rank of this user. For each user, the key is the rank and the value is the honor.

If nobody has an exact rank/honor match, return the rank of the user who comes closest. If there are several users who come closest, return the one with the lowest rank (numeric value). The hash will not necessarily contain consecutive rank numbers; return the best match from the ranks provided.

  Input
    Hash, where keys and values are integer objects

  Output
    Integer object

  Rules
    If possible, return the rank (key) of the user where key == value
    Otherwise, return the lowest difference between key and value
      If there are multiple key-value pairs with lowest difference, return the lowest key

Example
users = {1 => 3, 3 => 3, 5 => 1}
nexus(users) == 3

users = {1 => 10, 2 => 6, 3 => 4, 5 => 1}
nexus(users) == 3

Data Structures
  Hash
  Array

Algo
  We're given a hash
  We want to iterate through our hash (key, value)
  Select all the keys where key == value
    return the min key
  
  If that's empty, we want to map through our hash (keys and values)
  we want to take the absolute value of subtracting the key and value, as well as the key
  This will return an array of subarrays
  We want to find the subarray with the smallest difference and return the key (the first element)
=end
def nexus(input)
  min_diff = input.map do |key, value|
    [key, (key - value).abs]
  end

  min_diff.sort_by do |subarr|
    [subarr.last, subarr.first]
  end.first.first
end

# 54) https://www.codewars.com/kata/5808ff71c7cfa1c6aa00006d
=begin
Problem 
You've to count lowercase letters in a given string and return the letter count in a hash with 'letter' as key and count as 'value'. The key must be 'symbol' instead of string in Ruby

  Input
    String object

  Output
    Hash, with letters as keys, counts as values

  Rules
    The keys must be symbols
    We are counting lowercase letters

Examples
  letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
  letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
  letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}

Data Structures
  Hash
  Array

Algo
  Get the string input
  Break it up into a series of letters (arr_char)
  Iterate through arr_char
    Create a blank hash
    If the letter exists as a key (symbol) in the hash, increment the value by one
    Otherwise, initialise a key-value pair, with the letter as a symbol as key, with value = 1
=end
def letter_count(input)
  input.chars.each_with_object(Hash.new(0)) do |letter, hash|
    hash[letter.to_sym] += 1
  end
end

# 55) https://www.codewars.com/kata/55d5434f269c0c3f1b000058
=begin
Problem
Write a function which takes numbers num1 and num2 and returns 1 if there is a straight triple of a number at any place in num1 and also a straight double of the same number in num2. If this isn't the case, return 0. 

  Input
    Two integer objects as an input

  Output
    Integer object (0 or 1)

Examples
  triple_double(451999277, 41177722899) == 1
  triple_double(1222345, 12345) == 0
  triple_double(12345, 12345) == 0
  triple_double(666789, 12345667) == 1
  triple_double(10560002, 100) == 1
  triple_double(1112, 122) == 0

Data Structures
  Array

Algo
  break up num1 into an array of numbers (arr1_num)
    Iterate through arr1_num, 3 elements at a time
    If those elements are all the same, 
      if the uniq elements array length == 1

      join the result
      append this to empty string, called triple
    If there is no triple (i.e. triple remains empty), return 0
  
  Break up arr2 into an array (arr2_num)
    take the first two elements of triple via indexing
    Check if arr2_num contains this
    If so, return 1, otherwise, return 0
    
=end
def triple_double(num1, num2)
  arr1_num = num1.to_s.chars
  triple = []

  arr1_num.each_cons(3) do |triplet|
    triple << triplet.join if triplet.uniq.length == 1
  end

  return 0 if triple.empty?

  triple.any? do |triplet|
    num2.to_s.include?(triplet[1..-1])
  end ? 1 : 0
end

# 56) https://www.codewars.com/kata/550554fd08b86f84fe000a58/train/ruby
=begin
Problem
Given two arrays of strings a1 and a2 return a sorted array r in lexicographical order of the strings of a1 which are substrings of strings of a2.

  Input
    Two arrays, of string objects (might be empty)

  Output
    An array (could be empty)

  Rules
    The returned array must be without duplicates.
    Don't mutate the inputs.

Examples
  in_array(["arp", "live", "strong"], ["lively", "alive", "harp", "sharp", "armstrong"]) == ["arp", "live", "strong"]
  in_array(["tarp", "mice", "bull"], ["lively", "alive", "harp", "sharp", "armstrong"]) == []

Data Structures
  Array

Algo
  given two arrays, a1 and a2
  We iterate through a2, and a1
    We want to check if a1 appears in a2
    If it does, return that element of a1
    Append that a1 element to common_substr (an empty array)
  Remove duplicates from common_substr
  Sort common_substr
  Return common_substr
=end
def in_array(a1, a2)
  common_substr = []
  a2.each do |word2|
    a1.each do |word1|
      common_substr << word1 if word2.include?(word1)
    end
  end
  common_substr.uniq.sort.flatten
end

# 57) https://www.codewars.com/kata/53368a47e38700bd8300030d/
=begin
Problem
Given an array containing hashes of names, return a string formatted as a list of names separated by commas except for the last two names, which should be separated by an ampersand.

  Input
    An array, which contains a number of hashes, each hash has the 'name' as a key (type is symbol)

  Output
    A string object

  Rules
    All the hashes are pre-validated and will only contain A-Z, a-z, '-' and '.'.

Examples
  list([{name: 'Bart'},{name: 'Lisa'},{name: 'Maggie'},{name: 'Homer'},{name: 'Marge'}]) == 'Bart, Lisa, Maggie, Homer & Marge'
  list([{name: 'Bart'},{name: 'Lisa'}]) == 'Bart & Lisa'
  list([{name: 'Bart'}]) == 'Bart'

Data Structures
  Array
  Hashes

Algo
  Given an array
  Iterate through this array
  Capture all of the values of the keys in a separate array (name_arr)
  We should have an array of string objects
  Check how many string objects are in name_arr
    If length is 1, return the first element of name_arr
    if length is 2, return first and last elements of name_arr, separated by ampersand
    If length is > 2, return name_arr[0...-3].join(', ') + " " + #{name_arr[-2]} & #{name_arr[-1]}
=end
def list(input_arr)
  return '' if input_arr.empty?
  name_arr = input_arr.each_with_object([]) do |hash, arr|
    arr << hash[:name]
  end

  name_arr.length == 1 ? "#{name_arr.first}" : name_arr[0..-2].join(', ') + " & #{name_arr[-1]}"
end

# Alt solution - less conditional nonsense
def list(names)
  names = names.map { |name| name[:name] }
  last_name = names.pop
  return last_name.to_s if names.empty?
  "#{names.join(', ')} & #{last_name}"
end

# 58) https://www.codewars.com/kata/5839edaa6754d6fec10000a2
=begin
Problem
Write a method that takes an array of consecutive (increasing) letters as input and that returns the missing letter in the array.

  Input
    An array of string objects

  Output
    Integer object

  Rules
    You will always get an valid array. 
    The array will be always exactly one letter be missing. 
    The length of the array will always be at least 2.
    The array will always contain letters in only one case.

Examples
  find_missing_letter(["a","b","c","d","f"]) ==  "e"
  find_missing_letter(["O","Q","R","S"]) ==  "P"
  find_missing_letter(["b","d"]) ==  "c"
  find_missing_letter(["a","b","d"]) ==  "c"
  find_missing_letter(["b","d","e"]) ==  "c"

Data Structures
  Array

Algo
  Take input array
  Sort it, just in case
  Take the first string object element, assign to variable 'start_char'
  Take the last string object element, assign to variable 'end_char'
  Take a range of characters from start_char to end_char, save that to an array (full_range)
  Subtract input array from full range
  This should return a single character (string object)
=end
def find_missing_letter(input_arr)
  input_arr = input_arr.sort
  start_char = input_arr.first
  end_char = input_arr.last
  full_range = (start_char..end_char).to_a
  (full_range - input_arr).first
end

# 59) https://www.codewars.com/kata/5266876b8f4bf2da9b000362
=begin
Problem
Implement a function 'likes' which must take in input array, containing the names of people who like an item. 

  Input
    An array of string objects

  Output
    String object

  Rules
    For 4 or more names, the number in and 2 others simply increases.

Examples
  likes([]) ==  'no one likes this'
  likes(['Peter']) ==  'Peter likes this'
  likes(['Jacob', 'Alex']) ==  'Jacob and Alex like this'
  likes(['Max', 'John', 'Mark']) ==  'Max, John and Mark like this'
  likes(['Alex', 'Jacob', 'Mark', 'Max']) ==  'Alex, Jacob and 2 others like this'

Data Structures
  Array 

Algo
  Input array (could be empty)
  want to assign the string ' like this' to variable end_str_singular
  assign the string ' likes this' to variable end_str_plural
    If input array is empty, return 'no one' + end_str_singular
    If input array is one person, return first element of array + end_str_singular
    If input array is two or three people, save the last element as last_plural (pop to remove)
      join the other elements with (', ') + ' ' + last_plural + end_str_plural
    If the input >= 4 elements, take the first two elements, join with ', ', then count the remaining elements, pass that to the string + end_str_plural
=end
def likes(likers)
  end_str_singular = ' like this'
  end_str_plural = ' likes this'
  if likers.empty?
    'no one' + end_str_plural
  elsif likers.length == 1
    likers.first + end_str_plural
  elsif likers.length <= 3
    likers_new = likers.map { |person| person.dup }
    last_person = likers_new.pop
    likers_new.join(', ') + ' and ' + last_person + end_str_singular
  else
    likers[0..1].join(', ') + " and #{likers[2..-1].length} others#{end_str_singular}"
  end
end

# 60) https://www.codewars.com/kata/5526fc09a1bbd946250002dc
=begin
Problem
Write a method that takes the array as an argument and returns this "outlier" N.

  Input
    Array of integer objects

  Output
    Integer object

  Rules
    You are given an array (which will have a length of at least 3, but could be very large) containing integers. 
    The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N. 
    If there are more even integers than odd integers, we're looking for an odd integer
      Inverse is true

Example
  find_outlier([0, 1, 2]) == 1
  find_outlier([1, 2, 3]) == 2
  find_outlier([2,6,8,10,3]) == 3

Data Structures
  Array

Algo
  Given an input array
  Determine whether there are more odd or even numbers
    we count the even numbers, subtract this from the length of the full array
    If odd is greater, select even number from our array
    If even is greater, select odd from array
  Return the first item of this array (since we'll only have a single outlier)
=end
def find_outlier(input_arr)
  evens = input_arr.select { |num| num.even? }.size
  odds = input_arr.length - evens
  evens > odds ? input_arr.select { |num| num.odd? }.first : input_arr.select { |num| num.even? }.first
end

# 61) https://www.codewars.com/kata/52a112d9488f506ae7000b95
=begin
Problem
Write a function that:
  returns true if every element in an array is an integer or a float with no decimals.
  returns true if array is empty.
  returns false for every other input.

  Input
    An array of differing object types

  Output
    Boolean

  Rules

Examples
  is_int_array([]) == true
  is_int_array([1, 2, 3, 4]) == true
  is_int_array([-11, -12, -13, -14]) == true
  is_int_array([1.0, 2.0, 3.0]) == true
  is_int_array([1, 2, nil]) == false
  is_int_array(nil) == false
  is_int_array("") == false
  is_int_array([nil]) == false
  is_int_array([1.0, 2.0, 3.0001]) == false
  is_int_array(["-1"]) == false

Data Structures
  Array

Algo
  Given an array
  Return true if the array is empty
  Iterate through the array
    Return true if all items are 
      integer types (.is_a?(Integer))
      Floats with no 'remainder'
        We can compare the float converted to integer versus the float itself
  Otherwise, return false
=end
def is_int_array(arr)
  return false if arr == nil || arr == ''
  return true if arr.is_a?(Array) && arr.empty?
  arr.all? do |element|
    element.is_a?(Integer) || element.is_a?(Float) && element == element.to_i
  end
end

# *62) https://www.codewars.com/kata/56b861671d36bb0aa8000819/train/ruby
=begin
Problem
Your task is to Reverse and Combine Words.

  Input
    String containing different "words" separated by spaces

  Output

  Rules
    More than one word? Reverse each word and combine first with second, third with fourth and so on (odd number of words => last one stays alone, but has to be reversed too)
    Start it again until there's only one word without spaces
    Return your result

Example
  reverse_and_combine_text("abc def") == "cbafed")
  reverse_and_combine_text("abc def ghi jkl") == "defabcjklghi"
  reverse_and_combine_text("dfghrtcbafed") == "dfghrtcbafed"
  reverse_and_combine_text("234hh54 53455 sdfqwzrt rtteetrt hjhjh lllll12  44") == "trzwqfdstrteettr45hh4325543544hjhjh21lllll"
  reverse_and_combine_text("sdfsdf wee sdffg 342234 ftt") == "gffds432243fdsfdseewttf"

Data Structure
  Array

Algo
  Split our string intput into an array of words (arr_words)
  if arr_words length is one, return that element as is
  if arr_words length > 1
    Reverse each element
    Join pairs together
    Repeat until the array length is one
    Return the element in that array (string object)
=end
def reverse_and_combine_text(str_input)
  return str_input if str_input.split.length == 1
  reversed_arr = str_input.split
  loop do
    reversed_arr = reversed_arr.map do |word|
      word.reverse
    end

    reversed_arr = reversed_arr.each_slice(2).map do |pair|
      pair.length == 2 ? pair[0] + pair[1] : pair
    end.flatten

    return reversed_arr.first if reversed_arr.length == 1
  end
end

# *63) https://www.codewars.com/kata/59fd6d2332b8b9955200005f/ruby
=begin
Problem
You will be given two integers n and k and your task is to remove k-digits from n and return the lowest number possible, without changing the order of the digits in n. Return the result as a string.

  Input
    2 integer objects

  Output
    String

  Rules

Examples
  solve(123056,1) == '12056'
  solve(123056,2) == '1056'
  solve(123056,3) == '056'
  solve(123056,4) == '05'
  solve(1284569,1) == '124569'
  solve(1284569,2) == '12456'
  solve(1284569,3) == '1245'
  solve(1284569,4) == '124'

Data Structures
  Array

Algo
  Break up our n into an array of digits (make sure to reverse the .digits return value!), converting it to a string - arr_digits
  We iterate through arr_digits, k times
    On each iteration
      Compare whether the left digit is less than the digit to it's right
        If it is, next
        If it isn't, we want to:
          Destructively remove the left digit from arr_digits
            We could use 'sub' here to remove only first instance
    After we finish iterating:
      Join arr_digits back together (which will return a string)
=end
def solve(n, k)
  arr_digits = n.digits.reverse.map { |digit| digit.to_s }

  k.times do |_|
    arr_length_prior = arr_digits.length
    arr_digits.each_cons(2) do |a, b|
      if a <= b
        next
      else
        arr_digits.delete_at(arr_digits.index(a))
        break
      end
    end
    arr_digits.pop if arr_length_prior == arr_digits.length
  end

  arr_digits.join
end

# Alt solution without cons (helps with cons not assessing the last digit by itself)
def solve(integer1, remove)
  digits_array = integer1.digits.reverse
  
  remove.times do     
    digits_array.each_with_index do |digit, index|      
      if digits_array[index + 1] != nil && digit > digits_array[index + 1]
        digits_array.delete_at(index)
        break
      elsif digits_array[index + 1] == nil
        digits_array.delete_at(index)
        break
      end
    end    
  end
  
  digits_array.map! { |digit| digit.to_s }
  digits_array.join  
end

# Alt solution
def solve(n,k)
  n.digits.reverse.combination(n.digits.size - k).map(&:join).min
end
