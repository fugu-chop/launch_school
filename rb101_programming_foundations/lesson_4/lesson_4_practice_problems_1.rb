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

# 6) What is the return value of the following statement? Why?
['ant', 'bear', 'caterpillar'].pop.size

puts "The return value of this will be 11. The pop method will return the last element of the array (also permanently mutating the array), while size will return 11, based on what is returned by the method it is chained to. "

# 7) What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

puts "The block's return value should be true, false and true, since it evaluates each element of the array passed to it sequentially, and odd is the last expression in the block, meaning what it resolves will be returned. The return value of any should be 'true', since it evaluates what is returned by the block, and if any of the elements evaluate to true, any? will also return true."

puts "What is also interesting here is any? stops iterating after this point since there is no need to evaluate the remaining items in the array; therefore, puts num is only ever invoked for the first item in the array: 1."

# 8) How does take work? Is it destructive? How can we find out?
arr = [1, 2, 3, 4, 5]
arr.take(2)

puts "We can reference the documentation to find out what take does. It should return a new array that comprises of the first n elements of the array on which it is called. It does not destructively change the original array. This should return [1, 2]."

# 9) What is the return value of map in the following code? Why?
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

puts "map will return an array of [nil, 'bear'], as ant is not greater than three. This means the block evaluates this condition as false, and does not return a value, hence nil is passed to the new array."

puts "When none of the conditions in an if statement evaluates as true, the if statement itself returns nil. That's why we see nil as the first element in the returned array."

# 10) What is the return value of the following code? Why?
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

puts "This statement will return an array of [1, nil, nil]. This is because 2 and 3 evaluate to greater than 1, and puts returns a nil."