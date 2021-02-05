# RB129 Written Assessment Practice Questions

## Table of Contents
- [OOP & Reading Code](#OOP-&-Reading-Code)
- [Classes, objects, encapsulation, working with collaborator objects, method access control](#Classes-objects-encapsulation-working-with-collaborator-objects-method-access-control)
- [Polymorphism, inheritance, method lookup path, duck-typing](#Polymorphism-inheritance-method-lookup-path-duck-typing)
- [Getters and Setters](#getters-and-setters)
- [Instance methods, class methods, self](#Instance-methods-class-methods-self)
- [Fake operators and equality](#fake-operators-and-equality)

### OOP & Reading Code
*1) What is OOP and why is it important?*
OOP (Object Oriented Programming) is a programming paradigm that is designed to handle large scale, complex programs by breaking up code into a series of smaller parts that interact with each other, rather than code that is built on a chain of dependencies. By using OOP, we enable code that has fewer dependencies and is easier to maintain, making it less likely that a small change to a part of the code will not break the entire program. 

OOP achieves this through a number of ways, including:
- encapsulation (abstracting away code into objects and classes to reduce dependencies of one part of the code on structural details of another, such that a class should contain common methods it needs to function without having to rely on a number of other classes, as well as improve data protection); 
- polymorphism (allowing different objects to interact with a common interface to improve flexibility of pre-written code); and
- inheritance (allowing classes to inherit behaviours and class/constant variables from other classes, reducing the amount of repeated code)

*2) What is a spike?*
A spike is exploratory code designed to explore a problem domain and build an idea of how a program should be designed. The goal of a spike is to quickly validate hypotheses and not code quality. 

*3) When writing a program, what is a sign that you're missing a class?*
When writing a program, if we find we are consistently using the same noun in our methods, we could potentially abstract a lot of that functionality away into another class. 

*4) What are some rules/guidelines when writing programs in OOP?*
It's generally a good idea to:
- Expose as few public interfaces as possible in order to achieve strong data protection within our objects and reduce the chance of inadvertantly changing the state of objects.
- Have classes that interact with a few other classes through collaboration, rather than having all classes collaborate with all other classes (which introduces too many dependencies, something that OO tries to avoid in the first place).
- Not to include the class name in instance methods, which reduces human readability of code
- Avoid long method invocation chains, as these are both difficult to read, and introduce dependencies on methods earlier in the chain returning expected results. 
- Use setter methods, rather than work directly with instance variables, as working directly with instance variables bypasses any logic or guards we might apply within a setter method.

### Classes, objects, encapsulation, working with collaborator objects, method access control
*5) What is encapsulation? How does encapsulation relate to the public interface of a class?*
__Encapsulation__: Encapsulation is the hiding of functionality within code, making it unavailable to the rest of the code base. It is a form of data protection, such that data cannot be changed or manipulated without obvious intent. 

Encapsulation can be achieved by instantiating objects from classes. Within those objects, we have instance variables (created on instantiation of objects when assigned a value) and instance methods (defined in the class) that are encapsulated within the object, and can only be accessed by that object's class or the object itself. This improves our ability to debug when we make changes to code and reduce the number of dependencies on/from other parts of the code base by encapsulating methods that are relevant to a class as a logical entity (i.e. instead of calling methods from various classes or modules, which would introduce additional dependencies).

In our example below, any changes we make to `Dog` (or objects instantiated from `Dog`) is made specifically to that class, meaning any errors we get in relation `Dog` or objects instantiated from `Dog` can likely be resolved in a single location in our code. 

We have a collaborative relationship specified between the `Human` class and the `Dog` class through the `@pet` instance variable. 

The `@pet` instance variable is encapsulated within the created `peter` object - there is no ability defined within the code to change or access that instance variable. Similarly, the object instantiated from the `Dog` class does not have access to the `Human#speak` method, since that method is defined and encapsulated in the `Human` class. Each classes' methods are encapsulated within their respective class definitions (and not reliant on methods defined in other classes or modules to achieve functionality).
```
class Human
  def initialize(name, pet)
    @name = name
    @pet = Dog.new('Ted')
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

peter = Human.new('James', 'Teddy')
# => #<Human:0x00007fa1f120e500 @name="James", @pet=#<Dog:0x00007fa1f120e4b0 @pet_name="Teddy">>
```
We can also achieve encapsulation through *method access control*, which allows to to control which interfaces (i.e. instance methods) can interact with the object, such that even the object itself might not have access to certain instance methods. Public interfaces are methods that can be called *directly on the object itself*, whereas private interfaces can only be called *within* the class (i.e. they are not callable directly on the object itself, rather only through other methods within the class). 

In the below example, we are defining various instance methods within the `Hello` class, such that objects instantiated from the `Hello` class have access to the `public_method` instance method. We are also using *method access control* via the `private` keyword to ensure that even objects instantiated from the `Hello` class cannot call the `private_method` directly. 
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
Within Ruby, anything that can said to have a value can be regarded as an object (this excludes constructs like variables, methods and blocks). Objects are instances of classes that have been instantiated using the `Class#new` or `Class#allocate` method. Once instantiated, objects can encapsulate *state*, which are the set of instance variables and their associated values which distinguish them from other objects instantiated from the same class. 

*7) How do you initialise a new object/create a new instance of a class? What is instantiation?*
Instantiation is creating an object (or an *instance*) from a predefined class. We can instantiate an object by calling the `Class#new` method on a class, passing in any arguments that are required per the `initialize` method that is automatically called when a new object is instantiated (which creates instance variables and assigns references to values to them).

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
An instance variable is a variable scoped at an object level (meaning it is accessible to all instance methods, even though it's defined outside any given instance method). It is denoted by a `@` symbol in front of it's name. They are *named* by the class, but are not created by the class - they are created when an object is instantiated from a class and a value is assigned to it (an instance variable that does not have a value assigned to it is _not_ part of that object's state). 

When instance variables are initialised and assigned an object, they become part of an object's state. As instance variables are part of the state the object carries, they cannot be inherited (since they do not exist until an object is instantiated from a class)

In our below example, the `initialize` method in our `Dog` class can take a `fur` argument when an object is instantiated. However, because we have not initialised an instance variable for `fur`, it does not become part of `ted`'s state, even though we have created a getter method (the `initialize` method simply ignores the reference to the object passed as the `fur` argument). If we attempt to call `ted.fur`, we will get `nil` - uninitialized instance variables return `nil` (contrast this with uninitialised local variables, which return a `NameError`). 
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
An instance method is a method defined by a class that can add functionality to objects when those objects are instantiated from that class. Depending on the method access control over those instance methods (by default, instance methods are public), these methods can be called on instances of the object (`private` and `protected` instance methods cannot be directly called on the object). Instance methods can be inherited (along with any associated method access control), and all instances of a class will have access to the same set of instance methods.

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

In this example, we can see that the `say_name` method has access to the `@name` instance variable, despite `@name` being defined outside of that method and the `say_name` instance method not taking any arguments.
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
A class can be thought of as a template from which objects can be instantiated. A class can encapsulate various methods (either defined within the class, inherited from superclasses or mixed in from modules), which can be thought of as behaviours that either the class or object will have. 

A class also names instance variables, but does not create them (creation of instance variables occurs upon instantiation of an object from the class). By naming these instance variables within the class definition, the class determines what data the object should have (but again, these instance variables are not created until the object is instantiated from the class). 

We can define a class by using the `class`...`end` keyword pair. We define instance methods using the regular `def`...`end` reserved words within the class definition. We can also name instance variables - in our example, we have named the `@name` instance variable to be defined on instantiation through the `initialize` method, which expects an argument when a new object is created from `Dog` that will be assigned to the `@name` instance variable. 
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
When speaking to *behaviours* of a class, we are usually referring to the instance methods that are defined within the class. These instance methods are a way in which we can attach functionality to objects instantiated from that class. Since instance methods are defined with the class, they can be inherited. Objects can share behaviours (as they are defined on the class), but do not share state (which is defined at the object level). 

*State* refers to the instance variables and their values that are unique to each object. Instance variables are typically *named* by the class (e.g. the `initialize` instance method can be inherited, which allows for instance variables to be created on instantiation of an object), but are __not defined__ by the class - these instance variables are only defined when an object is instantiated from a class and a value assigned to them. As such, instance variables (and by extension, state) cannot be inherited as they are not defined within the class. 

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
State is the set of instance variables and their values that are associated with a given object after it has been instantiated from a class. State is 'encapsulated' by objects, as by default, the series of instance variables that comprise state cannot be accessed unless there are appropriate getter/setter methods; so there is a degree of data protection typically associated with encapsulation. It is important to note that instance variables that are not initialised do not become part of state. State is unique to each object - it cannot be shared between objects from the same class like instance methods can, so there is a degree of separation for state that is characteristic of encapsulation.

In our example below, when we instantiate the `ted` object from the `Dog` class, the `initialize` method is called, which we pass the string `"Teddy"` and `"Bushy"` as arguments. `"Teddy"` is assigned to the instance variable `@name` and becomes part of the `ted` object's state. This state is unique to `ted` and will be different to other objects instanted from `Dog`. However, while we pass in a reference to the string object `"Bushy"` as as argument, since we did not create a `@fur` instance variable on instantiation of the object, it is not part of `ted`'s state, even though we defined a getter method. 

As we have not defined any getter or setter methods for `@name`, the `@name` instance variable is inaccessible, and is protected from any access or changes. 
```
class Dog
  attr_reader :fur

  def initialize(name, fur)
    @name = name
  end
end

ted = Dog.new("Teddy", "Bushy")

ted = Dog.new("Teddy", "Bushy")
# #<Dog:0x00007ffebf8a8840 @name="Teddy">

ted.fur
# nil
```
*15) What is the difference between classes and objects?*
Classes act as templates from which objects are instantiated. Classes define the behaviours (instance methods) that objects will have access to once they are instantiated from classes (which could be through inheritance, mixed in modules, or simply defined in the class), and shape the state of the object (when the object is created, the `initialize` method creates instance variables pointing to object references passed as arguments to it). The collective set of instance variables, which taken together, comprise state. Objects can share behaviours from the same class, but are still distinct objects (as they have unique state, even if the arguments passed in reference the same object).

In our example below, although we have passed the same string object to the `Dog.new` method, we still see that the two objects instantiated from `Dog` are different objects. 
```
class Dog
  def initialize(name)
    @name = name
  end
end

name = "Teddy"
name1 = name

a = Dog.new(name)
# => #<Dog:0x00007fed968fd4d8 @name="Teddy">

b = Dog.new(name1)
# => #<Dog:0x00007fed959a5dc8 @name="Teddy">
```
*16) How can we expose information about the state of the object using instance methods?*
The state of an object comprises of the instance variables and their assigned values. By default, without instance methods, instance variables are inaccessible outside the object. However, we can access state by defining getter and setter instance methods in the class to access those instance variables. 
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
Collaborator objects are objects that are assigned to instance variables when objects are instantiated from a class and the `initialize` method is called. Functionally, they could be any object, whether they are custom objects we define, or objects pre-defined by the Core API in Ruby (e.g. objects instantiated from the Integer, String, Array classes). Collaborator objects allow us to model associative relationships ("has-a") between objects and define how those objects should interact with other objects. The collaborative relationship exists when the collaborator object is added to the state of the object (through assigning it as a value to an instance variable).

