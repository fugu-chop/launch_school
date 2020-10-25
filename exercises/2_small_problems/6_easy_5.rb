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

