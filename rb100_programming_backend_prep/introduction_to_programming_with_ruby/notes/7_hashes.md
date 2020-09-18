# Hashes

## Table of Contents
- [What is a hash?](#what-is-a-hash)

### What is a hash?
A hash is a data structure that stores __items by associated keys__. This is contrasted against arrays, which store items by an ordered index. Entries in a hash are often referred to as *key-value pairs*. This creates an associative representation of data.

Most commonly, a hash is created using __symbols as keys and any data types as values__. All key-value pairs in a hash are surrounded by curly braces {} and comma separated.

Hashes can be created with two syntaxes. The older syntax comes with a => sign to separate the key and the value.
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
We can __remove__ a key-value pair to a hash via the `delete` method. This __permanently__ alters the hash and returns the deleted value. 
```
new_hash.delete(:key)
=> deleted_value
```
We can __retrieve__ a value from a hash via: 
```
new_hash[:existing_key]
=> "value"
```
We can __merge__ two hashes together via the `merge` method. The `merge` method __does not permanently__ alter the original hash (i.e. the hash that has the .`merge` method applied to it). We can make it permanent by using the `!` method. 
`old_hash.merge(new_hash)`
