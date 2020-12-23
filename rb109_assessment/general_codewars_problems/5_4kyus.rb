# 1) https://www.codewars.com/kata/52b7ed099cdc285c300001cd
=begin
Problem
Write a method called sum_intervals that accepts an array of intervals, and returns the sum of all the interval lengths. Overlapping intervals should only be counted once.

  Input
    An array of indeterminate length. It will contain sub arrays, where each subarray is 2 integer objects

  Output
    Integer object

  Rules
    Overlapping intervals should only be counted once

Examples
  sum_of_intervals([[1, 5]]) == 4
  sum_of_intervals([[1, 5], [6, 10]]) == 8
  sum_of_intervals([[1, 5], [1, 5]]) == 4
  sum_of_intervals([[1, 4], [7, 10], [3, 5]]) == 7
  sum_if_intervals([[1, 5], [10, 20], [1, 6], [16, 19], [5, 11]]) == 19

Data Structures
  Array

Algo
  We have an input array of subarrays
  I need to iterate through each subarray, comparing it with each other subarray
  Check for duplicates and throw them out

  Helper method
  I need to test of an subarray 'overlaps' with another subarray
    For each subarray - look at the max limit
    Compare this max limit to the next subarray's smallest limit
    If the max limit is smaller than or equal to that limit
      Generate a new array, using the min limit of the smaller subarray and the higher limit of the comparison subarray
      Otherwise, 
  This method should return an array of subarrays

  Repeat until we have non-overlapping subarrays, or one big subarray
  Loop through the remaining subarrays
  Subtract the lower limit from the upper limit
  Add these differences together (returning an integer object)
=end
def sum_of_intervals(intervals)
  intervals.map{ |a| (a[0]...a[1]).to_a }.flatten.uniq.size
end

# 2) https://www.codewars.com/kata/5254ca2719453dcc0b00027d
=begin
Problem
  Create all permutations of an input string and remove duplicates, if present. This means, you have to shuffle all letters from the input in all possible orders.

  Input
    String object

  Output
    An array of string objects

  Rules
    The order of the permutations doesn't matter.

Examples
  permutations('ab') == ['ab', 'ba']
  permutations('aabb') == ['aabb', 'abab', 'abba', 'baab', 'baba', 'bbaa']

Data Structures
  Array

Algo
  Break up our string into an array of letters (arr_char)
  Take all the permutations of arr_char using the relevant method
  Join those returned subarrays together
  Return the full array
=end
def permutations(string) 
  string.chars.permutation(string.length).map do |subarr|
    subarr.join
  end.uniq
end

# 3) https://www.codewars.com/kata/51ba717bb08c1cd60f00002f/train/ruby
=begin
Problem
Complete the solution so that it takes a list of integers in increasing order and returns a correctly formatted string in the range format. 

  Input
    Array of integer objects

  Output
    A single string object

  Rules
    If numbers are consecutive, they need to go in a range
    In our string, numbers/ranges should be separated by commas

Examples
  solution([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20]) == "-6,-3-1,3-5,7-11,14,15,17-20"

Data Structures
  Array

Algo
  We need to convert each element into a string (map)
  We iterate through each pair of elements
  If the first element is one less than the next element, 
    Append the first element to an empty array, called current_range
  If the first element is not one less than the next element
    Append to current_range
    if current_range length > 1, take the first element of current_range and the last element of current_range, using string interpolation (separate the two elements with a -)
    Otherwise, just append current_range first element to clean_range
    REset current_range to an empty array
    Append current_rnage to an empty array called clean_range
    Join clean_range with a dash
=end
def solution(arr)
  clean_range = []
  chunked_arr = arr.chunk_while do |a, b|
    b.to_i - a.to_i == 1
  end.to_a

  chunked_arr.each do |subarr|
    if subarr.length < 3
      clean_range << subarr.flatten
    else
      clean_range << "#{subarr.min}-#{subarr.max}"
    end
  end
  clean_range.join(',')
end

# 4) https://www.codewars.com/kata/526d84b98f428f14a60008da
=begin
Problem
Write a function that computes the nth smallest Hamming number. 

  Input
    An integer object (the nth smallest hamming number)

  Output
    An integer object (the hamming number)

  Rules
    A hamming number can be decomposed into 2**i, 3**j, 5**k
    Anything to the power of 0 equals 1

