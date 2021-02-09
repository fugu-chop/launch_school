# The Object Model

## Table of Contents
- [What is OOP?](#what-is-oop)
- [Key Concepts](#key-concepts)
- [What is an object?](#what-is-an-object)
- [What is a class?](#what-is-a-class)
- [Modules](#modules)

### What is OOP?
Object Oriented Programming (OOP) is a way for programmers to create containers for data that could be changed and manipulated without affecting the entire program. 

They needed a way to section off areas of code that performed certain procedures so that their programs could become the interaction of many small parts, as opposed to one massive blob of dependency.

Benefits of OOP include:
- Large, complex programs can be difficult to maintain due to dependencies throughout the program. OOP lets programmers write programs in which the different parts of the program interact, thus reducing dependencies and facilitating maintenance.
- Coding in a non-OO way often means writing code that is useful solely within a single context. Defining basic classes and leveraging concepts like inheritance to introduce more detailed behaviors provides a greater level of reusability and flexibility.
- Complex coding problems are often difficult to break down and solve in a clear and systematic way. Using OOP to model classes appropriate to the problem, and using real-world nouns to represent objects, lets programmers think at a higher level of abstraction that helps them break down and solve problems.

### Key Concepts
#### Encapsulation 
*Encapsulation* is hiding pieces of functionality and making it unavailable to the rest of the code base. It is a form of data protection, so that data cannot be manipulated or changed without obvious intention. 

It is what defines the boundaries in your application and allows your code to achieve new levels of complexity. Ruby, like many other OO languages, accomplishes this task by creating objects, and exposing interfaces (i.e., methods) to interact with those objects.

Through the use of _objects_ instantiated from classes, we can create _instance variables_ and _instance methods_ that are encapsulated within those objects and thus only accessed by either the object’s class or the object itself, but nothing else. Through the use of _method access control_, we can even further encapsulate these so that even the object itself does not have access to them.

Each object _encapsulates its own state_ (as each object has a unique state). The methods (or behavior) are defined in the class and all objects of the class have access to them. Encapsulation works through the use of objects, and _exposing interfaces to interact with those objects_.

Another benefit of creating objects is that they allow the programmer to think on a new level of abstraction (also known as *indirection*), which allows us to think at a *higher level* instead of implementation details upfront. Objects are represented as real-world nouns and can be given methods that describe the behavior the programmer is trying to represent.

Encapsulation is a kind of abstraction that involves containing all the data and functionality for part of your program within a single construct, and exposing an interface for that construct.

We can regard abstraction as the hiding or disregarding of unnecessary detail (implementation details), focusing on how something works to focus on what it does. 

#### Polymorphism
*Polymorphism* is the ability for different types of data (_different objects_) to respond to a common interface (a _method_ that has the same name). It lets *objects of different types (could be the same or different classes) respond to the same method invocation* - e.g. we might have many different objects, but all of them have a `move` instance method. This, however, doesn't imply that the `move` method does the same thing for all objects - rather that there simply __is__ a `move` method among all of those objects. Polymorphism gives us flexibility to use the same code for different purposes (see our `each` method call in the example below). 

Another way to apply polymorphic structure to Ruby programs is to use a `Module`. This is known as _interface inheritance_ but is also a form of polymorphism. Modules are similar to classes in that they contain shared behavior. However, you __cannot instantiate an object from a module__. 

A module must be mixed in with a class using the `include` method invocation. This is called a `mixin` (i.e. a module that has been used to mix in functionality into a class is a `mixin`). After mixing in a module, the behaviors declared in that module are available to the class and its objects.

The third way of achieving polymorphism is through using __duck typing__. As an aside, duck-typing is not possible in statically typed languages, because you have to __declare the type (i.e. object) of each param/variable/return value__. Preventing duck typing is a big part of static typing (we want to avoid different objects being funneled into a method).

In our below example, none of the classes or objects created are related to each other. However, each of the objects have a `speak` method, which is why we can loop through each object and run the same method (despite the method returning completely different objects from different classes). 
```
class Dog
  def speak
    "Bark"
  end
end

class Cat
  def speak
    true
  end
end

class Fish
  def speak
    99
  end
end

[Dog.new, Cat.new, Fish.new].each do |animal|
  puts animal.speak
end
```
#### Inheritance
*Inheritance* is used in Ruby where a class inherits the behaviors of another class, referred to as the *superclass*. This gives Ruby programmers the power to define basic classes with large reusability and smaller __subclasses__ for more fine-grained, detailed behaviors (methods).

### What is an object?
Objects are created from classes. Think of classes as __molds__ and objects as the things you produce out of those molds. Individual objects will contain different information from other objects, yet they are instances of the same class. Objects instantiated from the same class are distinct and different objects to each other. 

__Anything that can be said to have a value is an object__ - that includes numbers, strings, arrays, and even classes (custom classes are just instances of the `class` Class) and modules. However, there are a few things that are __not__ objects: *variables* (which are __pointers__ to objects), *methods* and *blocks* are several that stand out.

Here's an example of two objects of the `String` class:
```
"hello".class
=> String

"world".class
=> String
```
We use the `class` instance method to determine what the class is for each object. So far, everything we've been using, from strings to integers, are in fact objects, which are instantiated from a class. 

### What is a class?
Ruby defines the *attributes and behaviors* of its objects in *classes*. You can think of classes as basic __outlines__ of what an object should be made of and what it should be able to do. 

To define a class, we use syntax similar to defining a method. We replace the `def` with `class` and use the `CamelCase` naming convention to create the name. We then use the reserved word `end` to finish the definition. 

Ruby file names should be in `snake_case`, and reflect the class name. In the below example, the file name is `good_dog.rb` and the class name is `GoodDog`.
```
class GoodDog
end

sparky = GoodDog.new
```
We created an __instance__ of our `GoodDog` class and stored it in the variable `sparky`. We now have an __object__. We say that `sparky` is _an object or instance of class `GoodDog`_. This entire workflow of creating a new object or instance from a class is called __instantiation__, so we can also say that we've instantiated an object called `sparky` from the class `GoodDog`. 

The important fact here is that __an object is returned by calling the class method `new`__.

![Class Instance Diagram](https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/class_instance_diagram.jpg)

### Modules
A module is a _collection of behaviors that is usable in other classes_ via __mixins__. A module is "mixed in" to a class using the `include` method invocation. 
```
module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!") 
=> Arf!

bob = HumanBeing.new
bob.speak("Hello!")
=> Hello!
```
Both the `GoodDog` object, which we're calling `sparky`, as well as the `HumanBeing` object, which we're calling `bob`, have access to the `speak` _instance method_. This is possible through "mixing in" the module `Speak`. It's as if we copy-pasted the `speak` method into the `GoodDog` and `HumanBeing` classes.

#### Method Lookups
Ruby has a distinct lookup path that it follows each time a method is called. We can use the `ancestors` method on any class to find out the method lookup chain.
```
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors

---GoodDog ancestors---
GoodDog
Speak
Object
Kernel
BasicObject

---HumanBeing ancestors---
HumanBeing
Speak
Object
Kernel
BasicObject
```
The `Speak` module is placed right in between our custom classes (i.e., `GoodDog` and `HumanBeing`) and the Object class that comes with Ruby. 

This means that since the `speak` method is not defined in the `GoodDog` class, the next place it looks is the `Speak` module. This continues in an ordered, linear fashion, until the method is either found, or there are no more places to look.

The method lookup follows the *trail of superclasses* (or ancestors).
