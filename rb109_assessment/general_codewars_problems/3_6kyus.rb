# 1) Sort elements in an array by decreasing frequency of elements. If two elements have the same frequency, sort them by increasing value. 
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

# 2) Assume "#" is like a backspace in string. This means that string "a#bc#d" actually is "bd". Your task is to process a string with "#" symbols.
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

# 3) Define a function that takes one integer argument and returns logical value true or false depending on if the integer is a prime. Per Wikipedia, a prime number (or a prime) is a natural number greater than 1 that has no positive divisors other than 1 and itself. You can assume you will be given an integer input.You can not assume that the integer will be only positive. You may be given negative numbers as well (or 0).
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

# 4) You will create the classic Pascal's triangle. Your function will be passed the depth of the triangle and your code has to return the corresponding pascal triangle up to that depth. The triangle should be returned as a nested array.
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

# 5) Your task, is to create NxN multiplication table, of size provided in parameter. 
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

# 6) Implement the encode function, using the following steps:
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

# 7) You will be given an array of arrays and your task will be to return the number of unique arrays that can be formed by picking exactly one element from each subarray. 
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

# 8) Given the initial configuration of the cubes inside of the box as a 2D array, determine how the cubes are arranged after Bob switches the gravity. The box is 3D, with small cubes arranged in a matrix of n×m columns. It can change gravity to go in a certain direction, which can be 'L', 'R', 'D', and 'U' (left, right, down, and up).
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

# 9) Write a function that when given a number >= 0, returns an Array of ascending length subarrays, populated by 1's.
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
    num.times.map { |_| 1 }
  end
end

# Suggested solution
def pyramid(numbers)
  # The * notation allows us to multiply each element in the array n times.
  (1..numbers).map { |n| [1] * n }
end

# 10) We need to create a function to calculate an index. The index is calculated based on how many vowels are repeated more than once in a row and dividing them by the total number of vowels in a string. There will always be at least 1 vowel, and non-round integers should be rounded to 2 decimal places.
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

# 11) Given a number, return a string with dash'-'marks before and after each odd integer, but do not begin or end the string with a dash mark.
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

# 12) Given an integer n (n > 1), the function cycle(n) returns the length of the cycle if n and 10 are coprimes, otherwise returns -1.
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

# 13) See this description: https://www.codewars.com/kata/5f70c55c40b1c90032847588
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

# 14) You have an array of numbers. Your task is to sort ascending odd numbers but even numbers must be on their places. Zero isn't an odd number and you don't need to move it. If you have an empty array, you need to return it.
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

# 15) Read this: https://www.codewars.com/kata/5ce399e0047a45001c853c2b
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

# 16)  You are given N ropes, where the length of each rope is a positive integer. At each step, you have to reduce all the ropes by the length of the smallest rope. The step will be repeated until no ropes are left. Given the length of N ropes, print the number of ropes that are left before each step.
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

# 17) Given a positive integer n written as abcd... (a, b, c, d... being digits) and a positive integer p, we want to find a positive integer k, if it exists, such as the sum of the digits of n taken to the successive powers of p is equal to k * n.
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

# 18) A triangle number is a number where n objects form an equilateral triangle. Check if a given input is a valid triangle number. Return true if it is, false if it is not (note that any non-integers, including non-number types, are not triangle numbers). You are encouraged to develop an effective algorithm: test cases include really big numbers.
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

# 19) Given a List [] of n integers , find minimum number to be inserted in a list, so that sum of all elements of list should equal the closest prime number .
=begin
minimum_number([3,1,2]) == 1
minimum_number([5,2]) == 0
minimum_number([1,1,1]) == 0
minimum_number([2,12,8,4,6]) == 5
minimum_number([50,39,49,6,17,28]) == 2
=end
def minimum_number(array)
  base = array.reduce(:+)
  increment = 0
  loop do
    break if (2..Math.sqrt(base + increment)).none? { |divisor| (base + increment) % divisor == 0 }
    increment += 1
  end
  increment
end

