# RB129 Written Assessment Practice Questions

## Table of Contents
- [OOP & Reading Code](#OOP-&-Reading-Code)
- [Classes, objects, encapsulation, working with collaborator objects, method access control](#Classes-objects-encapsulation-working-with-collaborator-objects-method-access-control)
- [Polymorphism, inheritance, method lookup path, duck-typing](#Polymorphism-inheritance-method-lookup-path-duck-typing)
- [Getters and Setters](#getters-and-setters)
- [Instance methods, class methods, self](#Instance-methods-class-methods-self)

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
__Encapsulation__: Encapsulation is the hiding of functionality within code, making it unavailable to the rest of the code base. It is a form of data protection, such that data cannot be changed or manipulated without obvious intent. 

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
*18) Why should a class have as few public methods as possible?*
It is typically good practice to expose as few public methods as possible on a class, in line with the principle of encapsulation. Public methods can enable direct interfacing with the state of our objects from outside of the class, which may result in unintended changes that alter the functionality or break our programs. Removing unnecessary avenues of altering state will reduce the potential for unexpected changes in the state of our objects, while also prevent data that shouldn't be seen or altered in our program from access. 

*19) What is the private method call used for?*
The `private` method call prevents instance methods from being accessed outside of the class where they are defined. They are useful to prevent access or changes to the state of objects unnecessarily. Private methods *can* be accessed from within the class definition, so public methods (which are accessible outside of the class definition) are able to access the return values of private methods. 

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
The `protected` method call is useful when we want our objects to be able to interact with other instances of the same class and subclasses, but otherwise prevent access/modification to an object's state from outside of the class definition. It serves as a "middle-ground" between private and public methods. 

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

joe = Dog.new("Joe")
tim = Dog.new("Tim")

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
A class method can be defined by prepending the `self.` keyword to a method definition within a class. When the `self` keyword is invoked outside of an instance method, it refers to the class, such that we are defining a method on the class. 

In our example below, we define the `get_species` method on the `Dog` class through use of the `self` keyword. We can then call the `get_species` directly on the `Dog` class (it is actually inaccessible to instances of objects created from `Dog`). The `get_species` class method returns `self`. When `self` is used outside of an instance method, it refers to the class. Here, since we are defining a class method instead of an instance method, the `get_species` method call returns the class, `Dog`. 
```
class Dog
  def self.get_species
    self
  end
end

Dog.get_species
```

### Polymorphism, inheritance, method lookup path, duck-typing
*23) What is polymorphism? Explain two different ways to implement polymorphism. ​How does polymorphism work in relation to the public interface?*
Polymorphism is a concept in object oriented programming that refers to the ability of different types (or different objects) to respond to a common interface (e.g. an instance method). Polymorphism is a way to model logical hierarchies through inheritance, reduce the amount of code written in our program (i.e. implementing DRY code) as well as sharing common behaviours between classes that don't fit neatly into these logical hierarchies through mixing in modules. 

Where encapsulation reduces the interactivity of different parts of the program in order to protect itself, polymorphism is about expanding the abilities of the encapsulated parts of the program to interact with the different parts of itself.

We can implement polymorphism in a number of ways - class inheritance, interface inheritance and duck-typing. 

In our example below, we observe polymorphism through class inheritance and interface inheritance. The `Cat`, `Turtle` and `Dog` classes subclass the `Pet` class, meaning they inherit the `initialize` method defined within `Pet` (denoted by the `<` symbol) - this explains why we need to provide an argument to the `Class#new` method when instantiating an object from `Cat`, `Turtle` or `Dog`. While `ted`, `charlie` and `oscar` are all distinct objects, they all have the `initialize` method defined in the `Pet` superclass (class inheritance).

We also observe _interface_ inheritance through use of mixing in modules. In our example, we have defined the module `Swimmable` and mixed this into the `Turtle` and `Dog` classes. Again, while objects instantiated from the `Turtle` and `Dog` class are distinct from each other, these objects will have access to the `swim` method. 
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
end

class Dog < Pet
  include Swimmable
end

class Cat < Pet
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
```

*24) What is duck-typing? How does it relate to polymorphism and what problem does it solve?*
Duck typing is a concept that implements polymorphism. It is achieved by implementing an instance method of the same name across numerous unrelated classes. It is an example of polymorphism since objects instantiated from unrelated classes (i.e. different types) are all able to respond to a commonly named method invocation (though this does not imply that the method will have the exact same functionality across the different classes). 

Duck typing is helpful in that we do not have to write complex, dependency-ridden logic in order to call a commonly named method to different objects. We can simply define the method (and it's associated functionality) within each class, which improves the extensibility of the code. Per our example below, we have implemented a `speak` method across all of our unrelated classes. Thus, we are able to call the `speak` method across the `cat`, `dog` and `turtle` objects through the `AnimalParty#introductions` instance method, instead of having to write a complex `case` statement in the `AnimalParty` class (which we will need to update every time we want to define a new class with a `speak` instance method). 
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
Inheritance is a mechanism in object oriented programming that allows classes to inherit behaviours (or instance methods) from other classes. This behaviour inheritance can also initialise any instance variables (i.e. state) that an object instantiated from these classes should have (though state only exists once the object is actually instantiated from a class and values assigned to those instance variables). It is a way of modelling logical hierarchies between different classes and reducing the amount of code we have to write for multiple objects to have the same functionality. In Ruby, classes are only able to inherit from a single class.

In our example below, we define a class `Pet` and an instance method `speak` within `Pet`. The `Dog` class, which inherits from the `Pet` class, as denoted by the `<` symbol, is able to access the `speak` method through class inheritance, and the `harry` object, when instantiated from the `Dog` class, expects to have a `@name` instance variable when initialised, since the `initialize` method in the `Pet` class stipulates that objects instantiated from it should have this instance variable. 
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
A subclass inherits it's instance methods (state is not inherited, since it is unique to the object and only exists once the object is instantiated, and values assigned to instance variables) from a superclass. In Ruby, a subclass can only inherit from a single superclass. 

*27) When is it good to use inheritance?*
Inheritance is useful when we want various classes to share the same behaviours (i.e. instance methods), since these can be defined in the superclass and inherited by the subclass without having to rewrite code. Inheritance does give us the flexibility to override methods if we do want our objects to respond to the same method name, but have a slightly different implementation.

In our example below, the `Dog` subclass inherits the `speak` method from the `Pet` superclass through class inheritance (denoted by the `<` symbol). When `Dog.new('Harry')` is invoked, Ruby will look within the `Dog` class for the `initialize` method and when it doesn't find it, Ruby will move up the inheritance hierarchy (to the `Pet` class), where it will find the `initialize` method and it will be invoked. While the `initialize` method still belongs to the superclass, `initialize` is still being called from the `Dog` class, so the instance variable created will still be part of the `Dog` class object's state.

However, we override the `speak` method to return a different string object. 
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
The `super` method, when called inside another instance method, allows a method to look up a similarly named method earlier in the method lookup chain and invoke it. It can be useful to add additional functionality to existing instance methods of the same name that have been inherited from a superclass.

In our below example, both the `Pet` and `Dog` (which inherits from the `Dog` class, as denoted by the `<` symbol) class have an `initialize` method. After initialising a `Dog` object, we call the `super` method in the `Dog#initialize` method with the `name` and `age` arguments to call the `Pet#initialize` method, which passes the arguments provided to `Dog.new` to `Pet#initialize`. In `Dog#initialize`, we extend the functionality of `Pet#initialize` to initialise another instance variable, `@owner` and assign to the object passed to the `owner` parameter. 

We also have a `speak` method in the `Pet` and `Dog` class. For the `Dog#speak` instance method, we invoke `super` with parenthesis (no arguments), which will invoke the `Pet#speak` method, take the return value of `"Hello!"` and append an additional string object to it. Invoking `super()` is necessary when the method being invoked earlier in the method lookup chain does not take any arguments. 
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
Method overriding occurs when we have a method defined in a superclass which is inherited by a subclass, but then define another method of the same name in the subclass that can have different functionality compared with the method in the superclass. It is useful when we want to extend (through use of the `super` method) or change the functionality of an instance method. 

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

It is useful in that classes can only inherit from a single superclass, whereas classes can mix in methods from any number of modules, so modules are useful from the perspective of being able to introduce common methods into unrelated classes that do not share a common hierarchical inheritance chain. Modules are also useful for organising various classes, also known as namespacing. This helps the reader makes it easier to recognise the purpose of the contained classes and also prevent avoid conflicts in methods that have the same name (but belong to different classes).

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
    def bark
      "Woof!"
    end
  end

  class Cat
    def meow
      "Meow!"
    end
  end
end

Mammal::Dog.new.bark
# => "Woof!"

Mammal::Cat.new.meow
# => "Meow!"
```
*31) Why should methods in mixin modules be defined without using `self.` in the definition?*
When an instance method definition is prefixed by the `self` keyword, it refers to the class. This means that if we define a method within a module with the `self` prefix, we are defining a class method on the module, meaning we can only call that class method directly on the module itself, and not from any objects instantiated from classes where the module is mixed in. 

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
```
*32) What is the method lookup path? How is the method lookup path affected by module mixins and class inheritance?*
The method lookup path is the chain of subclasses and superclasses (including mixed in modules) that Ruby will look within to call methods. It is applicable when an object instantiated from a subclass calls a method that is inherited from a superclass or mixed in through a module, and not explicitly defined within the subclass itself. 

