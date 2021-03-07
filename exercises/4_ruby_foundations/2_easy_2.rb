# 1) Write a method that does the same thing as Range#step, but does not operate on a range. Instead, your method should take 3 arguments: the starting value, the ending value, and the step value to be applied to each iteration. Your method should also take a block to which it will yield (or call) successive iteration values.
=begin
step(1, 10, 3) { |value| puts "value = #{value}" }

value = 1
value = 4
value = 7
value = 10
=end
def step(start, stop , increment)
  until start > stop
    yield(start)
    start += increment
  end
  # There's no stipulation as to what we should return. I've chosen stop as it seems like a logical to do? The Range#step returns the original array (which isn't applicable here)
  stop
end

# 2) Write your own version of zip that does the same type of operation. It should take two Arrays as arguments, and return a new Array (the original Arrays should not be changed). Do not use the built-in Array#zip method. You may assume that both input arrays have the same number of elements.
=begin
zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
=end
def zip(arr1, arr2)
  arr1.map.with_index do |element, idx|
    [element, arr2[idx]]
  end
end

# 3) Write a method called map that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return a new Array that contains the return values produced by the block for each element of the original Array. If the Array is empty, map should return an empty Array, regardless of how the block is defined. Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.
=begin
map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
map([]) { |value| true } == []
map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]
=end
def map(arr)
  output = []
  for i in arr
    output << yield(i)
  end
  output
end

# Alt solution that works with hashes and sets, but also returns a collection using the new format (instead of an array, which is what the default map implementation does)
def map(collection)
  collection.each_with_object(collection.class.new) { |element, result| result << yield(element) }
end

# 4) Write a method called count that behaves similarly for an arbitrarily long list of arguments. It should take 0 or more arguments and a block, and then return the total number of arguments for which the block returns true. If the argument list is empty, count should return 0.
=begin
count(1, 3, 6) { |value| value.odd? } == 2
count(1, 3, 6) { |value| value.even? } == 1
count(1, 3, 6) { |value| value > 6 } == 0
count(1, 3, 6) { |value| true } == 3
count() { |value| true } == 0
count(1, 3, 6) { |value| value - 6 } == 3
=end
def count(*items)
  # The *items lets us treat the inputs as an array
  counts = 0
  counter = 0
  while counter < items.size
    counts += 1 if yield(items[counter])
    counter += 1
  end
  counts
end

# 5) * Write a method called drop_while that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return all the elements of the Array, except those elements at the beginning of the Array that produce a truthy value when passed to the block. If the Array is empty, or if the block returns a truthy value for every element, drop_while should return an empty Array.
=begin
drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| true } == []
drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
drop_while([]) { |value| true } == []
=end
def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end

# Alt Approach - what I was going for originally
def drop_while(arr)
  results = []
  arr.each do |item|
    if yield(item)
      results << item
    else
      break
    end
  end
  arr - results
end

# 6) Write a method called each_with_index that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should yield each element and an index number to the block. each_with_index should return a reference to the original Array. Your method may use #each, #each_with_object, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.
=begin
result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

result == [1, 3, 6]
=end
def each_with_index(arr)
  idx = 0
  for i in arr
    yield(arr[idx], idx)
    idx += 1
  end
  arr
end

# 7) Write a method called each_with_object that behaves similarly for Arrays. It should take an Array and an object of some sort as an argument, and a block. It should yield each element and the object to the block. each_with_object should return the final value of the object. If the Array is empty, each_with_object should return the original object passed as its second argument. Note with each_with_object, the final value of the object is returned.
=begin
result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
result == {}
=end
def each_with_object(arr, empty_obj)
  empty_obj = empty_obj.class.new
  for i in arr
    yield(i, empty_obj)
  end
  empty_obj
end

# Alternative solution
def each_with_object(arr, obj)
  arr.each { |item| yield(item, obj) }
  obj
end

# 8) Write a method called max_by that behaves similarly for Arrays. It should take an Array and a block, and return the element that contains the largest value. If the Array is empty, max_by should return nil.
=begin
max_by([1, 5, 3]) { |value| value + 2 } == 5
max_by([1, 5, 3]) { |value| 9 - value } == 1
max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
max_by([-7]) { |value| value * 3 } == -7
max_by([]) { |value| value + 5 } == nil
=end
def max_by(arr)
  return nil if arr.empty?
  results = []
  arr.each { |item| results << yield(item) }
  arr[results.index(results.max)]
end

# Suggested solution
def max_by(array)
  return nil if array.empty?

  max_element = array.first
  # We need to yield this variable in order for the block to access it
  largest = yield(max_element)

  array[1..-1].each do |item|
    yielded_value = yield(item)
    if largest < yielded_value
      largest = yielded_value
      max_element = item
    end
  end

  max_element
end

# 9) Write a method called each_cons that behaves similarly for Arrays, taking the elements 2 at a time. The method should take an Array as an argument, and a block. It should yield each consecutive pair of elements to the block, and return nil. Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection. #each_cons returns nil
=begin
hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
result == nil
hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
hash == {}
result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
hash == {'a' => 'b'}
result == nil
=end
# We are assuming we only take two elements at a time
def each_cons(arr)
  idx1 = 0
  while idx1 < arr.size - 1
    yield(arr[idx1], arr[idx1 + 1])
    idx1 += 1
  end
  nil
end

# 10) Update your each_cons method so it takes an argument that specifies how many elements should be processed at a time.
=begin
hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
hash == {}
=end
def each_cons(arr, elements)
  idx = 0
  while idx < arr.size - (elements - 1)
    yield(elements == 1 ? arr[idx] : arr.slice(idx..(idx + elements - 1)))
    idx += 1
  end
  nil
end

# Suggested solution
def each_cons(array, n)
  array.each_index do |index|
    break if index + n - 1 >= array.size
    # The splat operator removes our issue with a single array element, for some reason
    yield(*array[index..(index + n - 1)])
  end
  nil
end