In our example, when we instantiate the `ted` object from the `Dog` class with the `Class#new` method, the `initialize` method is called, which we pass the string object `"Teddy"`. As this object is instantiated, the string object `"Teddy"` becomes part of `ted`'s state (i.e. `"Teddy"` is assigned to the `@name` instance variable). At this point, the associative relationship exists (the `ted` object "has a" name) and the string `"Teddy"` is a collaborator object with the `ted` object.
```
class Dog
  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
```
*18) Why should a class have as few public methods as possible?*
It is typically good practice to expose as few public methods as possible on a class, in line with the principle of encapsulation. Public methods can enable direct interfacing with the state of our objects from outside of the class, which may result in unintended changes that alter the functionality or break our programs. Removing unnecessary avenues of altering state will reduce the potential for unexpected changes in the state of our objects, while also prevent data that shouldn't be seen or altered in our program from access. 

In our example below, we have defined a getter method through the `attr_reader` method, which in theory, only allows access to the `@name` instance variable outside of the `ted` object once it's instantiated. However, we are able to call the `String#reverse!` method, which mutates the string object assigned to `@name`, despite us not explicitly defining a setter method to alter the value of the `@name` instance variable. Thus is it best practice to avoid using public methods where possible. 
```
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Ted")
ted.name.reverse!
ted.name
```
*19) What is the private method call used for?*
The `private` method call prevents instance methods from being accessed outside of the class where they are defined. They are useful to prevent access or changes to the state of objects unnecessarily, achieving encapsulation. Private methods *can* be accessed from within the class definition, so public methods (which are accessible outside of the class definition) are able to access the return values of private methods. 

In our example below, calling `private_method` on our `d` object results in a `NoMethodError` as private methods cannot be be accessed outside of the class definition. Contrast this with calling `public_method`, which is able to access `private_method` as it is part of the class definition, and thus is able to print out `"Hello!"` and return `nil`, per the `private_method`. 
```
class Dog
  def public_method
    private_method
  end

  private

  def private_method
    puts "Hello!"
  end
end

d = Dog.new

d.public_method
# => Hello!

d.private_method
# NoMethodError (private method `private_method' called for #<Dog:0x00007fae2c90d7d8>)
```
*20) What is the protected method used for?*
The `protected` method call is a form of method access control for instance methods defined within a class. It is useful when we want our objects to be able to interact with other instances of the same class and subclasses, but otherwise prevent direct access/modification to an object's state from outside of the class definition. It serves as a "middle-ground" between private and public methods. 

In our example below, we are unable to call the protected `name` instance method on the `joe` object instantiated from the `Dog` class, as it is inaccessible outside of the class definition. However, we are able to access the `name` instance method of other instances of the `Dog` class in our `play` instance method. 
```
class Dog
  def initialize(name)
    @name = name
  end

  def play(other_dog)
    "#{@name} plays with #{other_dog.name}"
  end

  protected

  def name
    @name
  end