Example
  hamming(1) == 1
  hamming(2) == 2
  hamming(3) == 3
  hamming(4) == 4
  hamming(5) == 5
  hamming(6) == 6
  hamming(7) == 8
  hamming(8) == 9
  hamming(9) == 10
  hamming(10) == 12
  hamming(11) == 15
  hamming(12) == 16
  hamming(13) == 18
  hamming(14) == 20
  hamming(15) == 24
  hamming(16) == 25
  hamming(17) == 27
  hamming(18) == 30
  hamming(19) == 32

Data Structures
  Array?

Algo
  We're given n, an integer object, which represents the nth hamming number
  We're expected to return the hamming number itself
  We need to sequentially generate an array of hamming numbers
    Start from 3 onwards
    Our test is:
      Can we subtract two from the number, and check if it's divisible by 2, 3 or 5?
      If it is, append it to an array, hamming
      Break the loop when length of hamming == n
    Return the last element of hamming
=end
def hamming(n)
  result = [1]
  i = j = k = 0
  while result.size < n
    # Only multiples of 2, 3, 5 are allowed into the result array
    result << [result[i]*2,result[j]*3,result[k]*5].min
    # There's some mathematical principle built in here that requires i, j and k to always increase...
    i += 1 if result.last == result[i] * 2
    j += 1 if result.last == result[j] * 3
    k += 1 if result.last == result[k] * 5
  end
  result.last
end

# 5) https://www.codewars.com/kata/52ec24228a515e620b0005ef
=begin
Problem
We need to find all the possible ways to add up to the input number.

  Input
    Integer object

  Output
    Integer object

  Rules
    1 is the smallest 'base' block we can build off
    return 0 if input is negative


Examples
  exp_sum(-1) == 0
  exp_sum(0) == 1
  exp_sum(1) == 1
  exp_sum(2) == 2
  exp_sum(3) == 3
  exp_sum(4) == 5
  exp_sum(5) == 7
  exp_sum(10) == 42

Data Structures

Algorithm
=end
def exp_sum(n)
  sum_table = Array.new(n + 1, 0)
  sum_table[0] = 1
  
  (1..n).each do |i|
    (i..n).each do |j|
      sum_table[j] += sum_table[j-i]
    end
  end
  
  sum_table[n]
end

# https://www.codewars.com/kata/5672682212c8ecf83e000050
=begin
Problem
  Given parameter n the function dbl_linear, return the element u(n) of the ordered (with <) sequence u (so, there are no duplicates).

  Input
    An integer object (index)

  Output
    An integer object (element of an array)

  Rules
    The sequence will start with 1 at index 0
    For each item in the sequence, we need to append 
      y = 2 * x + 1; and
      z = 3 * x + 1
    Indexing in the output array is 0 based.
    No duplicates

Example
  dbl_linear(10) == 22
  dbl_linear(20) == 57
  dbl_linear(30) == 91
  dbl_linear(50) == 175

Data Structures
  Array

Algo
  We are given an integer object, index
  Start with output_arr, [1]
  Append y and z
  Loop through output_arr again, appending y2 and z2 on the y1 and z1, if that number doesn't already exist
  Break when output_arr's length is equal to our input
=end
def dbl_linear(n)
    u = [1]
    twice = []
    thrice = []
    while u.count <= n
      twice << u[-1] * 2 + 1
      thrice << u[-1] * 3 + 1
      if twice[0] < thrice[0]
        u << twice.shift
      elsif twice[0] > thrice[0]
        u << thrice.shift
      else
        u << twice.shift
        thrice.shift
      end
    end
    u[-1]
end

# 6) https://www.codewars.com/kata/5426d7a2c2c7784365000783/train/ruby
=begin
Problem
Write a function which makes a list of strings representing all of the ways you can balance n pairs of parentheses

  Input
    An integer object (representing the number of parentheses pairs)

  Output
    An array of string objects, containing '()'

  Rules
    Our input might be 0 - return a array with an empty string
    For a pair of parentheses to be balanced, 
      The parenthesis pair must start with a '('
      A parenthesis pair must be closed (not necessarily sequentially)

