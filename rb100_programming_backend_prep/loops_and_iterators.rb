# While loop
i = 0
while i < 5
  puts i
  i += 1
end

# Unless loop. Functionally the same as a while loop
counter = 1
until counter > 10
  puts counter
  counter += 1
end

# For loop. The three dots mean 1 to 10, exclusive. Two dots is 1 to 10, inclusive. 
for num in 1...10
  puts num
end

# Iterators. Functionally similar to a for loop. We can replace the do end with {}.
x = 0
loop do
  x += 1
  puts x
  break if x > 5
end

# The next keyword can be used to skip steps in a loop. 
for i in 1..5
  next if i % 2 == 0
  print i
end

# Arrays are just like JS
my_array = [1, 2, 3, 4, 5]

# .each method
odds = [1, 2, 3, 4, 5]
odds.each do |i|
  i *= 2
  print "#{i}"
end

# Sample full code
puts "Type in some text, fool! "
text = gets.chomp

puts "Type a word you want to redact! "
redact = gets.chomp

words = text.split(" ")

words.each do |word|
  if word == redact
    print "REDACTED "
  else
    print "#{word} "
  end
end