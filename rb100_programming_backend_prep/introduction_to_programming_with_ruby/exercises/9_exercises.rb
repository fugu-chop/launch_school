# 1) Use the each method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.
my_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
my_arr.each { |num| puts num }

# 2) Same as above, but only print out values greater than 5.
my_arr.each { |num| puts num if num > 5 }

# 3) Now, using the same array from #2, use the select method to extract all odd numbers into a new array.
new_arr = my_arr.select { |num| (num > 5) && (num % 2 != 0) }

# 4) Append 11 to the end of the original array. Prepend 0 to the beginning.
my_arr.push(11).unshift(0)

# 5) Get rid of 11. And append a 3.
my_arr.pop
my_arr.push(3)

# 6) Get rid of duplicates without specifically removing any one value.
my_arr.uniq

# 7) What's the major difference between an Array and a Hash?
puts "An array is an ordered list of items. A hash is a collection of key value pairs. Prior to Ruby 1.9, hashes were unordered."

# 8) Create a Hash, with one key-value pair, using both Ruby syntax styles.
old_hash = {:key1 => "value1"}
new_hash = {key1: "value1"}

# 9) Get the value of key `:b`.
h = {a:1, b:2, c:3, d:4}
h[:b]

# Add to this hash the key:value pair `{e:5}`
h[:e] = 5

# Remove all key:value pairs whose value is less than 3.5
h.delete_if { |key, value| value < 3.5 }

# 10) Can hash values be arrays? Can you have an array of hashes? (give examples)
puts "You can definitely has arrays as hash values. You can also have an array of hashes."
hash_array_value = { key1: [1, 2, 3] }
array_of_hashes = [{key1: 1}, 2, 3]

# 11) Given the following data structures. Write a program that copies the information from the array into the empty hash that applies to the correct person.
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"], ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts["Joe Smith"][:email] = contact_data[0][0]
contacts["Joe Smith"][:address] = contact_data[0][1]
contacts["Joe Smith"][:phone] = contact_data[0][2]
contacts["Sally Johnson"][:email] = contact_data[1][0]
contacts["Sally Johnson"][:address] = contact_data[1][1]
contacts["Sally Johnson"][:phone] = contact_data[1][2]

# 12) Using the hash you created from the previous exercise, demonstrate how you would access Joe's email and Sally's phone number?
contacts["Joe Smith"][:email]
contacts["Sally Johnson"][:phone]

# 13) Use Ruby's Array method delete_if and String method start_with? to delete all of the words that begin with an "s" in the following array.
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if do |element|
  element.start_with?('s')
end

# Then recreate the arr and get rid of all of the words that start with "s" or starts with "w".
arr.delete_if do |word|
  word.start_with?('s') || word.start_with?('w')
end

# 14) Take the array and turn it into a new array that consists of strings containing one word. (ex. ["white snow", etc...] → ["white", "snow", etc...]. Look into using Array's map and flatten methods, as well as String's split method.
a = ['white snow', 'winter wonderland', 'melting ice', 'slippery sidewalk', 'salted roads', 'white trees']
new_arr = a.map do |element|
  element.split(' ')
end.flatten

# 15) What will the following program output?
=begin
hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end
=end
puts "This hash will output \"These hashes are the same!\", because the comparison operator for hashes compares key to key and value to value (including type), but not in order."

# 16) Programmatically loop or iterate over the contacts hash from exercise 11, and populate the associated data from the contact_data array. Hint: you will probably need to iterate over ([:email, :address, :phone]), and some helpful methods might be the Array shift and first methods. Note that this exercise is only concerned with dealing with 1 entry in the contacts hash. 
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"], ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# 1. Manually set our keys, since we don't have them anywhere in our code. Do this in an array
hash_keys = [:email, :address, :phone]

# We can insert our keys and values into a nested array, then use indexing to fetch these for insertion into the hash
full_arr = []
for i in 0...hash_keys.length
  full_arr.push([hash_keys[i], contact_data.first[i]])
end

# 2. Generate an empty hash, loop through our key array, inserting them into our hash
full_arr.each do |element|
  contacts["Joe Smith"][element[0]] = element[1]
end

# Suggested solution
=begin 
contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
fields = [:email, :address, :phone]

contacts.each do |name, hash|
  fields.each do |field|
    hash[field] = contact_data.shift
  end
end
=end

# As a bonus, see if you can figure out how to make it work with multiple entries in the contacts hash.
contact_list = contacts.keys

# Since we're going with an unknown list of entries, we have to iterate through them. For now, we'll just combine all the information into a single nested array.
full_arr = []
for n in 0 ...contact_list.length
  for i in 0...hash_keys.length
    full_arr.push([hash_keys[i], contact_data[n][i]])
  end
end

# Using the trick we learned in the previous lesson, we'll create a hash, so that we have an array of values according to the key.
results = {}
full_arr.each do |entry|
  key = entry[0]
  if results.has_key?(key)
    results[key].push(entry[1])
  else 
    results[key] = [entry[1]]
  end
end

# The shift method returns a value, then drops it from the original array. What a handy method!
contacts.each_key do |person|
  results.each do |key, value|
    contacts[person][key] = value.shift
  end
end

# Suggested solution
=begin
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"], ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
fields = [:email, :address, :phone]

contacts.each_with_index do |(name, hash), idx|
  fields.each do |field|
    hash[field] = contact_data[idx].shift
  end
end
=end

