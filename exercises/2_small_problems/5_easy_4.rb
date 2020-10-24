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
