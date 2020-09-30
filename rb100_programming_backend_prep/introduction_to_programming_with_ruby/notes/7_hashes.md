# Hashes

## Table of Contents
- [What is a hash?](#what-is-a-hash)
- [Iterating over hashes](#iterating-over-hashes)
- [Hashes as optional parameters](#hashes-as-optional-parameters)
- [Hashes versus Arrays](#hashes-versus-arrays)
- [Hash keys](#hash-keys)
- [Common hash methods](#common-hash-methods)

### What is a hash?
A hash is a data structure that stores __items by associated keys__. This is contrasted against arrays, which store items by an ordered index. Entries in a hash are often referred to as *key-value pairs*. This creates an associative representation of data.

Most commonly, a hash is created using __symbols as keys and any data types as values__ (including arrays and hashes as values!). All key-value pairs in a hash are surrounded by curly braces `{ }` and comma separated.

Hashes can be created with two syntaxes. The older syntax comes with a `=>` sign to separate the key and the value.
```
# Old
old_syntax_hash = {:name => 'bob'}
=> {:name=>'bob'}

# New (Ruby 1.9)
new_hash = {name: 'bob'}
=> {:name=>'bob'}
```
We can __add__ a key-value pair to a hash like we would access an item, but instead, we add a key and value pair that doesn't yet exist. This __permanently__ alters the hash and returns the newly added value. 
```
new_hash[:key] = "value"
=> "value"
```
We can __remove__ a key-value pair from a hash via the `delete` method. This __permanently__ alters the hash and returns the deleted value. 
```
new_hash.delete(:key)
=> deleted_value
```
We can __conditionally remove__ a key-value pair using the `delete_if` method. Again, this __permanently__ alters the hash. It returns the mutated hash.
```
hash = { "a" => 100, "b" => 200, "c" => 300 }
hash.delete_if {|key, value| key >= "b" }   

=> {"a"=>100}
```
We can __retrieve__ a value from a hash via: 
```
new_hash[:existing_key]
=> "value"
```
We can __merge__ two hashes together via the `merge` method. The `merge` method __does not permanently__ alter the original hash (i.e. the hash that has the .`merge` method applied to it). We can make it permanent by using the `!` method. The `merge` method returns the merged hash. 
```
a = { name: "Ben", age: 25}
b = { hobbies: "Chess" }
a.merge(b)
=> { name: "Ben", age: 25, hobbies: "Chess" }
a
=> { name: "Ben", age: 25}
b
=> { hobbies: "Chess" }
```
### Iterating over hashes
Iterating over hashes is similar to arrays - we can use the `each` method. However, since each element in a hash has two values (a key and a value), we need to specify both parameters in our `each` method, even if we only want to use one, since Ruby will otherwise not know which we have passed as a parameter.
```
person = {name: 'Bob', age: 34, hair: 'brown'}
person.each { |key, value| puts "Bob's #{key} is #{value}."}

Bob's name's is Bob.
Bob's age's is 34.
Bob's hair's is brown.
=> {:name=>"Bob", :age=>34, :hair=>"brown"}
```
We can do the same thing with the `.map` method, though note that the returned value will be __an array__ and __not__ a hash.
```
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

half_numbers = numbers.map do |key, value|
  value / 2
end
p half_numbers

[50, 25, 5]
=> [50, 25, 5]
```
### Hashes as optional parameters
You can use a hash to accept optional parameters when you are creating methods as well. This can be helpful when you want to give your methods some more flexibility and expressivity.
```
def greeting(name, options = {})
  if options.empty?
    puts "Hi, my name is #{name}"
  else
    puts "Hi, my name is #{name} and I'm #{options[:age]} years old and I live in #{options[:city]}."
  end
end

greeting("Bob")
Hi, my name is Bob
=> nil

greeting("Bob", {age: 62})
Hi, my name is Bob and I'm 62 years old and I live in .
=> nil

greeting("Bob", {age: 62, city: "New York City"})
Hi, my name is Bob and I'm 62 years old and I live in New York City.
=> nil

greeting("Bob", age: 62, city: "New York City")
Hi, my name is Bob and I'm 62 years old and I live in New York City.
=> nil
```
We used Ruby hash's `empty?` method to detect whether the options parameter, which is a hash, had anything passed into it.

Note how in the last example, we haven't passed in our parameters to a hash. Curly braces, *are __not required__ when a hash is the last argument*.

### Hashes versus Arrays
When deciding whether to use a hash or an array, ask yourself a few questions:
- Does this data need to be associated with a specific label? If yes, use a hash. If the data doesn't have a natural label, then typically an array will work fine.
- Does order matter? If yes, then use an array. *As of Ruby 1.9, hashes also maintain order*, but usually ordered items are stored in an array.
- Do I need a "stack" or a "queue" structure? Arrays are good at mimicking simple "first-in-first-out" queues, or "last-in-first-out" stacks.

### Hash keys
We normally use symbols as keys for our hashes, but they can take basically any type.
```
{"height" => "6 ft"}     # string as key
{["height"] => "6 ft"}   # array as key
{1 => "one"}             # integer as key
{45.324 => "forty-five point something"}  # float as key
{{key: "key"} => "hash as a key"}  # hash as key
```
Notice that we are forced to use the old style (i.e., using the hash rocket `=>`) when we deviate from using symbols as keys.

### Common hash methods
The `has_key?` method allows you to check if a hash contains a specific key. It *returns a boolean value*. Note - you have to match the type exactly when searching for the key (e.g. you need to search for a string if the key is a string, otherwise `false` will be returned).
```
name_and_age = { "Bob" => 42, "Steve" => 31, "Joe" => 19}
name_and_age.has_key?("Steve")
=> true
```
The `select` method allows you to pass a block and will __return any key-value pairs__ that evaluate to `true` when ran through the block. We have to pass in both `key` and `value` into the `select` method, even if we're only filtering for one of those values. 
```
name_and_age.select { |key, value| (key == "Bob") }
=> {"Bob"=>42}

name_and_age.select { |key, value| (key == "Bob") || (value == 19) }
=> {"Bob"=>42, "Joe"=>19}
```
The `fetch` method allows you to pass a given key and it will *return the value* for that key if it exists. You can also specify an option for return __if that key is not present__ either as a block, or as an argument. 
```
name_and_age.fetch("Steve")
=> 31

name_and_age.fetch("Larry")
=> KeyError: key not found: "Larry"

name_and_age.fetch("Larry", "Larry isn't in this hash")
=> "Larry isn't in this hash"

name_and_age.fetch("Larry") { |n| "Sorry, #{n} isn't in this hash!" }
=> "Sorry, Larry isn't in this hash!"
```
The `to_a` method *returns an array version* of your hash when called. It __does not__ permanently modify the hash. 
```
name_and_age.to_a
=> [["Bob", 42], ["Steve", 31], ["Joe", 19]]
```
The `keys` and `values` methods allow us to easily fetch all the keys or values from a hash together as an array, respectively. 
```
name_and_age.keys
=> ["Bob", "Steve", "Joe"]

name_and_age.values
=> [42, 31, 19]
```
If we want to fetch keys or values sequentially, we can use `each_key` or `each_value`.
```
name_and_age.each_key { |key| puts key}
name_and_age.each_value { |value| puts value}
```
Note though, that in past versions of Ruby, you could not rely on hashes maintaining order. Since Ruby 1.9, hashes maintain the order in which they're stored. 

It's important that you know this because if you are ever working with an older version of Ruby (anything before Ruby 1.9) you cannot rely on the hashes being in any specific order.
