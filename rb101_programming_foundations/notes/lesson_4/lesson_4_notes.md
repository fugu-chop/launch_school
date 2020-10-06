# Ruby Collections
## Table of Contents
- [String elements](#string-elements)
- [Array elements](#array-elements)
- [Hash elements](#hash-elements)
- [Gotchas](#gotchas)
- [Conversion](#conversion)
- [Element assignment](#element-assignment)

### String elements
Strings use an integer-based index that represents *each character in the string*. The index starts counting at *zero* and increments by one for the remaining index values. You can reference a specific character using this index.
```
str = 'abcdefghi'
str[2] 

=> "c"
```
You can also reference *multiple characters* within a string by using an index starting point and the number of characters to return.
```
str[2, 3]
=> "cde"
```
Note in the above example is that `str[2, 3]` is actually a call to the `#slice` method of String and is alternative syntax for `str.slice(2, 3)`. The fact that we can use this alternative form of `#slice` is part of Ruby's syntactical sugar.

### Array elements
Arrays are also ordered, zero-indexed collections. 

Arrays are lists of elements that are ordered by index, where each element __can be any object__. Arrays use an integer-based index to maintain the order of its elements. A specific element can be referenced using its index.
```
arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
arr[2]

=> "c"
```
Just as with `String`, `arr[2, 3]` is alternative syntax for the `Array#slice` method. 

It is important to be aware, however, that `Array#slice` and `String#slice` are not the same method, even though they have the same name. They do share a lot of the same functionality, but are separate implementations. One key distinction is that `String#slice` returns a new string whereas `Array#slice` returns a new array.

One situation where `Array#slice` does not return a new array is if we pass the method *only an index*, rather than a start and length or a range; in this case the element at that index is returned rather than a new array.
```
arr = [1, 'two', :three, '4']
arr.slice(3, 1)
=> ["4"]

arr.slice(3..3)
=> ["4"]

arr.slice(3)
=> "4"
```

### Hash elements
Hashes are another very common collection data structure that uses key-value pairs, where the *key or the value* can be __any type of Ruby object__. This allows for a more expansive and descriptive collection of elements. 

When initializing a hash, the __keys must be unique__. If we try to assign multiple key-value pairs to the same key, the initial ones are *overwritten* by subsequent key-value pairs. Values can be duplicated however. 

We can access just the keys or just the values from a hash with the `#keys` and `#values` methods of `Hash`. These methods __return an array__.
```
country_capitals = { uk: 'London', france: 'Paris', germany: 'Berlin' }
country_capitals.keys
=> [:uk, :france, :germany]

country_capitals.values
=> ["London", "Paris", "Berlin"]

country_capitals.values[0]
=> "London"
```
### Gotchas
###### Out of Bound Indices
```
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[5]
=> nil

arr[5]
=> nil
```
This is not necessarily a problem for a string, since we know that `nil` is an invalid return value; with an __array__, `nil` could be a *valid return value* since arrays can contain any other type of object, including `nil`.
```
arr = [3, 'd', nil]
arr[2]
=> nil

arr[3]
=> nil
```
So how can we tell the difference between the valid return and the out-of-bounds reference? Array has a method called `#fetch` - which tries to return the element at position index, but throws an `IndexError` exception if the referenced index lies outside of the array bounds.

Always try to think about whether nil is the real element in the array or if it's Ruby's way of telling us we've gone beyond the array boundary. If you really want to be safe, use `#fetch` in your own code.

###### Negative indices
Elements in String and Array objects can be referenced using negative indices, starting from the last index in the collection `-1` and working backwards.
```
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']

str[-2]
=> "d"

arr[-2]
=> "d"

str[-6]
=> nil

arr[-6]
=> nil

arr.fetch(-6)
=> IndexError: index -6 outside of array bounds: -5...5
```

###### Invalid Hash Keys
`Hash` also has a `#fetch` method which can be useful when trying to disambiguate valid hash keys with a `nil` value from invalid hash keys.
```
hsh = { :a => 1, 'b' => 'two', :c => nil }
hsh[:c]
=> nil

hsh['c']
=> nil

hsh.fetch(:c)
=> nil

hsh.fetch('c')
KeyError: key not found: "c"
```
### Conversion
We can convert between strings and arrays using a number of library methods.

`String#chars` returns an __array__ of individual characters.
```
str = 'Practice'

arr = str.chars
=> ["P", "r", "a", "c", "t", "i", "c", "e"]
```
`Array#join` returns __a string__ with the elements of the array joined together. It takes an argument which affects how individual elements are joined.
```
arr.join
=> "Practice"

arr.join(' ')
=> "P r a c t i c e"
```
`Hash` has a `#to_a` method, which returns an __array__, where each key-value pair is a sub-array.
```
hsh = { sky: "blue", grass: "green" }
hsh.to_a
=> [[:sky, "blue"], [:grass, "green"]]
```
`Array` has a `#to_h` method. When no block is given, the array must be an array of 2-element sub-arrays, where each sub-array is formed into a key-value pair in the new Hash.

If a block is given, the results of the block on each element of the object will be used as pairs.
```
a = [['foo', 'zero'], ['bar', 'one'], ['baz', 'two']]

a.to_h
=> {"foo"=>"zero", "bar"=>"one", "baz"=>"two"}

(1..5).to_h { |x| [x, x ** 2] }
=> {1=>1, 2=>4, 3=>9, 4=>16, 5=>25}
```
### Element assignment
###### String element assignment
We can use the element assignment notation of `String` in order to change the value of a specific character within a string by referring to its index. As mentioned in previous lessons, this is a __mutating method__. 
```
str = "Dobby's favorite color is blue"
str[0] = 'B'
str
=> "Bobby's favorite color is blue"
```
###### Array element assignment
We can assign elements of an array in the same way. This is a __mutating method__. 
```
arr = [1, 2, 3, 4, 5]
arr[0] += 1
=> 2

arr
=> [2, 2, 3, 4, 5]
```
###### Hash element assignment
Hash element assignment is not too dissimilar. The *hash key is used* instead of assigning a value using an index. This is a __mutating method__.
```
hsh = { apple: 'Produce', carrot: 'Produce', pear: 'Produce', broccoli: 'Produce' }
hsh[:apple] = 'Fruit'

hsh
=> { :apple => "Fruit", :carrot => "Produce", :pear => "Produce", :broccoli => "Produce" }
```
