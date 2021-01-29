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
__Encapsulation__: Encapsulation is the hiding of functionality within code, making it unavailable to the rest of the code base. It is a form of data protection, such that data cannot be changed or manipulated without obvious intent. Encapsulation allows us to contain functionality to certain parts of code (in our case, this is mostly objects and classes), which can reduce the amount of dependencies, since one changing one part of the program is less likely to affect all other parts. 

We can achieve encapsulation by instantiating objects from classes. Within those objects, we have instance variables and instance methods that are encapsulated within the object, and can only be accessed by that object's class or the object itself, meaning that the effect of changes to the code are more likely to be contained to specific classes and objects, improving our ability to debug and reducing dependencies.

In our example below, any changes we make to `Dog` is contained entirely to that class, reducing the likelihood that code involving any other objects that collaborate with objects instantiated from the `Dog` class will break if we change `Dog`. The `@name` instance variable is encapsulated within the `ted` object - there is no ability defined within the code to change or access that instance variable. 
```
class Dog
  def initialize(name)
    @name = name
  end
end

ted = Dog.new('Ted')
```
We can also achieve encapsulation through *method access control*, which allows to to control which interfaces (i.e. instance methods) can interact with the object, such that even the object itself might not have access to certain instance methods. Public interfaces allow methods to be called *directly on the object itself*, whereas private interfaces can only be called *within* the class (i.e. they are not callable directly on the object itself, rather only through other methods within the class). 

In the below example, we are encapsulating various instance methods within the `Hello` class, such that only objects instantiated from the `Hello` class have access to these instance methods. We are also using *method access control* via the `private` keyword to ensure that even objects instantiated from the `Hello` class cannot call the `private_method` directly. 
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
Within Ruby, anything that can said to have a value can be regarded as an object (this excludes constructs like variables, methods and blocks). In general, objects are instances of classes that have been initialised using the `Class#new` method. Objects encapsulate *state*, which are the series of instance variables and their values which define them as different from other objects instantiated from the same class. 

*7) How do you initialise a new object/create a new instance of a class? What is instantiation?*