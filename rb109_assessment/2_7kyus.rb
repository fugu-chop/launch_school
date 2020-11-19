# 1) A number is called Automorphic number if and only if its square ends in the same digits as the number itself. Given a number determine if it Automorphic or not.
def automorphic(number)
  number.to_s == (number ** 2).to_s[-(number.to_s.length)..-1] ? 'Automorphic' : 'Not!!'
end

# 2) An element is leader if it is greater than The Sum all the elements to its right side. Given an array/list [] of integers , Find all the LEADERS in the array.
=begin
# 4 is greater than the sum all the elements to its right side. The last element 0 is equal to the sum of its right elements (abstract zero). 
arrayLeaders ([1, 2, 3, 4, 0]) ==> 4

# 5 and 17 are greater than the sum all the elements to its right side. The last element 2 is greater than the sum of its right elements (abstract zero). 
arrayLeaders ([16, 17, 4, 3, 5, 2]) ==> [17, 5, 2]

# The last element -1 is less than the sum of its right elements (abstract zero).
arrayLeaders ([5, 2, -1]) ==> [5, 2]

# The last element 2 is greater than the sum of its right elements (abstract zero). 
arrayLeaders ([0, -1, -29, 3, 2]) ==> [0, -1, 3, 2]
=end
def array_leaders(array)
  leader_array = []
  cum_sum = array[-1]
  leader_array << array[-1] if array[-1] > 0
  counter = array.length - 2
  while counter > -1
    leader_array.insert(0, array[counter]) if array[counter] > cum_sum
    cum_sum += array[counter]
    counter -= 1
  end
  leader_array
end

# Suggested solution
def array_leaders(numbers)
  numbers.select_with_index { |number, index| number > numbers[index + 1..-1].sum }
end

# 3) Write a function doubles that will remove double string characters that are adjacent to each other. The strings will contain lowercase letters only.
=begin
doubles('abbcccdddda') == 'aca'
a) There is only one 'a' on the left hand side, so it stays.
b) The 2 b's disappear because we are removing double characters that are adjacent. 
c) Of the 3 c's, we remove two. We are only removing doubles. 
d) The 4 d's all disappear, because we first remove the first double, and again we remove the second double.
e) There is only one 'a' at the end, so it stays.

doubles('abbbzz') == 'ab'

doubles('abba') == ""
When we remove the b's in 'abba', the double a that results is then removed.
=end
# Failed attempt (did not pass all test cases) - this is because we need to update the new string/array at each iteration, not after we identify all duplicates. This prevents issues like the last test case.
def doubles(string)
  string_dup = string.dup

  loop do
    new_string = string_dup.chars
    index = 1
    delete_chars = []
    while index <= new_string.length - 1 do
      delete_chars << new_string[index] if new_string[index] == new_string[index - 1]
      index += 1
    end
    
    delete_chars.each do |letter| 
      delete_chars << letter if delete_chars.count(letter).odd?
    end

    delete_chars.each do |letter|
      string_dup.sub!(letter, '')
    end
    break if delete_chars.length == 0
  end

  string_dup
end

# Suggested solution
def doubles(s)
  a = []
  s.each_char do |i|
    i == a[-1] ? a.pop : a.push(i)
  end
  a.join
end

# 4) Given an array of integers, find the maximum product obtained from multiplying 2 adjacent numbers in the array. The array size is at least 2 and could be a mixture of positives, negatives, also zeroes.
=begin
adjacent_element_product([1, 2, 3]) == 6
adjacent_element_product([9, 5, 10, 2, 24, -1, -48]) == 50
adjacent_element_product([-23, 4, -5, 99, -27, 329, -2, 7, -921]) == -14
=end
def adjacent_element_product(array)
  multiplication_result = []
  index = 0
  until index == array.length - 1
    multiplication_result << (array[index] * array[index + 1])
    index += 1
  end
  multiplication_result.max
end

# Suggested solution
def adjacent_element_product(array)
  array.each_cons(2).map { |a,b| a * b }.max
end

# 5) Given an array of integers, construct a product array of same size such that prod[i] is equal to the product of all the elements of arr[] except arr[i]. The array size is at least 2 and will be only contain positive integers. Repetition of numbers in the array could occur.
=begin
# The first element in prod [] array 12 is the product of all array's elements except the first element
# The second element 20 is the product of all array's elements except the second element .
product_array ([12,20]) == [20, 12]