When looking for an instance method along the method lookup path, Ruby will look in the immediate class from which an object was instantiated from, then any modules mixed in, starting from the last module mixed in to the class. If Ruby cannot find the associated method, it will look in the superclass, and any modules mixed into that superclass using the same process, and continue further up the inherited superclasses until it finds a relevant instance method (at which point it will stop looking), or return a `NoMethodError` exception. We can observe this sequence by calling the `Class#ancestors` method on a particular class.

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
Class variables are scoped at a class level and defined by the `@@` symbols prefixing a variable name. They are accessible to objects instantiated from the class when there is an appropriate getter or setter method. It is generally not recommended to use class variables, as all objects that are instantiated from the class where the class variable is defined, share that same single class variable, meaning it is very easy to mistakenly change the value associated referenced by the class variable.

In our example below, we define the `SuperClass` class using the `class`...`end` keyword pair, with a getter method also defined. We also initialise the `@@class_var` class variable to the integer object `8` when we define the class. 

We then define a new class, `SubClass1`, which inherits from `SuperClass`. We then reassign the `@@class_var` class variable to the integer object `10`. We instantiate `obj2` from the `SubClass1` class, then call the `class_var` getter method to verify that the `@@class_var` class variable is now reassigned to the integer object `10`.

However, once we call the `class_var` getter method on `obj1`, we see that our value for `@@class_var` in `obj1` is also `10`, since all objects instantiated from `SuperClass` and it's subclasses share the single class variable. If we had any other subclasses that inherited from `SuperClass`, this change would also be observed in those subclasses. In this sense, class variables share state between objects (contrast this with instance variables, which are unique to each object).
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
In Ruby, constants are not evaluated at runtime. When dealing with constants, this means that the scope of the object remains limited to where it's defined in the code.