end

class Greyhound < Dog
end

joe = Dog.new("Joe")
tim = Greyhound.new("Tim")

joe.name
# NoMethodError (protected method `name' called for #<Dog:0x00007fcb6c8254f8>)
joe.play(tim)
# => "Joe plays with Tim"
```
*21) What are two rules of protected methods?*
The two rules of protected methods are:
1. Within the class definition, protected methods are accessible like public methods
2. Outside of the class definition, protected methods act like private methods

*22) Classes also have behaviors not for objects (class methods). How do you define a class method?*
A class method can be defined by prepending the `self.` keyword to a method definition within a class. When the `self` keyword is invoked outside of an instance method, it refers to the class, such that we are defining a method on the class. Class methods can only be called on a class (or subclasses) and not on instances of that class.

In our example below, we define the `get_species` method on the `Dog` class through use of the `self` keyword. We can then call the `get_species` directly on the `Dog` class (it is actually inaccessible to instances of objects created from `Dog`). The `get_species` class method returns `self`. When `self` is used outside of an instance method, it refers to the class. Here, since we are defining a class method instead of an instance method, the `get_species` method call returns the class, `Dog`. 
```
class Dog
  def self.get_species
    self
  end
end

Dog.get_species
# => Dog
```
### Polymorphism, inheritance, method lookup path, duck-typing
*23) What is polymorphism? Explain two different ways to implement polymorphism. ​How does polymorphism work in relation to the public interface?*
Polymorphism is a concept in object oriented programming that refers to the ability of different types (or different objects) to respond to a common interface (e.g. an instance method). Polymorphism is a way to model logical hierarchies through inheritance, reduce the amount of code written in our program (i.e. implementing DRY code) as well as sharing common behaviours between classes that don't fit neatly into these logical hierarchies through mixing in modules. 

While encapsulation reduces the interactivity of different parts of the program in order to protect unnecessary changes to object state, polymorphism is about expanding the abilities of the encapsulated parts of the program to interact with the different parts of itself.

We can implement polymorphism in a number of ways - class inheritance (inheriting methods), interface inheritance (through mixing in modules) and duck-typing. 

In our example below, we observe polymorphism through class inheritance and interface inheritance. The `Cat`, `Turtle` and `Dog` classes subclass the `Pet` class, meaning they inherit the `initialize` method defined within `Pet` (denoted by the `<` symbol) - this explains why we need to provide an argument to the `Class#new` method when instantiating an object from `Cat`, `Turtle` or `Dog`. While `ted`, `charlie` and `oscar` are all distinct objects, they all have the `initialize` method defined in the `Pet` superclass (class inheritance).

We also observe _interface_ inheritance through use of mixing in modules. In our example, we have defined the module `Swimmable` and mixed this into the `Turtle` and `Dog` classes. Again, while objects instantiated from the `Turtle` and `Dog` class are distinct from each other, these objects will have access to the `swim` method. We can also observe duck-typing at work, by iterating through our objects and calling the commonly named `name` method.
```
module Swimmable
  def swim
    "I can swim!"
  end
end

class Pet
  def initialize(name)
    @name = name
  end
end

class Turtle < Pet
  include Swimmable

  def name
    puts "My name is Turtle!"
  end
end

class Dog < Pet
  include Swimmable

  def name
    puts "My name is Dog!"
  end
end

class Cat < Pet
  def name
    puts "My name is Cat!"
  end
end

ted = Dog.new("Ted")
ted.swim
# "I can swim!"

charlie = Turtle.new("Charlie")
charlie.swim
# "I can swim!"

oscar = Cat.new("Oscar")
oscar.swim
# NoMethodError (undefined method `swim' for #<Cat:0x00007ff2ec11a3c8 @name="Oscar">)

[ted, charlie, oscar].each { |object| puts object.name }
# => My name is Dog!
# => My name is Turtle!
# => My name is Cat!
```
*24) What is duck-typing? How does it relate to polymorphism and what problem does it solve?*
Duck-typing is a concept that demonstrates polymorphism. It can be achieved by implementing an instance method of the same name across numerous unrelated classes - objects instantiated from unrelated classes (i.e. different types) are all able to respond to a single method invocation (though this does not imply that the method will have the exact same functionality across the different classes). 

Duck typing is helpful in that we do not have to write complex, dependency-ridden logic in order to call a commonly named method on different objects. We can simply define the method (and it's associated functionality) within each class, which improves the extensibility of the code. Per our example below, we have implemented a `speak` method across all of our unrelated classes. Thus, we are able to call the `speak` method across the `cat`, `dog` and `turtle` objects through the `AnimalParty#introductions` instance method (even though these classes are unrelated to each other), instead of having to write a complex `case` statement in the `AnimalParty` class (which we will need to update every time we want to define a new class with a `speak` instance method). 
```
class Cat
  def speak
    "I am a cat!"
  end
end

class Dog
  def speak
    "I am a dog!"
  end
end

class Turtle
  def speak
    "I am a turtle!"
  end
end

class AnimalParty
  def introductions(attendees)
    attendees.each { |attendee| puts attendee.speak }
  end
end

cat = Cat.new
dog = Dog.new
turtle = Turtle.new

AnimalParty.new.introductions([cat, dog, turtle])
# I am a cat
# I am a dog
# I am a turtle
# => [#<Cat:0x00007ff3ee873b30>, #<Dog:0x00007ff3ee88e728>, #<Turtle:0x00007ff3ee894768>]
```
*25) What is inheritance?*
Inheritance is a mechanism in object oriented programming that allows classes to inherit behaviours (or instance methods) from other classes. Note that objects (and their state) cannot be inherited - only classes can inherit from other classes (objects are instantiated from classes, and once they are instantiated, create instance variables and thus have state). It is a way of modelling logical hierarchies between different classes and reducing the amount of code we have to write for multiple objects to have the same functionality. In Ruby, classes are only able to inherit from a single class.

In our example below, we define a class `Pet` and an instance method `speak` within `Pet`. The `Dog` class, which inherits from the `Pet` class, as denoted by the `<` symbol, is able to access the `speak` method through class inheritance, and the `harry` object, when instantiated from the `Dog` class, expects to have a `@name` instance variable when initialised, since the `initialize` method inherited from the `Pet` class stipulates that objects instantiated from it should have this instance variable defined when instantiated. 
```
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
harry.speak
# "Hello! I am a pet"
```

*26) What is the difference between a superclass and a subclass?*
A subclass inherits it's instance methods (state is not inherited, since it is unique to the object and only exists once the object is instantiated) from a superclass. In Ruby, a subclass can only inherit from a single superclass. 

*27) When is it good to use inheritance?*
Inheritance is useful when we want various classes to share the same behaviours (i.e. instance methods), since these can be defined in the superclass and inherited by the subclass without having to rewrite code. It is a useful way to model logical hierarchies between classes (i.e. where a class has a "is-a" relationship with another class). Inheritance does give us the flexibility to override methods if we do want our objects to respond to the same method name, but have a slightly different implementation.

