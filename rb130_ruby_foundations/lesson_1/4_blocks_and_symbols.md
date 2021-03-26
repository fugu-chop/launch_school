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
If we reassign the local variable `name` __after__ the `Proc` object is assigned to `chunk_of_code`, the output changes. This implies that the `Proc` __keeps track of its surrounding context__, and drags it around wherever the chunk of code is passed to. Another way to think about it is that the binding has __access to the variable, not the value it's assigned to__. 

In Ruby, we call this its __binding__, or surrounding environment/context. A closure must keep track of its surrounding context in order to have all the information it needs in order to be executed later. The binding is not something that's created afresh every time it's required, but is __just a reference to variables__, and the values returned will be relevant to the point in the program the binding is invoked.

Remember, since blocks are also closures, the same rules for binding apply to them:
```ruby
ARRAY = [1, 2, 3]

def abc
  a = 3
end

def xyz(collection)
  collection.map { |x| yield x }
end

xyz(ARRAY) do
  # block body
end
```
In our above example, the block on line 12 has `ARRAY`, the `abc` method and the `xyz` method as part of it's binding (the `xyz` method is also part of the binding since it's defined before the block is executed).

This not only includes local variables, but also _method references, constants and other artifacts_ in your code -- __whatever it needs to execute correctly__, it will drag all of it around. It's why code like the above will work fine, seemingly violating the variable scoping rules we learned earlier.

This is at the core of variable scoping rules in Ruby, and it's why "inner scopes can access outer scopes". This is why anything __defined before__ a block is passed as an argument to a method invocation is *part of that block's binding*.

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
The reason this works __isn't__ because our definition of `madeup_method` is in the binding of `my_proc` (it is defined __after__ `my_proc` is instantiated), but because `madeup_method` is defined __before it is effectively invoked__ by `my_proc.call`.

#### Why does it work like this?
Basically, because Ruby needs to be able to disambiguate between variables and methods when it isn't clear purely from the written code. 

Remember back to OOP - When we don't use an explicit caller, the method is implicitly called on `self`. To be a little more precise here, if we try to invoke a method without an explicit caller and __without parentheses__, Ruby will first check to see if there is _a local variable of that name_ within scope (which in the case of a block __includes variables within its binding__). If there is, then Ruby will return the object referenced by the local variable. If not, it will attempt to call a method of that name on `self`.

Ruby doesn't know whether `my_method` is a local variable or a method, and so __first__ looks for the local __variable__, and __then__ tries calling the __method__ on `self`.
```ruby
my_method 
# => NameError: undefined local variable or method `my_method' for main:Object
```
In the below example, because of the parentheses, Ruby knows this is a method invocation and so skips the local variable part and just tries calling the method on `self`.
```ruby
my_method() 
# => NoMethodError: undefined method `my_method' for main:Object
```
If we explicitly call `my_method` on `self` we get the same result (Ruby knows this is a method invocation, and so skips the local variable part).
```ruby
self.my_method 
# => NoMethodError: undefined method `my_method' for main:Object
```
If we look at the last part of the error message for our first example (i.e. referencing `main:Object`), we see that `self` in the `main` scope is the `main` object. The `main` scope is an __instance of the `Object` class__, but it's also the `Object` __class itself__ (It's more complex than that, but for the purposes of this discussion, that's a good enough mental model).
```ruby
self
# => main

self.class 
# => Object
```
This means that we can define methods in the `main` scope, and then call those methods on `self`. Any methods defined in the `main` scope become instance methods of `Object` (__not__ the `main` scope itself). This makes them available everywhere, meaning that we can call the method without an explicit caller.
```ruby
def greeting
  puts 'Hello!'
end

greeting
# => 'Hello!'

self.greeting
# => 'Hello!'

Object.greeting
# => 'Hello!'
```
As an aside here, since all custom classes inherit from `Object`, we can also call the method on objects of custom classes; but __only if we make them public__, since methods defined in the `main` scope are __private by default__.
```ruby
public

def greeting
  puts 'Hello!'
end

class MyClass; end

MyClass.new.greeting 
# => 'Hello!'
```
So looking at the following example:
```ruby
my_proc_4 = Proc.new { puts d }

def d
  4
end