# The first element 10 is the product of all array's elements except the first element 
# The second element 2 is the product of all array's elements except the second element
# The Third element 5 is the product of all array's elements except the Third element
product_array ([1,5,2]) == [10,2,5]

product_array ([10,3,5,6,2]) == [180,600,360,300,900]
=end
def product_array(array)
  multiply_array = []
  index_counter = 0
  until index_counter > array.length - 1
    multiply_array << array.select.with_index do |_, index|
      index != index_counter
    end.reduce(:*)
    index_counter += 1
  end
  multiply_array
end

# Suggested solution
def product_array(numbers)
  numbers.map { |x| (numbers.reduce(:*)) / x }
end

# 5) Given an array of integers, find the maximum difference between the successive elements in its sorted form. The array size is at least 3. The numbers Will be mixture of positives, negatives and zeros. Repetition of numbers in the array could occur. The maximum gap is computed regardless of the sign.
=begin
# The maximum gap after sorting the array is 4, the difference between 9 - 5 = 4 .
max_gap ([13,10,5,2,9]) == 4
max_gap ([-3,-27,-4,-2]) == 23
max_gap ([-7,-42,-809,-14,-12]) == 767
max_gap ([-54,37,0,64,640,0,-15]) == 576
=end
def max_gap(array)
  array.sort!
  subtractions = []
  index_counter = 1
  until index_counter > array.length - 1
    subtractions << array[index_counter] - array[index_counter - 1]
    index_counter += 1
  end
  subtractions.max
end

# Suggested solution
def max_gap(numbers)
  numbers.sort.each_cons(2).map { |a, b| b - a }.max
end

# 6) Given an array of N integers, you have to find how many times you have to add up the smallest numbers in the array until their Sum becomes greater or equal to K. The list size is at least 3. All numbers will be positive. Each numbers could occur more than once.

=begin
# We add two smallest elements (1 + 2), their sum is 3 .
# Then we add the next smallest number to it (3 + 3) , so the sum becomes 6 .
# Now the result is greater or equal to 6 , Hence the output is (2) i.e (2) operations are required to do this .
minimum_steps([1, 10, 12, 9, 2, 3], 6) == 2
minimum_steps([8 , 9, 4, 2], 23) == 3
minimum_steps([19,98,69,28,75,45,17,98,67], 464) == 8
=end
def minimum_steps(numbers, value)
  numbers.sort!
  cum_sum = 0
  iterations = 0
  while cum_sum < value
    cum_sum += numbers[iterations]
    iterations += 1
  end
  iterations - 1
end

# Suggested solution
def minimum_steps(numbers, value)
  total = 0
  numbers.sort.each_with_index do |x, idx|
    total += x
    return idx if total >= value
  end
end

# 7) Given a list of digits, return the smallest number that could be formed from these digits, using the digits only once (ignore duplicates). Only positive integers will be passed to the function (no zeroes).
=begin
min_value ([1, 3, 1])  == 13
min_value ([5, 7, 5, 9, 7]) == 579
min_value ([1, 9, 3, 1, 7, 4, 6, 6, 7]) == 134679
=end
def min_value(array)
  array.uniq.sort.join.to_i
end

# 8) Several people are standing in a row divided into two teams. The first person goes into team 1, the second goes into team 2, the third goes into team 1, and so on. Given an array of positive integers (the weights of the people), return a new array of two integers, where the first one is the total weight of team 1, and the second one is the total weight of team 2. Array size is at least 1. All numbers will be positive.
=begin
row_weights([13, 27, 49])  ==  [62, 27]
row_weights([50, 60, 70, 80]) == [120, 140]
row_weights([80])  == [80, 0]
=end
def row_weights(array)
  weights = [0, 0]
  array.each_with_index do |weight, index|
    weights[0] += weight if index.even?
    weights[1] += weight if index.odd?
  end
  weights
end

# Suggested solution
def row_weights(array)
  array.partition.with_index { |weight, index| index.even? }.map { |element| element.reduce(:+) }
end

