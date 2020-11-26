# 1) Given a string, return the minimal number of parenthesis reversals needed to make balanced parenthesis. 
=begin
solve(")(") = 2 Because we need to reverse ")" to "(" and "(" to ")". These are 2 reversals. 
solve("(((())") = 1 We need to reverse just one "(" parenthesis to make it balanced.
solve("(((") = -1 Not possible to form balanced parenthesis. Return -1.


solve(")()(") == 2
solve("((()") == 1
solve("(((") == -1
solve("())(((") == 3
solve("())()))))()()(") == 4
=end
def solve(str)
  return -1 if str.length.odd?
  o, c, t = [0, 0, 0]
  
  str.each_char do |p|
    if p == '('
      o += 1
    else
      c += 1
      # If the total number of closing > opening, we add one to t, which is the total number of changes
      # I don't understand why we are modifying o or c in the loop. It must be something to do with the position of the parentheses?
      if c > o
        o += 1
        c -= 1
        t += 1
      end
    end
  end

  # Why do we not do anything if c > o?
  if o > c
    t += (o - c) / 2
  end
  t
end

# 2) Sort elements in an array by decreasing frequency of elements. If two elements have the same frequency, sort them by increasing value. 
=begin
solve([2,3,5,3,7,9,5,3,7]) == [3,3,3,5,5,7,7,2,9]
solve([1,2,3,0,5,0,1,6,8,8,6,9,1]) == [1,1,1,0,0,6,6,8,8,2,3,5,9])
solve([5,9,6,9,6,5,9,9,4,4]) == [9,9,9,9,4,4,5,5,6,6])
solve([4,4,2,5,1,1,3,3,2,8]) == [1,1,2,2,3,3,4,4,5,8])
solve([4,9,5,0,7,3,8,4,9,0]) == [0,0,4,4,9,9,3,5,7,8])
=end
def solve(array)
  hash_count = Hash.new(0)

  array.each do |number|
    if hash_count.keys.include?(number)
      hash_count[number] += 1
    else
      hash_count[number] = 1
    end
  end

  hash_count = hash_count.sort_by do |key, value|
    [value, key]
  end.reverse

  hash_count_sort = hash_count.sort do |a, b|
    [b[1], a[0]] <=> [a[1], b[0]]
  end

  final_arr = []
  hash_count_sort.each do |pair|
    pair[1].times do |_|
      final_arr << pair[0]
    end
  end

  final_arr
end

# Suggested solution lmao
def solve(arr)
  # The negative sign allows you to reverse!
  arr.sort_by { |element| [-arr.count(element), element] }
end

# 3) Assume "#" is like a backspace in string. This means that string "a#bc#d" actually is "bd". Your task is to process a string with "#" symbols.
=begin
clean_string('abc#d##c') == "ac"
clean_string('abc####d##c#') == "" 
clean_string("#######") == ""
clean_string("") == ""
=end
def clean_string(string)
  keep_letters = []
  string.each_char do |char|
    char == '#' ? keep_letters.pop : keep_letters << char
  end
  keep_letters.join
end

# Using each_with_object
def clean_string(str)
  str.chars.each_with_object([]) { |ch, o| ch == "#" ? o.pop : o << ch }.join
end

# 4) Define a function that takes one integer argument and returns logical value true or false depending on if the integer is a prime. Per Wikipedia, a prime number (or a prime) is a natural number greater than 1 that has no positive divisors other than 1 and itself. You can assume you will be given an integer input.You can not assume that the integer will be only positive. You may be given negative numbers as well (or 0).
=begin
is_prime(1) == false
is_prime(2) == true
is_prime(-1) == false
=end
# This works, but times out on Codewars' weaksauce computers
def is_prime?(integer)
  return false if integer <= 1
  (2..integer).each_with_object([]) do |num, arr|
    arr << num if integer % num == 0
    return false if arr.length > 1
  end.length == 1
end

# Optimised solution
def is_prime?(num)
  # I am not sure how 'clean' this solution is, tbh. Not every integer will have a clean square root...
  num < 2 ? false : (2..Math.sqrt(num)).none?{ |i| num % i == 0 }
end

