# Arrays

## Table of Contents
- [What is an array?](#what-is-an-array)
- [Modifying arrays](#modifying-arrays)
- [Iterating over an array](#iterating-over-an-array)
- [Common array methods](#common-array-methods)
- [Each v Map](#each-v-map)
- [Multiple assignment](#multiple-assignment)

### What is an array?
An array is an *ordered list* of elements that can be of *any* type. You can define an array by placing a list of elements between square bracket `[ ]`.
`my_array = [1, 'Bob', 4.33, true]`

###### Indexing arrays
For the first or last item of an array, we have methods for this. Arrays are what we call indexed lists. That means that each slot in an array is numbered. You can reference any element by *its index number*. Indexes start at 0 in Ruby. 
```
my_array.first
=> 1

my_array.last
=> true

my_array[1]
=> "Bob"

my_array[9]
=> nil
```
### Modifying arrays
If you'd like to take the last item off of an array *permanently*, you can use the `pop` method. 
Note that when we called the `pop` method, the *original* array variable was modified (ie, this is a method that __mutates the caller__), but the *returned* value is the popped element.
```
my_array.pop
=> true

my_array
=> [1, "Bob", 4.33]
```
If you want to add items to an array *permanently*, we can use the `push` method, along with any desired parameters. The full array is returned.
```
my_array.push("test1", 42, false)
=> [1, "Bob", 4.33, "test1", 42, false]
```
We can also use the shovel operator `<<` to permanently add a *single* item to an array.
```
my_array << 3
=> [1, "Bob", 4.33, "test1", 42, false, 3]
```
If we want to remove a specific item __permanently__ from an array, and we *know the index*, we can use the `delete_at` method. 
```
a = [1, 2, 3, 4]
a.delete_at(2)
=> 3
a
=> [1, 2, 4]
```
If we __don't__ know the index, but know what the value is, we can use the `delete` method instead. Again, this permanently mutates the original array. `delete` returns the deleted item.
```
a = [1, 2, 3, 4]
a.delete(2)
=> 2

a
=> [1, 3, 4]
```
If we want an array with only unique elements, we can use the `uniq` method. The `uniq` method will return a new array, and leave the old array untouched. However, if we want to remove non-unique elements from the array, we can use the bang (`!`) suffix.
```
a = [1, 2, 4, 3, 2, 3, 4]
a.uniq
=> [1, 2, 4, 3]

a
=> [1, 2, 4, 3, 2, 3, 4]

# Using the bang operator
a = [1, 2, 4, 3, 2, 3, 4]
a.uniq!
=> [1, 2, 4, 3]

a
=> [1, 2, 4, 3]
```
### Iterating over an array
If we want to apply a change to all elements of the array, we can use the `map` or `collect` method.
It iterates over an array *applying a block to each element* of the array and __returns a new array__ with those results (the original array is not mutated). 

Again, we can use the bang operator to make these changes permanent. 
```
a = [1, 2, 3, 4]
a.map { |num| num**2 }
=> [1, 4, 9, 16]

# Original array is not mutated
a
=> [1, 2, 3, 4]
```
If we want to filter specific elements from an array, we can use the `select` method. This method iterates over an array and *returns a new array* that includes any items that __return true__ to the expression provided. This allows us to save the new returned array to a variable.

Again, we can use the bang operator (`!`) to make these changes permanent. 
```
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
numbers.select { |number| number > 4 }
=> [5, 6, 7, 8, 9, 10]

numbers
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```
###### Comparing arrays
We are able to compare arrays using the `==` operator.
```
a = [1, 2, 3]
b = [2, 3, 4]
a == b
=> false
```
### Common array methods
The `unshift` method will *permanently* add an element to the start of the array.
```
b = [2, 3, 4]
b.unshift(1)
=> [1, 2, 3, 4]
```
The `to_s` method is used to create a string representation of an array. Ruby actually does this behind the scenes when you use string interpolation to print an array to the screen.
```
# Ruby doing it behind the scenes
a = [1, 2, 3]
"It's as easy as #{a}"
=> "It's as easy as [1, 2, 3]"

# Explicitly calling the method
b = [2, 3, 4]
b.to_s
=> "[2, 3, 4]"
```
The `include?` method checks to see if the argument given is included in the array. It has a question mark at the end of it which __usually__ means that you should expect it to return a boolean value. Such methods are called predicates.
```
a = [1, 2, 3, 4, 5]
a.include?(3)
=> true
```
The `flatten` method can be used to take an array that contains nested arrays and create a one-dimensional array. By default, this *does not* mutate the original array. `flatten` takes an optional argument that determines the level of nested arrays that should be flattened - a higher number indicates a deeper level of nesting to be flattened. 
```
a = [1, 2, [3, 4, 5], [6, 7]]
a.flatten
=> [1, 2, 3, 4, 5, 6, 7]

a = [ 1, 2, [3, [4, 5] ] ]
a.flatten(1)
=> [1, 2, 3, [4, 5]]
```
The `each_index` method iterates through the array much like the `each` method, however the variable represents the __index number__ as opposed to the value at each index. It passes the index of the element into the block and you may do as you please with it. The *original array is returned*.
```
a = [1, 2]
a.each_index { |index| puts "This is index #{index}" }
"This is index 0"
"This is index 1"
=> [1, 2]
```
The `each_with_index` method allows us to iterate through the array with both the index, and element at that index. The *first parameter passed to the block is the value and the second is the index*. Again, the original array is returned.
```
a = [1, 2]
a.each_with_index { |index, value| puts "The value at index #{index} is: #{value}" }
The value at index 1 is: 0.
The value at index 2 is: 1.
=> [1, 2]
```
The `sort` method allows us to sort the elements of an array. It returns the sorted array, but __does not__ modify the original array.
```
a = [5, 3, 8, 2, 4, 1]
a.sort
=> [1, 2, 3, 4, 5, 8]
```
The `product` method returns an array that is a combination of each element of each array. The argument in the `product` method __must be an array__ (even if it's an array of a single element). This __does not__ modify the original array.
```
[1, 2, 3].product([4, 5])
=> [[1, 4], [1, 5], [2, 4], [2, 5], [3, 4], [3, 5]]
```
### Each v Map
###### `each`
The `each` method works on objects that allow for iteration and is commonly used along with a block. If given a block, `each` runs the code in the block once for every element in the collection and *returns the collection it was invoked on*. If no block is given, it returns an *Enumerator* object. 

###### `map`
`map` also works on objects that allow for iteration. Like `each`, when given a block it invokes the given block once for every element in the collection. 

Where it really differs from `each` is the returned value. `map` __creates and returns a new array__ containing the values returned by the block. This makes it useful for transforming an array as a whole, rather than iterating through individual elements within an array (which `each` is better for). It also lets us save the result directly to a variable. 

If no block is given, it also returns an *Enumerator* object. 

### Multiple Assignment
When an array is assigned to two variables on the same line, *each element of that array gets assigned to one of the variables*. This type of assignment, where we assign more than one value on the same line, is called __multiple assignment__.