# 9) Given two integers a and b, which can be positive or negative, find the sum of all the numbers between including them too and return it. If the two numbers are equal return a or b. Note: a and b are not ordered!
=begin
get_sum(1, 0) == 1   # 1 + 0 = 1
get_sum(1, 2) == 3   # 1 + 2 = 3
get_sum(0, 1) == 1   # 0 + 1 = 1
get_sum(1, 1) == 1   # 1 Since both are same
get_sum(-1, 0) == -1 # -1 + 0 = -1
get_sum(-1, 2) == 2  # -1 + 0 + 1 + 2 = 2
=end
def get_sum(a, b)
  return a if a == b
  a, b = [a, b].sort
  (a..b).reduce(:+)
end

# 10) Given a year, find the next happy year, where a happy year is a 4 digit number composed of distinct digits. The input will always be a positive integer.
=begin
next_happy_year (7712) == 7801
next_happy_year (8989) == 9012
next_happy_year (1001) == 1023
=end
def next_happy_year(year)
  test_array = []
  year += 1
  loop do 
    test_array = year.to_s.chars
    break if test_array == test_array.uniq
    year += 1
  end
  test_array.join.to_i 
end

# Suggested solution
def next_happy_year(year)
  year += 1
  until year.digits.uniq.count == 4 do
    year += 1
  end
  year
end

# 11) Given a number, find if it is disarium or not. A disarium number occurs if the sum of its digits to the power of its respective position is equal to the number itself.
=begin
# 8 ^ 1 + 9 ^ 2 == 89
disarium_number(89) == "Disarium !!"
disarium_number(564) == "Not !!"
=end
def disarium_number(n)
  n == n.to_s.chars.map.with_index { |digit, index| digit.to_i ** (index + 1) }.reduce(:+) ? 'Disarium !!' : "Not !!"
end

# 12) Given an array of n integers, find maximum triplet sum in the array without duplications. The array will always be three elements, could contain duplicate numbers and elements within can be negative, positive or zero.
=begin
max_tri_sum([3,2,6,8,2,3]) == 17
max_tri_sum([2,1,8,0,6,4,8,6,2,4]) == 18
max_tri_sum([-7,12,-7,29,-5,0,-7,0,0,29]) == 41
=end
def max_tri_sum(numbers)
  numbers.uniq.sort.each_cons(3).map { |subarray| subarray.reduce(:+) }.max
end

# Suggested solution
def max_tri_sum(arr)
  arr.uniq.max(3).sum
end

# 13) Given an array of integers, find the Nth smallest element in this array of integers. The array will be three elements at least, will contain positives, negatives and zeroes, and will contain duplicates. 
=begin
nth_smallest([3,1,2], 2) == 2
nth_smallest([15,20,7,10,4,3], 3) == 7
nth_smallest([2,169,13,-5,0,-1], 4) == 2
nth_smallest([177,225,243,-169,-12,-5,2,92], 5) == 92
=end
def nth_smallest(arr, pos)
  arr.min(pos).max
end

# Suggested solution
def nth_smallest(arr, pos)
  arr.sort[pos-1]
end

# 14) Consider the word "abode". We can see that the letter a is in position 1 and b is in position 2. In the alphabet, a and b are also in positions 1 and 2. Notice also that d and e in abode occupy the positions they would occupy in the alphabet, which are positions 4 and 5. Given an array of words, return an array of the number of letters that occupy their positions in the alphabet for each word. Input will consist of alphabet characters, both uppercase and lowercase. No spaces.
=begin
solve(["abode","ABc","xyzD"]) = [4, 3, 1]
=end
def solve(array)
  lookup_hash = (('a'..'z').zip(1..26)).to_h
  array.map do |word|
    word.downcase.chars.select.with_index do |letter, index|
      lookup_hash[letter] == index + 1
    end.length
  end
end

# 15) a Jumping number is the number that All adjacent digits in it differ by 1. Given a number, Find if it is Jumping or not . The Number passed is always Positive. Return the result as String. The difference between ‘9’ and ‘0’ is not considered as 1. All single digit numbers are considered as Jumping numbers.
=begin
jumping_number(9) == 'Jumping!!'
jumping_number(79) == 'Not!!'
jumping_number(23) == 'Jumping!!'
jumping_number(556847) == 'Not!!'
jumping_number(32) == 'Jumping!!'
jumping_number(89098) == 'Not!!'
=end
def jumping_number(n)
  return 'Jumping!!' if n.to_s.length == 1
  n.to_s.chars.each_cons(2).select do |pair|
    (pair[0].to_i - pair[1].to_i).abs == 1
  end.length == n.to_s.length - 1 ? 'Jumping!!' : 'Not!!'
