# 1) Write a loop that prints numbers 1-5 and whether the number is even or odd. 
count = 1

loop do
  if count.even?
    puts "#{count} is even!"
  else
    puts "#{count} is odd!"
  end
  count += 1
  break if count > 5
end

# 2) Modify the following code so that the loop stops if number is equal to or between 0 and 10.
=begin
loop do
  number = rand(100)
  puts number
end
=end
loop do
  number = rand(100)
  puts number
  break if number.between?(0, 10)
end

# 3) Using an if/else statement, run a loop that prints "The loop was processed!" one time if process_the_loop equals true. Print "The loop wasn't processed!" if process_the_loop equals false.
process_the_loop = [true, false].sample

if process_the_loop
  loop do
    puts "The loop was processed!"
    break
  end
else
  puts "The loop wasn't processed!"
end

# 4) The code below asks the user "What does 2 + 2 equal?" and uses #gets to retrieve the user's answer. Modify the code so "That's correct!" is printed and the loop stops when the user's answer equals 4. Print "Wrong answer. Try again!" if the user's answer doesn't equal 4.
=begin
loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
end
=end
loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
  if answer == 4
    puts "That's correct!"
    break
  else
    puts "Wrong answer, try again!"
  end
end

# 5) Modify the code below so that the user's input gets added to the numbers array. Stop the loop when the array contains 5 numbers.
=begin
numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i
end
puts numbers
=end

numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i
  numbers.push(input)
  break if numbers.size == 5
end

puts numbers

# 6) Given the array below, use loop to remove and print each name. Stop the loop once names doesn't contain any more elements. Keep in mind to only use loop.
names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do
  puts names.shift
  break if names.empty?
end

# 7) The method below counts from 0 to 4. Modify the block so that it prints the current number and stops iterating when the current number equals 2.
=begin
5.times do |index|
  # ...
end
=end
5.times do |index|
  puts index
  break if index == 2
end

# 8) Using next, modify the code below so that it only prints even numbers.
=begin
number = 0

until number == 10
  number += 1
  puts number
end
=end

number = 0
until number == 10
  number += 1
  next if number.odd?
  puts number
end

# 9) The following code increments number_a and number_b by either 0 or 1. loop is used so that the variables can be incremented more than once, however, break stops the loop after the first iteration. Use next to modify the code so that the loop iterates until either number_a or number_b equals 5. Print "5 was reached!" before breaking out of the loop.
=begin
number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)

  break
end
=end

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)
  next if (number_a != 5) || (number_b != 5)
  puts "5 was reached!"
  break
end

# 10) Given the code below, use a while loop to print "Hello!" twice.
=begin
def greeting
  puts 'Hello!'
end

number_of_greetings = 2
=end

def greeting
  puts 'Hello!'
end

number_of_greetings = 2

while number_of_greetings != 0
  greeting
  number_of_greetings -= 1
end