When Ruby is attempting to find the value referenced by a constant, Ruby will look in the immediate module or class where the constant is referenced in the program, and if it fails to find a definition in the immediate class, it will look up the inheritance hierarchy (modules cannot inherit from other modules).

In our example below, we demonstrate the concept of constants having lexical scope. In our `Vehicle` class, we define the `WHEELS` constant to point to an integer object, `4`. We reassign this `WHEELS` constant in our `Motorcycle` class, which inherits from the `Vehicle` class.

We also define a getter method to access the `WHEELS` constant, `wheels`. After calling the `wheels` method on an object instantiated from the `Motorcycle` class, we see that the value of `bike.wheels` is still `4`. 

This is because constants have lexical scope - when `bike.wheels` was called, Ruby had to look up the method lookup chain to access a `wheels` method. Ruby was able to find it in the `Vehicle` class, where the `WHEELS` constant was also defined, and this is where Ruby took the value of the constant `WHEELS` from.

We could fix this by changing the return value of the `wheels` method to `self.class::WHEELS`. This syntax makes use of the namespace resolution operator (`::`), which is a way to point Ruby to look at a specific class when resolving the object referenced by a constant. We also use `self.class`, as `self` within an instance method refers to the calling object. We subsequently call the `Class#class` method on this, since the namespace resolution requires a class to look within to find the constant definition.
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

