# Inheritance

## Table of Contents
- [Class Inheritance](#class-inheritance)
- [super](#super)
- [Mixing in modules](#mixing-in-modules)

### Class Inheritance
Inheritance is when a class *inherits behavior from another class*. The class that is inheriting behavior is called the __subclass__ and the class it inherits from is called the __superclass__.

We use inheritance as a way to extract common behaviors from classes that share that behavior, and move it to a superclass. This lets us keep logic in one place. 

Here, we're extracting the `speak` method to a superclass `Animal`, and we use inheritance to make that behavior available to `GoodDog` and `Cat` classes.

```
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
=> Hello!

puts paws.speak
=> Hello!
```
We use the `<` symbol to signify that the `GoodDog` class is inheriting from the `Animal` class. This means that all of the methods in the `Animal` class are available to the `GoodDog` class for use. We also created a new class called `Cat` that inherits from `Animal` as well. We've eliminated the `speak` method from the `GoodDog` class in order to use the `speak` method from `Animal`.

What if we want to use the original `speak` method from the `GoodDog` class only?
```
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
=> Hello!
```
In the `GoodDog` class, we're overriding the `speak` method in the `Animal` class because Ruby checks the object's *class* __first__ for the method __before__ it looks in the superclass. 

That means when we wrote the code `sparky.speak`, Ruby first looked at the `sparky` class, which is `GoodDog`. It found the `speak` method there and used it. When we wrote the code `paws.speak`, Ruby first looked at the `paws` class, which is `Cat`. It __did not__ find a `speak` method there, so it continued to look in `Cat`'s superclass, `Animal`. It found a `speak` method in `Animal`, and used it.

Inheritance can be a great way to remove duplication in your code base. There is an acronym that you'll see often in the Ruby community, "DRY". This stands for *"Don't Repeat Yourself"*. It means that if you find yourself writing the same logic over and over again in your programs, there are ways to extract that logic to one place for reuse.

### `super`
Ruby provides us with the `super` *keyword* to call methods *earlier* in the method lookup path. When you call `super` from within a method, it searches the method lookup path for a method with the same name, then invokes it.
```
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
=> "Hello! from GoodDog class"
```
We've created a simple `Animal` class with a `speak` instance method. We then created `GoodDog` which subclasses `Animal` also with a `speak` instance method to *override the inherited version*. However, in the subclass `speak` method we use `super` to invoke the `speak` method from the superclass, `Animal`, and then we __extend the functionality__ by appending some text to the return value.

Another more common way of using `super` is with `initialize`. 
```
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
=> #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">
```
In this example, we're using `super` with no arguments. However, the `initialize` method, where `super` is being used, takes an argument and adds a new twist to how `super` is invoked. Here, in addition to the default behavior, `super` __automatically forwards the arguments__ that were passed to the method from which `super` is called (`initialize` method in `GoodDog` class). 

At this point, `super` will pass the `color` argument in the `initialize` defined in the subclass to that of the `Animal` superclass and invoke it. That explains the presence of `@name="brown"` when the `bruno` instance is created (i.e. the instance `initialize` method is using the argument as the value for __both__ the `name` and `color` instance variables). Finally, the subclass' `initialize` continues to set the `@color` instance variable. 

Note that passing a second argument to `GoodDog.new("brown")` will raise an `ArgumentError`, because the class `initialize` method in the `Animal` superclass is not equipped to take a second argument, and the instance method `initialize` in the `GoodDog` class also is not equipped to take a second argument. 

When called with specific arguments, eg. `super(a, b)`, the specified arguments will be sent up the method lookup chain.
```
class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear")
=> #<BadDog:0x007fb40b2beb68 @age=2, @name="bear">
```
This is similar to our previous example, with the difference being that `super` takes an argument, hence the *passed in argument is sent to the superclass*. Consequently, when a `BadDog` class is created, the passed in `name` argument ("bear") is passed to the superclass and set to the `@name` instance variable.

If you call `super()` exactly as shown -- with parentheses -- it calls the method in the superclass with __no arguments at all__. If you have a method in your superclass that takes *no arguments*, this is the safest -- and sometimes the only -- way to call it.
```
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
=> #<Bear:0x007fb40b1e6718 @color="black">
```
If you forget to use the parentheses here, Ruby will raise an `ArgumentError` exception since the number of arguments is incorrect.

### Mixing in modules
Another way to DRY up your code in Ruby is to use __modules__. 
