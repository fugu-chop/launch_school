# 1) What is the return value of the select method below? Why?
[1, 2, 3].select do |num|
  num > 5
  'hi'
end

puts "select performs selection based on the truthiness of the block's return value. In this case the return value will always be 'hi', which is a 'truthy' value. Therefore select will return a new array containing all of the elements in the original array."

# 2) How does count treat the block's return value? How can we find out?
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

puts "It would appear that count performs some operation based on the truthiness of the block's return value, since there is a conditional expression in the block. We can verify this by looking at the documentation."

# 3) What is the return value of reject in the following code? Why?
[1, 2, 3].reject do |num|
  puts num
end

puts "The documentation indicates reject will return a new array that contains elements where the evaluation criteria are returned as false or nil (falsy). Since puts returns nil, this should return an array of [1, 2, 3]."

# 4) What is the return value of each_with_object in the following code? Why?
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

puts "This will return a hash of { 'a' => 'ant', 'b' => 'bear', 'c' => 'cat }. The value parameter represents each element of the array as it gets iterated through, while the hash parameter represents the empty hash passed to the each_with_object method."

puts "When we invoke each_with_object, we pass in an object ({} here) as an argument. That object is then passed into the block and its updated value is returned at the end of each iteration. Once each_with_object has iterated over the calling collection, it returns the initially given object, which now contains all of the updates."

# 5) What does shift do in the following code? How can we find out?
hash = { a: 'ant', b: 'bear' }
hash.shift

puts "We can consult the documentation, which says the shift method removes a key-value pair from a hash and returns it as the two-item array [ key, value ]. This would suggest [a:, 'ant'] would be returned."