Accessor methods can be subject to method access control, such that only methods defined within the class can access/overwrite instance variables (in the case of a `private` accessor method), made `public` (such that all of the program can access/overwrite instance variables), or made `protected`, such that only methods defined within the class or other instances of the same class can access/overwrite instance variables.

Ruby has an `attr_accessor` method from the `Module` class that creates both a getter and setter method.

*26) What is a getter method?*
A getter method is an instance method we define in a class that allows us to read an instance variable by returning the value of the instance variable. Ruby has a shorthand `Module#attr_reader` method that allows us to quickly create a getter method inside a class definition.

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
```
class Dog
  attr_writer :name

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

ted.name = "Frank"
# "Frank"

ted.name
# => "Frank"
```
*28) How do you decide whether to reference an instance variable or a getter method?*
Whether we reference an instance variable or a getter method can depend on whether we need to perform any additional transformation on the object referenced by the instance variable, or want to add validation or guard logic. In these cases, a getter method can enable this (and reduce the amount of times we need to apply the validation/transformation logic in our code), whereas the instance variable is limited to whatever object it is referencing (i.e. without any transformation or validation or guard logic). A getter method can also be useful if we want to make the instance variable accessible outside the class where it is defined (when it is either protected or public), since instance variables cannot be accessed outside of the class definition unless a getter method is provided. 

### Instance methods, class methods, self
*29) When would you call a method with self?*
Within a class definition, if we have a setter method and want to utilise this setter method within another instance method definition, we will need to prepend `self` to the setter method name, otherwise Ruby will interpret the setter method as a local variable instead of the setter method. We *could* also prepend `self` to our getter methods, though this is unnecessary (since there is no `=` operator required, Ruby will not assume local variable assignment is happening), and often discouraged by the Ruby community.

Although somewhat contrived, we have an example of using the `self` keyword prepended to the setter method `name`. If we did not prepend `self`, Ruby would interpret the `name` setter method as a local variable. Therefore if we called the `rename` instance method, it would return a local variable `name` assigned to the object provided to the `name` argument, and the instance variable `@name` would be unchanged.
```
class Dog
  def initialize(name)
    @name = name
  end

  def rename(name)
    self.name = name
  end

  private

  attr_writer :name
end

d = Dog.new("Ted")
# => #<Dog:0x00007fe539022738 @name="Ted">

d.rename("Jeff")
d
# => #<Dog:0x00007fe539022738 @name="Jeff">
```
*30) What are class methods?*
Class methods are methods defined on the class itself. We can identify these by the `self` keyword prepended to the method definition. In the context of class methods, when `self` is used as a prefix, it refers to the class itself - hence we are literally defining the method on the class itself. Class methods can only be called directly on the class itself - they cannot be called by objects instantiated from the class (attempting to do so will raise a `NoMethodError`), though class methods are inherited in the same fashion as instance methods. 

