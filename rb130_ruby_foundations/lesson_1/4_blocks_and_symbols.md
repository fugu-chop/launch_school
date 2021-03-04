# Blocks and Symbols

## Table of Contents
- [Closure and Binding](#closure-and-binding)
- [Binding Scope](#binding-scope)
- [Symbol to proc](#symbol-to-proc)

### Closure and Binding
A block is how Ruby implements the idea of a __closure__, which is a general computing concept of a "chunk of code" that you can pass around and execute at some later time. In order for this "chunk of code" to be executed later, it must understand the surrounding context from when it was initialized. 

In Ruby, this "chunk of code" or closure is represented by a `Proc` object, a lambda, or a block. Remember that __blocks are a form of `Proc`__.

If we wanted to be really picky, we could say that technically blocks aren't real closures since we can't pass them around (without first converting them to a `Proc`-like object by using an explicit block parameter). For the purposes of discussing closures in Ruby though, it's easier just to think of blocks as closures. 

```ruby
name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" }
```
If you try to run that code, nothing will happen. That's because we've created a `Proc` and saved it to `chunk_of_code`, but haven't executed it yet. We can now pass around this local variable, `chunk_of_code` and execute it at any time later. Suppose we have a completely different method, and we pass in this `chunk_of_code` into that method, then the method executes that `chunk_of_code`. 
```ruby
def call_me(some_code)
  # call will execute the Proc object that gets passed in
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
chunk_of_code = Proc.new { puts "hi #{name}" }
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

Whatever we define within the `Proc` doesn't really matter __unless it actually gets invoked__.
```ruby
# madeup_method is referenced here but not invoked so it doesn't matter if it exists or not
my_proc = Proc.new { madeup_method }

# but when we call the Proc madeup_method is invoked, resulting in a NameError
my_proc.call
# NameError: undefined local variable or method madeup_method for main:Object
```
The `to_proc` method doesn't care what symbol is being passed in, it will not check if `madeup_method` was defined beforehand. 
```ruby
# madeup_method is referenced here but not invoked so it doesn't matter if it exists or not
my_proc = Proc.new { madeup_method }

# we then define a method called madeup_method
def madeup_method
  puts 'Hello!'
end

# now when we call the Proc madeup_method is invoked, outputting the String 'Hello!'
my_proc.call 
# => 'Hello!'
```
The reason this works __isn't__ because our definition of `madeup_method` is in the binding of `my_proc` (it is defined __after__ `my_proc` is instantiated), but because `madeup_method` is defined __before__ it is effectively invoked by `my_proc.call`.

### Binding Scope
The binding is what is in scope when the closure is __created__. Any variables that need to be accessed in a proc (or block/ lambda) __must be defined before the proc is created__ (or __passed as an argument__ when the proc is called). This does not stop the Proc from '*updating*' the state of it's information (e.g. see our previous example with the local variable `name`).
```ruby
a = 1
b = 2

my_proc = Proc.new do 
  p a
  p b
end

c = 3
my_proc.call
# => [:my_proc, :b, :a, ...]

p local_variables
# => [:c, :my_proc, :b, :a, ...]
```
In the code above, `a` and `b` are __in scope__ when the closure `my_proc` is created on line 4. When we execute the Proc on line 8, we output the return of `Kernel#local_variables`. 

This basically tells us the local variables that are in scope. `c` is not included even though we call the proc after `c` is assigned on line 6. When we output the return of `local_variables` outside of the closure on line 10, `c` is included.

In the following example, the __local variable__ `a` is not defined until __after `my_proc` is created__ (and as such is __not part of `my_proc`'s binding__).
```ruby
my_proc = Proc.new { puts a }
a = 'hello'

my_proc.call
# NameError (undefined local variable or method `a' for main:Object)
```
In the following example, we define an `a` __method__, which we define __subsequent__ to our Proc. In this case, `my_proc` is able to call the method, since it is defined elsewhere __before__ `my_proc` is called.
```ruby
my_proc = Proc.new { puts a }

def a
  'hello'
end

my_proc.call
# => 'hello'
```
In this final example, this works, but only because we are passing in `c` as __an argument__ to the `Proc.call` method, *not* because `c` is part of the proc's binding.
```ruby
my_proc = Proc.new do |num|
  p num
end

c = 3
my_proc.call(c)
```
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

Let's break down the code `(&:to_s)`. First, when we add a `&` in front of an object, it tells Ruby to try to __convert this object into a block__. To do so, it's expecting a `Proc` object. If this object is not a `Proc` object, it will __call `#to_proc` on the object__. 

Put another way, when the object prefixed with the` &` in a method invocation is a `Proc`, that tells Ruby to treat the `Proc` object __as if it were a regular block following a method invocation__.

So two things are happening during method __invocation__:
1. Ruby checks whether the object __after__ `&` is a `Proc`. 
  - If it is, it uses the object __as-is__. 
  - Otherwise, it tries to call `#to_proc` on the object, which should return a `Proc` object. An error will occur if the `#to_proc` fails to return a `Proc` object.
2. If all is well, the __`&` turns the `Proc` into a block__.

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
# convert Proc into block, then pass block in.
my_method(&a_proc)
# => "2"
```
#### The `&` symbol
When used in a method __definition__, the unary `&` __expects to be passed a block__ which it then __converts to a `Proc` object__ (we can leverage this fact to write methods with an explicit block parameter). 

When used in a method __invocation__, unary `&` __expects a `Proc` object__ which it then __converts to a block__ (which is used as the block for the called method). 

If a non-`Proc` object is used as the operand, then Ruby will attempt to call `to_proc` on it first, the resulting `Proc` object then being __converted to a block__ by `&`. This is why we can use a symbol object as the operand, since the `Symbol` class has a `#to_proc` instance method.
