# 1) Write a method that returns true if its argument looks like a URL, false if it does not
=begin
url?('http://launchschool.com')   # -> true
url?('https://example.com')       # -> true
url?('https://example.com hello') # -> false
url?('   https://example.com')    # -> false
=end
def url?(str)
  str.match?(/\Ahttps?:\/\/\S+\z/)
end

# 2) Write a method that returns all of the fields in a haphazardly formatted string. 
# A variety of spaces, tabs, and commas separate the fields, with possibly multiple occurrences of each delimiter.
=begin
fields("Pete,201,Student")
# -> ['Pete', '201', 'Student']

fields("Pete \t 201    ,  TA")
# -> ['Pete', '201', 'TA']

fields("Pete \t 201")
# -> ['Pete', '201']

fields("Pete \n 201")
# -> ['Pete', '\n', '201']
=end
def fields(str)
  str.split(/[ \t,]+/)
end

# 3) Write a method that changes the first arithmetic operator (+, -, *, /) in a string to a '?' and returns the resulting string. Don't modify the original string.
=begin
mystery_math('4 + 3 - 5 = 2')
# -> '4 ? 3 - 5 = 2'

mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'
=end
def mystery_math(str)
  str.sub(/[+\-\/*]/, '?')
end
puts "Note that we need to escape the - character in our character class to interpret as a literal hyphen, not a range specification."

# 4) Write a method that changes every arithmetic operator (+, -, *, /) to a '?' and returns the resulting string. Don't modify the original string.
=begin
mysterious_math('4 + 3 - 5 = 2')           
# -> '4 ? 3 ? 5 = 2'

mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') 
# -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'
=end
def mysterious_math(str)
  str.gsub(/[+\-\/*]/, '?')
end

# 5) Write a method that changes the first occurrence of the word apple, blueberry, or cherry in a string to danish.
=begin
danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

danish('The cherry of my eye')
# -> 'The danish of my eye'

danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

danish('I love pineapple')
# -> 'I love pineapple'
=end
def danish(str)
  str.sub(/\b(apple|blueberry|cherry)\b/, 'danish')
end

# 6) Write a method that changes dates in the format 2016-06-17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.
=begin
format_date('2016-06-17') # -> '17.06.2016'
format_date('2016/06/17') # -> '2016/06/17' (no change)
=end
def format_date(original_date)
  original_date.sub(/\A(\d{4})-(\d\d)-(\d\d)\z/, '\3.\2.\1')
end

# 7) write a method that changes dates in the format 2016-06-17 or 2016/06/17 to the format 17.06.2016. 
# You must use a regular expression and should use methods described in this section.
=begin
format_date('2016-06-17') # -> '17.06.2016'
format_date('2017/05/03') # -> '03.05.2017'
format_date('2015/01-31') # -> '2015/01-31' (no change)
=end
def format_date(date)
  date.sub(/\A(\d{4})([\/|\-])(\d\d)\2(\d\d)\z/, '\4.\3.\1')
end
