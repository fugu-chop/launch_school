# 1) Which of the following expressions return true or false?
# false
(32 * 4) >= 129

# false
false != !true

# false
true == 4

# true
false == (847 == '874')

# true
(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false

# 2) Write a method that takes a string as argument. The method should return a new, all-caps version of the string, only if the string is longer than 10 characters. Example: change "hello world" to "HELLO WORLD". 
def short_caps(string)
  if string.to_s.length > 10
    string.to_s.upcase
  else
    string.to_s
  end
end

# 3) Write a program that takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100.
def num_check(num)
  if num >= 0 && num <= 50
    puts "#{num} is between 0 and 50"
  elsif num <= 100
    puts "#{num} is between 51 and 100"
  elsif num > 100
    puts "#{num} is greater than 100"
  else
    puts "I got no idea, chief"
  end
end

# 4) What will each block of code below print to the screen?
# false
'4' == 4 ? puts("TRUE") : puts("FALSE")

# "Did you get it right?"
x = 2
if ((x * 3) / 2) == (4 + 4 - x - 3)
  puts "Did you get it right?"
else
  puts "Did you?"
end

# "Alright now!"
y = 9
x = 10
if (x + 1) <= (y)
  puts "Alright."
elsif (x + 1) >= (y)
  puts "Alright now!"
elsif (y + 1) == x
  puts "ALRIGHT NOW!"
else
  puts "Alrighty!"
end

# 5) When you run the following code, syntax error, unexpected end-of-input, expecting keyword_end. Why do you get this error and how can you fix it?
=begin
def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
end

equal_to_four(5)
=end
puts "The end keyword is being matched to the if loop, so the def is missing an end word on it"