# 1) The code below is an example of an infinite loop. Modify the code so the loop stops after the first iteration.
=begin
loop do
  puts 'Just keep printing...'
end
=end
loop do
  puts 'Just keep printing...'
  break
end

# 2) The code below is an example of a nested loop. Both loops currently loop infinitely. Modify the code so each loop stops after the first iteration.
=begin
loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
  end
end

puts 'This is outside all loops.'
=end
loop do
  puts 'This is the outer loop.'
  loop do
    puts 'This is the inner loop.'
    break
  end
  break
end
puts 'This is outside all loops.'

# 3) Modify the following loop so it iterates 5 times instead of just once.
=begin
iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  break
end
=end
iterations = 1

loop do 
  puts "Number of iterations = #{iterations}"
  iterations += 1
  if iterations > 5
    break
  end
end

# 4) Modify the code below so the loop stops iterating when the user inputs 'yes'.
=begin
loop do
  puts 'Should I stop looping?'
  answer = gets.chomp
end
=end
loop do
  puts 'Should I stop looping?'
  answer = gets.chomp
  break if answer == "yes"
  puts "I'll keep looping until you type in yes"
end

# 5) Modify the code below so "Hello!" is printed 5 times.
=begin
say_hello = true
while say_hello
  puts 'Hello!'
  say_hello = false
end  
=end
say_hello = 1
while say_hello < 6
  puts 'Hello!'
  say_hello += 1
end

# 6) Using a while loop, print 5 random numbers between 0 and 99. 
=begin
numbers = []

while <condition>
  # ...
end
=end
numbers = []

while numbers.length < 5
  numbers.push(rand(100))
end

puts numbers

# 7) The following code outputs a countdown from 10 to 1. Modify the code so that it counts from 1 to 10 instead.
=begin
count = 10

until count == 0
  puts count
  count -= 1
end
=end
count = 1

until count > 10
  puts count
  count += 1
end

# 8) Given the array of several numbers below, use an until loop to print each number.
numbers = [7, 9, 13, 25, 18]
count = 0

until count == numbers.length
  puts numbers[count]
  count += 1
end

# 9) The code below shows an example of a for loop. Modify the code so that it only outputs i if i is an odd number.
=begin
for i in 1..100
  puts i
end
=end

for i in 1..100
  puts i if i % 2 != 0
end

# 10) Your friends just showed up! Given the following array of names, use a for loop to greet each friend individually.
friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}!"
end