# 20) Given two arrays of strings a1 and a2, return a sorted array r in lexicographical order of the strings of a1 which are substrings of strings of a2. r must have no duplicates. Don't mutate the inputs.
=begin
a1 = ["arp", "live", "strong"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
==> ["arp", "live", "strong"]

a1 = ["tarp", "mice", "bull"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
==> []
=end
def in_array(array1, array2)
  return_array = []
  array2.map do |comparison|
    array1.select do |comparer|
      comparison.include?(comparer)
    end
  end.flatten.uniq.sort
end

# 21) In this Kata, you will be given a number and your task will be to return the nearest prime number. If difference is equal, pick the lower one.
=begin
solve(3) == 3
solve(11) == 11
solve(4) == 3
solve(110) == 109
solve(1110) == 1109
=end
def solve(n)
  upward = n
  downward = n
  until (2..(Math.sqrt(upward))).none? { |divisor| upward % divisor == 0 } == true
    upward += 1
  end
  until (2..(Math.sqrt(downward))).none? { |divisor| downward % divisor == 0 } == true
    downward -= 1
  end
  
  n - downward > upward - n ? upward : downward
end

# 22) In this Kata, you will be given a number n (n > 0) and your task will be to return the smallest square number N (N > 0) such that n + N is also a perfect square. If there is no answer, return -1.
=begin
# because 36 is the smallest perfect square that can be added to 13 to form a perfect square => 13 + 36 = 49
solve(13) = 36
solve(3) = 1 # 3 + 1 = 4, a perfect square
solve(12) = 4 # 12 + 4 = 16, a perfect square
solve(9) = 16 
solve(4) = -1
=end
# This passes our test cases, but it's too slow.
def solve(number)
  perfect_squares = (1..Math.sqrt(number)).map { |num| num ** 2 }
  answer = perfect_squares.select do |square|
    perfect_squares.include?(square + number)
  end.min 
  answer ? answer : -1
end

# Suggested solution
def solve n
  ans = -1 
  (1..[n**0.5,5].max).each do |i| 
    r = (n-i*i) / (2.0*i)
    ans = r*r if r > 0 and r % 1 == 0
  end
  ans
end

# 23) You will be given a seed value for the test series and your task will be to return the number of integers that have to be generated in the test series before it converges to the base series. 
=begin
1, 2, 4, 8, 16, 22, 26, 38, 62, 74, 102, 104, 108, 116, 122
  For single digit integers, add the number to itself to get the next element.
  For other integers, multiply all the non-zero digits and add the result to the original number to get the next element.

Let's begin the same series with a seed value of 3 instead of 1:

3, 6, 12, 14, 18, 26, 38, 62, 74, 102, 104, 108, 116, 122

Notice that the two sequences converge at 26 and are identical therefter. We will call the series seeded by a value of 1 the "base series" and the other series the "test series".

You will be given a seed value for the test series and your task will be to return the number of integers that have to be generated in the test series before it converges to the base series. In the case above:

convergence(3) = 5, the length of [3, 6, 12, 14, 18]. 

convergence(3) == 5
convergence(5) == 6
convergence(10) == 5
convergence(15) == 2
convergence(500) == 29
convergence(5000) == 283
=end
def next_num(n)
  n < 10 ? n * 2 : n + n.digits.reject(&:zero?).reduce(:*)
end

def convergence(n)
  base = [1]
  test = [n]

  loop do
    next_base = next_num(base.last)
    next_test = next_num(test.last)

    if next_base == next_test
      break test.size
    # At some point, there will be a convergence, just not necessarily at the same position in the array
    elsif base.include?(next_test)
      break test.size
    elsif test.include?(next_base)
      break test.index(next_base)
    else
      base << next_base
      test << next_test
    end
  end
end

# 24) If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Finish the solution so that it returns the sum of all the multiples of 3 or 5 below the number passed in. Note: If the number is a multiple of both 3 and 5, only count it once. Also, if a number is negative, return 0.
=begin
solution(10) == 23
solution(20) == 78
solution(200) == 9168
=end
def solution(limit)
  return -1 if limit < 0
  (1...limit).select { |number| number % 3 == 0 || number % 5 == 0 }.reduce(0, &:+)
end

# 25) Given an array of integers, find the one that appears an odd number of times. There will always be only one integer that appears an odd number of times.
=begin
find_it([20,1,-1,2,-2,3,3,5,5,1,2,4,20,4,-1,-2,5]) == 5
find_it([1,1,2,-2,5,2,4,4,-1,-2,5]) == -1
find_it([20,1,1,2,2,3,3,5,5,4,20,4,5]) == 5
find_it([10]) == 10
find_it([1,1,1,1,1,1,10,1,1,1,1]) == 10
=end
def find_it(array)
  array.each_with_object ({}) do |integer, hash|
    hash.keys.include?(integer) ? hash[integer] += 1 : hash[integer] = 1
  end.select { |key, value| value.odd? }.keys.first
end

# 26) Digital root is the recursive sum of all the digits in a number. Given n, take the sum of the digits of n. If that value has more than one digit, continue reducing in this way until a single-digit number is produced. The input will be a non-negative integer.
=begin
    16  -->  1 + 6 = 7
   942  -->  9 + 4 + 2 = 15  -->  1 + 5 = 6
132189  -->  1 + 3 + 2 + 1 + 8 + 9 = 24  -->  2 + 4 = 6
493193  -->  4 + 9 + 3 + 1 + 9 + 3 = 29  -->  2 + 9 = 11  -->  1 + 1 = 2

digital_root(16) == 7
digital_root(942) == 6
digital_root(132189) == 6
digital_root(493193) == 2
=end
def digital_root(n)
  return n if n.digits.length == 1
  reduced_sum = n.digits.reduce(:+)
  loop do
    reduced_sum = reduced_sum.digits.reduce(:+)
    break if reduced_sum.digits.length == 1
  end
  reduced_sum
end

# Recursive method (mutating)
def digital_root(n)
  n < 10 ? n : digital_root(n.digits.sum)
end

# 27) Write a function, persistence, that takes in a positive parameter num and returns its multiplicative persistence, which is the number of times you must multiply the digits in num until you reach a single digit.
=begin
persistence(39) # returns 3, because 3*9=27, 2*7=14, 1*4=4
                # and 4 has only one digit

persistence(999) # returns 4, because 9*9*9=729, 7*2*9=126,
                # 1*2*6=12, and finally 1*2=2

persistence(4) # returns 0, because 4 is already a one-digit number

persistence(39) == 3
persistence(4) == 0
persistence(25) == 2
persistence(999) == 4
=end
def persistence(n)
  return 0 if n.digits.length == 1
  counter = 1
  multiply = n.digits.reduce(:*)
  loop do 
    break if multiply.digits.length == 1
    counter += 1
    multiply = multiply.digits.reduce(:*)
  end
  counter
end

# More recursion
def persistence(n)
  # Here, the return value on each iteration is 1 + (return value of next iteration. The final iteration ends up being 0)
  n < 10 ? 0 : 1 + persistence(n.digits.reduce(:*))
end

# 28) Write a function that takes in a string of one or more words, and returns the same string, but with all five or more letter words reversed (Just like the name of this Kata). Strings passed in will consist of only letters and spaces. Spaces will be included only when more than one word is present.
=begin
spinWords("Hey fellow warriors") == "Hey wollef sroirraw"
=end
def spinWords(string)
  string.split.map do |word|
    word.length >= 5 ? word.reverse : word
  end.join(' ')
end

# 29) Write a function that will return the count of distinct case-insensitive alphabetic characters and numeric digits that occur more than once in the input string. The input string can be assumed to contain only alphabets (both uppercase and lowercase) and numeric digits.
=begin
duplicate_count("") == 0
duplicate_count("abcde") == 0
duplicate_count("abcdeaa") == 1
duplicate_count("abcdeaB") == 2
duplicate_count("Indivisibilities") == 2
=end
def duplicate_count(string)
  string.downcase.chars.each_with_object({}) do |letter, hash|
    hash.keys.include?(letter) ? hash[letter] += 1 : hash[letter] = 1
  end.select { |key, value| value > 1 }.size
end

# 30) You are given an array (which will have a length of at least 3, but could be very large) containing integers. The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N. Write a method that takes the array as an argument and returns this "outlier" N.
=begin
find_outlier([0, 1, 2]) == 1
find_outlier([1, 2, 3]) == 2
find_outlier([2,6,8,10,3]) == 3
=end
def find_outlier(array)
  array.count { |digit| digit.odd? } > array.count { |digit| digit.even? } ? 
  array.select { |digit| digit.even? }.first :
  array.select { |digit| digit.odd? }.first
end

# Partition is a useful method:
def find_outlier(integers)
  odd, even = integers.partition(&:odd?)
  odd.length > 1 ? even[0] : odd[0]
end

# 31) Implement a function likes :: [String] -> String, which must take in input array, containing the names of people who like an item. It must return the display text as shown in the examples. For 4 or more names, the number in and 2 others simply increases.
=begin
likes [] -- must be "no one likes this"
likes ["Peter"] -- must be "Peter likes this"
likes ["Jacob", "Alex"] -- must be "Jacob and Alex like this"
likes ["Max", "John", "Mark"] -- must be "Max, John and Mark like this"
likes ["Alex", "Jacob", "Mark", "Max"] -- must be "Alex, Jacob and 2 others like this"
=end
def likes(names)
  plural = 'like this'
  singular = 'likes this'
  return "no one #{singular}" if names.length < 1
  case names.length
  when 1 then "#{names.first} #{singular}"
  when 2 then "#{names.first} and #{names.last} #{plural}"
  when 3 then "#{names.first}, #{names[1]} and #{names.last} #{plural}"
  else
    "#{names.first}, #{names[1]} and #{names.length - 2} others #{plural}"
  end
end

# 32) The goal of this exercise is to convert a string to a new string where each character in the new string is "(" if that character appears only once in the original string, or ")" if that character appears more than once in the original string. Ignore capitalization when determining if a character is a duplicate.
=begin
duplicate_encode("din") == "((("
duplicate_encode("recede") == "()()()"
duplicate_encode("Success") == ")())())"
duplicate_encode("(( @") =="))(("
=end
def duplicate_encode(string)
  duplicates = string.downcase.chars.each_with_object({}) do |character, hash|
    hash.keys.include?(character) ? hash[character] += 1 : hash[character] = 1
  end.select { |key, value| value > 1 }.keys

  string.downcase.chars.map do |character|
    duplicates.include?(character) ? ')' : '('
  end.join
end

# Use count on the original string!
def duplicate_encode(word)
  word.downcase.chars.map do |char| 
    word.downcase.count(char) > 1 ? letter = ')' : letter = '(' 
  end.join
end

# 33) You always walk only a single block for each letter (direction) and you know it takes you one minute to traverse one city block, so create a function that will return true if the walk the app gives you will take you exactly ten minutes (you don't want to be early or late!) and will, of course, return you to your starting point. Return false otherwise.
=begin
is_valid_walk(['n','s','n','s','n','s','n','s','n','s']) == true
is_valid_walk(['w','e','w','e','w','e','w','e','w','e','w','e']) == false
is_valid_walk(['w']) == false
is_valid_walk(['n','n','n','s','n','s','n','s','n','s']) == false
=end
def is_valid_walk(array)
  return false if array.length != 10
  direction_count = array.each_with_object({}) do |direction, hash|
    hash.keys.include?(direction) ? hash[direction] += 1 : hash[direction] = 1
  end
  direction_count['n'] == direction_count['s'] && direction_count['e'] == direction_count['w']
end

# Shorter lol
def isValidWalk(walk)
  walk.count('w') == walk.count('e') &&
  walk.count('n') == walk.count('s') &&
  walk.count == 10
end

# 34) Write a function that takes an integer as input, and returns the number of bits that are equal to one in the binary representation of that number. You can guarantee that input is non-negative.
=begin
count_bits(0) == 0
count_bits(4) == 1
count_bits(7) == 3
count_bits(9) == 2
count_bits(10) == 2
=end
def count_bits(integer)
  bits = []
  loop do
    a, b =  integer.divmod(2)
    bits << b
    integer = a
    break if a == 0 
  end
  bits.count(1)
end

# Shorter
def count_bits(n)
  # .to_s(2) converts a number to binary
  n.to_s(2).count("1")
end

# 35) Implement a difference function, which subtracts one list from another and returns the result. It should remove all values from list a, which are present in list b. If a value is present in b, all of its occurrences must be removed from the other.
=begin
array_diff([1,2], [1]) == [2]
array_diff([1,2,2], [1]) == [2,2]
array_diff([1,2,2], [2]) == [1]
array_diff([1,2,2], []) == [1,2,2]
array_diff([], [1,2]) == []
=end
def array_diff(a, b)
  a_dup = a.dup
  b.each do |element|
    a_dup.delete(element) if a_dup.include?(element)
  end
  a_dup
end

#lmao
def array_diff(a, b)
  a - b
end

# 36) Your task is to sort a given string. Each word in the string will contain a single number. This number is the position the word should have in the result. If the input string is empty, return an empty string. The words in the input String will only contain valid consecutive numbers.
=begin
order("is2 Thi1s T4est 3a") == "Thi1s is2 3a T4est"
order("4of Fo1r pe6ople g3ood th5e the2") == "Fo1r the2 g3ood 4of th5e pe6ople"
order("") == ""
=end
def order(sentence)
  ordered_arr = []
  num = 1
  loop do 
    sentence.split.each do |word|
      ordered_arr << word if word.include?(num.to_s)
    end
    num += 1
    break if ordered_arr.length == sentence.split.length
  end
  ordered_arr.join(' ')
end

# 37) Create a fibonacci function that given a signature array/list, returns the first n elements - signature included of the so seeded sequence.
=begin
tribonacci([1,1,1],10) == [1,1,1,3,5,9,17,31,57,105]
tribonacci([0,0,1],10) == [0,0,1,1,2,4,7,13,24,44]
tribonacci([0,1,1],10) == [0,1,1,2,4,7,13,24,44,81]
tribonacci([1,0,0],10) == [1,0,0,1,1,2,4,7,13,24]
tribonacci([0,0,0],10) == [0,0,0,0,0,0,0,0,0,0]
tribonacci([1,2,3],10) == [1,2,3,6,11,20,37,68,125,230]
tribonacci([3,2,1],10) == [3,2,1,6,9,16,31,56,103,190]
tribonacci([1,1,1],1) == [1]
=end
# This passes, but takes too long. 
def tribonacci(array, num)
  return [] if num == 0
  output_array = array.dup
  loop do
    break if output_array.length == num
    output_array << output_array.last(3).reduce(:+)
  end
  output_array
end

# Non-timeout solution
def tribonacci(signature,n)
  n.times.map do |_| 
    signature << signature.reduce(:+)
    # Map creates an array of the return value of the block. In our case, the first element of signature is returned on each iteration.
    # This also has the effect of incrementing the numbers that are summed on each iteration
    # Signature is kept to 4 elements max at a time to reduce run-time.
    signature.shift 
  end
end

# 38) Given a string, replace every letter with its position in the alphabet. If anything in the text isn't a letter, ignore it and don't return it.
=begin
alphabet_position("The sunset sets at twelve o' clock.") == "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11"
alphabet_position("-.-'") == ""
=end
def alphabet_position(sentence)
  comparison_hash = ('a'..'z').zip('1'..'26').to_h
  sentence.downcase.chars.map do |letter|
    comparison_hash[letter]
  end.select do |values|
    values != nil
  end.join(' ')
end

# A mutating method
def alphabet_position(text)
  str = text.delete("^a-zA-Z")
  # Subtracting 96 from the .bytes value gives the alphabetical position
  string = str.downcase.bytes.map{|b| b - 96}
  string.join(" ")
end

# 39) Write a function that accepts an array of 10 integers (between 0 and 9), that returns a string of those numbers in the form of a phone number.
=begin
createPhoneNumber([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == "(123) 456-7890"
createPhoneNumber([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) == "(111) 111-1111"
createPhoneNumber([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == "(123) 456-7890"
=end
def createPhoneNumber(array)
  a = array.first(3).join
  b = array[3..5].join
  c = array.last(4).join
  "(#{a}) #{b}-#{c}"
end

# Neater solution using multiple assignment
def createPhoneNumber(digits)
  # Splat operator captures everything not assigned to a, b
  a, b, *c = digits.each_slice(3).map { |slice| slice.join }
  "(#{a}) #{b}-#{c.join}"
end

# 40) Let's assume that a song consists of some number of words (that don't contain WUB). To make the dubstep remix of this song, Polycarpus inserts a certain number of words "WUB" before the first word of the song (the number may be zero), after the last word (the number may be zero), and between words (at least one between any pair of neighbouring words), and then the boy glues together all the words, including "WUB", in one string and plays the song at the club. For example, a song with words "I AM X" can transform into a dubstep remix as "WUBWUBIWUBAMWUBWUBX" and cannot transform into "WUBWUBIAMWUBX".
=begin
song_decoder("AWUBBWUBC") == "A B C"
song_decoder("AWUBWUBWUBBWUBWUBWUBC") == "A B C"
song_decoder("WUBAWUBBWUBCWUB") == "A B C"
=end
def song_decoder(string)
  string.gsub('WUB', ' ').strip.gsub(/\s+/, ' ')
end

# Another method
def song_decoder(song)
  song.gsub('WUB', ' ').strip.squeeze(' ')
end

# 41) You are going to be given an array of integers. Your job is to take that array and find an index N where the sum of the integers to the left of N is equal to the sum of the integers to the right of N. If there is no index that would make this happen, return -1. If you are given an array with multiple answers, return the lowest correct index. 
=begin
find_even_index([1,2,3,4,3,2,1]) == 3
find_even_index([1,100,50,-51,1,1]) == 1
find_even_index([1,2,3,4,5,6]) == -1
find_even_index([20,10,30,10,10,15,35]) == 3
find_even_index([20,10,-80,10,10,15,35]) == 0
find_even_index([10,-80,10,10,15,35,20]) == 6
=end
def find_even_index(array)
  slide_index = 0
  loop do
    break slide_index if array[0...slide_index].reduce(0, &:+) == array[slide_index + 1..-1].reduce(0, &:+)
    break -1 if slide_index == array.length - 1
    slide_index += 1
  end
end

# Another solution
def find_even_index(arr)
  left_sum = 0
  right_sum = arr.reduce(:+)
  
  arr.each_with_index do |e, ind|
    right_sum -= e
    
    return ind if left_sum == right_sum

    left_sum += e
  end
  
  -1  
end

# 42) Implement the function unique_in_order which takes as argument a sequence and returns a list of items without any elements with the same value next to each other and preserving the original order of elements.
=begin
unique_in_order('AAAABBBCCDAABBB') == ['A', 'B', 'C', 'D', 'A', 'B']
unique_in_order('ABBCcAD')         == ['A', 'B', 'C', 'c', 'A', 'D']
unique_in_order([1,2,2,3,3])       == [1,2,3]
=end
def unique_in_order(sequence)
  array_seq = sequence.is_a?(String) ? sequence.chars : sequence
  uniq_array = []
  array_seq.each do |element|
    uniq_array << element if uniq_array.last != element
  end
  uniq_array
end

# 43) The new "Avengers" movie has just been released! There are a lot of people at the cinema box office standing in a huge line. Each of them has a single 100, 50 or 25 dollar bill. An "Avengers" ticket costs 25 dollars. Vasya is currently working as a clerk. He wants to sell a ticket to every single person in this line. Can Vasya sell a ticket to every person and give change if he initially has no money and sells the tickets strictly in the order people queue? Return YES, if Vasya can sell a ticket to every person and give change with the bills he has at hand at that moment. Otherwise return NO.
=begin
tickets([25, 25, 50]) == 'YES' 

# Vasya will not have enough money to give change to 100 dollars
tickets([25, 100])  == 'NO'. 

# Vasya will not have the right bills to give 75 dollars of change (you can't make two bills of 25 from one of 50)
tickets([25, 25, 50, 50, 100]) == 'NO' 
=end
def tickets(people)
  money = people.each_with_object({}) do |bill, hash|
    hash.keys.include?(bill) ? hash[bill] += 1 : hash[bill] = 1
  end

  people.each do |bill|
    case bill
    when 25
      money[25] += 1
    when 50
      return 'NO' if money[25] == 0
      money[25] -= 1
      money[50] += 1
    when 100
      if money[50] >= 1 and money[25] >= 1
        money[50] -= 1
        money[25] -= 1
      elsif money[25] >= 3
        money[25] -= 3
      else
        return 'NO'
      end
    end
  end
  'YES'
end

# 45) There is a queue for the self-checkout tills at the supermarket. Your task is write a function to calculate the total time required for all the customers to check out!
=begin
inputs:
  customers: an array of positive integers representing the queue. Each integer represents a customer, and its value is the amount of time they require to check out.
  n: a positive integer, the number of checkout tills

queue_time([5,3,4], 1)
# should return 12
# because when n=1, the total time is just the sum of the times

queue_time([10,2,3,3], 2)
# should return 10
# because here n=2 and the 2nd, 3rd, and 4th people in the 
# queue finish before the 1st person has finished.

queue_time([2,3,10], 2)
# should return 12
=end
def queue_time(customers, n)
  occupied_tills = []
  [customers.length, n].min.times { occupied_tills << customers.shift }
  customers.each do |customer|
    occupied_tills[occupied_tills.index(occupied_tills.min)] += customer
  end
  occupied_tills.max ? occupied_tills.max : 0
end

# 43) You are given an array(list) strarr of strings and an integer k. Your task is to return the first longest string consisting of k consecutive strings taken in the array.
=begin
strarr = ["tree", "foling", "trashy", "blue", "abcdef", "uvwxyz"], k = 2

Concatenate the consecutive strings of strarr by 2, we get:

treefoling   (length 10)  concatenation of strarr[0] and strarr[1]
folingtrashy ("      12)  concatenation of strarr[1] and strarr[2]
trashyblue   ("      10)  concatenation of strarr[2] and strarr[3]
blueabcdef   ("      10)  concatenation of strarr[3] and strarr[4]
abcdefuvwxyz ("      12)  concatenation of strarr[4] and strarr[5]

Two strings are the longest: "folingtrashy" and "abcdefuvwxyz".
The first that came is "folingtrashy" so 
longest_consec(strarr, 2) should return "folingtrashy".

In the same way:
longest_consec(["zone", "abigail", "theta", "form", "libe", "zas", "theta", "abigail"], 2) --> "abigailtheta"
=end
def longest_consec(strarr, k)
  return '' if k <= 0 || strarr.length == 0 || k > strarr.length
  concat_words = strarr.each_cons(k).map do |pair|
    pair.join
  end
  
  max_length = concat_words.map do |words|
    words.length
  end.max

  concat_words.select do |words|
    words.length == max_length
  end.first
end

# max_by could help here
def longest_consec(strarr, k)
  return "" unless k.between?(1, strarr.length)
  strarr.each_cons(k).map(&:join).max_by(&:length) || ""
end

# 44) Your task is to construct a building which will be a pile of n cubes. The cube at the bottom will have a volume of n^3, the cube above will have volume of (n-1)^3 and so on until the top which will have a volume of 1^3. You are given the total volume m of the building. Being given m can you find the number n of cubes you will have to build? You have to return the integer n such as n^3 + (n-1)^3 + ... + 1^3 = m if such a n exists or -1 if there is no such n.
=begin
find_nb(1071225) == 45
find_nb(91716553919377) == -1
=end
def find_nb(m)
  counter = 0
  while m > 0
    counter += 1
    m -= counter ** 3
  end
  m == 0 ? counter : -1
end

# 45) Given two arrays a and b write a function comp(a, b) that checks whether the two arrays have the "same" elements, with the same multiplicities. "Same" means, here, that the elements in b are the elements in a squared, regardless of the order. If a or b are nil, return false
def comp(array1, array2)
  return false if array1 == nil || array2 == nil
  array1.sort.map { |num| num ** 2 } == array2.sort
end

#46) Complete the method/function so that it converts dash/underscore delimited words into camel casing. The first word within the output should be capitalized only if the original word was capitalized (known as Upper Camel Case, also often referred to as Pascal case). 
=begin
to_camel_case('') == ''
to_camel_case("the_stealth_warrior") == "theStealthWarrior"
to_camel_case("The-Stealth-Warrior") == "TheStealthWarrior"
to_camel_case("A-B-C") == "ABC"
=end
def to_camel_case(str)
  str.split(/[-_]/).map.with_index do |word, index|
    index != 0 ? word.capitalize : word
  end.join
end

# Without regex
def to_camel_case(str)
  str.gsub('_', '-').split('-').map.with_index do |word, index|
    index != 0 ? word.capitalize : word
  end.join
end

# 47) Given: an array containing hashes of names, Return: a string formatted as a list of names separated by commas except for the last two names, which should be separated by an ampersand.
=begin
list([ {name: 'Bart'}, {name: 'Lisa'}, {name: 'Maggie'} ])
# returns 'Bart, Lisa & Maggie'

list([ {name: 'Bart'}, {name: 'Lisa'} ])
# returns 'Bart & Lisa'

list([ {name: 'Bart'} ])
# returns 'Bart'

list([])
# returns ''
=end
def list names
  names = names.map { |name| name[:name] }
  last_name = names.pop
  return last_name.to_s if names.empty?
  "#{names.join(', ')} & #{last_name}"
end

# 48) Your code must return true or false depending upon whether the given number is a Narcissistic number in base 10. A Narcissistic Number is a positive number which is the sum of its own digits, each raised to the power of the number of digits in a given base. In this Kata, we will restrict ourselves to decimal (base 10).
=begin
narcissistic?(5) == true
narcissistic?(153) == true
narcissistic?(1633) == false
=end
def narcissistic?(num)
  num.digits.map do |digit|
    digit ** num.digits.length
  end.reduce(:+) == num
end

# 49) There is an array with some numbers. All numbers are equal except for one. Try to find it! It’s guaranteed that array contains at least 3 numbers. The tests contain some very huge arrays, so think about performance.
=begin
find_uniq([ 1, 1, 1, 2, 1, 1 ]) == 2
find_uniq([ 0, 0, 0.55, 0, 0 ]) == 0.55
=end
# This works. It's just too slow
def find_uniq(array)
  array.sort_by do |a, b|
    array.count(a)
  end.first
end

# This is fast.
def find_uniq(array)
  common_nums = []
  array.each do |number|
    if number == common_nums.last
      array.delete(number)
    else
      common_nums << number
    end
  end
  array.first
end

# 50) Write a method that takes an array of consecutive (increasing) letters as input and that returns the missing letter in the array. You will always get an valid array. And it will be always exactly one letter be missing. The length of the array will always be at least 2. The array will always contain letters in only one case.
=begin
find_missing_letter(["a","b","c","d","f"]) == "e"
find_missing_letter(["O","Q","R","S"]) == "P"
find_missing_letter(["b","d"]) == "c"
find_missing_letter(["a","b","d"]) == "c"
find_missing_letter(["b","d","e"]) == "c"
=end
def find_missing_letter(arr)
  comparison_array = ('a'..'z').to_a
  comparison_array.map! { |letter| letter.upcase } if !comparison_array.include?(arr.first)
  (comparison_array[comparison_array.index(arr.first).. comparison_array.index(arr.first) + arr.length + 1] - arr).first
end

# Smart
def find_missing_letter(arr)
  ((arr.first..arr.last).to_a - arr).first
end

# 51) A pangram is a sentence that contains every single letter of the alphabet at least once. For example, the sentence "The quick brown fox jumps over the lazy dog" is a pangram, because it uses the letters A-Z at least once (case is irrelevant). Given a string, detect whether or not it is a pangram. Return True if it is, False if not. Ignore numbers and punctuation.
=begin
panagram?("The quick brown fox jumps over the lazy dog.") == true
panagram?("This is not a pangram.") == false
=end
def panagram?(sentence)
  ('a'..'z').select do |letter|
    sentence.downcase.include?(letter)
  end == ('a'..'z').to_a
end

# Here's how to use all?
def panagram?(string)
  ('a'..'z').all? { |x| string.downcase.include? (x) } 
end

# 52) Given a list lst and a number N, create a new list that contains each number of lst at most N times without reordering. 
=begin
For example if N = 2, and the input is [1,2,3,1,2,1,2,3], you take [1,2,3,1,2], drop the next [1,2] since this would lead to 1 and 2 being in the result 3 times, and then take 3, which leads to [1,2,3,1,2,3].

delete_nth ([1,1,1,1],2) == [1,1]
delete_nth ([20,37,20,21],1) == [20,37,21]
delete_nth([1,1,3,3,7,2,2,2,2], 3) == [1, 1, 3, 3, 7, 2, 2, 2]
=end
def delete_nth(order, max_e)
  order.each_with_object([]) do |number, deduped|
    deduped << number if deduped.count(number) < max_e
  end
end

# 53) Complete the solution so that it splits the string into pairs of two characters. If the string contains an odd number of characters then it should replace the missing second character of the final pair with an underscore ('_').
=begin
solution("abcdef") == ["ab", "cd", "ef"]
solution("abcdefg") == ["ab", "cd", "ef", "g_"]
solution("") == []
=end
def solution(sentence)
  sentence.chars.each_slice(2).map do |pairs|
    (pairs.length < 2 ? pairs << '_' : pairs).join
  end
end

# 54) Write a function that takes a string of braces, and determines if the order of the braces is valid. It should return true if the string is valid, and false if it's invalid. A string of braces is considered valid if all braces are matched with the correct brace. All input strings will be nonempty, and will only consist of parentheses, brackets and curly braces: ()[]{}.
=begin
validBraces( "()" ) == true
validBraces( "[(])" ) == false
=end
def validBraces(braces)
  stack = []
  braces.each_char do |c|
    stack.push ')' if c == '('
    stack.push ']' if c == '['
    stack.push '}' if c == '{'
    # We keep track of unclosed braces in the stack array, in reverse order
    # If we see that the brace gets closed, we remove that brace from the stack array
    # This only happens if the innermost opening bracket is immediately closed
    stack.pop if c == stack.last
  end
  braces.count('(') == braces.count(')') && braces.count('[') == braces.count(']') && braces.count('{') == braces.count('}') && stack.empty?
end

# 55) Write a function that takes an array of numbers (integers for the tests) and a target number. It should find two different items in the array that, when added together, give the target value. The indices of these items should then be returned in an array like so: [index1, index2]. For the purposes of this kata, some tests may have multiple answers; any valid solutions will be accepted. The input will always be valid (numbers will be an array of length 2 or greater, and all of the items will be numbers; target will always be the sum of two different items from that array).
=begin
two_sum([1, 2, 3], 4).sort == [0, 2]
two_sum([1234, 5678, 9012], 14690).sort == [1, 2]
two_sum([2, 2, 3], 4).sort == [0, 1]
=end
def two_sum(numbers, target)
  numbers.each_with_index do |n1, i1|
    # You can iterate the same thing within another loop!
    numbers.each_with_index do |n2, i2|
      return [i1, i2] if (n1 + n2) == target && i1 != i2
    end
  end
end
# 56) Given a string of words, you need to find the highest scoring word. Each letter of a word scores points according to its position in the alphabet: a = 1, b = 2, c = 3 etc. You need to return the highest scoring word as a string. If two words score the same, return the word that appears earliest in the original string. All letters will be lowercase and all inputs will be valid.
=begin
high('man i need a taxi up to ubud') == 'taxi'
high('what time are we climbing up the volcano') == 'volcano'
high('take me to semynak') == 'semynak'
high('aaa b') == 'aaa'
=end
def high(sentence)
  lookup = ('a'..'z').to_a.zip((1..26).to_a).to_h
  words_arr = sentence.split
  values = words_arr.map do |word|
    word.each_char.map do |letter|
      lookup[letter]
    end.reduce(:+)
  end
  words_arr[values.index(values.max)]
end

# 57) You will be given a number and you will need to return it as a string in Expanded Form.
=begin
expanded_form(12); # Should return '10 + 2'
expanded_form(42); # Should return '40 + 2'
expanded_form(70304); # Should return '70000 + 300 + 4'
=end
def expanded_form(number)
  digit_arr = number.digits.reverse
  multiplied = digit_arr.map.with_index do |number, index|
    number * 10 ** ((digit_arr.length - index) - 1) if number > 0
    # We could use .compact to remove nils
  end.select do |digit|
    digit != nil
  end
  remainder = multiplied[1..-1].map do |num|
    " + #{num}"
  end.join
  multiplied.first.to_s + remainder
end

# 58) The main idea is to count all the occurring characters in a string. If you have a string like aba, then the result should be {'a': 2, 'b': 1}. What if the string is empty? Then the result should be empty object literal, {}.
=begin
count_chars("aba") == {"a" => 2, "b" => 1}
count_chars("") == {}
=end
def count_chars(string)
  string.chars.each_with_object({}) do |letter, hash|
    hash.keys.include?(letter) ? hash[letter] += 1 : hash[letter] = 1
  end
end

# 59) In this simple Kata your task is to create a function that turns a string into a Mexican Wave. You will be passed a string and you must return that string in an array where an uppercase letter is a person standing up. 
=begin
wave("hello") == ["Hello", "hEllo", "heLlo", "helLo", "hellO"]
=end
def wave(string)
  (string.length).times.map do |integer|
    next if string[integer] == ' '
    base = string.chars
    base[integer] = base[integer].upcase
    base.join
  # next returns nil, but compact gets rid of the nil
  end.compact
end

# 60) A string is considered to be in title case if each word in the string is either (a) capitalised (that is, only the first letter of the word is in upper case) or (b) considered to be an exception and put entirely into lower case unless it is the first word, which is always capitalised. 

# Write a function that will convert a string into title case, given an optional list of exceptions (minor words). The list of minor words will be given as a string with each word separated by a space. Your function should ignore the case of the minor words string -- it should behave in the same way even if the case of the minor word string is changed. 

=begin
First argument (required): the original string to be converted.
Second argument (optional): space-delimited list of minor words that must always be lowercase except for the first word in the string.

title_case('a clash of KINGS', 'a an the of') == 'A Clash of Kings'
title_case('THE WIND IN THE WILLOWS', 'The In') == 'The Wind in the Willows'
title_case('the quick brown fox') == 'The Quick Brown Fox'
=end
def title_case(title, minor_words = '')
  return '' if title.length == 0
  sentence_arr = title.downcase.split
  new_sentence = sentence_arr.map do |word|
    if !minor_words.downcase.split.include?(word)
      broken_up = word.chars
      start = broken_up[0].upcase
      broken_up.delete_at(0)
      broken_up.insert(0, start).join
    else
      word
    end
  end.join(' ')
  new_sentence[0] = new_sentence[0].upcase
  new_sentence
end

# I forgot there was a capitalize method lol
def title_case(title, minor_words = '')
  title.capitalize.split.map do |a| 
    minor_words.downcase.split.include?(a) ? a : a.capitalize
  end.join(' ')
end

# 61) Write a function that receives two strings and returns n, where n is equal to the number of characters we should shift the first string forward to match the second. 
=begin
  shifted_diff("eecoff","coffee") == 4
  shifted_diff("Moose","moose") == -1
  shifted_diff("isn't","'tisn") == 2
  shifted_diff("Esham", "Esham") == 0
  shifted_diff("dog", "god") == -1
=end
def shifted_diff(str1, str2)
  rotation_counter = 0
  str1_arr = str1.chars
  loop do 
    return -1 if rotation_counter > str2.length
    return rotation_counter if str1_arr.join == str2
    last_el = str1_arr.pop
    str1_arr = str1_arr.insert(0, last_el)
    rotation_counter += 1
  end
end
