# 1) In the code below, an array containing different types of pets is assigned to pets. Select 'fish' from pets, assign the return value to a variable named my_pet, then print the value of my_pet.
pets = ['cat', 'dog', 'fish', 'lizard']

my_pet = pets[2]
puts "I have a pet #{my_pet}!"

# 2) Write some code that selects 'fish' and 'lizard' form the pets array - select the two items at the same time. Assign the return value to a variable named my_pets, the print the contents of my_pets as a single string.
pets = ['cat', 'dog', 'fish', 'lizard']

my_pet = pets[2..3]
puts "I have a pet #{my_pet[0]} and a pet #{my_pet[1]}!"

# 3) In the code below, an array containing different types of pets is assigned to pets. Also, the return value of pets[2..3], which is ['fish', 'lizard'], is assigned to my_pets. Remove 'lizard' from my_pets then print the value of my_pets.
=begin
pets = ['cat', 'dog', 'fish', 'lizard']
my_pet = pets[2..3]
=end
pets = ['cat', 'dog', 'fish', 'lizard']
my_pet = pets[2..3]

my_pet.pop
# my_pets is still an array. Just because it only has one element doesn't mean it somehow converted to a string. Arrays can contain any number of elements, even none.
puts "I have a pet #{my_pet[0]}!"

# 4) Using the code below, select 'dog' from pets, add the return value to my_pets, then print the value of my_pets.
=begin
pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop
=end
pets = ['cat', 'dog', 'fish', 'lizard']
my_pets = pets[2..3]
my_pets.pop

my_pets.push(pets[1])
puts "I have a pet #{my_pets[0]} and a pet #{my_pets[1]}!"

# 5) In the code below, an array containing different types of colors is assigned to colors. Use Array#each to iterate over colors and print each element.
=begin
colors = ['red', 'yellow', 'purple', 'green']
=end

colors = ['red', 'yellow', 'purple', 'green']

colors.each do |color|
  puts "I'm the color #{color}!"
end

# 6) In the code below, an array containing the numbers 1 through 5 is assigned to numbers. Use Array#map to iterate over numbers and return a new array with each number doubled. Assign the returned array to a variable named doubled_numbers and print its value using #p.
=begin
numbers = [1, 2, 3, 4, 5]
=end
numbers = [1, 2, 3, 4, 5]

# In this exercise, we use Array#map which iterates over an array and returns a new array with each element transformed based on the block's return value. This means we can assign the return value of #map to a variable to use at a later time. 
doubled_numbers = numbers.map do |number|
  number * 2
end
p doubled_numbers

# 7) In the code below, an array containing five numbers is assigned to numbers. Use Array#select to iterate over numbers and return a new array that contains only numbers divisible by three. Assign the returned array to a variable named divisible_by_three and print its value using #p.
=begin
numbers = [5, 9, 21, 26, 39]
=end
numbers = [5, 9, 21, 26, 39]

divisible_by_three = numbers.select do |number|
  number % 3 == 0
end
p divisible_by_three

# 8) The following array contains three names and numbers. Group each name with the number following it by placing the pair in their own array. Then create a nested array containing all three groups. What does this look like? (You don't need to write any code here. Just alter the value shown so it meets the exercise requirements.)
=begin
['Dave', 7, 'Miranda', 3, 'Jason', 11]
=end
[[['Dave', 7], ['Miranda', 3], ['Jason', 11]]]

# 9) In the code below, a nested array containing three groups of names and numbers is assigned to favorites. Flatten and print this array. That is, the printed result should not have any subarrays, but should have all of the original strings and numbers from the original array:
=begin
favorites = [['Dave', 7], ['Miranda', 3], ['Jason', 11]]
=end
favorites = [['Dave', 7], ['Miranda', 3], ['Jason', 11]]

p favorites.flatten

# 10) In the code below, two arrays containing several numbers are assigned to two variables, array1 and array2.
=begin
array1 = [1, 5, 9]
array2 = [1, 9, 5]
=end
puts "These arrays will evaluate as false, since an array comparison will compare elements by index."