# 5) You will create the classic Pascal's triangle. Your function will be passed the depth of the triangle and you code has to return the corresponding pascal triangle up to that depth. The triangle should be returned as a nested array.
=begin
pascal(5) # should return [[1], [1,1], [1,2,1], [1,3,3,1], [1,4,6,4,1]]
=end
def pascal(rows)
  push_array = [[1]]
  counter = 1
  loop do
    break if counter >= rows
    new_arr = []
    push_array.last.each_cons(2) { |a, b| new_arr << [a, b].reduce(:+) }
    new_arr.insert(0, 1)
    new_arr.insert(-1, 1)
    push_array << new_arr
    counter +=1
  end
  push_array
end

# 6) Your task, is to create NxN multiplication table, of size provided in parameter. 
=begin
multiplication_table(3) == [[1,2,3],[2,4,6],[3,6,9]]

1 2 3
2 4 6
3 6 9

1 2 3 4
2 4 6 8
3 6 9 12
4 8 12 16
=end
def multiplication_table(size)
  push_array = [(1..size).to_a]
  loop do 
    break if push_array.size == size
    push_array << push_array.last.map.with_index do |number, index|
      number += (index + 1)
    end
  end
  push_array
end

# Suggested solution (shorter)
def multiplication_table(size)
  (1..size).map do |i|
    (1..size).map { |j| i * j }
  end
end

# 7) Implement the encode function, using the following steps:
=begin
  convert every letter of the text to its ASCII value;
  convert ASCII values to 8-bit binary;
  triple every bit;
  concatenate the result;

input: "hey"
--> 104, 101, 121                  // ASCII values
--> 01101000, 01100101, 01111001   // binary
--> 000111111000111000000000 000111111000000111000111 000111111111111000000111  // tripled
--> "000111111000111000000000000111111000000111000111000111111111111000000111"  // concatenated


encode("hey") == "000111111000111000000000000111111000000111000111000111111111111000000111"
encode("The Sensei told me that i can do this kata") == "000111000111000111000000000111111000111000000000000111111000000111000111000000111000000000000000000111000111000000111111000111111000000111000111000111111000111111111000000111111111000000111111000111111000000111000111000111111000111000000111000000111000000000000000000111111111000111000000000111111000111111111111000111111000111111000000000111111000000111000000000000111000000000000000000111111000111111000111000111111000000111000111000000111000000000000000000111111111000111000000000111111000111000000000000111111000000000000111000111111111000111000000000000111000000000000000000111111000111000000111000000111000000000000000000111111000000000111111000111111000000000000111000111111000111111111000000000111000000000000000000111111000000111000000000111111000111111111111000000111000000000000000000111111111000111000000000111111000111000000000000111111000111000000111000111111111000000111111000000111000000000000000000111111000111000111111000111111000000000000111000111111111000111000000000111111000000000000111"
encode("T3st") == "000111000111000111000000000000111111000000111111000111111111000000111111000111111111000111000000"
encode("T?st!%") == "000111000111000111000000000000111111111111111111000111111111000000111111000111111111000111000000000000111000000000000111000000111000000111000111"

=end
def encode(s)
  ascii = s.each_char.map { |char| char.ord }
  binary = ascii.map do |value|
    remainder = []
    a = 0
    loop do 
      a, b = value.to_i.divmod(2)
      remainder << b
      value = a
      break if a == 0
    end
    remainder.reverse.join
  end
  
  binary.each do |bin|
    until bin.length == 8
      bin.insert(0, '0')
    end
  end
  
  binary.map do |value|
    value.each_char.map do |digit|
      digit * 3
    end
  end.join
end

=begin
decode("100111111000111001000010000111111000000111001111000111110110111000010111") == "hey"
decode("000111000111000111000100000111111000111000001000000111111000010111000111000100111000000000000100000111000111000000111111000111111000000111000111000111111000111111111000000111111111000000111111000110111000000111000111000111111000111000000111000000111000000000000000000111111111000111000000000111111000111111111111000111111000111111000000000111111000000111000001000000111000000000001000000111111000111111000111000111111000000111000111000000111000000000000000000111111111000111000000000111111000111000000000000111111000000010000111000111111111000111000000000100111000000000000000000111111000111000000111000000111000000000000000000111111000000000111111000111111000000000000111000111111000111111111000000000111000000000000010000111111000000111000000000111111000111111110111000000111000000000000000000111111111000111000000000111111000111000000000000111111000111000000111000111111111000000111111000000111000000000000000000111111000111000111111000111111000000000000111000111111111000111000000000111111000000000000111") == "The Sensei told me that i can do this kata"
decode("000111000111000111000010000000111111000000111111000111111111000000111111000111111111000111010000") == "T3st"
decode("000111000111000111000001000000111111110111111111000111111111000000111111000111111111000111000000000000111000000000000111000000111000000111000111") == "T?st!%"
=end
def decode(s)
    corrected_chars = s.chars.each_slice(3).map do |triplet|
      triplet.map do |digit|
        triplet.count('0') > triplet.count('1') ? digit = '0' : digit = '1'
      end.uniq.join
    end

    bytes = corrected_chars.each_slice(8).each_with_object([]) do |byte, arr|
      arr << byte
    end

    ascii = bytes.map do |subarr|
      subarr.map.with_index do |element, index|
        element.to_i * 2 ** ((subarr.length - 1) - index)
      end.reduce(:+)
    end

    ascii.map do |ord|
      ord.chr
    end.join
