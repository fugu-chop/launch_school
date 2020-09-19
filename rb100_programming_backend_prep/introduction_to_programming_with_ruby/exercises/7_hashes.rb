# 1) Given a hash of family members, with keys as the title and an array of names as the values, use Ruby's built-in select method to gather only immediate family members' names into a new array.
family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
}

family.select { |key, value| (key == :sisters) || (key == :brothers) }.to_a.flatten

# 2) Look at Ruby's merge method. Notice that it has two versions. What is the difference between merge and merge!? Write a program that uses both and illustrate the differences.
puts "merge (without the bang operator) will return a combined hash of two separate hashes. However, neither of the original hashes is modified. merge! (with the bang operator) will permanently create a new hash. The original hashes that has the second hash merged into it is permanently modified. The second hash is unmodified."

hash_one = {name: "James", age: 24}
hash_two = {gender: 'M', hobby: "Chess"}

# A new hash is returned, but neither original hash is modified
hash_one.merge(hash_two)
hash_one
hash_two

# A new hash is retained, and both original hashes are modified.
hash_one.merge!(hash_two)
hash_one == hash_two

# 3) Using some of Ruby's built-in Hash methods, write a program that loops through a hash and prints all of the keys. Then write a program that does the same thing except printing the values. Finally, write a program that prints both.
my_hash = {name: "James", age: 24, gender: 'M', hobby: "Chess"}
my_hash.each_key { |key| puts key }
my_hash.each_value { |value| puts value }
my_hash.each do |key, value|
  puts "#{value} is the value associated with #{key}."
end

# 4) Given the following expression, how would you access the name of the person?
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
person[:name]

# 5) What method could you use to find out if a Hash contains a specific value in it? Write a program to demonstrate this use.
test_array = {name: "Timmy", occupation: "Dog", hobbies: "Sleeping"}
def hash_val_check (hash, value)
    return hash.has_value?(value)
end

# 6) What's the difference between these hashes?
=begin
x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}
=end
puts "my_hash uses Ruby 1.9 syntax to create a hash. my_hash2 will throw an error, since the type of the key hasn't been specified."

# 7) What does this error mean? NoMethodError: undefined method `keys' for Array
puts "The user has tried to enter a .keys method for an array, which doesn't exist."

# 8) Given the following array, write a program that prints out groups of words that are anagrams. Anagrams are words that have the same exact letters in them but in a different order.
words = ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live', 'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide', 'flow', 'neon']

result = {}

# This solution plays on the fact that hash values can be arrays.
# Iterate through each word
words.each do |word|
  # Split up the word, rearrange it alphabetically and merge the letters back together. This is an array!
  key = word.split('').sort.join
  # At the start, the hash is empty. We skip this on the first run.
  if result.has_key?(key)
    result[key].push(word)
  else
    # We are adding the sorted word AS AN ARRAY. This allows subsequent passes where the key exists, to push the word to an array
    result[key] = [word]
  end
end

result.each_value do |value|
  p value
end