Class methods cannot access instance variables (as instance variables are only created when objects are instantiated from the class). Class methods can be useful when we need a class level method that does not have anything to do with the state of an object.
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
A class variable is a variable defined at a class level and initialised when the class is evaluated by Ruby (distinguish this from an instance level, which only occurs when an object is instantiated from a class). Class variables can be inherited by subclasses and are accessible by both class and instance methods (this  implies they are accessible within objects). They are denoted by `@@` symbols before a variable name. 

Within the Ruby community, the use of class variables is somewhat discouraged due to the fact that they can be inherited, and that all objects instantiated from the class (and subclasses inheriting from the superclass where the class variable is defined) share the same copy of the class variable, meaning it is easy to accidentally reassign the class variable, and have that change reflected across all subclasses and objects instantiated from that class and subclasses. 

In our example below, we define the `Animal` class with a class variable, `@@legs` and assign it to the integer object `4`. Once this class is defined by Ruby, the class variable is created. We call the class method `legs` and the instance method `legs`, which both return the `@@legs` class variable, which still references the integer object `4`.

However, as soon as we define the `Snake` class, which subclasses the `Animal` class, the class variable `@@legs` now points to the integer object `0`. We can observe the fact that this class variable is referencing `0` in the `Animal` superclass, as well as objects instantiated from the `Animal` class - `horse` in our case. 
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

We can identify constants by variable names starting with a capital letter (though by convention we usually use all capital letters when defining a constant). They are created and initialised when the class is defined (i.e. evaluated at runtime) and can be accessed by class or instance methods. Constants are different from instance or class variables, in that we are able to access constants from completely unrelated classes by using the namespace resolution operator `::`. This allows us to reach into other classes to access a constant. 

The other unique aspect of constants when compared with instance or class variables in that constants also have lexical scope, meaning that when attempting to evaluate the value of a constant, Ruby will look to the immediate class or module where the constant is referenced, and if it cannot find the constant definition at that location, Ruby will attempt to look up the inheritance chain for the constant definition.

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
*33) What is the default to_s method that comes with Ruby, and how do you override this? What are some important attributes of the to_s method?*
The default `to_s` instance method comes from the `Object` class in Ruby, and by default, print the name of the object's class and an encoding of the object's `object_id`. Often, this is not a particularly useful output, so we are able to use method overriding to replace the default functionality of the `Object#to_s` instance method to custom functionality, by defining a `to_s` method within a class definition.

Two important things to note are that the `Object#to_s` instance method is automatically called by Ruby during a `puts` method call on the argument (i.e. `puts argument.to_s`), as well as during string interpolation. This is demonstrated in our example below - when we call the `puts` method, Ruby automatically calls `to_s` on the `jack` object. Ruby finds a method definition for `to_s` in the `Dog` class definition, and hence calls `Dog#to_s` instead of `Object#to_s`. This is why `"Jack"` is printed, instead of the `Dog` class name and an encoding of the `jack` object's object_id. 

We also observe `to_s` being automatically called in our string interpolation - the code is equivalent to `#{d.to_s}`.
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

"Hello, I am a dog and my name is #{d}!"
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
In our example above, we use the `self` keyword in our `Dog#display_class` instance method. Thus when we call the `display_class` method, `self` is pointing to the object that called the `display_class` method, the `d` object instantiated from `Dog`. We then chain the `Class#class` method onto the `display_class` method, which returns the class of the `d` object.

Prior to Ruby 2.7, we could not use the `self` keyword when calling private methods within the class, as this would be the equivalent of calling the method on the object (i.e. calling the instance method outside of the class), which is prevented through use of the `private` method.

*35) What happens when you use self inside a class but outside of an instance method?*
When we use the `self` keyword inside a class definition but outside of an instance method, it refers to the class itself. This is useful when defining class methods (i.e. methods that are called directly on the class, and not on objects instantiated from the class).

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
We need to use the `self` keyword when calling private setter methods, as without `self`, Ruby will interpret the setter method as a local variable assignment, which will not change the state of the object when the private setter method is called.
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
