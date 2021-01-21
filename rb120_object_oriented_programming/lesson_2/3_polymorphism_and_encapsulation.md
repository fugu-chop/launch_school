# Polymorphism and Encapsulation

## Table of Contents
- [Polymorphism](#polymorphism)
- [Encapsulation](#encapsulation)

### Polymorphism
*Polymorphism* refers to the ability of objects with __different types to respond in different ways to the same message (or method invocation)__; that is, data of different types can respond to a common interface (i.e. *method*). It's a crucial concept in OO programming that can lead to more maintainable code.

When two or more object types have a *method with the same name*, we can invoke that method with *any* of those objects. When we don't care what type of object is calling the method (e.g. different objects instantiated from different classes), we're using polymorphism. Often, polymorphism involves inheritance from a common superclass. However, inheritance isn't necessary as we'll see in this assignment.

For example, assume we have a method that expects an argument that has a `move` method. We can pass it any type of argument, provided it has a compatible `move` method. The object might represent a human, a cat, a jellyfish, or, conceivably, even a car or train. That is, it lets objects of different types respond to the same method invocation.

There are several ways to implement polymorphism.

#### Polymorphism through inheritance
```
class Animal
  def eat
    # generic eat method
  end
end

class Fish < Animal
  def eat
    # eating specific to fish
  end
end

class Cat < Animal
  def eat
     # eat implementation for cat
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Cat.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end
```
Looking at this example, we can see that every object in the array is a different animal, but the client code can treat them all as a generic animal, i.e., an object that can eat. Thus, the public interface lets us work with all of these types in the same way even though the implementations can be dramatically different. That is polymorphism in action.

#### Polymorphism through duck-typing
We can also implement polymorphism through __duck typing__. Duck typing in Ruby doesn't concern itself with the class of an object; instead, it concerns itself with __what methods are available__ on the object. If an object "quacks" like a duck, then we can treat it like a duck. In other words, we are interested in *what the object can do*, rather than with what the object __is__.

Here's an example of attempting to apply polymorphism **without** duck typing. __Don't use this approach__. The problem with this approach is that the `prepare` method has *too many dependencies*. It relies on *specific classes and their names*. It also needs to know which method it should call on each of the objects, as well as the argument that those methods require. 
```
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end
```
If you change anything within those classes that impacts `Wedding#prepare`, you need to refactor the method. For instance, if we need to add another wedding preparer, we must add another case statement. Before long, the method will become long and messy.

We can clean up the code using duck-typing:
```
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      # self refers to an object instantiated from the Wedding class - per our rules about self when used in an instance method, which is what we would pass to the preparers block parameter - e.g. Chef.prepare_wedding(self)
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end
```
We can see that there is no inheritance in this example, but we still have polymorphism. Each class must define a `prepare_wedding` method and implement it in its own way. If we must add another preparer, we can create another class and just implement `prepare_wedding` to perform the appropriate actions.

Essentially, for an object instantiated from the `Wedding` class, once we pass in some `preparers` to the `prepare` method, Ruby will try apply the `prepare_wedding` method to each of the objects passed into `preparers`, __hoping__ that that object has an applicable method. 

### Encapsulation
Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need. We can use *method access control* to expose these properties and methods through the public (or external) interface of a class: its public methods. 

An example of encapsulation can be found in the contrast between:
- *Local* variables, which can be freely accessed and reassigned.
- *Instance* variables, which can have read or write access restricted. 

Here's an example of method access control:
```
class Dog
  attr_reader :nickname

  def initialize(n)
    # This also works with self.nickname since we've defined attn_writer :nickname
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private
  
  attr_writer :nickname
end

dog = Dog.new("rex")
dog.change_nickname("barny") # changed nickname to "barny"
puts dog.greeting 
=> Barny says Woof Woof!
```
In this example, we can change the nickname of a dog by calling the `change_nickname` method without needing to know how the `Dog` class and this method are implemented.

The same thing happens when we call the method `greeting` on a `Dog` object. The output is "Barny says Woof Woof!", with the dog's nickname capitalized. Again, we don't need to know how the method is implemented. The main point is that we expect a greeting message from the dog and that's what we get.

Note that the setter method for `nickname` is private: it is not available outside of the class and `dog.nickname = "barny"` would raise an error.

You might have noticed that even though the setter method for `nickname` is private we are still calling it with `self` prepended on line 9, `self.nickname = n`. This is an exception in Ruby. You need to use `self` when calling private setter methods as if you didn't use `self` Ruby would think you are creating a local variable.

On a final note, always keep in mind that the class should have _as few public methods as possible_. It lets us simplify using that class and protect data from undesired changes from the outer world.
