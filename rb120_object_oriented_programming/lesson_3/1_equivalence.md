# Equivalence

## Table of Contents
- [Introduction](#introduction)
- [The == method](#the-==-method)
- [object_id](#object_id)
- [===](#===)
- [The eql? method](#the-eql?-method)

### Introduction
For most objects, the `==` method compares the two variables' _values_ whereas the `equal?` method determines whether the two variables point to the _same object_. 
```
str1 = "something"
str2 = "something"
str1_copy = str1

# comparing the string objects' values
str1 == str2            # => true
str1 == str1_copy       # => true
str2 == str1_copy       # => true

# comparing the actual objects
str1.equal? str2        # => false
str1.equal? str1_copy   # => true
str2.equal? str1_copy   # => false
```
### The `==` method
`==` is not an operator in Ruby, like the `=` assignment operator is. Instead, it's actually an __instance method__ available on _all objects_. 

Ruby gives the `==` method a special syntax to make it look like a normal operator. For example, instead of calling the method as `str1.==(str2)`, we can use the more natural syntax `str1 == str2`. Both options are functionally equivalent. 

Since it's an instance method, the answer to "how does == know what value to use for comparison" is: it's _determined by the class_.

The original `==` method is defined in the `BasicObject` class, which is the _parent class for all classes_ in Ruby. This implies __every object in Ruby__ has a `==` method. However, each class should define the `==` method to specify the value to compare, since the default implementation is to compare whether the two __objects__ are the same, which is a much more strict definition.
```
class Person
  attr_accessor :name
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => false

bob_copy = bob
bob == bob_copy            # => true
```
This implies that the _default implementation_ for `==` is the same as `equal?` (which is also in the `BasicObject` class). It's not very useful, because when we use `==`, we don't actually want to ask "_are the two variables pointing to the same object?_", and instead, we want to ask "_are the values in the two variables the same?_".

To tell Ruby what "the same" means for a `Person` object, we need to define the `==` method.
```
class Person
  attr_accessor :name

  def ==(other)
    # relying on String#== here when we pass in an argument of a String class
    name == other.name     
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => true
```
Note that the `Person#==` method we just wrote uses the `String#==` method for comparison. That's perfectly ok, and almost every Ruby core library class will come with its own `==` method. 

Therefore, you can safely use `==` to compare Array, Hash, Integer, String and many other objects. But just remember there's a method somewhere backing that equality comparison, and so it can be modified.

Take this example:
```
45 == 45.00                 # => true
```
The above code is actually `45.==(45.00)`, which means that it's calling the `Integer#==` method. The implementer of this method took care to consider the possibility of comparing an integer with a float, and handled the conversion from float to integer appropriately.

This is the first time we've seen comparing two objects of different classes. But this is possible because you can implement `==` however you wish. You should also realize that `45 == 45.00` is __not the same__ as `45.00 == 45`. 

The former is calling `Integer#==` while the latter is calling `Float#==`. Thankfully, the creator of those methods took time to make the interface consistent.

When you define a `==` method, you also get the `!=` for free.

### `object_id`
Every object has a method called `object_id`, which returns a numerical value that uniquely identifies the object. We can use this method to determine whether *two variables are pointing to the same object*. We could do this with `equal?` as well.
```
str1 = "something"
str2 = "something"

str1.object_id            # => 70186013144280
str2.object_id            # => 70186013536580
```
From the above output, you can see that though `str1` and `str2` contain the same value, they are indeed __different objects__. Because `object_id` returns an integer, we can compare the object ids of various objects.
```
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => false

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => true

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => true
```
If two symbols or two integers have the _same value_, they are also the _same object_. This is a performance optimization in Ruby, because you __can't modify a symbol or integer__. This is also why Rubyists prefer symbols over strings to act as hash keys: it's a slight performance optimization and saves on memory.

### `===`
There are two more concepts related to equality. The first is the `===` method. Just like `==,` it looks like a built-in Ruby operator when you use it, but it's in fact an _instance method_. The more confusing part about this method is that it's used implicitly by the `case` statement.

The `===` operator is generally used to determine if an object __belongs to a set__. For example, an _instance of a class belongs to the class_, a number in a range belongs to that range, etc.

A good example of seeing `===` in action is when we have ranges in a `when` clause.
```
num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end
```
Behind the scenes, the `case` statement is using the `===` method to compare each `when` clause with `num`. In this example, the `when` clauses contain only ranges, so `Range#===` is used for each clause. If the `when` clause simply had a number, the `case` statement would use `Integer#===`.

Visualised another way:
```
num = 25

if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end
```
In the above example, on each conditional, we are evaluating whether `num` belongs in the set.

Another example:
```
number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end
```
In our above example, we are using `Range#===` and `Integer#===`, since we are comparing a number to a range on `line 6`, but also comparing integers within a `case` statement on `lines 4-5`.

Typically, you do not have to define your own `===` behavior, as you likely wouldn't use your custom classes in a `case` statement. It's sometimes useful to remember that `===` is used for comparison in `case` statements, though.

Consider the following code:
```
String === "hello" # => true
String === 15      # => false
```
On line 1, `true` is returned because "hello" is an instance of `String`, even though "hello" doesn't equal `String`. Similarly, `false` is returned on line 2 because `15` is an integer, which doesn't equal `String` and isn't an instance of the `String` class.

Sidenote: the `===` operator in JavaScript is very __different from its function in Ruby__. Do not get the two confused.

### The `eql?` method
The `eql?` method (as defined by the `Object` class) determines if two objects are the __same object and same value__. However, most other classes overwrite this implementation (e.g. `String#eql?` tests for whether the two objects contain the same __value__ and __not__ the same object. It's not used very often (primarily for comparing key-value pairs between `Hash` objects).
