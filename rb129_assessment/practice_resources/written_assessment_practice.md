# RB129 Written Assessment Practice Questions

## Table of Contents
- [OOP & Reading Code](#OOP-&-Reading-Code)
- [Classes, objects, encapsulation, working with collaborator objects, method access control](#Classes-objects-encapsulation-working-with-collaborator-objects-method-access-control)


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

### Classes, objects, encapsulation, working with collaborator objects, method access control
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
An instance variable is a variable scoped at an object level (meaning it is accessible to all instance methods, even though it's defined outside any given instance method). It is denoted by a `@` symbol in front of it. They are *named* by the class, but are not created by the class - they are created when an object is instantiated from a class and a value is assigned to it (an instance variable that does not have a value assigned to it is _not_ part of that object's state). When instance variables are initialised and assigned an object, they become part of an object's state. As instance variables are part of the state the object carries, they cannot be inherited. 

In our below example, the `initialize` method in our `Dog` class can take a `fur` argument when an object is instantiated. However, because we have not initialised an instance variable for `fur`, it does not become part of `ted`'s state, even though we have created a getter method. If we attempt to call `ted.fur`, we will get `nil` - uninitialized instance variables return `nil`. 
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
An instance method is a method defined by a class that adds functionality to objects when those objects are instantiated from that class, depending on the method access control over those instance methods (by default, instance methods are public). Instance methods can be inherited, and all instances of a class will have access to the same set of instance methods.

In our example below, we have defined a `bark` instance method in the `Dog` class (denoted by the `def`...`end` keyword pairs). We then instantiate two objects from `Dog`, `bob` and `ted`. While they are two different objects, as they are instantiated from the same class, they both have access to the public instance method `bark`. 
```
class Dog
  def bark
    "Woof!"
  end
end

ted = Dog.new
bob = Dog.new

puts ted.bark
# => Woof!

puts bob.bark
# => Woof!
```
*10) What is the scoping rule for instance variables?*
Instance variables are scoped at the object level. This means that when an object is instantiated from the class (and the instance variables created and assigned values), the instance methods defined by that class will have access to those instance variables, even though those instance variables are defined outside of the instance methods. 

In this example, we can see that the `say_name` method has access to the `@name` instance variable, despite `@name` being defined outside of that method and the `say_name` not taking any arguments.
```
class Dog
  def initialize(name)
    @name = name
  end

  def say_name
    puts "My name is #{@name}!"
  end
end

ted = Dog.new("Ted")
ted.say_name
# => "My name is Ted!"
```
*11) How do you see if an object has instance variables?*
We can call the `Object#instance_variables` method on an object to return an array of instance variables cast as symbols. 

*12)What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?*
A class can be thought of as a template from which objects can be instantiated. A class can contains various methods (either defined within the class, inherited from superclasses or mixed in from modules), which can be thought of as behaviours that the object will have, or ways to interact with the object. A class also names instance variables, but does not define them (this occurs upon instantiation of an object from the class). By naming these instance variables within the class definition, the class determines what data the object should have (but again, these instance variables are not created until the object is instantiated from the class). 

We can define a class by using the `class`...`end` keyword pair. We define instance methods using the regular `def`...`end` reserved words within the class definition. We can also name instance variables - in our example, we have named the `@name` instance variable to be defined on instantiation through the `initialize` method, which expects an argument when a new object is created from `Dog`. 
```
class Dog
  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof!"
  end
end
```
*13) When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?*
When speaking to *behaviours* of a class, we are usually referring to the instance methods that are defined within the class. These instance methods are the way in which we can attach functionality to objects instantiated from that class. Since instance methods are defined with the class, they can be inherited. Objects can share behaviours (as they are defined on the class), but do not share state (which is defined at the object level). 

*State* refers to the instance variables and their values that are unique to each object. Instance variables are typically *named* by the class (e.g. the class can allow for instance variables to be created on instantiation of an object), but are __not defined__ by the class - these instance variables are only defined when an object is instantiated from a class and a value assigned to them. As such, instance variables (and by extension, state) cannot be inherited as they are not defined within the class. 