end

# 8) You will be given an array of arrays and your task will be to return the number of unique arrays that can be formed by picking exactly one element from each subarray. 
=begin
# The below results in only 4 possiblites. They are [1,4,5],[1,4,6],[2,4,5],[2,4,6].
solve([[1,2],[4],[5,6]]) == 4

# We don't count duplicate combinations
solve([[1,2],[4,4],[5,6,6]]) == 4
solve([[1,2],[3,4],[5,6]]) == 8
solve([[1,2,3],[3,4,6,6,7],[8,9,10,12,5,6]]) == 72
=end
def solve(arr)
  arr.map { |subarr| subarr.uniq.length }.reduce(:*)
end 

# 9) Given the initial configuration of the cubes inside of the box as a 2D array, determine how the cubes are arranged after Bob switches the gravity. The box is 3D, with small cubes arranged in a matrix of n×m columns. It can change gravity to go in a certain direction, which can be 'L', 'R', 'D', and 'U' (left, right, down, and up).
=begin
BOX = [ [1, 3, 2],
        [4, 5, 1],
        [6, 5, 3],
        [7, 2, 9] ]

flip('R', BOX) ==
  [ [1, 2, 3],
    [1, 4, 5],
    [3, 5, 6],
    [2, 7, 9] ]

flip('L', BOX) ==
  [ [3, 2, 1],
    [5, 4, 1],
    [6, 5, 3],
    [9, 7, 2] ]

flip('U', BOX) ==
  [ [7, 5, 9],
    [6, 5, 3],
    [4, 3, 2],
    [1, 2, 1] ]

flip('D', BOX) ==
  [ [1, 2, 1],
    [4, 3, 2],
    [6, 5, 3],
    [7, 5, 9] ]
=end
def flip(direction, box)
  case direction
  when 'R' then box.map { |subarr| subarr.sort }
  when 'L' then box.map { |subarr| subarr.sort.reverse }
  when 'D' then box.transpose.map { |subarr| subarr.sort }.transpose
  when 'U' then box.transpose.map { |subarr| subarr.sort.reverse }.transpose
  end
end

# 10) Write a function that when given a number >= 0, returns an Array of ascending length subarrays, populated by 1's.
=begin
pyramid(0) == [ ]
pyramid(1) == [ [1] ]
pyramid(2) == [ [1], [1, 1] ]
pyramid(3) == [ [1], [1, 1], [1, 1, 1] ]
=end
def pyramid(numbers)
  answer_array = []
  return answer_array if numbers == 0
  (1..numbers).map do |num|
    num.times.map { |iteration| 1 }
  end
end

# Suggested solution
def pyramid(numbers)
  # The * notation allows us to multiply each element in the array n times.
  (1..numbers).map { |n| [1] * n }
end

# 11) We need to create a function to calculate an index. The index is calculated based on how many vowels are repeated more than once in a row and dividing them by the total number of vowels in a string. There will always be at least 1 vowel, and non-round integers should be rounded to 2 decimal places.
=begin
trump_detector("I will build a huge wall") == 0 
# 4 extra "U", 3 extra "E" and 5 extra "A" on 3 different vowel groups
trump_detector("HUUUUUGEEEE WAAAAAALL") == 4 
#14 extra vowels on 9 base ones
trump_detector("listen migrants: IIII KIIIDD YOOOUUU NOOOOOOTTT") == 1.56 

# 15 / 6
trump_detector("MEXICAAAAAAAANS GOOOO HOOOMEEEE") == 2.5