end

# 16) Given a string, capitalize the letters that occupy even indexes and odd indexes separately, and return as shown below. Index 0 will be considered even.
=begin
capitalize("abcdef") == ['AbCdEf', 'aBcDeF']
=end
def capitalize(string)
  result = string.downcase.chars.map.with_index do |letter, index|
    index.even? ? letter.upcase : letter
  end.join
  [result, result.swapcase]
end

# 17) A number is a Special Number if it’s digits only consist 0, 1, 2, 3, 4 or 5. Given a number determine if it special number or not. The number passed will be positive (N > 0). All single-digit numbers with in the interval [0:5] are considered as special number.
=begin
special_number(2) == 'Special!!'
special_number(9) == 'NOT!!'
special_number(39) == 'NOT!!'
special_number(513) == 'Special!!'
=end
def special_number(n)
  comparison_array = (0..5).to_a
  n.digits.all? do |number|
    comparison_array.include?(number)
  end ? 'Special!!' : "NOT!!"
end

# Shorter
def special_number(n)
  n.digits.all? { |dgt| dgt <= 5 } ? 'Special!!' : 'NOT!!'
end

# 18) you will be given a string that may have mixed uppercase and lowercase letters and your task is to convert that string to either lowercase only or uppercase only based on making as few changes as possible.If the string contains equal number of uppercase and lowercase letters, convert the string to lowercase.
=begin
solve("coDe") = "code". Lowercase characters > uppercase. Change only the "D" to lowercase.
solve("CODe") = "CODE". Uppercase characters > lowecase. Change only the "e" to uppercase.
solve("coDE") = "code". Upper == lowercase. Change all to lowercase.
=end
def solve(string)
  upcase_letters = ('A'..'Z').to_a
  string.chars.select do |letter|
    upcase_letters.include?(letter)
  end.length > string.chars.length / 2 ? string.upcase : string.downcase
end

# Shorter solution
def solve(s)
  s.count('A-Z') > s.count('a-z') ? s.upcase : s.downcase
end

# 19) A Tidy number is a number whose digits are in non-decreasing order. Given a number, Find if it is Tidy or not. Number passed is always Positive. Return the result as a Boolean

=begin
tidy_number(12) == true
tidy_number(32) == false
tidy_number(1024) == false
tidy_number(13579) == true
tidy_number(2335) == false
=end
def tidy_number(number)
  number.to_s.chars.each_cons(2).select do |a, b|
    a <= b
  end.length == number.to_s.chars.length - 1
end

# Suggested solution
def tidy_number(n)
  n.to_s.chars.sort.join.to_i == n
end

# 20) Triangular numbers are so called because of the equilateral triangular shape that they occupy when laid out as dots. You should return 0 for out of range values.
=begin
1st (1)   2nd (3)    3rd (6)
*          **        ***
           *         **
                     *

triangular(0)==0
triangular(2)==3
triangular(3)==6
triangular(4)==10
triangular(-10)==0
=end
def triangular(n)
  return 0 if n <= 0
  (1..n).reduce(:+)
end

# Handling the edge case on a single line
def triangular(n)
  (1..n).reduce(0, &:+)
end

# 21) Given an array of ints, return the index such that the sum of the elements to the right of that index equals the sum of the elements to the left of that index. If there is no such index, return -1. If there is more than one such index, return the left-most index. The special case of an array of zeros (for instance [0,0,0,0]) will not be tested. 
=begin
# The sum of the elements at indexes 0,1,2 == sum of elements at indexes 4,5,6. We don't sum index 3.
peak([1,2,3,5,3,2,1]) = 3
peak([1,12,3,3,6,3,1]) = 2
peak([10,20,30,40]) = -1
=end
def peak(arr)
  arr.each_index do |index|
    return index if arr[0...index].sum == arr[index + 1..-1].sum
  end
  -1
end

