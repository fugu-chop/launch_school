# Data Types & Variable assignment. Note how we don't need to use var my_num = x
my_num = 25
my_boolean = true
my_string = "Ruby"

# Print out contents of variables
puts my_num
puts my_boolean
puts my_string

# Math operators - we need to use `puts` to display these in the terminal, but not irb
puts 10 + 10
puts 10 - 10
puts 10 * 10
puts 10 / 10
puts 10 ** 2
puts 10 % 3

# Printing - `puts` adds a blank line after returning the string - `print` does not.
print 10 / 10
puts 10 / 10

# Objects - everything in Ruby is an object, which means most things have built in methods attached to them. We can chain methods together.
puts "friend".length
puts "friend".reverse
puts "WINNER".downcase
puts "friend".upcase

# Adding a ! to the end of the method applies it in place
namo = "dominguez"
puts namo.capitalize
puts namo
puts namo.capitalize!

# Multi-line comments
=begin
A BUNCH OF STRING
A BUNCH OF STRING
A BUNCH OF STRING
=end

# Ask for inputs. By default, gets will insert a newline, which .chomp will get rid of. 
print "What's your name, champ? "
name = gets.chomp

#String interpolation
puts "Your name is #{name}."