my_proc_4.call
# => 4
```
1. We create the Proc object and assign it to the local variable `my_proc_4`. The __name__ `d` is part of the Proc's binding. At this stage, it doesn't really matter what `d` is.
2. We then define a method `d` in the `main` scope.
3. We then invoke the `call` method on `my_proc_4`. 

Since Ruby can't disambiguate between `d` being a local variable or a method, it first looks to see if there is a local variable `d` in scope. Since there isn't a local variable `d` in the Proc's binding, it then implicitly calls `d` as a method on `self`. Since `self` here is the `main` object, and since we have defined a `d` method on that object, we are able to successfully invoke the method.

If we had reversed the order (i.e. defined the method __after__ `my_proc_4.call`, we would get a `NameError: undefined local variable or method 'd' for main:Object`).
### Binding Scope
The binding is what is in scope when the closure is __created__. Any variables that need to be accessed in a proc (or block/ lambda) __must be defined before the proc is created__ (or __passed as an argument__ when the proc is called). This does not stop the Proc from '*updating*' the state of it's information (e.g. see our previous example with the local variable `name`).
```ruby
# This works, and outputs the values of a and b
a = 1
b = 2

my_proc = Proc.new do
  p a
  p b
end

my_proc.call
c = 3

# This doesn't work, because c was not in scope (and so not part of the proc's binding), when the proc was created
my_proc = Proc.new do
  p c
end

my_proc.call
# => Undefined local variable or method `c' for main:Object (NameError)
c = 3 

# This doesn't work, for the same reasons as example 2 even though we call the proc after c is defined it wasn't in scope when the proc was created and so is still not part of the binding
my_proc = Proc.new do
  p c
end

c = 3

my_proc.call
# => Undefined local variable or method `c' for main:Object (NameError)
```
In the code below, `a` and `b` are __in scope__ when the closure `my_proc` is created on line 4. When we execute the Proc on line 8, we output the return of `Kernel#local_variables`. 
```ruby
a = 1
b = 2

my_proc = Proc.new { p local_variables }

c = 3

my_proc.call 
# =>[:a, :b, :my_proc]

p local_variables
# => [:a, :b, :my_proc, :c]
```
This basically tells us the local variables that are in scope. `c` is not included even though we call the Proc after `c` is assigned on line 6. When we output the return of `local_variables` outside of the closure on line 10, `c` is included, as it's been defined in the `main` scope.

In the following example, the __local variable__ `a` is not defined until __after `my_proc` is created__ (and as such is __not part of `my_proc`'s binding__).
```ruby
my_proc = Proc.new { puts a }
a = 'hello'

my_proc.call
# NameError (undefined local variable or method `a' for main:Object)
```
In the following example, we define an `a` __method__, which we define __subsequent__ to our Proc. In this case, `my_proc` is able to call the method, since it is defined elsewhere __before `my_proc` is called__.
```ruby
my_proc = Proc.new { puts a }

def a
  'hello'
end

my_proc.call
# => 'hello'
```
In this final example, this works, but only because we are passing in `c` as __an argument__ to the `Proc.call` method, *not* because `c` is part of the Proc's binding (our Proc definition does not require a specific `c` variable or method) - we have __explicitly required the block to take an argument__, but that argument itself could be any object.
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

Suppose you want to use `String#prepend` to prepend each value with `"The number is:"`. Unfortunately, we can't use the shortcut to do that; it __doesn't work for methods that take arguments__. We would need to use a `Proc` object for this, which we can obtain by using the `Method#to_proc` method.
```ruby
def convert_to_base_8(n)
  # The #to_s method converts an integer to Base 8
  n.to_s(8).to_i
end

# We can convert methods to procs with Method#to_proc. This requires a Method object, which we create with Object#method(:method_name) 
base8_proc = method(:convert_to_base_8).to_proc

[8, 10, 12, 14, 16, 33].map(&base8_proc)
``` 
In the above code, the `map` method expects a block, passing individual elements of the array to that block. At method invocation, the `&` symbol converts our `base8_proc` Proc object into a block. The actual proc object is a method which accepts an argument, which is exactly what we want with the `map` method and how we get around the issue of `&:method_name` not taking an argument.
#### `Symbol#to_proc`
What the above shortcut is doing, is effectively converting `(&:to_s)` to `{ |n| n.to_s }`. The mechanism at work here is related to the use of `&` with explicit blocks, but since it isn't applied to a method parameter, it's also different. 

Let's break down the code `(&:to_s)`. First, when we add a `&` in front of an object, it tells Ruby to try to __convert this object into a block__. To do so, it's expecting a `Proc` object. If this object is not a `Proc` object, it will __call `#to_proc` on the object__. 

Put another way, when the object prefixed with the `&` in a method invocation is a `Proc`, that tells Ruby to treat the `Proc` object __as if it were a regular block following a method invocation__.

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

In essence, the two uses of `&` are opposites.