# 22) Your task will be to return a list of ints detailing the count of uppercase letters, lowercase, numbers and special characters, given a string:
=begin
# the order is: uppercase letters, lowercase, numbers and special characters.
solve("*'&ABCDabcde12345") = [4,5,5,3]. 
=end
def solve(string)
  [string.count('A-Z'), string.count('a-z'), string.count('0-9'), string.length - (string.count('A-Z') + string.count('a-z') + string.count('0-9'))]
end

# Here's how to solve for special characters
def solve s
  [ s.count('A-Z'),
    s.count('a-z'),
    s.count('0-9'),
    s.count('^a-zA-Z0-9') ]
end

# 23) Given a string of digits confirm whether the sum of all the individual even digits are greater than the sum of all the indiviudal odd digits. A string of numbers will be given.
=begin
If the sum of even numbers is greater than the odd numbers return: "Even is greater than Odd"
If the sum of odd numbers is greater than the sum of even numbers return: "Odd is greater than Even"
If the total of both even and odd numbers are identical return: "Even and Odd are the same"
even_or_odd("12") == "Even is greater than Odd"
even_or_odd("123") == "Odd is greater than Even"
even_or_odd("112") == "Even and Odd are the same"
=end
def even_or_odd(string)
  evens, odds = string.to_i.digits.partition { |digit| digit.even? }
  if evens.sum < odds.sum 
    'Odd is greater than Even'
  elsif evens.sum > odds.sum 
    'Even is greater than Odd'
  else 
    'Even and Odd are the same'
  end
end

# Alternative solution
def even_or_odd(s)
  even_sum, odd_sum = s.chars.map(&:to_i).partition(&:even?).map(&:sum)
  even_sum > odd_sum ? 'Even is greater than Odd' : odd_sum > even_sum ? 'Odd is greater than Even' : 'Even and Odd are the same'
end

# 24) You will be given a multi-dimensional array containing 2 or more sub-arrays of integers. Your task is to find the maximum product that can be formed by taking any one element from each sub-array. Each subarray could have more than two elements.
=begin
solve([[1, 2],[3, 4]]) == 8
solve([[10,-15],[-1,-3]]) == 45
solve([[1,-1],[2,3],[10,-100]]) == 300
=end
def solve(arr)
  arr[0].product(*arr[1..-1]).map{ |i| i.reduce(&:*) }.max 
end

# 25) you will be given a lower case string and your task will be to remove k characters from that string using the following rule:
=begin
first remove all letter 'a', followed by letter 'b', then 'c', etc...
remove the leftmost character first.

For example: 
solve('abracadabra', 1) = 'bracadabra' # remove the leftmost 'a'.
solve('abracadabra', 2) = 'brcadabra'  # remove 2 'a' from the left.
solve('abracadabra', 6) = 'rcdbr'      # remove 5 'a', remove 1 'b' 
solve('abracadabra', 8) = 'rdr'
solve('abracadabra',50) = ''
=end
def solve (s, k)
  s.chars.sort.take(k).each { |c| s = s.sub(c, '') }
  s
end

# 26) Given a list of numbers, determine whether the sum of its elements is odd or even. Give your answer as a string matching "odd" or "even". If the input array is empty consider it as: [0] (array with a zero).
=begin
odd_or_even([0])          ==  "even"
odd_or_even([0, 1, 4])    ==  "odd"
odd_or_even([0, -1, -5])  ==  "even"
=end
def odd_or_even(array)
  # Note the zero argument covers off instances where the array is empty
  array.reduce(0, &:+).odd? ? 'odd' : 'even'
end

# 27) In this Kata, we will check if a string contains consecutive letters as they appear in the English alphabet and if each letter occurs only once. 
=begin
solve("abc") = True, because it contains a,b,c
solve("abd") = False, because a, b, d are not consecutive/adjacent in the alphabet, and c is missing.
solve("dabc") = True, because it contains a, b, c, d
solve("abbc") = False, because b does not occur once.
solve("v") = True
=end
def solve(string)
  string.chars.sort.each_cons(2).select do |a, b|
    a.next == b
  end.length == string.chars.length - 1
end

# We can shorten this slightly to 
def solve(str)
  str.chars.sort.each_cons(2).all? { |a,b| a.next == b }
end