# 17 / 9
trump_detector("America NUUUUUKEEEE Oooobaaaamaaaaa") == 1.89
=end
def trump_detector(sentence)
  denom_counter = 0
  nom_counter = 0

  sentence.downcase.chars.each_cons(2) do |a, b| 
    if b == a && %w(a e i o u).include?(b)
      nom_counter += 1 
    elsif b != a && %w(a e i o u).include?(b)
      denom_counter += 1
    end
  end

  denom_counter += 1 if %w(a e i o u).include?(sentence.downcase[0])

  (nom_counter.to_f / denom_counter).round(2)
end

# 12) Given a number, return a string with dash'-'marks before and after each odd integer, but do not begin or end the string with a dash mark.
=begin
dashatize(274) == "2-7-4"
dashatize(5311) == "5-3-1-1"
dashatize(86320) == "86-3-20"
dashatize(974302) == "9-7-4-3-02"
dashatize(nil) == "nil"
dashatize(0) == "0"
dashatize(-1) == "1"
dashatize(-28369) == "28-3-6-9"
=end
def dashatize(num)
  return 'nil' if num == nil
  num_string = num.abs.digits.reverse.map do |digit|
    if digit.odd?
      digit = "-#{digit}-"
    else
      digit.to_s
    end
  end.join.gsub('--', '-')
  num_string[0] = '' if num_string[0] == '-'
  num_string[-1] = '' if num_string[-1] == '-'
  num_string
end

# 13) Given an integer n (n > 1), the function cycle(n) returns the length of the cycle if n and 10 are coprimes, otherwise returns -1.
=begin
cycle(5) == -1
cycle(13) == 6 -> 0.076923 076923 0769
cycle(21) == 6 -> 0.047619 047619 0476
cycle(27) == 3 -> 0.037 037 037 037 0370
cycle(33) == 2 -> 0.03 03 03 03 03 03 03 03
cycle(37) == 3 -> 0.027 027 027 027 027 0
cycle(94) == -1 
cycle(22) == -1 since 1/22 ~ 0.0 45 45 45 45
=end
def cycle(n)
  c = n.to_s.length
  cycles = 1
  r = (10 ** c) % n

  return -1 if (n % 2 == 0) || (n % 5 == 0) 

  until r == 10 ** (c - 1)
    r = (r * 10) % n
    cycles += 1
  end

  cycles
end

# 14) See this description: https://www.codewars.com/kata/5f70c55c40b1c90032847588
def points(dice)
  dice_counts = Hash.new(0)
  dice.chars.each do |die|
    if dice_counts.keys.include?(die)
      dice_counts[die] += 1
    else
      dice_counts[die] = 1
    end
  end
  
  return 50 if dice_counts.values.include?(5)
  return 40 if dice_counts.values.include?(4)
  return 30 if dice_counts.values.include?(3) && dice_counts.values.include?(2)
  return 20 if dice_counts.keys.count == 5 && dice_counts.keys.include?("5") && dice_counts.keys.include?("3")
  0
end

# Alternative syntax to my solution
def points(dice)
  counts = dice.chars.each_with_object({}) do |die, hash|
    # This is a conditional assignment operator. It means if a is undefined or falsey, then evaluate b and set a to the result.
    hash[die] ||= 0
    hash[die] += 1
  end
  
  return 50 if counts.values.any? { |c| c == 5 }
  return 40 if counts.values.any? { |c| c == 4 }
  return 30 if counts.values.any? { |c| c == 3 } && counts.values.any? { |c| c == 2 }
  return 20 if ['12345', '23456', '13456'].include?(dice.chars.sort.join)
  0
end

# 15) You have an array of numbers. Your task is to sort ascending odd numbers but even numbers must be on their places. Zero isn't an odd number and you don't need to move it. If you have an empty array, you need to return it.
=begin
sort_array([5, 3, 2, 8, 1, 4]) == [1, 3, 2, 8, 5, 4]
=end
def sort_array(array)
    odd_nums = []
    array.each_with_index do |number, index|
      odd_nums << [number, index] if number.odd? 
    end

    odd_nums_index = []
    odd_nums.each do |pair|
      odd_nums_index << pair[1]
    end

    odd_nums.sort!.each_with_index do |pair, index|
      array[odd_nums_index[index]] = pair[0]
    end

    array
end

