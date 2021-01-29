# RB129 Written Assessment Practice Questions

## Table of Contents
- [OOP & Reading Code](#OOP-&-Reading-Code)
- [Classes, objects, encapsulation, working with collaborator objects, method access control](#OOP-&-Reading-Code)


### OOP & Reading Code
*1) What is OOP and why is it important?*
OOP (Object Oriented Programming) is a programming paradigm that is designed to handle large scale, complex programs by breaking up code into a series of smaller parts that interact with each other, rather than code that is built on a chain of dependencies. By using OOP, it allows code that has fewer dependencies and is easier to maintain, making it less likely that a small change to a part of the code will not break the entire program. 

OOP achieves this through a number of ways, including:
- encapsulation (hiding functionality of code into objects and classes to reduce dependencies and improve data protection); 
- polymorphism (allowing different objects to interact with a common interface to improve flexibility of pre-written code); and
- inheritance (allowing classes to inherit behaviours from other classes, reducing the amount of repeated code)

*2) What is a spike?*
A spike is exploratory code designed to explore a problem domain and build an idea of how a program should be designed. The goal of a spike is to quickly validate hypotheses and not code quality. 

*3) When writing a program, what is a sign that you're missing a class?*
When writing a program, if we find we are consistently using the same noun in our methods, we could potentially abstract a lot of that functionality away into another class. 

*4) What are some rules/guidelines when writing programs in OOP?*
It's generally a good idea to:
- Expose as few public interfaces as possible in order to achieve strong data protection within our objects
- Have classes that interact with a few other classes through collaboration, rather than having all classes collaborate with all other classes (which introduces too many dependencies, something that OO tries to avoid in the first place)
- Not to include the class name in instance methods, which reduces human readability of code
- Avoid long method invocation chains, as these are both difficult to read, and introduce dependencies on methods earlier in the chain returning expected results. 
- Use setter methods, rather than work directly with instance variables, as working directly with instance variables bypasses any logic or guards we might apply within a setter method

*5) What is encapsulation? How does encapsulation relate to the public interface of a class?*
__Encapsulation__: Encapsulation is the hiding of functionality within code, making it unavailable to the rest of the code base. It is a form of data protection, such that data cannot be changed or manipulated without obvious intent. Encapsulation allows us to contain functionality to certain parts of code (through objects and classes), which can reduce the amount of dependencies, since we generally make changes to code specified within classes (rather than throughout the code). 

Encapsulation can be achieved by instantiating objects from classes. Within those objects, we have instance variables (created on instantiation of objects when assigned a value) and instance methods (defined in the class) that are encapsulated within the object, and can only be accessed by that object's class or the object itself. This improves our ability to debug when we make changes to code and reduce the number of dependencies on/from other parts of the code base.

In our example below, any changes we make to `Dog` (or objects instantiated from `Dog`) is made specifically to that class, meaning any errors we get in relation `Dog` or objects instantiated from `Dog` can likely be resolved in a single location in our code, even though there is a collaborative relationship between `peter` and `ted`.

The `@pet_name` instance variable is also encapsulated within the `ted` object - there is no ability defined within the code to change or access that instance variable. Similarly, `ted` does not have access to the `Human#speak` method, since that method is defined and encapsulated in the `Human` class.
```
class Human
  def initialize(name, pet)
    @name = name
    @pet = pet
  end

  def speak
    "Hello from #{@name}!"
  end
end

class Dog
  def initialize(pet_name)
    @pet_name = pet_name
  end

  def bark
    "Woof!"
  end
end

ted = Dog.new('Ted')
peter = Human.new('James', ted)
```
We can also achieve encapsulation through *method access control*, which allows to to control which interfaces (i.e. instance methods) can interact with the object, such that even the object itself might not have access to certain instance methods. Public interfaces allow methods to be called *directly on the object itself*, whereas private interfaces can only be called *within* the class (i.e. they are not callable directly on the object itself, rather only through other methods within the class). 

In the below example, we are defining various instance methods within the `Hello` class, such that only objects instantiated from the `Hello` class have access to these instance methods. We are also using *method access control* via the `private` keyword to ensure that even objects instantiated from the `Hello` class cannot call the `private_method` directly. 
```
class Hello
  def public_method
    "Hello, I'm a public method and can be called outside of the class!"
  end

  private

  def private_method
    "I'm a private method!"
  end
end

Hello.new.public_method
# => "Hello, I'm a public method and can be called outside of the class!"

Hello.new.private_method
# => NoMethodError (private method `private_method' called for #<Hello:0x00007f86781646c0>)
```

*6) What is an object?*
Within Ruby, anything that can said to have a value can be regarded as an object (this excludes constructs like variables, methods and blocks). In general, objects are instances of classes that have been initialised using the `Class#new` method. Objects encapsulate *state*, which are the set of instance variables and their values which distinguish them from other objects instantiated from the same class. 

*7) How do you initialise a new object/create a new instance of a class? What is instantiation?*
Instantiation is creating an object (or an *instance*) from a predefined class. We can instantiate an object by calling the `Class.new` method on a class, passing in any arguments that are required per the `initialize` method that is automatically called when a new object is instantiated. 

We can see this in the example below. We have a predefined `Dog` class (denoted by the `class`...`end` keyword pair), from which we instantiate a new object by calling `Dog.new('Teddy')` and assign it to the local variable `teddy`. After calling the `Class#new` method, this creates an instance of the `Dog` class and automatically calls the `initialize` method, which accepts an argument (a string object `"Teddy"`) and assigns it to the instance variable `@name`, denoted by the `@` symbol.
```
class Dog
  def initialize(name)
    @name = name
  end
end

teddy = Dog.new('Teddy')
```
*8) What is an instance variable, and how is it related to an object?*
An instance variable is a variable scoped at an object level. It is denoted by a `@` symbol in front of it. They are *named* by the class, but are not created by the class - they are created when an object is instantiated from a class and a value is assigned to it (an instance variable that does not have a value assigned to it is _not_ part of that object's state). When instance variables are initialised and assigned an object, they become part of an object's state. As instance variables are part of the state the object carries, they cannot be inherited. 

In our below example, the `initialize` method in our `Dog` class can take a `fur` argument when an object is instantiated. However, because we have not initialised an instance variable for `fur`, it does not become part of `ted`'s state, even though we have created a getter method. If we attempt to call `ted.fur`, we will get `nil` - uninitialized isntance variables return `nil`. 
```
class Dog
  attr_reader :fur

  def initialize(name, fur)
    @name = name
  end
end

ted = Dog.new('Teddy', 'Bushy')
```
*9) What is an instance method, and how is it related to an object?*

*10) What is the scoping rule for isntance variables?*