In our example below, the `Dog` subclass inherits the `speak` method from the `Pet` superclass through class inheritance (denoted by the `<` symbol). When `Dog.new('Harry')` is invoked, Ruby will look within the `Dog` class for the `initialize` method and when it doesn't find it, Ruby will move up the inheritance hierarchy (to the `Pet` class), where it will find the `initialize` method and it will be invoked. While the `initialize` method still belongs to the superclass, `initialize` is still being called from the `Dog` class, so the instance variable created will still be part of the `Dog` class object's state.

However, we override the `Pet#speak` method in the `Dog` class to return a different string object. 
```
class Pet
  def initialize(name)
    @name = name
  end

  def speak
    "Hello! I am a pet"
  end
end

class Dog < Pet
  def speak
    "Hello! I am a dog!"
  end
end

harry = Dog.new("Harry")
harry.speak
# "Hello! I am a dog"
```
*28) Give an example of using the super method, both with and without an argument.*
The `super` method, when called inside another instance method, allows a method to look up a similarly named method earlier in the method lookup chain and invoke it. It can be useful to add additional functionality to existing instance methods of the same name that have been inherited from a superclass. The functionality of `super` can change, whether or not it is defined to accept arguments.
- When `super` is called without parentheses, it will forward any arguments provided in the instance method which it is called to the equivalently named method in the superclass. This may cause problems if there the argument provided in the subclass instance method is different to what is expected in the superclass method.
- When `super` is called with parentheses, but not with any arguments, it will invoke the instance method in the superclass, ignoring any arguments passed to the subclass instance method. This is often the safest way to call an instance method from the superclass if that instance method doesn't take any arguments. 
- When `super` is passed arguments, it will pass those arguments to the equivalently named instance method in the superclass, in the order in which they are provided. 

In our below example, both the `Pet` and `Dog` (which inherits from the `Dog` class, as denoted by the `<` symbol) class have an `initialize` method. After initialising a `Dog` object, we call the `super` method in the `Dog#initialize` method with the `name` and `age` arguments to call the `Pet#initialize` method, which passes the arguments provided to `Dog.new` to `Pet#initialize`. In `Dog#initialize`, we extend the functionality of `Pet#initialize` to initialise another instance variable, `@owner` and assign to the object passed to the `owner` parameter. 

We also have a `speak` method in the `Pet` and `Dog` class. For the `Dog#speak` instance method, we invoke `super` with parenthesis (no arguments), which will invoke the `Pet#speak` method, take the return value of `"Hello!"` and append an additional string object to it. Invoking `super()` is often the safest way to incorporate functionality from the superclass instance method when that method does not take any arguments. 
```
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end

  def speak
    "Hello!"
  end
end

class Dog < Pet
  def initialize(name, age, owner)
    super(name, age)
    @owner = owner
  end

  def speak
    super() + " I am #{@name} and I am #{@owner}'s pet."
  end
end

ted = Dog.new("Ted", 4, "Bobby")
```
*29) Give an example of overriding: when would you use it?*
Method overriding occurs when we have a method defined in a superclass which is inherited by a subclass, but then define another method of the same name in the subclass that has different functionality compared with the method in the superclass. It is useful when we want to extend (through use of the `super` method) or change the functionality of an instance method inherited from a superclass (or mixed in via module). 

In our example below, the `Dog` subclass inherits a `speak` method from the `Pet` superclass (denoted by the `<` symbol), which returns the string object `"Hello!"`. However, we override `Pet#speak` in `Dog` by defining `Dog#speak` and change it's functionality to return the string object `"I am a dog!"`
```
class Pet
  def speak
    "Hello!"
  end
end

class Dog < Pet
  def speak
    "I am a dog!"
  end
end
```
*30) What is a module? What is a mixin? When would a module be useful? What is namespacing?*
A module is a series of methods that can be mixed into a class, such that objects instantiated from that class also gain access to methods from that module. This is achieved by using the `include ModuleName` keyword in a class definition. Note that we cannot instantiate objects from modules - we can only mix in the module methods into a class, and instantiate an object directly from that class.

Modules are useful in that classes can only inherit from a single superclass, whereas classes can mix in methods from any number of modules, so modules are useful from the perspective of being able to introduce common methods into unrelated classes that do not share a common hierarchical inheritance chain. Modules are also useful for organising various classes, also known as namespacing. This helps the reader makes it easier to recognise the purpose of the contained classes and also prevent avoid conflicts in methods that have the same name (but belong to different classes) by using the namespace resolution operator `::`.

In the example below, we define two unrelated classes, `Human` and `Dog`. We then mix in the `Walkable` module, allowing us to access the module method `walk` in both `Human` and `Dog` classes, even though these classes are unrelated to each other.
```
module Walkable
  def walk
    "I am walking!"
  end
end

class Human
  include Walkable
end

class Dog
  include Walkable
end

fred = Human.new
fred.walk

teddy = Dog.new
teddy.walk
```
In the following example, we use modules as convenient way of organising related classes together (namespacing). We can then access these classes and call their associated instance methods by using the namespace resolution operator `::`.
```
module Mammal
  class Dog
    def speak
      "Woof!"
    end
  end

  class Cat
    def speak
      "Meow!"
    end
  end
end

Mammal::Dog.new.speak
# => "Woof!"

Mammal::Cat.new.speak
# => "Meow!"
```
*31) Why should methods in mixin modules be defined without using `self.` in the definition?*
When an instance method definition is prefixed by the `self` keyword, it refers to the class. This means that if we define a method within a module with the `self` prefix, we are defining a class method on the module, meaning we can only call that class method directly on the module itself, and not from the class, or any objects instantiated from classes where the module is mixed in. 

In our example below, we create the `Identifiable` module, and define the class method `self.identify`. We can then call this method directly from the `Identifiable` module, but an object instantiated from the `Dog` class does not have access to the `self.identify` class method. 
```
module Identifiable
  def self.identify
    "I am a class method!"
  end
end

class Dog
  include Identifiable
end

Identifiable.identify
# => "I am a class method!"

Dog.new.identify
# NoMethodError (undefined method `identify' for #<Dog:0x00007fc8aa156f38>)

Dog.identify
# NoMethodError (undefined method `identify' for Dog:Class)
```
*32) What is the method lookup path? How is the method lookup path affected by module mixins and class inheritance?*
The method lookup path is the chain of subclasses and superclasses (including mixed in modules) that Ruby will look through to call methods. It is applicable when an object instantiated from a subclass calls a method that is inherited from a superclass or mixed in through a module, and not explicitly defined within the subclass itself. 

When looking for an instance method along the method lookup path, Ruby will look in the immediate class from which an object was instantiated from, then any modules mixed in, starting from last to first module mixed into the class. If Ruby cannot find the associated method in the class or mixed in modules, it will look in the superclass, and any modules mixed into that superclass using the same process, and continue further up the inherited superclasses until it finds a relevant instance method (at which point it will stop looking), or return a `NoMethodError` exception. We can observe this sequence by calling the `Class#ancestors` method on a particular class.

In our example below, when we call `Dog.new.walk`, Ruby will first look in the `Dog` class to see if there is a `walk` instance method. Since this does not exist, it will then look at the `Pet` class definition, then the `Animal` class definition, then the `Swimmable` module, then the `Walkable` module, where it finds the `walk` method definition, at which point it will stop looking further up the method lookup chain, and call the `walk` method. 

