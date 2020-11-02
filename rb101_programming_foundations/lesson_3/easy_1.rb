# 1) What would you expect the code below to print out?
=begin
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
=end
puts 'I would expect the puts statement in this code to print out 1, 2, 2, 3, as .uniq is a non-mutating method. Puts formats the array into a string, which breaks it up into it\'s elements'

# 2) Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios.
puts '! is a bang operator. It can make a non-mutating method into a mutating method, negate a boolean, as well as serve as a non-equality comparison operator. ? typically serves to indicate to a user that a method returns a boolean, but can also serve as a ternary operator.'

# 2a) What is != and where should you use it? 
puts '!= serves as a non-equality operator between two operands, to return a boolean.'

# 2b) put ! before something, like !user_name
puts '! serves to negate the returned value of user_name, with the assumption that user_name would return a boolean'

# 2c) put ! after something, like words.uniq!
puts '! here would turn a non-mutating method into a mutating method.'

# 2d) put ? before something 
puts 'Putting a ? before something would convert it to a ternary operator, such that the something would be returned as the true condition'

# 2e) put ? after something 
puts 'Putting a ? after something usually signifies that the something is a method, and should return a boolean.'

# 2f) put !! before something, like !!user_name
puts 'A double ! turns an object into it\'s boolean equivalent.'

# 3) Replace the word "important" with "urgent" in this string
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent')

# 4) What do the following method calls do (assume we reset numbers to the original array between method calls)?
numbers = [1, 2, 3, 4, 5]
# numbers.delete_at(1)
puts 'The delete_at method will return the element at index 1, which is 2 in our case. This is a permanently mutating method.'

# numbers.delete(1)
puts 'The delete method will delete the element 1 from the numbers array (all occurrences). This is a permanently mutating method.'

# 5) Programmatically determine if 42 lies between 10 and 100. Use the range object
(10..100).cover?(42)

# 6) Show two different ways to put the expected "Four score and " in front of it.
famous_words = "seven years ago..."
"Four score and " + famous_words
famous_words.prepend("Four score and ")

# 7) Unnest this array
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!(1)

# 8) Turn this into an array containing only two elements: Barney's name and Barney's number
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintstones.assoc("Barney")