# 1) Write a method that takes a floating point number that represents an angle between 0 and 360 degrees and returns a String that represents that angle in degrees, minutes and seconds. You should use a degree symbol (°) to represent degrees, a single quote (') to represent minutes, and a double quote (") to represent seconds. A degree has 60 minutes, while a minute has 60 seconds.
=begin
dms(30) == %(30°00'00")
dms(76.73) == %(76°43'48")
dms(254.6) == %(254°36'00")
dms(93.034773) == %(93°02'05")
dms(0) == %(0°00'00")
dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
=end
# Note: your results may differ slightly depending on how you round values, but should be within a second or two of the results shown. You should use two digit numbers with leading zeros when formatting the minutes and seconds, e.g., 321°03'07". You may use this constant to represent the degree symbol: DEGREE = "\xC2\xB0"
def dms(fpnum)
  degree_symbol = "\xC2\xB0"
  degree = fpnum.floor
  minutes = ((fpnum - degree) * 60).floor
  seconds = ((((fpnum - degree) * 60) - minutes) * 60).floor
  %(#{format('%02d', degree)}#{degree_symbol}#{format('%02d', minutes)}'#{format('%02d', seconds)}")
end

# Suggested solution
DEGREE = "\xC2\xB0"
MINUTES_PER_DEGREE = 60
SECONDS_PER_MINUTE = 60
SECONDS_PER_DEGREE = MINUTES_PER_DEGREE * SECONDS_PER_MINUTE

def dms(degrees_float)
  total_seconds = (degrees_float * SECONDS_PER_DEGREE).round
  degrees, remaining_seconds = total_seconds.divmod(SECONDS_PER_DEGREE)
  minutes, seconds = remaining_seconds.divmod(SECONDS_PER_MINUTE)
  format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds)
end

# 1b) Since degrees are normally restricted to the range 0-360, can you modify the code so it returns a value in the appropriate range when the input is less than 0 or greater than 360?
=begin
dms(400) == %(40°00'00")
dms(-40) == %(320°00'00")
dms(-420) == %(300°00'00")
=end
def dms(fpnum)
  degree_symbol = "\xC2\xB0"
  if fpnum > 360 || fpnum < 0
    _, fpnum = fpnum.divmod(360)
  end
  degree = fpnum.floor
  minutes = ((fpnum - degree) * 60).floor
  seconds = ((((fpnum - degree) * 60) - minutes) * 60).floor
  %(#{format('%02d', degree)}#{degree_symbol}#{format('%02d', minutes)}'#{format('%02d', seconds)}")
end

# 2) Write a method that takes an array of strings, and returns an array of the same string values, except with the vowels (a, e, i, o, u) removed.
=begin
remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']
=end

def remove_vowels(arr)
  arr.map { |el| el.delete('aeiouAEIOU') }
end

# 3) Write a method that calculates and returns the index of the first Fibonacci number that has the number of digits specified as an argument. (The first Fibonacci number has index 1.). You may assume that the argument is always greater than or equal to 2.
=begin
find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
find_fibonacci_index_by_length(10) == 45
find_fibonacci_index_by_length(100) == 476
find_fibonacci_index_by_length(1000) == 4782
find_fibonacci_index_by_length(10000) == 47847
=end

def find_fibonacci_index_by_length(num_length)
  sequence = [1, 1]
  loop do
    sequence << (sequence[-2] + sequence[-1])
    break if sequence.last.to_s.length == num_length
  end
  sequence.length
end

# 4) Write a method that takes an Array as an argument, and reverses its elements in place; that is, mutate the Array passed into this method. The return value should be the same Array object. You may not use Array#reverse or Array#reverse!.
=begin
list = [1,2,3,4]
result = reverse!(list)
result == [4, 3, 2, 1]
list == [4, 3, 2, 1]
list.object_id == result.object_id

list = %w(a b e d c)
reverse!(list) == ["c", "d", "e", "b", "a"]
list == ["c", "d", "e", "b", "a"]

list = ['abc']
reverse!(list) == ["cba"]
list == ["cba"]

list = []
reverse!(list) == []
list == []
=end
def reverse!(list)
  list.length.times do |index|
    list.insert(index, list.delete_at(-1))
  end
  list
end

# 5) Write a method that takes an Array as an argument, and reverses its elements without mutating the original object. You may not use Array#reverse or Array#reverse!.
def reverse(list)
  arr = []
  counter = list.length - 1
  while counter >= 0
    arr << list[counter]
    counter -= 1
  end
  arr
end

# 6) Write a method that takes two Arrays as arguments, and returns an Array that contains all of the values from the argument Arrays. There should be no duplication of values in the returned Array, even if there are duplicates in the original Arrays.
=begin
merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]
=end

def merge(arr1, arr2)
  (arr1 + arr2).uniq
end

# Suggested solution
def merge(array_1, array_2)
  # This is a method that gives the set union of two arrays, so the result contains no duplicates. It works perfectly for our merge method. The union part of this method means that we get back all the elements that both array_1 and array_2 might contain, but without duplicates.
  array_1 | array_2
end

# 7) Write a method that takes an Array as an argument, and returns two Arrays (as a pair of nested Arrays) that contain the first half and second half of the original Array, respectively. If the original array contains an odd number of elements, the middle element should be placed in the first half Array.
=begin
halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
halvsies([5]) == [[5], []]
halvsies([]) == [[], []]
=end
def halvsies(arr)
  break_point = (arr.size / 2.0).ceil
  new_arr = [arr.values_at(0...break_point), arr.values_at(break_point..-1)]
end

# 8) Given an unordered array and the information that exactly one value in the array occurs twice (every other value occurs exactly once), how would you determine which value occurs twice? Write a method that will find and return the duplicate value that is known to be in the array.
=begin
find_dup([1, 5, 3, 1]) == 1
find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73
=end
def find_dup(arr)
  sort_arr = arr.sort
  sort_arr.select.with_index do |el, idx| 
    return el if sort_arr[idx] == sort_arr[idx + 1] 
  end
end

# Suggested solution
def find_dup(array)
  array.find { |element| array.count(element) == 2 }
end

#9) Write a method named include? that takes an Array and a search value as arguments. This method should return true if the search value is in the array, false if it is not. You may not use the Array#include? method in your solution.
=begin
include?([1,2,3,4,5], 3) == true
include?([1,2,3,4,5], 6) == false
include?([], 3) == false
include?([nil], nil) == true
include?([], nil) == false
=end
def include?(arr, search_element)
  !!arr.find_index(search_element)
end

# 10) Write a method that takes a positive integer, n, as an argument, and displays a right triangle whose sides each have n stars. The hypotenuse of the triangle (the diagonal side in the images below) should have one end at the lower-left of the triangle, and the other end at the upper-right.
=begin
triangle(5)

    *
   **
  ***
 ****
*****
=end
def triangle(max_stars)
  (0..max_stars).each do |line|
    puts "#{' ' * (max_stars - line)}#{'*' * line}"
  end
end

# 10b) Try modifying your solution so it prints the triangle upside down from its current orientation.
def triangle_invert(max_stars)
  (0..max_stars).each do |line|
    puts "#{' ' * line}#{'*' * (max_stars - line)}"
  end
end