We can also verify the full method lookup path (i.e. the path that Ruby would take if it could not find the `walk` method in the `Walkable` module) by calling the `Class#ancestors` method on the `Dog` class.
```
module Walkable
  def walk
    "I can walk!"
  end
end

module Swimmable
  def swim
    "I can swim"
  end
end

class Animal
  include Walkable
  include Swimmable

  def speak
    "I am an animal!"
  end
end

class Pet < Animal
end

class Dog < Pet
end

Dog.ancestors
# => [Dog, Pet, Animal, Swimmable, Walkable, Object, Kernel, BasicObject]
```
*33) Are class variables accessible to subclasses? Why is it recommended to avoid the use of class variables when working with inheritance?*
Class variables are scoped at a class level and defined by the `@@` symbols prefixing a variable name. They are accessible to objects instantiated from the class when there is an appropriate getter or setter method. It is generally not recommended to use class variables, as all objects that are instantiated from the class where the class variable is defined (as well as from any subclasses), share that same single class variable, meaning it is very easy to mistakenly change the value referenced by the class variable.

In our example below, we define the `SuperClass` class using the `class`...`end` keyword pair, with a getter method `class_var` also defined. We also initialise the `@@class_var` class variable to reference the integer object `8` when we define the class. 

We then define a new class, `SubClass1`, which inherits from `SuperClass`. We then reassign the `@@class_var` class variable to the integer object `10`. We instantiate `obj2` from the `SubClass1` class, then call the `class_var` getter method to verify that the `@@class_var` class variable is now reassigned to the integer object `10`.

However, once we call the `class_var` getter method on `obj1`, we see that our value for `@@class_var` in `obj1` is also `10`, since all objects instantiated from `SuperClass` and it's subclasses share the single class variable. If we had any other subclasses that inherited from `SuperClass`, this change would also be observed in those subclasses. In this sense, class variables can share state between objects (contrast this with instance variables, which are unique to each object).
```
class SuperClass 
  @@class_var = 8

  # We cannot use attr_ methods as these only work for instance variables
  def class_var
    @@class_var
  end
end

obj1 = SuperClass.new
obj1.class_var 
# => 8

class SubClass1 < SuperClass
  @@class_var = 10
end

obj2 = SubClass1.new
obj2.class_var
# => 10

obj1.class_var
# => 10
```
*24) Is it possible to reference a constant defined in a different class? How are constants used in inheritance? What is lexical scope?*
In Ruby, constants are not evaluated at runtime and have lexical scope. When dealing with constants, this means that the scope of the object remains limited to where it's defined in the code, unless prefixed with a specific class and the namespace resolution operator `::`.

When Ruby is attempting to find the value referenced by a constant, Ruby will look in the immediate module or class where the constant is referenced in the program, and if it fails to find a definition in the immediate class, it will look up the inheritance hierarchy (modules cannot inherit from other modules), as constants can be inherited.

In our example below, we demonstrate the concept of constants having lexical scope. In our `Vehicle` class, we define the `WHEELS` constant to point to an integer object, `4`. We reassign this `WHEELS` constant in our `Motorcycle` class, which inherits from the `Vehicle` class.

We also define a getter method to access the `WHEELS` constant, `wheels`. After calling the `wheels` method on an object instantiated from the `Motorcycle` class, we see that the value of `bike.wheels` is still `4`. 

This is because constants have lexical scope - when `bike.wheels` was called, Ruby had to look up the method lookup chain to access a `wheels` method. Ruby was able to find this method in the `Vehicle` class, where the `WHEELS` constant was also defined, and this is where Ruby took the value of the constant `WHEELS` from.

We could fix this by changing the return value of the `wheels` method to `self.class::WHEELS`. This syntax makes use of the namespace resolution operator (`::`), which is a way to point Ruby to look at a specific class when resolving the the scope of a constant. We also use `self.class`, as `self` within an instance method refers to the calling object. We subsequently call the `Class#class` method on this, since the namespace resolution requires a class to look within to find the constant definition.
```
class Vehicle
  WHEELS = 4

  def wheels
    WHEELS
  end
end

class Motorcycle < Vehicle
  WHEELS = 2
end

car = Vehicle.new
car.wheels 
# => 4

bike = Motorcycle.new
bike.wheels
# => 4
```
### Getters and Setters
*25) What is an accessor method?*
An accessor method, is an instance method defined within a class that allows instance variables to be both accessed (has the functionality of a getter method) and overwritten (functionality of a setter method). 

Accessor methods can be subject to method access control, such that only methods defined within the class can access/overwrite instance variables (in the case of a `private` accessor method), made `public` (such that all of the program can access/overwrite instance variables - this is the default level of method access control), or made `protected`, such that only methods defined within the class or subclass or other instances of the same class or subclass can access/overwrite instance variables.

Ruby has an `attr_accessor` method from the `Module` class that creates both a getter and setter method.

*26) What is a getter method?*
A getter method is an instance method we define in a class that allows us to return the value of an instance variable by calling this method on an object instantiated from a class. Ruby has a shorthand `Module#attr_reader` method that allows us to quickly create a getter method inside a class definition. Getter methods, like other instance methods, can be be subject to method access control. 

An important aside is that while getter methods are intended to read instance variables (they do not provide an explicit ability to reassign values assigned to instance variables), they can be prone to destructive methods.

In our example below, we have defined a getter method for the instance variable `@name` via the `attr_reader` method. However, we call a destructive method on the return value of the `Dog#name` method, resulting in mutation of the return value of `Dog#name`. 
```
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Ted")
ted.name
# => "Ted"

ted.name.upcase!
ted.name
# => "TED"
```
We could prevent this by defining a custom getter method that duplicates the original `@name` instance variable.
```
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name.dup
  end
end

ted = Dog.new("Ted")
ted.name
# => "Ted"

ted.name.upcase!
ted.name
# => "Ted"
```
*27) What is a setter method? What does it return?*
A setter method is an instance method we define within a class definition that enables us to reassign the value of an instance variable. Ruby has a shorthand `Module#attr_writer` method that allows us to quickly create a setter method.

An important point is that a setter method will return the argument that is passed to it. This may have unintended consequences if our code implementation relies on the setter method returning a value after some form of transformation to the object referenced by the instance variable - this will not be reflected in the return value of the setter method and in this case, we should rely on the return value of the getter method called after the instance variable value has been reassigned by the setter method.

In our example below, our `name=` setter method calls the `String#capitalize` method on the string object passed as an argument - however, the return value of the setter method is the string object passed as an argument, not the `@name` instance variable after being reassigned to the transformed string object.
```
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name.dup
  end

  def name=(name)
    @name = name.downcase.capitalize
  end
end

ted = Dog.new("Ted")
ted.name
# => "Ted"

ted.name = "frANk"
# => "frANk"

ted.name
# => "Frank"
```
*28) How do you decide whether to reference an instance variable or a getter method?*
Whether we reference an instance variable or a getter method can depend on whether we need to perform any additional transformation on the object referenced by the instance variable before it is returned, or want to add validation or guard logic. 

