# Inheritance

## Table of Contents
- [Class Inheritance](#class-inheritance)
- [super](#super)
- [Mixing in modules](#mixing-in-modules)
- [Inheritance v Modules](#inheritance-v-modules)
- [Method Lookup Path](#method-lookup-path)
- [More modules](#more-modules)
- [Private, Protected & Public](#private-protected-&-public)
- [Accidental Method Overriding](#accidental-method-overriding)

### Class Inheritance
Inheritance is when a class *inherits behavior from another __class__*. The class that is inheriting behavior is called the __subclass__ and the class it inherits from is called the __superclass__. Objects __do not inherit__ from their class, rather the class acts as a mold or template for objects of that class and determines the attributes and behaviors of those objects (classes inherit from *other classes*).

We use inheritance as a way to extract common behaviors from classes that share that behavior, and move it to a superclass. This lets us keep logic in one place. 

Ruby comes with multiple built-in classes, including `String`, `Integer`, `Hash`, and `Array`. Each class is itself an object (or instance of) the `Class` class, which we can think of as the primordial class.

Calling the class method `superclass` on any class will return that class’s superclass. 
```ruby
puts Integer.superclass 
# => Numeric
```
Here, we're extracting the `speak` method to a superclass `Animal`, and we use inheritance to make that behavior available to `GoodDog` and `Cat` classes.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak
# => Hello!

puts paws.speak
# => Hello!
```
We use the `<` symbol to signify that the `GoodDog` class is inheriting from the `Animal` class. This means that all of the methods in the `Animal` class are available to the `GoodDog` class for use. We also created a new class called `Cat` that inherits from `Animal` as well. We've eliminated the `speak` method from the `GoodDog` class in order to use the `speak` method from `Animal`.

What if we want to use the original `speak` method from the `GoodDog` class only?
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak
Sparky says arf!

puts paws.speak
# => Hello!
```
In the `GoodDog` class, we're overriding the `speak` method in the `Animal` class because Ruby checks the object's *class* __first__ for the method __before__ it looks in the superclass. 

That means when we wrote the code `sparky.speak`, Ruby first looked at the `sparky` class, which is `GoodDog`. It found the `speak` method there and used it. When we wrote the code `paws.speak`, Ruby first looked at the `paws` class, which is `Cat`. It __did not__ find a `speak` method there, so it continued to look in `Cat`'s superclass, `Animal`. It found a `speak` method in `Animal`, and used it.

In the below example, the `Dog` class isn't inheriting the `@name` instance variable from the `Pet` class, it is inheriting the `initialize` method and it's the `initialize` method that is creating the `@name` variable. 

When `Dog.new('Harry')` is invoked, Ruby will look within the `Dog` class for the `initialize` method and when it doesn't find it, Ruby will move _up the inheritance hierarchy_ (to the `Pet` class), where it will find the `initialize` method and it will be invoked. While the `initialize` method still belongs to the superclass, __`initialize` is still being called from the `Dog` class, so the instance variable created will still be part of the `Dog` class object's state__.
```ruby
class Pet
  def initialize(name)
    @name = name
  end
  
  def speak
    "Hello! I am a pet"
  end
end

class Dog < Pet
end

harry = Dog.new("Harry")
```
Inheritance can be a great way to remove duplication in your code base. There is an acronym that you'll see often in the Ruby community, "DRY". This stands for *"Don't Repeat Yourself"*. It means that if you find yourself writing the same logic over and over again in your programs, there are ways to extract that logic to one place for reuse.

### `super`
Ruby provides us with the `super` *keyword* to call methods *earlier* in the method lookup path. When you call `super` from within a method, it searches the method lookup path for a method with the same name, then invokes it. `super` is a good way of overriding an existing method in the superclass, but still incorporating some of the functionality within that superclass. `super` is __not__ limited to the `initialize` method.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak
# => "Hello! from GoodDog class"
```
We've created a simple `Animal` class with a `speak` instance method. We then created `GoodDog` which subclasses `Animal` also with a `speak` instance method to *override the inherited version*. However, in the subclass `speak` method we use `super` to invoke the `speak` method from the superclass, `Animal`, and then we __extend the functionality__ by appending some text to the return value.

Another more common way of using `super` is with `initialize`. 
```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")
# => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">
```
In this example, we're using `super` with no arguments. However, the `initialize` method, where `super` is being used, takes an argument and adds a new twist to how `super` is invoked. Here, in addition to the default behavior, `super` __automatically forwards the arguments__ that were passed to the method from which `super` is called (`initialize` method in `GoodDog` class). 

At this point, `super` will pass the `color` argument in the `initialize` defined in the subclass to that of the `Animal` superclass and invoke it. That explains the presence of `@name="brown"` when the `bruno` instance is created (i.e. the instance `initialize` method is using the argument as the value for __both__ the `name` and `color` instance variables). Finally, the subclass' `initialize` continues to set the `@color` instance variable. 

Note that passing a second argument to `GoodDog.new("brown")` will raise an `ArgumentError`, because the `initialize` instance method in the `Animal` superclass is not equipped to take a second argument, and the instance method `initialize` in the `GoodDog` class also is not equipped to take a second argument. 

When called with specific arguments, eg. `super(a, b)`, the specified arguments will be sent up the method lookup chain.
```ruby
class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear")
# => #<BadDog:0x007fb40b2beb68 @age=2, @name="bear">
```
This is similar to our previous example, with the difference being that `super` takes an argument, hence the *passed in argument is sent to the superclass*. Consequently, when a `BadDog` class is created, the passed in `name` argument ("bear") is passed to the superclass and set to the `@name` instance variable.

If you call `super()` exactly as shown -- with parentheses -- it calls the method in the superclass with __no arguments at all__. If you have a method in your superclass that takes *no arguments*, this is the safest -- and sometimes the only -- way to call it.
```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new("black")
# => #<Bear:0x007fb40b1e6718 @color="black">
```
If you forget to use the parentheses here, Ruby will raise an `ArgumentError` exception since the number of arguments is incorrect.

We can also use `super()` to pass in default values as arguments, again, extending the functionality of an instance method in the superclass.
```ruby
class SeaVessel
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    @km_traveled_per_liter = km_traveled_per_liter
    @liters_of_fuel_capacity = liters_of_fuel_capacity
  end
end

class Motorboat < SeaVessel
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # In the SeaVessel class, the initialize method takes two additional arguments in addition to those provided on initialisation here
    # We are calling SeaVessel#initialize and autofilling two of those arguments (We don't have to define them within Motorboat#initialize as we don't expect the user to provide these when calling the method)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end
```
### Mixing in modules
Another way to DRY up your code in Ruby is to use __modules__. 

Extracting common methods to a superclass, like we did in the previous section, is a great way to model concepts that are naturally hierarchical. We gave the example of animals. We have a generic superclass called `Animal` that can keep all basic behavior of all animals. We can then expand on the model a little and have, perhaps, a `Mammal` subclass of `Animal`.

![Subclass Diagram](https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/animal_hierarchy.jpg)

The above diagram shows what pure class based inheritance looks like. Remember the goal of this is to put the *right behavior (i.e., methods) in the right class so we don't need to repeat code in multiple classes*. We can imagine that all `Fish` objects are related to animals that live in the water, so perhaps a `swim` method should be in the `Fish` class. 

We can also imagine that all `Mammal` objects will have warm blood, so we can create a method called `warm_blooded?` in the `Mammal` class and have it return `true`. Therefore, the `Cat` and `Dog` objects will have access to the `warm_blooded?` method which is automatically inherited from `Mammal` by the `Cat` and `Dog` classes, but they won't have access to the methods in the `Fish` class.

This type of hierarchical modeling works, to some extent, but there are always exceptions. For example, we put the `swim` method in the `Fish` class, but some mammals can swim as well. We don't want to move the `swim` method into `Animal` because not all animals swim, and we don't want to create another `swim` method in Dog because that violates the DRY principle. For concerns such as these, we'd like to *group them into a module* and then __mix in that module__ to the classes that require those behaviors.
```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal
  def exist
    "I exist!"              # All subclasses have access to this through class inheritance
  end
end

class Fish < Animal
  include Swimmable         # mixing in Swimmable module (Interface inheritance)
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable         # mixing in Swimmable module
end
```
And now `Fish` and `Dog` objects can `swim`, but objects of other classes won't be able to:
```ruby
sparky = Dog.new
neemo  = Fish.new
paws   = Cat.new

sparky.swim
# => I'm swimming!

neemo.swim
# => I'm swimming!

paws.swim
# => NoMethodError: undefined method `swim' for #<Cat:0x007fc453152308>
```
A common naming convention for Ruby is to use the `able` suffix on whatever verb describes the behavior that the module is modeling. You can see this convention with our `Swimmable` module. Likewise, we could name a module that describes "walking" as `Walkable`. Not all modules are named in this manner, however, it is quite common.

In order to figure out all the modules a class includes, the class method `included_modules` is useful. This class method travels up the method lookup path, and returns all the modules __it encounters along the way__, as an array.
```ruby
Hash.included_modules
# => [Enumerable, Kernel]
```
Where `include` mixes a module’s methods in at the *instance level* (allowing instances of a particular class to use the methods), the `extend` keyword mixes a module’s methods at the _class level_. This means that __class itself__ can use the methods, as opposed to instances of the class.
```ruby
module ThePresent
  def now
    puts "It's #{Time.new.hour > 12 ? Time.new.hour - 12 : Time.new.hour}:#{Time.new.min} #{Time.new.hour > 12 ? 'PM' : 'AM'} (GMT)."
  end
end

class TheHereAnd
  extend ThePresent
end

TheHereAnd.now
# => It's 10:24 AM (GMT).
```
### Inheritance v Modules
Now you know the two primary ways that Ruby implements inheritance. 
- __Class inheritance__ is the traditional way to think about inheritance: one type inherits the behaviors of another type. The result is a new type that specializes the type of the superclass. 
- The other form is sometimes called __interface inheritance__: this is where __mixin modules__ come into play. The class doesn't inherit from another type, but instead inherits the interface (i.e. __methods__) provided by the mixin module. In this case, the result type is not a specialized type with respect to the module.

You may wonder when to use class inheritance vs mixins. Here are a couple of things to consider when evaluating these choices.
- You can only subclass (class inheritance) from __one__ class, whereas you can mix in as many modules (interface inheritance) as you'd like.
- If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a dog "is an" animal and it "has an" ability to swim.
- You __cannot instantiate objects from modules__. Modules are used only for namespacing and grouping common methods together.

### Method Lookup Path
Recall the method lookup path is the order in which classes are inspected when you call a method.
```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end
```
The __method lookup path__ is the *path Ruby takes to look for a method*. We can see this path with the `ancestors` class method.
```ruby
puts "---Animal method lookup---"
puts Animal.ancestors

# ---Animal method lookup---
# Animal
# Walkable
# Object
# Kernel
# BasicObject
```
This means that when we call a method of any `Animal` object, first Ruby looks in the `Animal` class, then the `Walkable` module, then the `Object` class, then the `Kernel` module, and finally the `BasicObject` class. Note that the `BasicObject` superclass is `nil` (i.e. it doesn't inherit from anything, but the `.superclass` method for `BasicObject` is a special implementation designed to return `nil` instead of an actual superclass).
```ruby
fido = Animal.new
fido.speak
# => I'm an animal, and I speak!
```
In the above example, Ruby found the `speak` method in the `Animal` class and looked no further.
```ruby
fido.walk
# => I'm walking.
```
Ruby first looked for the `walk` instance method in `Animal`, and not finding it there, kept looking in the next place according to our list, which is the `Walkable` module. It saw a `walk` method there, executed it, and stopped looking further.
```ruby
fido.swim
# => NoMethodError: undefined method `swim' for #<Animal:0x007f92832625b0>
```
Ruby traversed all the classes and modules in the list, and didn't find a `swim` method, so it threw an error.

Let's add another class to the code above. This class will inherit from the `Animal` class and mix in the `Swimmable` and `Climbable` modules.
```ruby
class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors

# ---GoodDog method lookup---
# GoodDog
# Climbable
# Swimmable
# Animal
# Walkable
# Object
# Kernel
# BasicObject
```
There are several interesting things about the above output. 
- First, this tells us that the order in which we include modules is important. Ruby actually __looks at the last module we included first__. This means that in the rare occurrence that the modules we mix in contain a method with the same name, the __last module included will be consulted first__. 
- The second interesting thing is that the module included in the superclass made it on to the method lookup path. That means that all `GoodDog` objects will have access to not only `Animal` methods, but __also methods defined in the `Walkable` module__, as well as _all other modules mixed in to any of its superclasses_.

Here's a chart of how the various classes fit together:

![Class Hierarchy Chart](https://vahid.blog/post/2020-11-04-encapsulation-polymorphism-and-abstraction-in-ruby/class_hierarchy.png)

As a detailed point - a custom class is an instance of `Class` but it has as its superclass `Object`. This means that the method lookup path (`.ancestors`) for the custom class won't show `Class` and `Module` since it's not its superclass, but it still inherits all the methods from `Class` and `Module` - a prime example are accessor methods, which come from `Class`.
```ruby
class MyCustomClass; end

myObj = MyCustomClass.new

myObj.class.ancestors
# Note that the ancestors method is available on the class of the object, which comes from `Class`
# => [MyCustomClass, Object, Kernel, BasicObject]

MyCustomClass.class.ancestors
# Note that MyCustomClass is an object - an instance of the `Class` class
# => [Class, Module, Object, Kernel, BasicObject]
```
### More modules
The first use case we'll discuss is using modules for __namespacing__. In this context, __namespacing__ means *organizing similar classes under a module*. In other words, we'll use modules to group related classes. 
- It becomes easy for us to recognize related classes in our code. 
- The second advantage is it reduces the likelihood of our classes colliding with other similarly named classes in our codebase.
```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```
Namespacing allows us to avoid conflicts in methods that have the same name (but belong to different classes).
```ruby
module Circle
  PI = 3.141592653589793
end

# No conflicts occur, even though the methods have the same name.
Math::PI
# => 3.141592653589793

Circle::PI
# => 3.141592653589793
```
We call classes in a module by appending the class name to the module name with two colons(`::`), also known as the __scope resolution operator__.
```ruby
buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')
# => "Arf!"

kitty.say_name('kitty')
# => "kitty"
```
The second use case for modules we'll look at is using modules as a *container for methods*, called __module methods__. This involves using modules to house other methods. This is very useful for methods that seem out of place within your code.
```ruby
module Mammal
  def self.some_out_of_place_method(num)
    num ** 2
  end
end
```
Defining methods this way within a module means we can call them directly from the module (the former is the preferred way).
```ruby
value = Mammal.some_out_of_place_method(4)
value = Mammal::some_out_of_place_method(4)
```
### Private, Protected & Public
__Access Control__ is a concept that exists in a number of programming languages, including Ruby. It is generally implemented through the use of access modifiers. The purpose of access modifiers is to allow or restrict access to a particular thing. 

In Ruby, the things that we are concerned with restricting access to are the *methods defined in a class*. In a Ruby context, therefore, you'll commonly see this concept referred to as __Method Access Control__.

The way that Method Access Control is implemented in Ruby is through the use of the `public`, `private`, and `protected` access modifiers. Ruby __does not__ apply any access control over _instance and class variables_ - these are all 'private' and cannot be accessed outside of the class.

#### Public Methods
Right now, all the methods in our `GoodDog` class are public methods. A public method is a method that is *available to anyone who knows either the class name or the object's name*. These methods are readily available for the rest of the program to use and comprise the class's interface (that's how other classes and objects will interact with this class and its objects). By default, instance methods are public. 

#### Private Methods
Sometimes you'll have methods that are doing work in the class but don't need to be available to the rest of the program. These methods can be defined as `private`. 

How do we define private methods? We use the `private` method call in our program and anything below it is private (unless another method, like `protected`, is called after it to negate it). The exception is the `initialize` method, which is __always__ private.

In our `GoodDog` class we have one operation that takes place that we could move into a `private` method. When we initialize an object, we calculate the dog's age in Dog years. Let's refactor this logic into a method and make it private so nothing outside of the class can use it. 
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.human_years
# => NoMethodError: private method `human_years' called for #<GoodDog:0x007f8f431441f8 @name="Sparky", @age=4>
```
We have made the `human_years` method private by placing it under the `private` keyword. What is it good for, then, if we can't call it? `private` methods are *only accessible from other methods in the class* (i.e. only within the class definition, and not from objects instantiated from the class). For example, given the above code, the following would be allowed:
```ruby
# Assume this method definition is above the "private" keyword
def public_disclosure
  "#{self.name} in human years is #{human_years}"
end
```
We cannot use `self.human_years`, because the `human_years` method is private. Remember that `self.human_years` is equivalent to `sparky.human_years` (since it's used in an instance method within the class, `self.` refers to the calling object). This would be equivalent to allowing the private method to be called outside of instance methods in the class (i.e. directly on the object instantiated). 

Therefore, we had to use the `human_years` instance method, which inside the class, the `public_disclosure` instance method is able to see (and use the returned value).

As of Ruby 2.7, it is now legal to call private methods with a literal `self` as the caller.

#### Protected
Public and private methods are most common, but in some less common situations, we'll want an in-between approach. We can use the `protected` keyword to create protected methods. 

A protected method can be invoked only by *objects of the defining class and its subclasses*. The easiest way to understand protected methods is to follow these two rules:
- from inside the class, protected methods are accessible just like public methods.
- from outside the class, protected methods act just like private methods.
```ruby
class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method
# We can call a protected method from within the class, even with self prepended
# => Will this work? Yes, I'm protected!

fido.a_protected_method
# => NoMethodError: protected method `a_protected_method' called for #<Animal:0x007fb174157110>
```
Protected methods are not used often in practice and that knowledge isn’t transferrable to other languages.

A protected method allows __other instances of the same class to invoke the method__:
```ruby
class Abc
  def initialize(val)
    @val = val
  end  
  
  def add(other)
    self.get_val + other.get_val
  end  
  
  protected
  
  def get_val
    @val
  end
end

abc1 = Abc.new(5)
abc2 = Abc.new(8)
puts abc1.add(abc2)
# => 13
```
This code works because `get_val` is protected -- it lets the `abc1` instance access the `get_val` method in the `abc2` instance. Had `get_val` been declared as `private`, then this code would fail because an object (`abc1` here) __can't access a private method from any other object__ - they can only access `get_val` (prior to Ruby 2.7, we would have to remove the `self.` prefix), not `other.get_val`. When a method is private, only the *class* - __not__ *instances* of the class - can access it. 

Had `get_val` been declared as public, then this code would work, but anyone could call `abc1.get_val`, which may not be desired. A protected method can be __called by any instance of the class__ - either `self` or some other object of the same type.

### Accidental Method Overriding
It’s important to remember that every class you create inherently subclasses from class `Object`. The `Object` class is built into Ruby and comes with many critical methods. This means that methods defined in the `Object` class are available in all classes.
```ruby
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

Parent.superclass
# => Object
```
Through the magic of inheritance, a subclass can override a superclass’s method. *Method overriding is one way in which Ruby implements polymorphism*.
```ruby
class Child < Parent
  def say_hi
    p "Hi from Child."
  end
end

child = Child.new
child.say_hi
# => "Hi from Child."
```
This means that, if you accidentally override a method that was originally defined in the `Object` class, it can have far-reaching effects on your code. For example, `send` is an instance method that all classes inherit from `Object`. 

If you defined a new `send` instance method in your class, __all objects of your class will call your custom `send` method__, instead of the one in class `Object`, which is probably the one they mean to call. `Object#send` serves as a way to call a method by passing it a symbol or a string which represents the method you want to call. The next couple of arguments will represent the method's arguments, if any.
```ruby
son = Child.new
son.send :say_hi
# => "Hi from Child."
```
Let's see what happens when we define a `send` method in our `Child` class and then try to invoke Object's `send` method:
```ruby
class Child
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end
end

lad = Child.new
lad.send :say_hi
# => ArgumentError: wrong number of arguments (1 for 0) from (pry):12:in `send'
```
In our example, we're passing `send` one argument even though our overridden `send` method does not take any arguments. 

Let's take a look at another example by exploring `Object`'s `instance_of?` method. What this handy method does is to return `true` if an object is an instance of a given class and `false` otherwise.
```ruby
c = Child.new
c.instance_of? Child
# => true

c.instance_of? Parent
# => false
```
Let's temporarily override `instance_of?` within our class:
```ruby
class Child
  # other methods omitted

  def instance_of?
    p "I am a fake instance"
  end
end

heir = Child.new
heir.instance_of? Child
# => ArgumentError: wrong number of arguments (1 for 0) from (pry):22:in `instance_of?'
```
One `Object` instance method that's easily overridden without any major side-effect is the `to_s` method. You'll normally want to do this when you want a different string representation of an object. 
