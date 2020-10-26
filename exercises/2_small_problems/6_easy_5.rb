# 1) Write a method that determines and returns the ASCII string value of a string that is passed in as an argument. The ASCII string value is the sum of the ASCII values of every character in the string. (You may use String#ord to determine the ASCII value of a character.)
=begin
ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0
=end
def ascii_value(str)
  str.chars.map { |char| char.ord }.reduce(0, :+)
end

# 2) The time of day can be represented as the number of minutes before or after midnight. If the number of minutes is positive, the time is after midnight. If the number of minutes is negative, the time is before midnight. Write a method that takes a time using this minute-based format and returns the time of day in 24 hour format (hh:mm). Your method should work with any integer input. You may not use ruby's Date and Time classes.
=begin
time_of_day(0) == "00:00"
time_of_day(-3) == "23:57"
time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"
=end
def time_of_day(integer)
  hour, minute = integer.divmod(60)

  if integer > 0
    while hour > 24 
      hour, _ = hour.divmod(24)
    end  
  elsif integer < 0
    while hour < -24
      hour, min = hour.divmod(24)
    end 
  end

  hour = min if integer < 0 && (hour != -24 && hour != -1)
  hour = 24 + hour if integer < 0 && hour < 0
  
  hour = hour.to_s
  minute = minute.to_s
  [hour, minute].map do |element|
    element.prepend('0') if element.length < 2
  end
  "#{hour}:#{minute}"
end

# Suggested solution
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def time_of_day(delta_minutes)
  delta_minutes =  delta_minutes % MINUTES_PER_DAY
  hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, minutes)
end

# 3) Write two methods that each take a time of day in 24 hour format, and return the number of minutes before and after midnight, respectively. Both methods should return a value in the range 0..1439
=begin
after_midnight('00:00') == 0
before_midnight('00:00') == 0
after_midnight('12:34') == 754
before_midnight('12:34') == 686
after_midnight('24:00') == 0
before_midnight('24:00') == 0
=end

def after_midnight(time)
  arr = time.split(':').map(&:to_i)
  (60 * arr[0] + arr[1]) % 1440
end

def before_midnight(time)
  arr = time.split(':').map(&:to_i)
  (1440 - (60 * arr[0] + arr[1])) % 1440
end

# 4) Given a string of words separated by spaces, write a method that takes this string of words and returns a string in which the first and last letters of every word are swapped. You may assume that every word contains at least one letter, and that the string will always contain at least one word. You may also assume that each string contains nothing but words and spaces.
=begin
swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
swap('Abcde') == 'ebcdA'
swap('a') == 'a'
=end

def swap(str)
  arr = str.split
  new_arr = arr.each do |element|
    first_char = element[0]
    end_char = element[-1]
    element[0] = end_char
    element[-1] = first_char
  end
  new_arr.join(' ')
end

# Suggested solution
def swap_first_last_characters(word)
  # the a, b = b, a allows exchange of elements
  # When Ruby sees something like this, it effectively creates a temporary array with the values from the right side ([b, a]), and then assigns each element from that array into the corresponding named variable.
  word[0], word[-1] = word[-1], word[0]
  word
end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word)
  end
  result.join(' ')
end

# 4) How come our solution passes word into the swap_first_last_characters method invocation instead of just passing the characters that needed to be swapped? Suppose we had this implementation and just called swap_first_last_characters(word[0], word[-1]) directly - what would happen?
=begin
def swap_first_last_characters(a, b)
  a, b = b, a
end
=end

puts "Calling the swap_first_last_characters method itself wouldn't work, since it would only work on the very first and last character of the string. The map method is required to apply this change to each word in a string, by breaking up the words in the string into elements of an array."