In these cases, a getter method can enable this (and reduce the amount of times we need to apply the validation/transformation logic in our code), whereas the instance variable is limited to whatever object it is referencing (i.e. without any transformation or validation or guard logic). 

A getter method can also be useful if we want to make the instance variable accessible outside the class where it is defined (when it is either protected or public), since instance variables cannot be accessed outside of the class definition unless a getter method is provided.

In our `initialize` method, we don't perform any validations or transformations on the argument passed to the `name` parameter. However, in our `name` getter method, we perform additional transformation by applying some string methods and using string interpolation to append `"Lord "` to our transformed string variable. We could thus use the return value of this `name` getter method in other parts of our program, instead of having to apply the same set of transformations every time the instance variable `@name` is referenced in our program.
```
class Dog
  def initialize(name)
    @name = name
  end

  def name
    "Lord #{@name.downcase.capitalize}"
  end
end

teddy = Dog.new("Teddy")
teddy.name
# => "Lord Teddy"
```
### Instance methods, class methods, self
*29) When would you call a method with self?*
Within a class definition, if we have a setter method defined and want to utilise this setter method within another instance method definition, we will need to prepend `self` to the setter method name, otherwise Ruby will interpret the setter method call as a local variable initialisation and assignment instead. We *could* also prepend `self` to our getter methods, though this is unnecessary (since there is no `=` operator used, Ruby will not assume local variable assignment is happening), and this is a practice often discouraged by the Ruby community.

We have an example of using the `self` keyword prepended to the setter methods `name` and `age`. If we did not prepend `self`, Ruby would interpret the `name` and `age` setter method calls as a local variable initialisation and assignment to the arguments provided to the `remodel` instance method. Therefore if we called the `remodel` instance method without appending `self` to `age =` and `make =`, it would return local variable `name` and `age` assigned to the objects passeed by reference to the `name` and `age` parameters respectively, and the instance variables `@name` and `@age` would be unchanged.
```
class Car
  def initialize(make, age)
    @make = make
    @age = age
  end

  def remodel(make, age)
    self.make = make
    self.age = age
  end

  private

  attr_writer :make, :age
end

toyota = Car.new("Toyota", 14)
# => #<Car:0x00007fe539022738 @make="Toyota" @age=14>

toyota.remodel("Lexus", 2)
toyota
# => #<Car:0x00007fe539022738 @make="Lexus" @age=2>
```
*30) What are class methods?*
Class methods are methods defined on the class itself. We can identify these by the `self` keyword prepended to a method definition. In the context of class methods, when `self` is used as a prefix, it refers to the class itself - hence we are literally defining a method on the class itself. Class methods can only be called directly on the class itself - they cannot be called by objects instantiated from the class (attempting to do so will raise a `NoMethodError`), though class methods are inherited in the same fashion as instance methods. 

Class methods cannot access instance variables (as instance variables are only created when objects are instantiated from the class). Class methods can be useful when we need a method that does not have anything to do with the state of objects.

In our example below, we define a class method `identify` by using the `self` keyword prepended to the method name. Within the class method, `Dog::identify` will return the class, since `self` used outside of an instance method will return the class.
```
class Dog
  def self.identify
    self
  end
end

class Puppy < Dog
end

Dog.identify
# => Dog

Puppy.identify
# => Puppy

Dog.new.identify
# => NoMethodError
```
*31) What is the purpose of a class variable?*
A class variable is a variable defined at a class level and initialised when the class is evaluated by Ruby (distinguish this from an instance variable, which only occurs when an object is instantiated from a class). Class variables can be inherited by subclasses and are accessible by both class and instance methods (this  implies they are accessible within objects). They are denoted by `@@` symbols before a variable name. 

Within the Ruby community, the use of class variables is somewhat discouraged due to the fact that they can be inherited, and that all objects instantiated from the class (and subclasses inheriting from the superclass where the class variable is defined) share the same copy of the class variable, meaning it is easy to accidentally reassign the class variable, and have that change reflected across all subclasses and objects instantiated from that class and subclasses. Nonetheless, if we want to keep track of a class level detail that is unrelated to the state of objects instantiated from that class, class variables are an option.

In our example below, we define the `Animal` class with a class variable, `@@legs` and assign it to the integer object `4`. Once this class is defined by Ruby, the class variable is created. We call the class method `legs` and the instance method `legs`, which both return the `@@legs` class variable, which still references the integer object `4`.

However, as soon as Ruby evaluates the `Snake` class, which subclasses the `Animal` class, the class variable `@@legs` now points to the integer object `0`, irrespective of whether an object is instantiated from the `Snake` class. We can observe the fact that this class variable is referencing `0` in the `Animal` superclass, as well as objects instantiated from the `Animal` class - `horse` in our case. 
```
class Animal
  @@legs = 4

  def self.legs
    @@legs
  end

  def legs
    @@legs
  end
end

Animal.legs
# => 4

horse = Animal.new
horse.legs
# => 4

class Snake < Animal
  @@legs = 0
end

Snake.legs
# => 0

Snake.new.legs
# => 0

Animal.legs
# => 0

horse.legs
# => 0
```
*32) What is a constant variable?*
A constant variable (or constant for short) is a variable we define at the class level. It is intended that a constant points to an object that should not change through the operation of our program (hence the name, constant). Ruby will allow us to reassign objects referenced by constants, but will raise a warning that the constant has already been defined.

We can identify constants by variable names starting with a capital letter (though by convention we usually use all capital letters when defining a constant). They are created and initialised when the class is evaluated by Ruby and can be accessed by class or instance methods. Constants are different from instance or class variables, in that we are able to access constants from completely unrelated classes by using the namespace resolution operator `::`. This allows us to reach into other classes to access a constant. 

The other unique aspect of constants when compared with instance or class variables are that constants also have lexical scope, meaning that when attempting to evaluate the value of a constant, Ruby will look to the immediate class or module where the constant is referenced, and if it cannot find the constant definition at that location, Ruby will attempt to look up the inheritance chain for the constant definition (or return a `NameError` if Ruby cannot find a constant definition in the hierarchy chain).

We can bring the scoping behaviour of constants in line with instance variables by appending `self.class::` to the constant in any method that attempts to reference the constant.
```
class Animal
  LEGS = 4

  def legs
    self.class::LEGS
  end
end

class Bird < Animal
  LEGS = 2
end

Bird.new.legs
# => 2

Animal.new.legs
# => 4
```
Here is an example of constants being inheritable:
```
module Legs
  def legs
    "This construct has #{Dog::LEGS} legs!"
  end
end

class Mammal
  LEGS = 4

  include Legs
end

class Dog < Mammal
end
```
*33) What is the default to_s method that comes with Ruby, and how do you override this? What are some important attributes of the to_s method?*
The default `to_s` instance method comes from the `Object` class in Ruby, and by default, will print the name of the object's class and an encoding of the object's `object_id`. Often, this is not a particularly useful output, so we are able to use method overriding to replace the default functionality of the `Object#to_s` instance method to custom functionality, by defining a `to_s` method within a class definition.

