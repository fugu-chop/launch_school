# 1) Write a method that takes two strings as arguments, determines the longest of the two strings, and then returns the result of concatenating the shorter string, the longer string, and the shorter string once again. You may assume that the strings are of different lengths.
=begin
short_long_short('abc', 'defgh') == "abcdefghabc"
short_long_short('abcde', 'fgh') == "fghabcdefgh"
short_long_short('', 'xyz') == "xyz"
=end

def short_long_short(str1, str2)
  long_string = str1.length > str2.length ? str1 : str2
  short_string = str1.length < str2.length ? str1 : str2
  short_string + long_string + short_string
end

# 2) Write a method that takes a year as input and returns the century. The return value should be a string that begins with the century number, and ends with st, nd, rd, or th as appropriate for that number. New centuries begin in years that end with 01. So, the years 1901-2000 comprise the 20th century.
=begin
century(2000) == '20th'
century(2001) == '21st'
century(1965) == '20th'
century(256) == '3rd'
century(5) == '1st'
century(10103) == '102nd'
century(1052) == '11th'
century(1127) == '12th'
century(11201) == '113th'
=end

def century(year)
  unique_suffix = { '1' => 'st',
             '2' => 'nd', 
             '3' => 'rd' }
  output = ''
  century_num = (((year - 1) / 100) + 1).to_s
  if ['11', '12', '13'].include?(century_num[-2..-1])
    output = century_num + 'th'
  elsif unique_suffix[century_num[-1]]
    output = century_num + unique_suffix[century_num[-1]]
  else
    output = century_num + 'th'
  end
  output
end


# 3) Write a method that takes any year greater than 0 as input, and returns true if the year is a leap year, or false if it is not a leap year. Leap years occur in every year that is evenly divisible by 4, unless the year is also divisible by 100. If the year is evenly divisible by 100, then it is not a leap year unless the year is evenly divisible by 400.
=begin
leap_year?(2016) == true
leap_year?(2015) == false
leap_year?(2100) == false
leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == false
leap_year?(1) == false
leap_year?(100) == false
leap_year?(400) == true
=end

def leap_year?(year)
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0
end

# 3b) Rewrite a previous loop with year % 4 at the top.
def leap_year?(year)
  if year % 4 == 0
    if year % 400 == 0
      true
    elsif year % 100 == 0
      false
    else
      true
    end
  else
    false
  end
end

# 4) A continuation of the previous exercise. The British Empire adopted the Gregorian Calendar in 1752, which was a leap year. Prior to 1752, the Julian Calendar was used. Under the Julian Calendar, leap years occur in any year that is evenly divisible by 4. Using this information, update the method from the previous exercise to determine leap years both before and after 1752.
=begin
leap_year?(2016) == true
leap_year?(2015) == false
leap_year?(2100) == false
leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == true
leap_year?(1) == false
leap_year?(100) == true
leap_year?(400) == true
=end

def leap_year?(year)
  if year >= 1752
    year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  else
    year % 4 == 0
  end
end

# 5) Write a method that searches for all multiples of 3 or 5 that lie between 1 and some other number, and then computes the sum of those multiples. For instance, if the supplied number is 20, the result should be 98 (3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20). You may assume that the number passed in is an integer greater than 1.
=begin
multisum(3) == 3
multisum(5) == 8
multisum(10) == 33
multisum(1000) == 234168
=end

def multisum(num)
  (1..num).select { |value| value % 3 == 0 || value % 5 == 0 }.reduce(:+)
end

# 6) Write a method that takes an Array of numbers, and returns an Array with the same number of elements, and each element has the running total from the original Array.
=begin
running_total([2, 5, 13]) == [2, 7, 20]
running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
running_total([3]) == [3]
running_total([]) == []
=end

def running_total(arr)
  cum_sum = 0
  arr.map { |element| cum_sum += element }
end

# 6b) Try solving this problem using Enumerable#each_with_object
def running_total(arr)
  cum_sum = 0
  arr.each_with_object([]) { |element, obj| obj << cum_sum += element }
end

# 7) Write a method that takes a String of digits, and returns the appropriate number as an integer. You may not use any of the following methods - String#to_i, Integer(). For now, do not worry about leading + or - signs, nor should you worry about invalid characters; assume all characters will be numeric.
=begin
string_to_integer('4321') == 4321
string_to_integer('570') == 570
=end

