# Ruby Advanced Collections
## Table of Contents
- [Sorting](#sorting)
- [Comparison](#comparison)
- [Sort](#sort)
- [Sort By](#sort-by)
- [Other comparison methods](#other-comparison-methods)
- [Updating collection elements](#updating-collection-elements)
- [Variable reference for nested collections](#variable-reference-for-nested-collections)
- [Shallow copy](#shallow-copy)

### Sorting
Sorting is setting the order of the items in a collection according to a certain criterion. 

Although it is also possible to write looping code to perform sorting manually, this code would have to be fairly complex and is beyond the scope of what we're looking at in this lesson. 

Luckily for us Ruby provides a couple of methods that can do this complex work for us: `sort` and `sort_by`.
```
[2, 5, 3, 4, 1].sort
=> [1, 2, 3, 4 ,5]
```
The return value is a *new array* with the integers ordered sequentially according to their value.

### Comparison
Sorting is essentially carried out by comparing the items in a collection with each other, and ordering them based on the result of that comparison. Comparison is at the heart of how sorting works.

Under the hood, Ruby uses the spaceship operator (`<=>`) to help determine how to sort a collection. 

Any object in a collection that we want to sort __must implement__ a `<=>` operator. This method performs comparison between two objects of the __same type__ and __returns__ a `-1`, `0`, or `1`, depending on whether the first object is less than, equal to, or greater than the second object; if the two objects cannot be compared, then `nil` is returned.
```
2 <=> 1
=> 1

1 <=> 2
=> -1

2 <=> 2
=> 0

'b' <=> 'a'
=> 1

'a' <=> 'b'
=> -1

'b' <=> 'b'
=> 0

1 <=> 'a'
=> nil
```
The return value of the `<=>` method is used by sort to determine the order in which to place the items. If `<=>` returns `nil` to sort then it throws an `ArgumentError`.
```
['a', 1].sort
=> ArgumentError: comparison of String with 1 failed
```
For strings, order is determined by a character's position in the ASCII table. It is this ASCII character order that determines the result if we compare one ASCII character with another using the `String#<=>` method.
```
'A' <=> 'a'
=> -1

'!' <=> 'A'
=> -1
```
You can determine a string's ASCII position by calling `ord` on the string.
```
'b'.ord
=> 98

'}'.ord
=> 125
```
Based on the above example we know that `'b'` should come before `'}'`. 

Some useful rules to remember are:
- Uppercase letters come before lowercase letters
- Digits and (most) punctuation come before letters
- There is an extended ASCII table containing accented and other characters - this comes after the main ASCII table

### Sort
We can also call sort with *a block*; this gives us more control over how the items are sorted. 

The block needs two arguments passed to it (the two items to be compared) and the return value of the block has to be `-1`, `0`, `1` or `nil`.
```
[2, 5, 3, 4, 1].sort do |a, b|
  a <=> b
end

=> [1, 2, 3, 4, 5]
```
By switching the order in which the items are compared the new array returned is in descending order.
```
[2, 5, 3, 4, 1].sort do |a, b|
  b <=> a
end

=> [5, 4, 3, 2, 1]
```
`String#<=>` compares *multi-character* strings __character by character__, so the strings beginning with `'a'` will come before those beginning with `'b'`; if both characters are the same then the *next characters* in the strings are compared, and so on.

`Array#<=>` compares each object in the array in an __element-wise manner__, so the first object in all of the arrays is compared initially.
```
[['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort

=> [["a", "car", "d"], ["a", "car", "d", 3], ["a", "cat", "b", "c"], ["b", 2]] 
```
Since three of the arrays have the string `'a'` at their first index, these all come before the array that has the string `'b'` at its first index.

You will have noticed that the sub-array that has `'b'` at its first index has an integer `2` at its second index. We already know that comparing an integer with a string will return `nil`, which will cause `sort` to raise an exception.

In this case, since `sort` *did not need to compare the second item of that array* to be able to establish its order, the integer does not come into play here and so no exception is raised. 

There is another sub-array which contains an integer `['a', 'car', 'd', 3]`. In this case the integer __does__ come into play, but only in terms of comparing the __length__ of this array with the array `['a', 'car', 'd']`. The integer __itself is not compared with a string__, so again no exception is raised.

If the first item in that array had been an `'a'`, like the other arrays, then the integer would have come into play and an exception would have been raised.
```
[['a', 'cat', 'b', 'c'], ['a', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort

=> ArgumentError: comparison of Array with Array failed
```
### Sort by
`sort_by` is similar to `sort` but is usually called with a block. The code in the block determines how the items are compared.
```
['cot', 'bed', 'mat'].sort_by do |word|
  word[1]
end

=> ["mat", "bed", "cot"]
```
While hash values are accessed via their *keys* rather than position, if you did want to sort a hash however, calling `sort_by` on it would be a way to do so.
```
people = { Kate: 27, john: 25, Mike:  18 }

people.sort_by do |_, age|
  age
end

=> [[:Mike, 18], [:john, 25], [:Kate, 27]]
```
`sort_by` __always returns an array__, even when called on a hash, so the result here is a __new__ array with the key-value pairs as objects in nested arrays. If we need to convert this back into a hash we can call `Array#to_h` on it.

What if we want to order the hash by `name` rather than `age`? The `Symbol#<=>` documentation explains that the symbols are compared __after `to_s` is called on them__. By using `Symbol#<=>`, we are effectively comparing strings. 

In our example above though, `john` is not capitalised, and will therefore fall below the other capitalised keys. We can fix this by using the `capitalize` method. 

Note: `Array#sort` and `Array#sort_by` have a equivalent destructive methods `Array#sort!` and `Array#sort_by!`. With these methods, rather then returning a new collection, the __same collection is returned but sorted__. These methods are specific to arrays and are __not available to hashes__. 

As a general practice, always pay attention to whether the method you're invoking is destructive or returns a new collection (or both). 

### Other comparison methods
Ruby has some other methods which use comparison in order to work with collections. Again, the objects being compared need to implement a `<=>` method in order for these methods to be used.
- `min`
- `max`
- `minmax`
- `min_by`
- `max_by`
- `minmax_by`

### Updating collection elements
Recall that Ruby gives us a very convenient way to update array elements.
```
arr = [[1, 3], [2]]
arr[1] = "hi there"
arr

=> [[1, 3], "hi there"]
```
The `arr[1] = "hi there"` is a __destructive action__ that permanently changed the second element in the `arr` array; it replaced the entire `[2]` inner array with the string `"hi there"`.

Likewise, we can modify a value in a nested array in a similar way. 
```
arr = [[1, 3], [2]]
arr[0][1] = 5
```
This is a __chained action__, but the first part of that chain (`arr[0]`) is *element reference*, while the second part of that chain (`[1] = 5`) is *element update*.

We can add elements into our array using a similar principle:
```
arr = [[1], [2]]

arr[0] << 3
arr
=> [[1, 3], [2]]
```
The line `arr[0] << 3` is again a two part chain: 
1. The first part, `arr[0]` is *element reference* and returns `[1]`; 
2. The second part can be thought of as `[1] << 3`, which destructively appends `3` into the inner array (*element update*).

### Variable reference for nested collections
```
a = [1, 3]
b = [2]
arr = [a, b]
arr

=> [[1, 3], [2]]
```
The local variables `a` and `b` are pointing to Array objects. When we place the local variables as elements in an array, it looks the same as adding the actual Array objects that they're pointing to into the array.

What happens if we modify `a` after placing it in `arr`?
```
a = [1, 3]
b = [2]
arr = [a, b]
arr
=> [[1, 3], [2]]

a[1] = 5
arr
=> [[1, 5], [2]]
```
The value of `arr` changed because `a` still points to the __same Array object__ that's in `arr`. When we modified it by replacing 3 with 5, we were *modifying the Array object*.

What if we modify the first array in `arr`?
```
arr[0][1] = 8
arr
=> [[1, 8], [2]]

a
=> [1, 8]
```
This produces the same result as modifying `a` directly. In both cases, we're __modifying the object that `a` and `arr[0]` point to__; we now have two ways to reference the same object. 

In the first example, the object is being modified through `a`. In the second example, the object is being modified through `arr[0]`.

`a` and `arr[0]` are in fact two different ways of referencing the same object. The assignment `arr[0][1] = 8` would be the same as `a[1] = 8`.

### Shallow copy
Ruby has methods that allow us to copy collections - `dup` and `clone`.

Both of these methods create a __shallow copy__ of an object. This means that only the object that the method is called on is copied. If the object __contains other objects__ - like a nested array - then those objects will be __shared__, not copied. This has a major impact on nested collections.

`dup` allows objects within the copied object to be modified.
```
arr1 = ["a", "b", "c"]
arr2 = arr1.dup

arr1.reverse!
=> ["c", "b", "a"]

arr2
=> ["a", "b", "c"]
```
Remember, the __inner objects__ of the collections are __shared__. Even if you mutate that object by referencing it from within a particular array or other collection, it is the __inner object__ you are affecting rather than the *collection*. 

In the example below, mutating methods were called on the object __within__ the array rather than the array itself. Note that __mutating__ the object is different from __reassigning__ the object! 
```
arr1 = ["a", "b", "c"]
arr2 = arr1.dup

arr1.reverse!
=> ["c", "b", "a"]

arr2[1].upcase!
=> "B"

arr2
=> ["a", "B", "c"]

arr1
=> ["c", "B", "a"]

arr2[0] = 'z'
=> 'z'

# Object reassignment is different from a mutating method in the context of a shallow copy
arr1
=> ["c", "B", "a"]

arr2
=> ["z", "B", "c"]
```
`clone` works the same way.
```
arr1 = ["abc", "def"]
arr2 = arr1.clone
arr2[0].reverse!

arr2
=> ["cba", "def"]

arr1
=> ["cba", "def"]
```
Consider the following examples
```
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

arr1
=> ["a", "b", "c"]

arr2
=> ["A", "B", "C"]

arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.each do |char|
  char.upcase!
end

arr1
=> ["A", "B", "C"]

arr2
=> ["A", "B", "C"]
```
In the first example `arr2` is changed but `arr1` is not. Here, we call the destructive method `Array#map!` on `arr2`; this method modifies the *array*, replacing each element of `arr2` with a new value. Since we are __changing the Array, not the elements within it__, `arr1` is left unchanged.

We would have changed the *elements* within the array (and mutated `arr1`) if we had called:
```
arr2.map do |char|
  char.upcase!
end
```
In the second example, both `arr1` and `arr2` are changed. Here, we call the destructive `String#upcase!` method on each *element* of `arr2`. However, every element of `arr2` is a __reference to the object referenced by the corresponding element in `arr1`__. Thus, when `#upcase!` mutates the element in `arr2`, `arr1` is also affected; __we change the Array elements, not the Array__.

The important thing to be aware of is exactly *what level you're working at*, especially when working with nested collections and using variables as pointers; are you working at the level of an outer array or hash, or at the level of an object within that?

###### Freezing objects
In Ruby, objects can be frozen in order to prevent them from being modified. Only mutable objects can be frozen because immutable objects, like integers, are already frozen. 

We can check if an object is frozen with the `frozen?` method.
```
5.frozen?
=> true
```
`freeze` only freezes the object it's called on. If the object it's called on contains *other objects*, those objects __won't be frozen__. 
```
arr = [[1], [2], [3]].freeze
arr[2] << 4
arr 

=> [[1], [2], [3, 4]]

arr = ["a", "b", "c"].freeze
arr[2] << "d"
arr

=> ["a", "b", "cd"]
```
The main difference between `dup` and `clone` is that `clone` __preserves the frozen state__ of the object.
```
arr1 = ["a", "b", "c"].freeze
arr2 = arr1.clone

arr2 << "d"
=> RuntimeError: can't modify frozen Array

arr2.reverse!
=> RuntimeError: can't modify frozen Array
```
`dup` __doesn't__ preserve the frozen state of the object.
```
arr1 = ["a", "b", "c"].freeze
arr2 = arr1.dup
arr2 << "d"

arr2
=> ["a", "b", "c", "d"]

arr1
=> ["a", "b", "c"]
```
In Ruby, there's __no built-in or easy way__ to create a *deep copy* or *deep freeze objects* within objects. 

###### Evaluating code
When evaluating code like this, ask the following questions:
- What is the type of action being performed (method call, block, conditional, etc..)?
- What is the object that action is being performed on?
- What is the side-effect of that action (e.g. output or destructive action)?
- What is the return value of that action?
- Is the return value used by whatever instigated the action?
