# Method syntax
def greeting
  puts "Hi there!"
end

# Call our method
greeting

# Splat arguments allow methods to take a variable number of arguments
def what_up(greeting, *friends)
  friends.each { |friend| puts "#{greeting}, #{friend}!" }
end

what_up("What up", "Ian", "Zoe", "Zenas", "Eleanor")

# Return allows us to use outputs from functions for other purposes (not just printing them out and losing them)
def double(n)
  return n * 2
end

output = double(6)
output += 2
puts output

# Blocks are the equivalent of anonymous functions
1.times do
  puts "I'm a code block!"
end

# Sorting
my_array = [4, 5, 1, -4, 9, 2, 10]

puts my_array.sort!

# Combined Comparison Operator (CCO)
# For strings, this compares corresponding characters' binary values. 
puts 7 <=> -3

# Sorting with the CCO
books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]

# Ascending order
puts books.sort! { |firstBook, secondBook| firstBook <=> secondBook }

# Descending order (We could also use reverse!)
puts books.sort! { |firstBook, secondBook| secondBook <=> firstBook }