def string_to_integer(str)
  digits = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

  num_arr = str.chars.map { |char| digits[char] }
  power = num_arr.size - 1
  array_index = 0
  sum_arr = []
  while power > -1
    sum_arr << num_arr[array_index] *= (10 ** power)
    power -= 1
    array_index += 1
  end
  sum_arr.reduce(:+)
end

# Suggested solution
def string_to_integer(string)
  digit_hash = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

  digits = string.chars.map { |char| digit_hash[char] }

  value = 0
  digits.each { |digit| value = 10 * value + digit }
  value
end

# 7b) Write a hexadecimal_to_integer method that converts a string representing a hexadecimal number to its integer value.
=begin
hexadecimal_to_integer('4D9f') == 19871
=end

def hexadecimal_to_integer(hex)
  digit_hash = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
  'A' => 10,'B'	=> 11,'C' => 12, 'D' => 13, 'E' => 14,
  'F' => 15
}
  num_arr = hex.upcase.chars.map { |char| digit_hash[char] }
  power = num_arr.size - 1
  array_index = 0
  sum_arr = []
  while power > -1
    sum_arr << num_arr[array_index] *= (16 ** power)
    power -= 1
    array_index += 1
  end
  sum_arr.reduce(:+)
end

# 8) Write a method that takes a String of digits, and returns the appropriate number as an integer. The String may have a leading + or - sign; if the first character is a +, your method should return a positive number; if it is a -, your method should return a negative number. If no sign is given, you should return a positive number.
=begin
string_to_signed_integer('4321') == 4321
string_to_signed_integer('-570') == -570
string_to_signed_integer('+100') == 100
=end
def string_to_signed_integer(str)
  digits = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

  num_arr = str.delete('+').delete('-').chars.map { |char| digits[char] }
  power = num_arr.size - 1
  array_index = 0
  sum_arr = []
  while power > -1
    sum_arr << num_arr[array_index] *= (10 ** power)
    power -= 1
    array_index += 1
  end
  
  if str[0] == '-'
    return -1 * sum_arr.reduce(:+)
  else
    return sum_arr.reduce(:+)
  end
end

# Suggested solution
def string_to_signed_integer(string)
  case string[0]
  when '-' then -string_to_integer(string[1..-1])
  when '+' then string_to_integer(string[1..-1])
  else string_to_integer(string)
  end
end

# 8b) In our solution, we call string[1..-1] twice, and call string_to_integer three times. This is somewhat repetitive. Refactor our solution so it only makes these two calls once each.
def string_to_signed_integer(string)
  string[0]
  modifier = case string[0]
    when '-' then -1
    when '+' then 1
  end

  modifier ? modifier * string_to_integer(string[1..-1]) : string_to_integer(string)
end

# 9) Write a method that takes a positive integer or zero, and converts it to a string representation. You may not use any of the standard conversion methods available in Ruby, such as Integer#to_s, String(), Kernel#format, etc. 
=begin
integer_to_string(4321) == '4321'
integer_to_string(0) == '0'
integer_to_string(5000) == '5000'
=end

def integer_to_string(int)
  digits = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
  }.invert
  int.digits.reverse.map { |el| digits[el] }.reduce(:+)
end

# Suggested solution
def integer_to_string(number)
  digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
  result = ''
  loop do
    number, remainder = number.divmod(10)
    result.prepend(digits[remainder])
    break if number == 0
  end
  result
end

# 10) In the previous exercise, you developed a method that converts non-negative numbers to strings. In this exercise, you're going to extend that method by adding the ability to represent negative numbers as well. Write a method that takes an integer, and converts it to a string representation.
=begin
signed_integer_to_string(4321) == '+4321'
signed_integer_to_string(-123) == '-123'
signed_integer_to_string(0) == '0'
=end

def signed_integer_to_string(number)
  case number <=> 0
  when -1 then "-#{integer_to_string(-number)}"
  when +1 then "+#{integer_to_string(number)}"
  else         integer_to_string(number)
  end
end

# 10b) Refactor our solution to reduce the 3 integer_to_string calls to just one.
def signed_integer_to_string(number)
  modified_number = number < 0 ? number * -1 : number
  
  modifier = case number <=> 0
  when -1 then "-"
  when +1 then "+"
  else ''
  end

  modifier + integer_to_string(modified_number)
end