Two important things to note are that the `Object#to_s` instance method is automatically called by Ruby during a `puts` method call on the argument (i.e. `puts argument.to_s`), as well as during string interpolation (i.e. "I am an #{`argument.to_s`}"). This is demonstrated in our example below - when we call the `puts` method, Ruby automatically calls `to_s` on the `jack` object. Ruby finds a method definition for `to_s` in the `Dog` class definition, and hence calls `Dog#to_s` instead of `Object#to_s`. This is why `"Jack"` is printed, instead of the `Dog` class name and an encoding of the `jack` object's object_id. 

We also observe `to_s` being automatically called in our string interpolation - the code is equivalent to `#{jack.to_s}`.
```
class Dog
  def initialize(name)
    @name = name
  end

  def to_s
    "#{@name}"
  end
end

jack = Dog.new("Jack")
puts jack
# => Jack

"Hello, I am a dog and my name is #{jack}!"
# => "Hello, I am a dog and my name is Jack!"
```
*34) From within a class, when an instance method uses self, what does it reference?*
Within a class definition, when an instance method uses the `self` keyword, it is referring to the calling object. 
```
class Dog
  def display_class
    "#{self.class}"
  end
end

d = Dog.new
d.display_class
# => "Dog"
```
In our example above, we use the `self` keyword in our `Dog#display_class` instance method. Thus when we call the `display_class` method, `self` is pointing to the object that called the `display_class` method, the object instantiated from `Dog`. We then chain the `Class#class` method onto the `display_class` method, which returns the class of the `d` object.

Prior to Ruby 2.7, we could not use the `self` keyword when calling private methods within the class, as this would be the equivalent of calling the method on the object (i.e. calling the instance method outside of the class), which is prevented through use of the `private` method.

*35) What happens when you use self inside a class but outside of an instance method?*
When we use the `self` keyword inside a class definition but outside of an instance method, it refers to the class itself. This is useful when defining class methods (i.e. methods that are called directly on the class, and not on objects instantiated from the class) - we append `self` to a method name in a method definition to define a class method instead of an instance method.

In our example below, our use of the `self` keyword in the method definition means that we are defining the `species` method directly on the class - i.e. defining a class method. As this is a class method, the `self` keyword within the `self.species` class method also refers to the class itself when called on the class.
```
class Dog
  def self.species
    self
  end
end

Dog.species
# => Dog
```
*36) Why do you need to use self when calling private setter methods?*
We need to use the `self` keyword when calling private setter methods, as without `self`, Ruby will interpret the setter method call as a local variable assignment, which will not change the state of the object when the instance method calling the setter method is called.
```
class Dog
  def initialize(name, age)
    @name = name
    @age = age
  end

  def change_info(name, age)
    self.name = name
    self.age = age
  end

  private
  
  attr_writer :name, :age
end

ted = Dog.new("Teddy", 4)
# => #<Dog:0x00007fc1a105ab30 @name="Teddy", @age=4>

ted.change_info("Bob", 3)

ted
# => #<Dog:0x00007fc1a105ab30 @name="Bob", @age=3>
```
*37) Why use self, and how does self change depending on the scope it is used in?*
The `self` keyword can change the functionality of our code, depending on where it is used. When used within an instance method, it refers to the calling object. When used within a class definition, but outside of an instance method, it refers to the class where the `self` keyword was used.
```
class Dog
  def self.species
    self
  end

  def object_info
    self
  end
end

Dog.species
# => Dog

Dog.new.object_info
# => => #<Dog:0x00007fd5f595e660>
```
*38) What happens when you call the p method on an object? And the puts method?*
When we call the `p` method on an object, this is the `Kernel#p` instance method. This has the effect of also calling the `Class#inspect` on the same object that is passed as an argument to the `p` method (i.e. `p object.inspect`). When we call the `Kernel#puts` method, this also automatically calls the `Object#to_s` instance method on the object passed as an argument to the `puts` method (i.e. `puts object.to_s`).

*39) What are the scoping rules for class variables? What are the two main behaviors of class variables?*
Class variables are scoped at the class level and can be inherited by subclasses. They are denoted by `@@` symbols before the variable name. Class variables exhibit two particular behaviours:
1. All objects instantiated from the class, subclasses, and the objects instantiated from those classes or subclasses, all have access to a single copy of the class variable. This means that any change in the class variable, wherever it occurs, is reflected across all of those classes, subclasses and objects. This is why it is very easy to make unintended changes that impact multiple other classes and objects, which is why usage of class variables is generally discouraged. 
2. Class variables can be accessed via class methods (regardless of where the class variable is initialised), or by instance methods when an object is instantiated from the class where the class variable is defined.

In our example below, we initialise the `@@legs` class variable in the `Animal` class and assign it to the integer object `4`. We have both a class (`Animal::legs`) and an instance getter method (`Animal#legs`) that can access the `@@legs` class variable.

When we call `Animal::legs` or the `Animal#legs` on an instance of `Animal`, both methods return the integer object `4`, as expected. However, once we define the `Bird` class, we notice that calling `Animal.legs` now returns the integer object `2`. This is because objects instantiated from `Bird` and `Animal`, and the `Bird` and `Animal` classes all share a single copy of the `@@legs` class variable, which means that reassignment of `@@legs` in the `Bird` class also affected the class variable in `Animal`, as well as any objects instantiated from the `Bird` or `Animal` class.
```
class Animal
  @@legs = 4

  def self.legs
    @@legs
  end

  def legs
    @@legs
  end
end

Animal.legs
# => 4

class Bird < Animal
  @@legs = 2
end

Animal.legs
# => 2
```
*40) What are the scoping rules for constant variables?*
Constant variables (or constants) are defined at the class level and have lexical scope. This means that when evaluating the object referenced by a constant, Ruby will look in the immediate class or module where that constant is referenced. If Ruby cannot find the definition in that class or module, it will look up the inheritance chain until it finds the definition (or raise a `NameError` if it cannot). However, we are also able to access constants in other, unrelated classes by using the namespace resolution operator `::`.

In our following example, we observe lexical scope in action. We define a constant `LEGS` in our `Animal` class, as well as a getter method `Animal#legs` for this constant. We then define a `Bird` class, which inherits from the `Animal` class, but also assigns the integer object `2` to the `LEGS` constant. When we call `Bird#legs`, the instance method returns `4`, since when attempting to reference the value of `LEGS`, Ruby will look to where the constant is referenced (i.e. in the `Animal` class), and attempt to find the object referenced by the constant in that location, which is `4`. 

We could change this method to return `2` by changing our `Animal#legs` to reference `self.class::LEGS`, as the namespace resolution operator allows us to reference a specific class where Ruby should look to find the value referenced by the constant. 
```
class Animal
  LEGS = 4

  def legs
    LEGS
  end
end

class Bird < Animal
  LEGS = 2
end

Bird.new.legs
# => 4
```
*41) How does sub-classing affect instance variables?*
Subclassing (or inheritance), does not really exist in the context of instance variables, as instance variables do not exist until an object is instantiated from a class and a value assigned to them. Thus, instance variables are not inherited. We can say, however, that instance methods are inherited, which when called, can initialise instance variables.

