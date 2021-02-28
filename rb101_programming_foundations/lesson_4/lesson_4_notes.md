# Ruby Collections
## Table of Contents
- [String elements](#string-elements)
- [Array elements](#array-elements)
- [Hash elements](#hash-elements)
- [Gotchas](#gotchas)
- [Conversion](#conversion)
- [Element assignment](#element-assignment)
- [Other useful methods](#other-useful-methods)

### String elements
Strings use an integer-based index that represents *each character in the string*. The index starts counting at *zero* and increments by one for the remaining index values. You can reference a specific character using this index.
```ruby
str = 'abcdefghi'
str[2] 

# => "c"
```
You can also reference *multiple characters* within a string by using an index starting point and the number of characters to return.
```ruby
str[2, 3]
# => "cde"
```
Note in the above example is that `str[2, 3]` is actually a call to the `#slice` method of String and is alternative syntax for `str.slice(2, 3)`. The fact that we can use this alternative form of `#slice` is part of Ruby's syntactical sugar.

### Array elements
Arrays are also ordered, zero-indexed collections. 

Arrays are lists of elements that are ordered by index, where each element __can be any object__. Arrays use an integer-based index to maintain the order of its elements. A specific element can be referenced using its index.
```ruby
arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
arr[2]

# => "c"
```
Just as with `String`, `arr[2, 3]` is alternative syntax for the `Array#slice` method. 

It is important to be aware, however, that `Array#slice` and `String#slice` are not the same method, even though they have the same name. They do share a lot of the same functionality, but are separate implementations. One key distinction is that `String#slice` returns a new string whereas `Array#slice` returns a new array.

One situation where `Array#slice` does not return a new array is if we pass the method *only an index*, rather than a start and length or a range; in this case the element at that index is returned rather than a new array.
```ruby
arr = [1, 'two', :three, '4']
arr.slice(3, 1)
# => ["4"]

arr.slice(3..3)
# => ["4"]

arr.slice(3)
# => "4"
```

### Hash elements
Hashes are another very common collection data structure that uses key-value pairs, where the *key or the value* can be __any type of Ruby object__. This allows for a more expansive and descriptive collection of elements. 

When initializing a hash, the __keys must be unique__. If we try to assign multiple key-value pairs to the same key, the initial ones are *overwritten* by subsequent key-value pairs. Values can be duplicated however. 

We can access just the keys or just the values from a hash with the `#keys` and `#values` methods of `Hash`. These methods __return an array__.
```ruby
country_capitals = { uk: 'London', france: 'Paris', germany: 'Berlin' }
country_capitals.keys
# => [:uk, :france, :germany]

country_capitals.values
# => ["London", "Paris", "Berlin"]

country_capitals.values[0]
# => "London"
```
### Gotchas
###### Out of Bound Indices
```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[5]
# => nil

arr[5]
# => nil
```
This is not necessarily a problem for a string, since we know that `nil` is an invalid return value; with an __array__, `nil` could be a *valid return value* since arrays can contain any other type of object, including `nil`.
```
arr = [3, 'd', nil]
arr[2]
# => nil

arr[3]
# => nil
```
So how can we tell the difference between the valid return and the out-of-bounds reference? Array has a method called `#fetch` - which tries to return the element at position index, but throws an `IndexError` exception if the referenced index lies outside of the array bounds.

Always try to think about whether nil is the real element in the array or if it's Ruby's way of telling us we've gone beyond the array boundary. If you really want to be safe, use `#fetch` in your own code.

###### Negative indices
Elements in String and Array objects can be referenced using negative indices, starting from the last index in the collection `-1` and working backwards.
```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[-2]
# => "d"

arr[-2]
# => "d"

str[-6]
# => nil

arr[-6]
# => nil

arr.fetch(-6)
# => IndexError: index -6 outside of array bounds: -5...5
```
###### Invalid Hash Keys
`Hash` also has a `#fetch` method which can be useful when trying to disambiguate valid hash __keys__ with a `nil` value from invalid hash keys.
```ruby
hsh = { :a => 1, 'b' => 'two', :c => nil }
hsh[:c]
# => nil

hsh['c']
# => nil

hsh.fetch(:c)
# => nil

hsh.fetch('c')
# KeyError: key not found: "c"
```
### Conversion
We can convert between strings and arrays using a number of Core API methods.

`String#chars` returns an __array__ of individual characters.
```ruby
str = 'Practice'

arr = str.chars
# => ["P", "r", "a", "c", "t", "i", "c", "e"]
```
`Array#join` returns __a string__ with the elements of the array joined together. It takes an argument which affects how individual elements are joined.
```ruby
arr.join
# => "Practice"

arr.join(' ')
# => "P r a c t i c e"
```
`Hash` has a `#to_a` method, which returns an __array__, where each key-value pair is a sub-array.
```ruby
hsh = { sky: "blue", grass: "green" }
hsh.to_a
# => [[:sky, "blue"], [:grass, "green"]]
```
`Array` has a `#to_h` method. When no block is given, the array must be an array of 2-element sub-arrays, where each sub-array is formed into a key-value pair in the new Hash.

If a block is given, the results of the block on each element of the object will be used as pairs. Note how we have to *wrap our key and value elements in an array*.
```ruby
a = [['foo', 'zero'], ['bar', 'one'], ['baz', 'two']]

a.to_h
# => {"foo"=>"zero", "bar"=>"one", "baz"=>"two"}

(1..5).to_h { |x| [x, x ** 2] }
# => {1=>1, 2=>4, 3=>9, 4=>16, 5=>25}
```
### Element assignment
###### String element assignment
We can use the element assignment notation of `String` in order to change the value of a specific character within a string by referring to its index. The element reassignment always returns the *assigned value*. This is a __mutating method__. 
```ruby
str = "Dobby's favorite color is blue"
str[0] = 'B'
# => "B"

str
# => "Bobby's favorite color is blue"
```
###### Array element assignment
We can assign elements of an array in the same way. This is a __mutating method__ and the element reassignment __always__ returns the *assigned value*, even if the underlying array is *empty*.
```ruby
arr = [1, 2, 3, 4, 5]
arr[0] += 1
# => 2

arr
# => [2, 2, 3, 4, 5]

test = []
test[1] = 2
# => 2

test
# => [nil, 2]
```
###### Hash element assignment
Hash element assignment is not too dissimilar. The *hash key is used* instead of assigning a value using an index. This is a __mutating method__ and the element reassignment __always__ returns the *assigned value*.
```ruby
hsh = { apple: 'Produce', carrot: 'Produce', pear: 'Produce', broccoli: 'Produce' }
hsh[:apple] = 'Fruit'
# => "Fruit"

hsh
# => { :apple => "Fruit", :carrot => "Produce", :pear => "Produce", :broccoli => "Produce" }
```
### Other useful methods
Many of these methods fall under the `Enumerable` module within the Core API, which can be used with arrays and hashes. These methods are 'enabled' because arrays and hashes both have access to an iteration method (i.e. `.each`).

`Enumerable#any?` <br/>
This is a method available to both `Array` and `Hash` as part of the `Enumerable` module. 
```ruby
a = [nil, false, nil]

a.any?
#=> false

[1, 2, 3].any? do |num|
  num > 2
end
#=> true

{ a: "ant", b: "bear", c: "cat" }.any? do |key, value|
  value.size > 4
end
#=> false
```
There are two return values that we need to be aware of here:
1. the return value of the method; and 
2. the return value of the block. 

`any?` looks at the truthiness of the *block's* return value in order to determine what the *method's* return value will be. If the *block* returns a "truthy" value for __any__ element in the collection, then the *method* will return `true`.

`Enumerable#all?` <br/>
`all?` functions in a similar way to `any?`. It also looks at the truthiness of the block's return value, but the method only returns `true` if the block's return value in __every iteration is truthy__ (that is, not `false` or `nil`).
```ruby
[1, 2, 3].all? do |num|
  num > 2
end
# => false

{ a: "ant", b: "bear", c: "cat" }.all? do |key, value|
  value.length >= 3
end
# => true
```
`Enumerable#each_with_index` <br/>
`each_with_index` is nearly identical to `each`. Unlike `each`, `each_with_index` takes a second argument which represents the *index of each element*. Just like `each`, `each_with_index` always returns the __original calling collection__.
```ruby
[1, 2, 3].each_with_index do |num, index|
  puts "The index of #{num} is #{index}."
end

# The index of 1 is 0.
# The index of 2 is 1.
# The index of 3 is 2.
# => [1, 2, 3]
```
When calling `each_with_index` on a hash, the first argument now represents *an array containing both the key and the value*.
```ruby
{ a: "ant", b: "bear", c: "cat" }.each_with_index do |pair, index|
  puts "The index of #{pair} is #{index}."
end

# The index of [:a, "ant"] is 0.
# The index of [:b, "bear"] is 1.
# The index of [:c, "cat"] is 2.
# => { :a => "ant", :b => "bear", :c => "cat" }
```
`Enumerable#each_with_object`<br/>
Besides taking a block like the methods above, `each_with_object` takes a method argument. The method argument is a __collection object that will be returned by the method__. 

On top of that, the block takes 2 arguments of its own. The first block argument represents the *current element* and the second block argument represents the *collection object that was passed in as an argument* to the method. Once it's done iterating, the method returns the __collection object that was passed in__. 
```ruby
[1, 2, 3].each_with_object([]) do |num, array|
  array << num if num.odd?
end

# => [1, 3]
```
In the above example, `array` is initialized to an empty array, `[]`. Inside the block, we can now manipulate `array`. In this case, we're just appending the current `num` into it if it's odd.

Similar to `each_with_index`, the first block argument turns into an array when we invoke `each_with_object` on a hash.
```ruby
{ a: "ant", b: "bear", c: "cat" }.each_with_object([]) do |pair, array|
  array << pair.last
end

# => ["ant", "bear", "cat"]
```
As an additional quirk, it's possible to use parentheses to capture the key and value in the first block argument.
```ruby
{ a: "ant", b: "bear", c: "cat" }.each_with_object({}) do |(key, value), hash|
  hash[value] = key
end

# => { "ant" => :a, "bear" => :b, "cat" => :c }
```
`Enumerable#first` <br/>
`first` __doesn't take a block__, but it does take an optional argument which represents the *number of elements to return*. When no argument is given, it returns *only the first element in the collection*.
```ruby
[1, 2, 3].first
# => 1
```
When an argument is provided, `first` will return the specified number of elements.
```ruby
{ a: "ant", b: "bear", c: "cat" }.first(2)

# => [[:a, "ant"], [:b, "bear"]]
```
There are a couple of interesting things of note here:
1. Hashes are typically thought of as __unordered__ and values are retrieved by keys. In some programming languages, the order is not preserved at all. This used to be true for Ruby too, but since Ruby 1.9, order is preserved __according to the order of insertion__. Calling first on a hash doesn't quite make sense, but Ruby lets you do it.
2. Notice that the return value of calling `first` on a hash with a numeric argument is a nested array. This is unexpected. Fortunately, turning this nested array back to a hash is easy enough: `[[:a, "ant"], [:b, "bear"]].to_h`.

In practice, `first` is rarely called on a hash, and most often used with arrays.

`Enumerable#include?` <br/>
`include?` __doesn't take a block__, but it does require one argument. It returns `true` if the argument *exists in the collection* and `false` if it doesn't.
```ruby
[1, 2, 3].include?(1)
# => true
```
When called on a hash, `include?` only checks the *keys*, not the values.
```ruby
{ a: "ant", b: "bear", c: "cat" }.include?("ant")
# => false

{ a: "ant", b: "bear", c: "cat" }.include?(:a)
# => true
```
In fact, `Hash#include?` is essentially an alias for `Hash#key?` or `Hash#has_key?`. In practice, Rubyists would usually prefer these methods over `include?` as they make the intention more explicit.

`Enumerable#reject` <br/>
`reject` will return a __new__ collection that contains elements where the evaluation criteria are returned as `false` or `nil` (falsy).
```ruby
1, 2, 3].reject do |num|
  puts num
end

# puts returns nil, and nil is falsy
# 1 
# 2
# 3
# => [1, 2, 3]
```
`Enumerable#partition` <br/>
`partition` divides up elements in the current collection into two collections, depending on the block's return value.
```ruby
[1, 2, 3].partition do |num|
  num.odd?
end

# => [[1, 3], [2]]
```
The most idiomatic way to use `partition` is to parallel assign variables to capture the divided inner arrays:
```ruby
odd, even = [1, 2, 3].partition do |num|
  num.odd?
end

odd
# => [1, 3]
even
# => [2]
```
Even if the collection is a hash, the return value of `partition` will __always be an array__.
```ruby
long, short = { a: "ant", b: "bear", c: "cat" }.partition do |key, value|
  value.size > 3
end

# => [[[:b, "bear"]], [[:a, "ant"], [:c, "cat"]]]

long.to_h
# => { :b => "bear" }

short.to_h
# => { :a => "ant", :c => "cat" }
```
`Enumerable#each_slice(n)` <br/>
`each_slice(n)` will pass an array of `n` elements at a time to the block, with any leftovers passed at the end.
```ruby
(1..10).each_slice(3) { |a| p a }

# [1, 2, 3]
# [4, 5, 6]
# [7, 8, 9]
# [10]
```
`Enumerable#each_cons(n)` <br/>
`each_cons(n)` will pass an array of rolling `n` elements at a time to the block.
```ruby
(1..10).each_cons(3) { |a| p a }
# [1, 2, 3]
# [2, 3, 4]
# [3, 4, 5]
# [4, 5, 6]
# [5, 6, 7]
# [6, 7, 8]
# [7, 8, 9]
# [8, 9, 10]
```
`Enumerable#chunk_while` <br/>
`chunk_while` splits up an Enumerable when the criteria is evaluated as `false`. This is probably the version we'll use most frequently (compared with `slice_when`):
```ruby
a = [1,2,4,9,10,11,12,15,16,19,20,21]

p a.chunk_while {|i, j| i+1 == j }.to_a
# [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
```
`Enumerable#slice_when` <br/>
`slice_when` splits up an Enumerable when the criteria is evaluated as `true`:
```ruby
a = [1,2,4,9,10,11,12,15,16,19,20,21]

p a.slice_when {|i, j| i+1 == j }.to_a
# [[1], [2, 4, 9], [10], [11], [12, 15], [16, 19], [20], [21]]
```
