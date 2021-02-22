# Classes and Objects II

## Table of Contents
- [Class Methods](#class-methods)
- [Class Variables](#class-variables)
- [Constants](#constants)
- [The to_s Method](#the-to_s-method)
- [More about self](#more-about-self)

### Class Methods
Class methods are methods we can call __directly on the class itself__, without having to instantiate any objects. Class methods __cannot__ be called by *objects instantiated from them*, and __cannot access instance variables__ (since instance variables are only initialised when an object is instantiated from the class).

When defining a class method, we prepend the method name with the reserved word `self.`, like this:
```ruby
# Class method definition (rest of code omitted)
def self.what_am_i
  "I'm a GoodDog class!"
end
```
When we call the class method, we use the class name `GoodDog` followed by the method name, without even having to instantiate any objects, like this:
```ruby
GoodDog.what_am_i
# => I'm a GoodDog class!
```
Class methods are where we put functionality that does not pertain to _individual_ objects. Objects contain state, and if we have a method that __does not need to deal with states__, then we can just use a class method.

### Class Variables
Just as instance variables capture information related to specific instances of classes (i.e., objects), we can create variables for an entire class (i.e. they are shared between all instances of a class) that are appropriately named *class variables*. Class variables are created using two `@` symbols like so: `@@`.
```ruby
class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs
# => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs
# => 2
```
We have a class variable called `@@number_of_dogs`, which we initialize to 0. Then in  our `initialize` method, we increment that number by 1. Remember that `initialize` gets called __every time we instantiate a new object__ via the `new` method. 

This also demonstrates that we can _access class variables from within an instance method_ (`initialize` is an instance method) of the same class. Finally, we just return the value of the class variable in the class method `self.total_number_of_dogs`. This is an example of using a class variable and a class method to keep track of a class level detail that pertains only to the class, and not to individual objects.

### Constants
When creating classes there may also be certain variables that you never want to change. You can do this by creating what are called __constants__. You define a constant within by using an uppercase letter at the beginning of the variable name (attempting to define a constant in an instance method will return a `SyntaxError - dynamic constant assignment`). If you want to access a constant outside of the class then you would have to use `classname::constant`.

While technically constants just need to begin with a capital letter, most Rubyists will make the entire variable uppercase.
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age
# => 28
```
Here we used the constant `DOG_YEARS` to calculate the age in dog years when we created the object, `sparky`. Note that we used the setter methods in the `initialize` method to initialize the `@name` and `@age` instance variables given to us by the `attr_accessor` method. We then used the `age` getter method to retrieve the value from the object.

`DOG_YEARS` is a variable that will never change for any reason so we use a constant. It is possible to reassign a new value to constants but Ruby will throw a warning.

### The `to_s` Method
The `to_s` instance method comes built in to every class in Ruby (it comes from the `Object` class).
```ruby
puts sparky
# => #<GoodDog:0x007fe542323320>
```
What's happening here is that the `puts` method automatically calls `to_s` on its argument, which in this case is the `sparky` object. In other words `puts sparky` is equivalent to `puts sparky.to_s`. 

The reason we get this particular output lies within the `to_s` method in Ruby. By default, the `to_s` method returns the __name of the object's class and an encoding of the `object_id`__. 

Note: the `puts` method calls `to_s` for any argument that is __not an array__. For an array, it writes on *separate lines* the result of calling `to_s` on each element of the array.

To test this, we can add a custom `to_s` method to our `GoodDog` class, __overriding__ the default `to_s` that comes with Ruby.
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

puts sparky
# => This dog's name is Sparky and is 28 in dog years.
```
Besides being called automatically when using `puts`, another important attribute of the `to_s` method is that it's also automatically called in __string interpolation__. 
```ruby
arr = [1, 2, 3]
# => [1, 2, 3]

x = 5
# => 5

"The #{arr} array doesn't include #{x}."
# => The [1, 2, 3] array doesn't include 5.
```
Here, the `to_s` method is automatically called on the `arr` array object, as well as the `x` integer object. We can see this in action on our `sparky` object when using string interpolation.
```ruby
"#{sparky}"
# => "This dog's name is Sparky and it is 28 in dog years."
```
Another example:
```ruby
class Human  
  def what_species_am_I
    puts "I am a #{self}"
  end

  def to_s
    "#{self.class}"
  end
end
```
Ordinarily, the `what_species_am_I` method would return `I am a #<Human:0x00007fd4ad0f6ae8>` - i.e. a reference to the __object__. However, as string interpolation automatically calls the `to_s` method, it replaces the `self` with `self.class` instead.

An interesting aside is that if our custom implementation of `to_s` does not return a string, Ruby seems to ignore the class definition of the `to_s` method and reverts to the `Object#to_s` instance method.

In summary, the `to_s` method is called automatically on the object when we use it with `puts` or when used with string interpolation. This fact may seem trivial at the moment, but knowing when `to_s` is called will help us understand how to read and write better OO code.

#### The `p` Method
There's another method called `p` that's very similar to `puts`, except it __doesn't__ call `to_s` on its argument; it calls another built-in Ruby instance method called `inspect`. The `inspect` method is very helpful for debugging purposes, so we don't want to override it.
```ruby
p sparky
# => #<GoodDog:0x007fe54229b358 @name="Sparky", @age=28>
```
This output implies that `p sparky` is equivalent to `puts sparky.inspect`.

### More about `self`
`self` can refer to different things depending on where it is used. For example, so far we've seen two clear use cases for `self`:
  1. Use `self` when calling setter methods from within the class. In our earlier example we showed that `self` was necessary in order for our `change_info` method to work properly. We had to use `self` to allow Ruby to disambiguate between initializing a local variable and calling a setter method.
    - Note that the `initialize` method is not counted as a setter method by itself - we need to use an instance variable for `initialize`, unless we have defined the setter method already using `attr_*`.
  2. Use `self` for class method definitions.

Let's work through an example:
```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    # We can only use self here because we defined setter methods through attr_accessor
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end
```
This is our standard `GoodDog` class, and we're using `self` whenever we call an instance method from within the class. What does `self` really represent here? Let's add one more instance method to help us find out.
```ruby
class GoodDog
  # rest of code omitted for brevity

  def what_is_self
    self
  end
end
```
Now we can instantiate a new `GoodDog` object.
```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
# => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```
From __within__ the class, when an instance method uses `self`, it references the _calling object_. In this case, that's the `sparky` object. Therefore, from __within__ the `change_info` method, calling `self.name=` acts the same as calling `sparky.name=` from __outside__ the class (you __can't__ call `sparky.name=` _inside_ the class, though, since it isn't in scope - the class itself has no concept of what the `sparky` object is).

The other place we use `self` is when we're defining class methods:
```ruby
class MyAwesomeClass
  def self.this_is_a_class_method
    self
  end
end
```
When `self` is prepended to a method definition, it is defining a __class method__. In our `GoodDog` class method example, we defined a class method called `self.total_number_of_dogs`. This method returned the value of the class variable `@@number_of_dogs`. The `self` within the class method also refers to the class itself - unless `self` is within an *instance* method, it will refer to the class.
```ruby
class GoodDog
  # rest of code omitted for brevity
  puts self
end
```
If we run the above code in `irb`, we get:
```ruby
# irb :001 > GoodDog
# => GoodDog
```
You can see that using `self` __inside a class but outside an instance method__ refers to the *class itself*. Therefore, a method definition prefixed with `self` is the __same as defining the method on the class__. That is, `def self.a_method` is equivalent to `def GoodDog.a_method`. That's why it's a class method; it's actually being defined __on the class__.

From __within__ a class:
  1. `self`, __inside__ of an instance method, references the __instance (object)__ that called the method - the calling object. Therefore, `self.weight=` inside the class is the same as calling `sparky.weight=`, in our example.
  2. `self`, __outside__ of an instance method, references the __class__ and can be used to define class methods (this also includes when `self` is used *within a class method*). Therefore if we were to define a `name` class method, `def self.name=(n)` is the same as `def GoodDog.name=(n)`.

Thus, we can see that `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behavior. `self` changes *depending on the scope it is used in*, so pay attention to see if you're inside an instance method or not. 

When a method is called without an explicit `self`, the __implicit__ `self` is used, which is the value of the `self` keyword. In the following example, the `Person#full_name` method uses the values from `Person#first_name` and `Person#last_name`, but does not explicitly use `self` and relies on the value of the implicit `self`. The *implicit `self`* is how we call private methods from other methods (an *explicit* `self` on private methods in versions of Ruby prior to 2.7 will return a `NoMethodError`, even if `self` is referencing the same thing).
```ruby
class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end
 
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  attr_reader :first_name, :last_name
end
```
