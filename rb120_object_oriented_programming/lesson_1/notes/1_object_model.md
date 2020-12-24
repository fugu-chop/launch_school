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

### Key Concepts
#### Encapsulation 
__Encapsulation__ is hiding pieces of functionality and making it unavailable to the rest of the code base. It is a form of data protection, so that data cannot be manipulated or changed without obvious intention. 

It is what defines the boundaries in your application and allows your code to achieve new levels of complexity. Ruby, like many other OO languages, accomplishes this task by creating objects, and exposing interfaces (i.e., methods) to interact with those objects.

Another benefit of creating objects is that they allow the programmer to think on a new level of abstraction. Objects are represented as real-world nouns and can be given methods that describe the behavior the programmer is trying to represent.

#### Polymorphism
__Polymorphism__ is the ability for different types of data to respond to a common interface. For instance, if we have a method that expects argument objects that have a `move` method, we can pass it any type of argument, provided it has a compatible `move` method. 

The object might represent a human, a cat, a jellyfish, or, conceivably, even a car or train. That is, it lets objects of different types respond to the same method invocation. OOP gives us flexibility in using pre-written code for new purposes.

#### Inheritance
__Inheritance__ is used in Ruby where a class inherits the behaviors of another class, referred to as the *superclass*. This gives Ruby programmers the power to define basic classes with large reusability and smaller __subclasses__ for more fine-grained, detailed behaviors.

Another way to apply polymorphic structure to Ruby programs is to use a `Module`. Modules are similar to classes in that they contain shared behavior. However, you __cannot create an object with a module__. A module must be mixed in with a class using the `include` method invocation. This is called a `mixin`. After mixing in a module, the behaviors declared in that module are available to the class and its objects.

### What is an object?
Objects are created from classes. Think of classes as molds and objects as the things you produce out of those molds. Individual objects will contain different information from other objects, yet they are instances of the same class. 

Anything that can be said to have a value is an object: that includes numbers, strings, arrays, and even classes and modules. However, there are a few things that are not objects: methods and blocks are two that stand out.

Here's an example of two objects of the `String` class:
```
"hello".class
=> String

"world".class
=> String
```
We use the `class` instance method to determine what the class is for each object. So far, everything we've been using, from strings to integers, are in fact objects, which are instantiated from a class. 

### What is a class?
Ruby defines the attributes and behaviors of its objects in classes. You can think of classes as basic outlines of what an object should be made of and what it should be able to do. 

To define a class, we use syntax similar to defining a method. We replace the `def` with `class` and use the `CamelCase` naming convention to create the name. We then use the reserved word `end` to finish the definition. 

Ruby file names should be in `snake_case`, and reflect the class name. In the below example, the file name is `good_dog.rb` and the class name is `GoodDog`.
```
class GoodDog
end

sparky = GoodDog.new
```
We created an __instance__ of our `GoodDog` class and stored it in the variable `sparky`. We now have an __object__. We say that `sparky` is _an object or instance of class `GoodDog`_. This entire workflow of creating a new object or instance from a class is called __instantiation__, so we can also say that we've instantiated an object called `sparky` from the class `GoodDog`. 

The terminology in OOP is something you'll eventually get used to, but the important fact here is that an object is returned by calling the class method `new`.

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
When you call a method, how does Ruby know where to look for that method? Ruby has a distinct lookup path that it follows each time a method is called. Let's use our program from above to see what the method lookup path is for our `GoodDog` class. We can use the `ancestors` method on any class to find out the method lookup chain.
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
The `Speak` module is placed right in between our custom classes (i.e., `GoodDog` and `HumanBeing`) and the Object class that comes with Ruby. In __Inheritance__ you'll see how the method lookup chain works when working with both mixins and class inheritance.

This means that since the `speak` method is not defined in the `GoodDog` class, the next place it looks is the `Speak` module. This continues in an ordered, linear fashion, until the method is either found, or there are no more places to look.
