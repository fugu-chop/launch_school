# Arrays

## Table of Contents
- [What is an array?](#what-is-an-array)
- [Modifying arrays](#modifying-arrays)
- [Iterating over an array](#iterating-over-an-array)
- [Select](#select)
- [Common array methods](#common-array-methods)
- [Each v Map](#each-v-map)
- [Multiple assignment](#multiple-assignment)

### What is an array?
An array is an *ordered list* of elements that can be of *any* type. You can define an array by placing a list of elements between square bracket `[ ]`.
`my_array = [1, 'Bob', 4.33, true]`

###### Indexing arrays
For the first or last item of an array, we have methods for this. Arrays are what we call indexed lists. That means that each slot in an array is numbered. You can reference any element by *its index number*. Indexes start at 0 in Ruby. 
```ruby
my_array.first
# => 1

my_array.last
# => true

my_array[1]
# => "Bob"

my_array[9]
# => nil
```
### Modifying arrays
If you'd like to take the last item off of an array *permanently*, you can use the `pop` method. 
Note that when we called the `pop` method, the *original* array variable was modified (i.e. this is a method that __mutates the caller__), but the *returned* value is the popped element.
```ruby
my_array.pop
# => true

my_array
# => [1, "Bob", 4.33]
```
If you want to add items to an array *permanently*, we can use the `push` method, along with any desired parameters. The full array is returned, with the new elements appended to the __end__ of the array.
```ruby
my_array.push("test1", 42, false)
# => [1, "Bob", 4.33, "test1", 42, false]
```
We can also use the shovel operator `<<` to permanently add a *single* item to the end of an array.
```ruby
my_array << 3
# => [1, "Bob", 4.33, "test1", 42, false, 3]
```
If we want to remove a specific item __permanently__ from an array, and we *know the index*, we can use the `delete_at` method. 
```ruby
a = [1, 2, 3, 4]
a.delete_at(2)
# => 3
a
# => [1, 2, 4]
```
If we __don't__ know the index, but know what the value is, we can use the `delete` method instead. Note that this will delete __all__ instances of the value. This permanently mutates the original array. `delete` returns the deleted item.
```ruby
a = [1, 2, 3, 4, 2]
a.delete(2)
# => 2

a
# => [1, 3, 4]
```
If we want an array with only unique elements, we can use the `uniq` method. The `uniq` method will return a new array, and leave the old array untouched. However, if we want to remove non-unique elements from the array, we can use the bang (`!`) suffix.
```ruby
a = [1, 2, 4, 3, 2, 3, 4]
a.uniq
# => [1, 2, 4, 3]

a
# => [1, 2, 4, 3, 2, 3, 4]

# Using the bang operator
a = [1, 2, 4, 3, 2, 3, 4]
a.uniq!
# => [1, 2, 4, 3]

a
# => [1, 2, 4, 3]
```
### Iterating over an array
If we want to apply a change to all elements of the array, we can use the `map` or `collect` method.
It iterates over an array *applying a block to each element* of the array and __returns a new array__ with those results (the original array is not mutated). 

The key to remember here is that `map` always performs transformation based on the *return value of the block*. 
```ruby
[1, 2, 3].map do |num|
  num.odd?
end
# => [true, false, true]
```
In this case, the return value of the block will be a boolean for each iteration. This means that the collection returned by `map` will be an array of booleans. 

Take care to remember that `map` doesn't care about truthiness, and takes the return value as the transformation criteria.
```ruby
[1, 2, 3].map do |num|
  num.odd?
  puts num
end

1
2
3
# => [nil, nil, nil]
```
Again, we can use the bang operator to make these changes permanent. 
```ruby
a = [1, 2, 3, 4]
a.map { |num| num**2 }
# => [1, 4, 9, 16]

# Original array is not mutated
a
# => [1, 2, 3, 4]

a.map! { |num| num**2 }
# => [1, 4, 9, 16]

# Original array is mutated
a
# => [1, 4, 9, 16]
```
### Select
If we want to filter specific elements from an array or hash, we can use the `select` method. This method iterates over an array or hash and *returns a new collection* (either hash or array) that includes items based on the *truthiness* of the block's return value.

To perform selection, `select` evaluates the return value of the block for each iteration. 

When evaluating the block's return value, `select` __only cares about its truthiness__. If the return value of the block is "truthy", then the element during that iteration will be selected. If the return value of the block is "falsey" then the element will not be selected. 

When an element is selected, it's __placed in a new collection__. If no element is truthy, an *empty collection* will be returned.

Again, we can use the bang operator (`!`) to make these changes permanent. 
```ruby
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
numbers.select { |number| number > 4 }
# => [5, 6, 7, 8, 9, 10]

numbers
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```
###### Comparing arrays
We are able to compare arrays using the `==` operator. Ruby will compare each element in the corresponding array, in order. 
```ruby
a = [1, 2, 3]
b = [2, 3, 4]
a == b
# => false
```
### Common array methods
The `unshift` method will *permanently* add an element to the start of the array.
```ruby
b = [2, 3, 4]
b.unshift(1)
# => [1, 2, 3, 4]
```
The `to_s` method is used to create a string representation of an array. Ruby actually does this behind the scenes when you use string interpolation to print an array to the screen.
```ruby
# Ruby doing it behind the scenes
a = [1, 2, 3]
"It's as easy as #{a}"
# => "It's as easy as [1, 2, 3]"

# Explicitly calling the method
b = [2, 3, 4]
b.to_s
# => "[2, 3, 4]"
```
The `include?` method checks to see if the argument given is included in the array. It has a question mark at the end of it which __usually__ means that you should expect it to return a boolean value. Such methods are called predicates.
```ruby
a = [1, 2, 3, 4, 5]
a.include?(3)
# => true
```
The `flatten` method can be used to take an array that contains nested arrays and create a one-dimensional array. By default, this *does not* mutate the original array. `flatten` takes an optional argument that determines the level of nested arrays that should be flattened - a higher number indicates a deeper level of nesting to be flattened. 
```ruby
a = [1, 2, [3, 4, 5], [6, 7]]
a.flatten
# => [1, 2, 3, 4, 5, 6, 7]

a = [ 1, 2, [3, [4, 5] ] ]
a.flatten(1)
# => [1, 2, 3, [4, 5]]
```
The `each_index` method iterates through the array much like the `each` method, however the variable represents the __index number__ as opposed to the value at each index. It passes the index of the element into the block and you may do as you please with it. The *original array is returned*.
```ruby
a = [1, 2]
a.each_index { |index| puts "This is index #{index}" }
# "This is index 0"
# "This is index 1"
# => [1, 2]
```
The `each_with_index` method allows us to iterate through the array with both the index, and element at that index. The *first parameter passed to the block is the value and the second is the index*. Again, the original array is returned.
```ruby
a = [1, 2]
a.each_with_index { |value, index| puts "The value at index #{index} is: #{value}" }
# The value at index 0 is: 1.
# The value at index 1 is: 2.
# => [1, 2]
```
The `sort` method allows us to sort the elements of an array. It returns the sorted array, but __does not__ modify the original array.
```ruby
a = [5, 3, 8, 2, 4, 1]
a.sort
# => [1, 2, 3, 4, 5, 8]
```
The `product` method returns an array that is a combination of each element of each array. The argument in the `product` method __must be an array__ (even if it's an array of a single element). This __does not__ modify the original array.
```ruby
[1, 2, 3].product([4, 5])
# => [[1, 4], [1, 5], [2, 4], [2, 5], [3, 4], [3, 5]]
```
The `join` method allows us to extract the elements of an array, separated by a delimiter character of our choice and return a *single string* of those elements, concatenated together. 
```ruby
a = [1, 2, 3]
a.join('-')
# => "1-2-3"
```
### Each v Map
###### `each`
The `each` method works on objects that allow for iteration and is commonly used along with a block. 

If given a block, `each` runs the code in the block once for every element in the collection and *returns the collection it was invoked on*. For each iteration, `each` sends the value of the current element to the block in the form of an *argument*. 

It __does not care (or do anything) about the return value of the block__. If no block is given, it returns an *Enumerator* object. 

Let's walk through what happens when `.each` is called:
```ruby
[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end

# 1
# 3
# => [[1, 2], [3, 4]]
```
The `Array#each` method is being called on the multi-dimensional array `[[1, 2], [3, 4]]`. Each inner array is passed to the block in turn and assigned to the local variable `arr`. The `Array#first` method is called on `arr` and returns the object at index `0` of the current array - in this case the integers `1` and `3`, respectively. 

The `puts` method then outputs a string representation of the integer. `puts` returns `nil` and, since this is the last evaluated statement within the block, the return value of the block is therefore `nil`. `.each` *doesn't do anything with this returned value* though, and since the return value of `each` is the calling object - in this case the nested array `[[1, 2], [3, 4]]` - this is what is ultimately returned.

If we want to iterate through each element of the array, but mutate an object within each element, we need to reassign those mutated objects within the method or block. This is probably most applicable for hashes, since `map` will return a new array, even when called on a hash. Otherwise, it's probably best to use `map` for these situations.
```ruby
def word_cap(string)
  string_arr = string.downcase.split
  string_arr.each do |word|
    word[0] = word[0].upcase
  end
  string_arr.join(' ')
end
```
###### `map`
`map` also works on objects that allow for iteration. Like `each`, when given a block it invokes the given block once for every element in the *collection*. 

Where it really differs from `each` is the __returned value__. Unlike `each`, `map` performs transformation based on the __return value of the block__. `map` takes the return value and places it in a __new array__ (*even if called on a hash*). This process is repeated for each element in the original collection. 

This means that if we write some code in the block that's not a transformation instruction (e.g. it *returns* a boolean instead), `map` will return *array of booleans*, since `map` does not care about the truthiness of the return value of the block.

Alternatively, if the last line of code to be evaluated in the block is a `puts` statement, a new __array__ of `nil` will be returned (since `puts` returns `nil`).

`map` __creates and returns a new array__ containing the values returned by the block. This makes it useful for transforming an object __as a whole__, rather than iterating through individual elements within an array (which `each` is better for). It also lets us save the result directly to a variable. 

If no block is given, it also returns an *Enumerator* object. 

### Multiple Assignment
When an array is assigned to two or more variables on the same line, *each element of that array gets assigned to one of the variables*. This type of assignment, where we assign more than one value on the same line, is called __multiple assignment__, which uses the principle of *array decomposition*.
```ruby
first, second, third = ['uno', 'dos', 'tres']
# => ["uno", "dos", "tres"]

first
# => "uno"

second
# => "dos"

third
# => "tres"
```
