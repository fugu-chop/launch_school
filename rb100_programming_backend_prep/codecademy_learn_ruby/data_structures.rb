# Arrays are defined using square brackets. 
# They can contain anything, including other arrays ("everything in Ruby is an object")
crazy_array = [[1, 2, 3], [true, false, true], ["a", "b", "c"]]
crazy_array.each do |item|
  print "#{item}\n"
end

# Hashes are key value pairs, like dictionaries in Python, or JS objects
# This is hash literal notation (explicitly defining our key value pairs)
example_hash = {
    "name" => "Eric",
    "age" => 25,
    "angry" => true
}

puts example_hash["angry"]

# Creating an empty hash, adding key value pairs
# We've set a default value of 0 for when we try to access keys that don't exist
pets = Hash.new(0)
pets["name"] = "Steve"

# Iterating over arrays
s = [["ham", "swiss"], ["turkey", "cheddar"], ["roast beef", "gruyere"]]

s.each do |sub_array|
  sub_array.each do |item| 
    puts item
  end
end

# Iterating over hashes - we need two placeholder variables to represent each key/value pair.
restaurant_menu = {
  "noodles" => 4,
  "soup" => 3,
  "salad" => 2
}

restaurant_menu.each do |item, price|
  puts "#{item}: #{price}"
end

# Sample code for a count of words
puts "Please enter some text "
text = gets.chomp.downcase

words = text.split(" ")

frequencies = Hash.new(0)

# For each word we find, assume that the word itself is a key in frequencies and increment its value by 1.
# This is why our default is 0. The first time we find the word, it will have a default value of 0 that we can increment by 1.
words.each do |word|
  frequencies[word] += 1
end

# We need to reference each potential variable before we can use them (otherwise Ruby won't know which variable you're referencing)
frequencies = frequencies.sort_by do |word, count|
  count
end

frequencies.reverse!

# We have to 
frequencies.each do |word, count|
  puts "#{word} #{count.to_s}"
end