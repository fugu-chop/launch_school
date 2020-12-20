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
  intervals.map{|a| (a[0]...a[1]).to_a }.flatten.uniq.size
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

# 4) https://www.codewars.com/kata/54eb33e5bc1a25440d000891
=begin
  
=end