# Shorter solution
def sort_array(source_array)
  odds = source_array.select(&:odd?).sort
  # [5, 3, 2, 8, 1, 4]
  # odds = [1, 3, 5]
  # This tests whether each element of the source array is even (map generates a new array)
    # If it's even, return that number
    # If it's odd, instead of using that number in the source_array, use the first number of the odds array, removing it from future iterations, allowing us to continually use .shift
  source_array.map { |n| n.even? ? n : odds.shift }
end

# 16) Read this: https://www.codewars.com/kata/5ce399e0047a45001c853c2b
=begin
ls = [1, 2, 3, 4, 5, 6] 
parts_sums(ls) -> [21, 20, 18, 15, 11, 6, 0]

ls = [744125, 935, 407, 454, 430, 90, 144, 6710213, 889, 810, 2579358]
parts_sums(ls) -> [10037855, 9293730, 9292795, 9292388, 9291934, 9291504, 9291414, 9291270, 2581057, 2580168, 2579358, 0]
=end
def parts_sums(ls)
  # Here, we set the end index to something outside of the range of ls, resulting in an empty array. That way, the reduce method will just add 0 (we defined this as a parameter)
  (0..ls.length).map { |idx| ls[idx..-1].reduce(0, &:+) }
end

# Fast solution
def parts_sums(ls)
  ls.reduce([ls.sum]) { |sums, x| sums << sums.last - x }
end

# 17)  You are given N ropes, where the length of each rope is a positive integer. At each step, you have to reduce all the ropes by the length of the smallest rope. The step will be repeated until no ropes are left. Given the length of N ropes, print the number of ropes that are left before each step.
=begin
a = [3, 3, 2, 9, 7] == [5, 4, 2, 1]
1. 5 ropes remain
2. 4 ropes remain (2 is removed)
3. 2 ropes remain (the two 3's are removed)
4. 1 rope remains (the 7 is removed)

cut_the_ropes([3, 3, 2, 9, 7]) == [5, 4, 2, 1]
cut_the_ropes([1, 2, 3, 4, 3, 3, 2, 1]) == [8, 6, 4, 1]
cut_the_ropes([13035, 6618, 13056, 20912, 1119, 13035, 6618, 6618, 8482, 13056]) == [10, 9, 6, 5, 3, 1]
cut_the_ropes([9, 9, 9, 9, 7]) == [5, 4]
=end
def cut_the_ropes(arr)
  array = arr.clone
  array_lengths = []
  until array.length < 1
    array_lengths << array.length
    array.delete(array.min)
  end
  array_lengths
end

# 18) Given a positive integer n written as abcd... (a, b, c, d... being digits) and a positive integer p, we want to find a positive integer k, if it exists, such as the sum of the digits of n taken to the successive powers of p is equal to k * n.
=begin
dig_pow(89, 1) should return 1 since 8¹ + 9² = 89 = 89 * 1
dig_pow(92, 1) should return -1 since there is no k such as 9¹ + 2² equals 92 * k
dig_pow(695, 2) should return 2 since 6² + 9³ + 5⁴= 1390 = 695 * 2
dig_pow(46288, 3) should return 51 since 4³ + 6⁴+ 2⁵ + 8⁶ + 8⁷ = 2360688 = 46288 * 51
=end
def dig_pow(n, p)
    power_array = (p..(p + n.digits.length - 1)).to_a
    array_sum = n.digits.reverse.map.with_index do |digit, index|
      digit ** power_array[index]
    end.reduce(:+)
    array_sum % n == 0 ? array_sum / n : -1
end

# 19) A triangle number is a number where n objects form an equilateral triangle. Check if a given input is a valid triangle number. Return true if it is, false if it is not (note that any non-integers, including non-number types, are not triangle numbers). You are encouraged to develop an effective algorithm: test cases include really big numbers.
=begin
# Triangle Number
  1
 2 3
4 5 6

# Not a triangle Number
   1
  2 3
 4 5 6
7 8

# Triangle number
       1
      2 3
     4 5 6
    7 8 9 10
 11 12 13 14 15
16 17 18 19 20 21

isTriangleNumber(3) == true
isTriangleNumber(5) == false
isTriangleNumber("hello!") == false
isTriangleNumber(6.15) == false"
=end
def isTriangleNumber(number)
  return false unless number.is_a? Fixnum
  number = 15
  (Math.sqrt(1+8*number)-1) % 2 == 0
end
