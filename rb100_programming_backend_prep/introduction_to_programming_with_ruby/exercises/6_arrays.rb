# 1) Write a program that checks to see if the number appears in the array.
arr = [1, 3, 5, 7, 9, 11]
number = 3

arr.include?(number)

# 2) What will the following programs return? What is the value of arr after each?
=begin
arr = ["b", "a"]
arr = arr.product(Array(1..3))
arr.first.delete(arr.first.last)

arr = ["b", "a"]
arr = arr.product([Array(1..3)])
arr.first.delete(arr.first.last)
=end
puts "The first program's array will have a value of [[b], [b, 2], [b, 3], [a, 1], [a, 2], [a, 3]]. The program will return 1. While .product does not mutate an array by itself, reassigning the varible means the original array is overwritten. The new array is permanently mutated by the delete method."
puts "The second program's array has a value of [[b], [a, [1, 2, 3]]]. The program will return [1, 2, 3]."

# 3) How do you return the word "example" from the following array?
arr = [["test", "hello", "world"],["example", "mem"]]
arr.last.first

# 4) What does each method return in the following example?
arr = [15, 7, 18, 5, 12, 8, 5, 1]

puts "arr.index(5) returns 3"
puts "arr.index[5] returns an error"
puts "arr[5] returns 8"

# 5) What is the value of a, b, and c in the following program?
string = "Welcome to America!"
puts "string[6] returns \"e\""
puts "string[11] returns \"A\""
puts "string[19] returns nil"

# 6) We have the following code - it throws the error specified. Why does this happen and how do we fix it?
=begin
names = ['bob', 'joe', 'susan', 'margaret']
names['margaret'] = 'jody'
TypeError: no implicit conversion of String into Integer
=end
puts "This syntax looks like the user is trying to replace an element in an array using hash style commands.  Arrays are indexed with integers, not strings. We could use names[3] = \"jody\"."

# 7) Use the each_with_index method to iterate through an array of your creation that prints each index and value of the array.
arr = [1, 2, 3, 4, 5]
arr.each_with_index { |index, value| puts "The value #{value} is found at index #{index}" }

# 8) Write a program that iterates over an array and builds a new array that is the result of incrementing each value in the original array by a value of 2. You should have two arrays at the end of this program, The original array and the new array you've created. Print both arrays to the screen using the p method instead of puts.
my_arr = [1, 2, 3, 4, 5]
new_arr = my_arr.map { |element| element + 2 }
p my_arr
p new_arr