Examples
  balanced_parens(0) == [""]
  balanced_parens(1) == ["()"]
  balanced_parens(2) == ["()()","(())"]
  balanced_parens(3) == ["()()()","(())()","()(())","(()())","((()))"

Data Structures
  Array

Algorithm
  We probably want two methods
    1. Generate all the possible combinations
      we get an input integer (n)
      We create an array where we input a left parenthesis and right parenthesis (n) times (string_arr)
      we take the combination of our string arrays, using permutations.to_a (combos)
      Return combos

    2. Filter out anything that's not balanced
      We get an array of all the different combos (input_arr)
      We iterate through input_arr
        We need to check if it's balanced
          If the string starts with ')' or ends with '(', exclude it
          Otherwise, create an empty array (paren_tester)
          Iterate through the subarr (select)
            If the parenthesis is '(', append to paren_tester
            if the parenthesis is ')', pop paren_tester IF the last character is '('
            We should end up with an empty paren_tester if it's balanced
=end
def combos(n)
  combo_arr = []
  n.times do |_|
    combo_arr << '(' << ')'
  end
  combo_arr.permutation.to_a.uniq
end

def tester(combinations)
  combinations.select do |combo|
    paren_tester = []
    combo.each do |paren|
      paren_tester << paren if paren == '('
      paren_tester.pop if paren == ')' && paren_tester.last == '('
    end
    paren_tester.empty?
  end
end

def balanced_parens(n)
  tester(combos(n)).map do |combo|
    combo.join
  end
end

# 7) https://www.codewars.com/kata/52f677797c461daaf7000740/train/ruby
=begin
Problem
Given an array X of positive integers, its elements are to be transformed by running the following operation on them as many times as required. When no more transformations are possible, return its sum

  Input
    An array of integers

  Output
    An integer object

  Rules
    We deem 'no more transformations as possible' when all three elements are the same
    If an element is larger than the next largest element, replace the largest element with the subtraction of largest - next largest element 

Examples
  solution([1, 21, 55]) == 3
  solution([3, 13, 23, 7, 83]) == 5
  solution([4, 16, 24]) == 12
  solution([30, 12]) == 12
  solution([60, 12, 96, 48, 60, 24, 72, 36, 72, 72, 48]) == 132
  solution([71, 71, 71, 71, 71, 71, 71, 71, 71, 71, 71, 71, 71]) == 923
  solution([11, 22]) == 22
  solution([9]) == 9

Data Structures
  Array

Algo
  We're given an input array
  Check if all elements are the same (uniq array length == 1)
    If so, reduce the numbers
  Otherwise
    Find the max number in the array (need to keep track of index as well)
    Subtract the second max in the array
    Replace maxnumber index with the subtracted version
    Repeat until uniq length of the input array == 1
    Reduce
=end
def solution(n)
  n.reduce(:gcd) * n.size
end

# https://www.codewars.com/kata/58ad317d1541651a740000c5
=begin
Problem
You are given a string s. Every letter in s appears once. Consider all strings formed by rearranging the letters in s. After ordering these strings in dictionary order, return the middle term. If the sequence has a even length n, define its middle term to be the (n/2)th term.

  Input
    String object

  Output
    String object

  Rules
    We need to generate all permutations of the string s
    We need to order these permutations by dictionary (alphabetical)
    Return the 'middle' permutation (n/2) if the number of permutations is even
      Otherwise return n/2 + 1 if the number of permutations is odd

Example
  middle_permutation("abc") == "bac"
  middle_permutation("abcd") == "bdca"
  middle_permutation("abcdx") == "cbxda"
  middle_permutation("abcdxg") == "cxgdba"
  middle_permutation("abcdxgz") == "dczxgba"

Data Structures
  Array

Algorithm
  Input string object s
  Break up s into array of characters (s_chars)
  Generate all permutations of s_char (perms)
  sort perms by alphabetical order
  Check if length of perms is odd
    If odd, return perms[perms.length / 2]
    If even, return perms[perms.length / 2 - 1]
=end
def middle_permutation(s)
  s_chars = s.chars
  perms = s_chars.permutation.to_a.sort
  perms.length.odd? ? perms[perms.length / 2].join : perms[perms.length / 2 - 1].join
end
