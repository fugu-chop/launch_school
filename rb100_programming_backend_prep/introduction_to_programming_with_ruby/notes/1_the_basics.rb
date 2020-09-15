# Add two strings together that, when concatenated, return your first and last name as your full name in one string.
puts "Pickle " + "Juice"

# 2) Use the modulo operator, division, or a combination of both to take a 4 digit number and find the digit in the: 
# thousands place
puts 1234 / 1000

# hundreds place 
puts 1234 % 1000 / 100

# tens place 
puts 1234 % 100 / 10

# ones place
puts 1234 % 10

# 3) Write a program that uses a hash to store a list of movie titles with the year they came out. Then use the puts command to make your program print out the year of each movie to the screen.
movies_hash = { :seven_samurai => 1954, 
                :reservoir_dogs => 1992, 
                :godfather => 1972, 
                :shawshank_redemption => 1994 }

puts movies_hash[:seven_samurai]
puts movies_hash[:reservoir_dogs]
puts movies_hash[:godfather]
puts movies_hash[:shawshank_redemption]

# 4) Use the dates from the previous example and store them in an array. Then make your program output the same thing as exercise 3
my_array = [1954, 1992, 1972, 1994]
puts my_array[0]
puts my_array[1]
puts my_array[2]
puts my_array[3]

# 5) Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.
puts 5 * 4 * 3 * 2
puts 6 * 5 * 4 * 3 * 2
puts 7 * 6 * 5 * 4 * 3 * 2
puts 8 * 7 * 6 * 5 * 4 * 3 * 2

# 6) Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen
puts 4.3 ** 2
puts 2.3 ** 2
puts 1.3 ** 2

# 7) What does the following error message tell you?
# SyntaxError: (irb):2: syntax error, unexpected ')', expecting '}' from /usr/local/rvm/rubies/ruby-2.5.3/bin/irb:16:in `<main>'
puts "This looks like a hash that doesn't have the closing curly bracket."