In this example, when we instantiate the `ted` object from the `Dog` class, we pass the `"Teddy"` and `4` objects respectively to the `initialize` method as arguments, where they are assigned to the `@name` and `@age` instance variables respectively. These instance variables represent the object's state, while the behaviour of the `ted` object is defined in the `Dog` class - specifically the instance method `bark`.
```
class Dog
  def initialize(name, age)
    @name = name
    @age = age
  end

  def bark
    puts "Woof!"
  end
end

ted = Dog.new("Teddy", 4)
ted.bark
# => Woof!
```
*14) How do objects encapsulate state?*
State is the set of instance variables and their values that are associated with a given object. State is 'encapsulated' by objects, as by default, the series of instance variables that comprise state cannot be accessed unless there are appropriate getter/setter methods; so there is a degree of data protection typically associated with encapsulation. Also, state is unique to each object - it cannot be shared between objects (nor are there dependencies between objects for state) from the same class like instance methods can, so there is a degree of separation that is characteristic of encapsulation.

In our example below, when we instantiate the `ted` object from the `Dog` class, the `initialize` method is called, which we pass the string `"Teddy"` as an argument. This is assigned to the instance variable `@name` and becomes part of the `ted` object's state. This state is unique to `ted` and will be different to other objects instanted from `Dog`. As we have not defined any getter or setter methods, the `@name` instance variable is inaccessible, and is protected from any access or changes. 
```
class Dog
  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
```
*15) What is the difference between classes and objects?*
Classes act as templates for objects. Classes define the behaviours (instance methods) that objects will have once they are instantiated from classes (which could be through inheritance, mixed in modules, or simply defined in the class), and shape the state of the object (when the object is created, the `initialize` method creates instance variables and assigns objects passed as arguments to it as values for those instance variables, which taken together, comprise state). Objects can share behaviours from the same class, but are still distinct objects (as they have unique state, unless when the objects are instantiated, the arguments passed in are the exact same object).
```
class Dog
  def initialize(name)
    @name = name
  end
end

name = "Teddy"
name1 = name

a = Dog.new(name)
# => #<Dog:0x00007f9374a40c90 @name="Teddy">

# b is a different object, since "Teddy".object_id != name.object_id
b = Dog.new("Teddy")
# => #<Dog:0x00007f9374a482d8 @name="Teddy">

# c is the same object as a, since name1.object_id == name.object_id (i.e. same object)
c = Dog.new(name1)
# => #<Dog:0x00007f9374a40c90 @name="Teddy">
```

*16) How can we expose information about the state of the object using instance methods?*
State comprises of the instance variables and their assigned values of an object. By default, without instance methods, instance variables are inaccessible outside the object. However, we can access state by defining getter and setter instance methods in the class to access those instance variables. 
```
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
ted.name
# => "Teddy"
```
*17) What is a collaborator object, and what is the purpose of using collaborator objects in OOP?*
Collaborator objects are objects that are assigned to instance variables when objects are instantiated from a class. Functionally, they could be any object, whether they are custom objects we define, or objects pre-defined by the Core API in Ruby (e.g. Integer, String, Array objects). Collaborator objects allow us to model associative relationships ("has-a") between objects and define how those objects should interact with other objects. The collaborative relationship exists when the collaborator object is added to the state of the object (through assigning it as a value to an instance variable).

In our example, when we instantiate the `ted` object from the `Dog` class with the `Class#new` method, the `initialize` method is called, which we pass the string object `"Teddy"`. As this object is instantiated, the string object `"Teddy"` becomes part of `ted`'s state (i.e. `"Teddy"` is assigned to the `@name` instance variable). At this point, the associative relationship exists (the `ted` object "has a" name) and `"Teddy"` is a collaborator object with the `ted` object.
```
class Dog
  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
```
