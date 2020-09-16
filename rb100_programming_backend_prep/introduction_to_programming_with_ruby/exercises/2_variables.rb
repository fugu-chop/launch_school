# Write a program called name.rb that asks the user to type in their name and then prints out a greeting message with their name included.
puts "Hello, I am name.rb. Please enter your name!"
name = gets.chomp
puts "Hello #{name}!"

# Write a program called age.rb that asks a user how old they are and then tells them how old they will be in 10, 20, 30 and 40 years.
puts "Hello, I am age.rb. Please enter your age!"
age = gets.chomp.to_i
puts "You will be #{age + 10} in 10 years time, #{age + 20} in 20 years time, #{age + 30} in 30 years time and #{age + 40} in 40 years time!"

# Add another section onto name.rb that prints the name of the user 10 times. You must do this without explicitly writing the puts method 10 times in a row.
puts "Hello, I am name.rb. Please enter your name!"
name = gets.chomp
10.times { puts "Hello #{name}!" }

# Modify name.rb again so that it first asks the user for their first name, saves it into a variable, and then does the same for the last name. Then outputs their full name all at once.
puts "Hello, I am name.rb. Please enter your first name!"
first_name = gets.chomp
puts "Please enter your last name!"
last_name = gets.chomp
puts "Hello, #{first_name} #{last_name}!"

# Look at the following programs...
=begin
x = 0
3.times do
  x += 1
end
puts x

compared to

y = 0
3.times do
  y += 1
  x = y
end
puts x

What does x print to the screen in each case?
=end
puts "In the first example, x = 3, since the variable has access to the outer scope when the method is invoked with a block (do end), meaning it can change that variable in the outer scope."

puts "In the second example, x will return an error, since the outer scope does not have access to variables that are assigned only when a method is invoked with a block. The outer scope does not know what x is here."