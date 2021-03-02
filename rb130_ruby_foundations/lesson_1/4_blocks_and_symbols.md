# Blocks and Symbols

## Table of Contents
- [Closure and Binding](#closure-and-binding)
- [Symbol to proc](#symbol-to-proc)

### Closure and Binding
A block is how Ruby implements the idea of a __closure__, which is a general computing concept of a "chunk of code" that you can pass around and execute at some later time. In order for this "chunk of code" to be executed later, it must understand the surrounding context from when it was initialized. 

In Ruby, this "chunk of code" or closure is represented by a `Proc` object, a lambda, or a block. Remember that __blocks are a form of `Proc`__.
```ruby
name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" }
```
If you try to run that code, nothing will happen. That's because we've created a `Proc` and saved it to `chunk_of_code`, but haven't executed it yet. We can now pass around this local variable, `chunk_of_code` and execute it at any time later. Suppose we have a completely different method, and we pass in this `chunk_of_code` into that method, then the method executes that `chunk_of_code`. 
```ruby
def call_me(some_code)
  # call will execute the "chunk of code" that gets passed in
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" }

call_me(chunk_of_code)

# hi Robert
# => nil
```
Note that the `chunk_of_code` knew how to handle `puts #{name}`, and specifically that it knew how to process the `name` variable. 

Remember that the `name` variable was initialized outside the method definition, and local variables initialized *outside* the method __aren't__ accessible _inside_ the method, unless it's explicitly passed in as an argument.
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
# re-assign name after Proc initialization
name = "Griffin III"

call_me(chunk_of_code)

# hi Griffin III
# => nil
```
If we reassign the local variable `name` __after__ the `Proc` object is assigned to `chunk_of_code`, the output changes. This implies that the `Proc` __keeps track of its surrounding context__, and drags it around wherever the chunk of code is passed to. 

In Ruby, we call this its __binding__, or surrounding environment/context. A closure must keep track of its surrounding context in order to have all the information it needs in order to be executed later. 

This not only includes local variables, but also _method references, constants and other artifacts_ in your code -- __whatever it needs to execute correctly__, it will drag all of it around. It's why code like the above will work fine, seemingly violating the variable scoping rules we learned earlier.

This is at the core of variable scoping rules in Ruby, and it's why "inner scopes can access outer scopes".

### Symbol to proc
When working with collections, we often want to transform all items in that collection. For example, suppose we have an array of integers and we want to transform every element in the array into strings.
```ruby
[1, 2, 3, 4, 5].map do |num|
  num.to_s
end

# => ["1", "2", "3", "4", "5"]
```
You can see the return value for the above is a new array, where every element is now a string. This type of code is so common that there's a shortcut for it.
```ruby
[1, 2, 3, 4, 5].map(&:to_s)
# => ["1", "2", "3", "4", "5"]

["hello", "world"].each(&:upcase!)
# => ["HELLO", "WORLD"]

[1, 2, 3, 4, 5].select(&:odd?)
# => [1, 3, 5]

[1, 2, 3, 4, 5].select(&:odd?).any?(&:even?)
# => false
```
The above code iterates through every element in the array and calls `to_s` on it, then saves the result into a new array. After it's done iterating, the new array is returned. And because it returns another array, you could chain another transformation.
```ruby
[1, 2, 3, 4, 5].map(&:to_s).map(&:to_i)
# => [1, 2, 3, 4, 5]
```
The above code transforms all elements to strings, then back to integers. Note that the `&` __must be followed by a symbol name for a method that can be invoked on each element__. In the last example, we use the symbols `:to_s` and `:to_i` to represent the `#to_s` and `#to_i` methods.

Suppose you want to use `String#prepend` to prepend each value with `"The number is:"`. Unfortunately, we can't use the shortcut to do that; it __doesn't work for methods that take arguments__.

#### `Symbol#to_proc`
What the above shortcut is doing, is effectively converting `(&:to_s)` to `{ |n| n.to_s }`. The mechanism at work here is related to the use of `&` with explicit blocks, but since it isn't applied to a method parameter, it's also different. 

Let's break down the code `(&:to_s)`. First, when we add a `&` in front of an object, it tells Ruby to try to __convert this object into a block__. To do so, it's expecting a `Proc` object. If this object is not a `Proc` object, it will __call `#to_proc` on the object__. So two things are happening:
1. Ruby checks whether the object __after__ `&` is a `Proc`. 
  - If it is, it uses the object __as-is__. 
  - Otherwise, it tries to call `#to_proc` on the object, which should return a `Proc` object. An error will occur if the `#to_proc` fails to return a `Proc` object.
2. If all is well, the `&` turns the `Proc` into a __block__.

This means that Ruby is trying to turn `:to_s` into a block. However, it's not a `Proc`; it's a `Symbol`. Ruby will then try to call the `Symbol#to_proc` method -- and there is one! This method will return a `Proc` object, which will execute the method based on the name of the symbol. In other words, `Symbol#to_proc` returns a `Proc`, which `&` turns into a block, which turns our shortcut into the long form block usage.

As a further example:
```ruby
def my_method
  yield(2)
end

# turns the symbol into a Proc, then & turns the Proc into a block
my_method(&:to_s)
# => "2"

# If we break up the shortcut syntax into two steps:
# explicitly call to_proc on the symbol
a_proc = :to_s.to_proc
# convert Proc into block, then pass block in. Returns "2"
my_method(&a_proc)
```
