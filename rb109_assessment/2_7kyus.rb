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
  numbers.select.with_index { |number, index| number > numbers[index + 1..-1].sum }
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
  numbers.sort.each_cons(2).map{ |a, b| b - a }.max
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
  array.partition.with_index{ |a, b| b.even? }.map{ |e| e.reduce(:+) }
end