As each object is instantiated from a class, it's instance variables are created and values assigned to them, contributing to that object's state. Each object is unique, regardless of whether the objects passed as arguments are the same object.
```
class Dog
  def initialize(name)
    @name = name
  end
end

name = "Teddy"
name1 = name

a = Dog.new(name)
# => #<Dog:0x00007fed968fd4d8 @name="Teddy">

b = Dog.new(name1)
# => #<Dog:0x00007fed959a5dc8 @name="Teddy">
```
### Fake operators and equality
*41) What is a fake operator?*
A fake operator is an instance method defined within a class that appears to be an operator, but can have different implementations based on where/how it is defined across different classes. The reason why these methods appear to be operators is due to Ruby's syntactical sugar, which makes the syntax of calling these methods look like operators. Examples include `==`, `+`, `[]`, which are all methods disguised as operators due to Ruby's syntactical sugar. 

*42) How does equivalence work in Ruby?*
Equivalence in Ruby can have different meanings, depending on what implementation our instance methods use. The `BasicObject#==` method treats objects as equivalent if they are the same object (i.e. occupying the same physical space in memory). However, various classes such as `Hash`, `String` and `Array` implement their own versions of the `==` method, such that many of these methods treat objects as equal if they have the same value, but not necessarily the same object (i.e. they do not have the same `object_id`). 

The notable exceptions are the `Integer` and `Symbol` classes, where integer and symbol objects that have the same value also have the same object_id. This is more of a memory optimisation choice since `Symbol` and `Integer` objects can't be mutated (however the `Integer#==` instance method has a slight wrinkle in it's implementation, as it allows comparison between `Float` and `Integer` objects, and vice versa for `Float#==` instance method).

Ruby also has an `Object#equal?` method, which treats objects as equal if they occupy the same space in memory (i.e. have the same `object_id`). Most other classes typically do not provide their own implementation of this instance method as this method is a common way to test whether two objects occupy the same space in memory (i.e. are the same object).

*43) How do you determine if two variables actually point to the same object?*
We can call `Object#object_id` on that variable. This will return the object id of the object referenced by that variable. Since the object id is unique to every object in Ruby, if the object id of the object is the same for both variables, then this indicates that the two variables are pointing at the same object. Alternatively, we could use the `Object#equal?` method. 
```
"Hello".object_id == "Hello".object_id
# => false

"Hello".equal?("Hello")
# => false
```
*44) What is the === method?*
The `===` method compares objects, returning `true` if the argument passed into the instance method belongs to the set on which the method is invoked. It is most frequently observed in `case` statements.

In our below example, we are comparing the integer object `25` to various ranges using the `Range#===` instance method - e.g. `(1..50).===25`
```
case 25
when 1..50
  puts "1 to 50"
when 51..100
  puts "51 to 100"
else
  puts ">100"
end
```
In our example below, we use `String#===` to compare whether `"Hello"` belongs to the set `String` (i.e. whether `"Hello"` is an object instantiated from the `String` class). 
```
String === "Hello"
# => true

"Hello" === String
# => false

String === Hash
# => false
```
*45) What is the eql? method?*
The `eql?` method returns true if the two objects being compared have the same value and refer to the same objects. It's not commonly used - mostly commonly for comparing the key-value pairs between two `Hash` objects.

In our example below, we have defined two hashes `a` and `b`. The `Hash#eql?` method compares whether the key-value pairs have the same values. 
```
a = { a: "Test", b: "Test1" }
b = { a: "Test", b: "Test1" }

a.eql?(b)
# => true
```
*46) What is interesting about the #object_id method and its relation to symbols and integers?*
The `Object#object_id` instance method, when called on an object, will return an object id of that particular object which represents it's location within memory. Each object that has been instantiated in Ruby has a unique object_id. In relation to symbols and integers, objects with the same value instantiated from these classes occupy a single location in memory (and thus have the same object_id). Constrast this with objects instantiated from other classes, such as String objects, which despite having the same value, will occupy different locations in memory (and thus have different object ids).

In our example below, we have instantiated two different instance variables to reference the `Integer` object with a value of `4`. When we call the `Object#object_id` instance method, we find that the two `4` objects occupy the same space in memory and thus have the same object id, despite being referenced in two different instance variables. This means that the two integer objects `4` are the same object. Contrast this with our instance variables referencing the string object `"Harry"`. Despite the string objects having the same value, they occupy two different spaces in memory and hence have two different object ids. This indicates that these are two different objects. 
```
class Dog
  attr_reader :dog_age_start, :dog_age_finish, :dog_name_start, :dog_name_finish

  def initialize
    @dog_age_start = 4
    @dog_age_finish = 4
    @dog_name_start = "Harry"
    @dog_name_finish = "Harry"
  end
end

Dog.new.dog_age_start.object_id
# => 9
Dog.new.dog_age_finish.object_id
# => 9
Dog.new.dog_name_start.object_id
# => 70221944311620
Dog.new.dog_name_finish.object_id
# => 70221965054880
```
*47) When do shift methods make the most sense?*
The shift method is generally best used with collections, or Array objects, in particular. This is because the `Array` class already has an implementation of these shift methods (e.g. `Hash` objects don't have this method and while the `String` class also has an implementation, there is also an equivalent `+` instance method defined to concatenate strings). In general, the implementation of custom methods should be similar to the implementation pattern already built into classes already defined by the Core API in Ruby.

In our below example, when instantiating an object from the `Library` class, the `initialize` method is called, which initialises an instance variable `@books`, which points to an empty array. We then define a custom `<<` method, which uses the `Array#<<` method to allow us to insert objects into that empty array. If we did not define this `<<` method, we would not be able to interface with the `@books` instance method (which would return a `NoMethodError`), unless we had a getter method for the `@books` instance variable, at which point calling the `<<` method would call `Array#<<`.
```
class Library
  def initialize
    @books = []
  end

  def <<(book)
    @books << book
  end
end

lib = Library.new
lib << "Grapes of Wrath"
# => ["Grapes of Wrath"]
```
*48) Explain how the element reference getter and element assignment setter methods work, and their corresponding syntactical sugar*
The element reference getter and element assignment setter methods are observed in the `Array` class in the Ruby Core API. In the standard implementation, they allow us to reference array elements by index and mutate arrays by reassigning elements by index, respectively. There is a significant degree of syntactical sugar which makes these methods look like operators. We are able to define our own implementation in our own classes (though it is generally recommended that their syntax and functionality be similar to the equivalent methods in the `Array` class). 

In our example below, there is a custom element reference getter method and element assignment setter method defined, which strips back the syntactical sugar in the instance method definition and utilises the element reference getter and element assignment setter methods already defined in the `Array` class to interface with the array referenced by the `@pets` instance variable. Calling these methods however, still makes use of the syntactical sugar provided in equivalent instance methods defined in the `Array` class. 
```
class Owner
  def initialize
    @pets = ["Teddy", "Charlie", "Bob"]
  end

  def [](idx)
    @pets[idx]
  end

  def []=(idx, pet)
    @pets[idx] = pet
  end
end

ted = Owner.new
ted[1]
# => "Charlie"
ted[2] = "Jamie"
ted[2]
# => "Jamie
```
