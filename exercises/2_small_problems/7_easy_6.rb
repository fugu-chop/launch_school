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
  counter = list.length - 1

  while counter > -1
    list.unshift(list[counter])
    list.pop
    counter -= 1
  end

  list
end