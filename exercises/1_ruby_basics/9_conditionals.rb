# 1) In the code below, sun is randomly assigned as 'visible' or 'hidden'. Write an if statement that prints "The sun is so bright!" if sun equals 'visible'.
sun = ['visible', 'hidden'].sample

if sun == 'visible'
  puts "The sun is so bright!"
end

# 2) Write an unless statement that prints "The clouds are blocking the sun!" unless sun equals 'visible'.
sun = ['visible', 'hidden'].sample

unless sun == 'visible'
  puts "The clouds are blocking the sun!"
end

# 3) Write an if statement that prints "The sun is so bright!" if sun equals visible. Also, write an unless statement that prints "The clouds are blocking the sun!" unless sun equals visible. When writing these statements, take advantage of Ruby's expressiveness and use statement modifiers instead of an if...end statement to print results only when some condition is met or not met.

puts "The sun is so bright" if sun == 'visible'
puts "The clouds are blocking the sun" unless sun == 'visible'

# 4) In the code below, boolean is randomly assigned as true or false. Write a ternary operator that prints "I'm true!" if boolean equals true and prints "I'm false!" if boolean equals false.
boolean = [true, false].sample

# This is one case where you can't take advantage of Ruby's syntactical sugar. We need to wrap the strings with parentheses.
boolean ? puts ("I'm true!") : puts ("I'm false!")

# 4) What will the following code print? Why?
=begin
number = 7

if number
  puts "My favorite number is #{number}."
else
  puts "I don't have a favorite number."
end
=end
puts "This conditional will print \"My favourite number is 7\". This is because numbers are truthy."

# 5) In the code below, stoplight is randomly assigned as 'green', 'yellow', or 'red'. Write a case statement that prints "Go!" if stoplight equals 'green', "Slow down!" if stoplight equals 'yellow', and "Stop!" if stoplight equals 'red'.
stoplight = ['green', 'yellow', 'red'].sample

case stoplight
when 'green'
  puts "Go!"
when 'yellow'
  puts "Slow down!"
else
  puts "Stop!"
end

# 6) Convert the following case statement to an if statement.
=begin
case stoplight
when 'green'
  puts 'Go!'
when 'yellow'
  puts 'Slow down!'
else
  puts 'Stop!'
end
=end

if stoplight == 'green'
  puts 'Go!'
elsif stoplight == 'yellow'
  puts 'Slow down!'
else
  puts 'Stop!'
end

# 7) In the code below, status is randomly assigned as 'awake' or 'tired'. Write an if statement that returns "Be productive!" if status equals 'awake' and returns "Go to sleep!" otherwise. Then, assign the return value of the if statement to a variable and print that variable.
status = ['awake', 'tired'].sample

productivity = if status == 'awake'
  "Be productive!"
else
  "Go to sleep!"
end

puts productivity

# 8) Currently, "5 is a cool number!" is being printed every time the program is run. Fix the code so that "Other numbers are cool too!" gets a chance to be executed.
=begin
number = rand(10)

if number = 5
  puts '5 is a cool number!'
else
  puts 'Other numbers are cool too!'
end
=end
number = rand(10)

if number == 5
  puts '5 is a cool number!'
else
  puts 'Other numbers are cool too!'
end

# 9) Reformat the following case statement so that it only takes up 5 lines. 
=begin
stoplight = ['green', 'yellow', 'red'].sample

case stoplight
when 'green'
  puts 'Go!'
when 'yellow'
  puts 'Slow down!'
else
  puts 'Stop!'
end
=end

stoplight = ['green', 'yellow', 'red'].sample

case stoplight 
when 'green' then puts 'Go'
when 'yellow' then puts 'Slow down!'
else puts 'Stop!'
end