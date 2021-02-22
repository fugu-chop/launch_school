#### What is OOP and why is it important?
OOP is a programming paradigm that was created in response to programs becoming more complex and more difficult to maintain. Through use of classes, we break up our programs into a number of components designed for specific roles, allowing programmers to define the points of interaction between different components, reducing dependencies and improving maintainability of the code base.

OOP also allows us the flexibility to reuse and extend the functionality of code through polymorphism, or extending behaviours through modules and inheritance, and overriding methods.

OOP also lets us think about the functionality at a higher level of abstraction, allowing programmers to plan and design very complex programs using objects represented as 'nouns', with methods as the 'verbs'.

Benefits of OOP include:
- Large, complex programs can be difficult to maintain due to dependencies throughout the program. OOP lets programmers write programs in which the different parts of the program interact, thus reducing dependencies and facilitating maintenance.
- Coding in a non-OO way often means writing code that is useful solely within a single context. Defining basic classes and leveraging concepts like inheritance to introduce more detailed behaviors provides a greater level of reusability and flexibility.
- Complex coding problems are often difficult to break down and solve in a clear and systematic way. Using OOP to model classes appropriate to the problem, and using real-world nouns to represent objects, lets programmers think at a higher level of abstraction that helps them break down and solve problems.

#### What is encapsulation? How does encapsulation relate to the public interface of a class?
Encapsulation is the hiding of functionality within our program from the rest of the code base. It is a form of data protection such that the state of an object cannot be changed without deliberate and obvious intent. 

One form of encapsulation is the breaking up of a program's functionality into classes, where classes represent discrete parts of a program designed for specific functionality. Each class encapsulates a set of behaviours, and objects instantiated from those classes interact in specific ways with other objects, allowing for boundaries to be set for how objects interact with each other, reducing dependencies and making the program more maintainable. 

Another form of encapsulation is method access control. Method access control is a way to limit the behaviour of objects defined in classes, so that only strictly necessary interactions between objects are allowed. While most instance methods are public by default, private and protected methods also exist, which limit the ability of an object to call methods or directly interface with it's state thus protecting it's encapsulated data from external change.

#### What is an object? How do you initialize a new object/instance of a class?
In Ruby, anything that can be said to have a value can be regarded as an object (notable exceptions to this include variables, blocks and methods). Objects are instantiated from classes, using the `Class#new` or `Class#allocate` methods. 

When instantiated from a class, an object is able to access the methods that were defined within the class (depending on the level of method access control) - all objects instantiated from a class have access to the same set of methods. 

Objects can also have instance variables with assigned values after instantiation. These instance variables and their assigned values constitute the state of an object. State is unique to an object (i.e. state is not shared between different objects instantiated from the same class), and cannot be inherited, as it can only exists after objects are instantiated from a class (only classes can inherit from other classes).

#### What is an instance variable, and how is it related to an object? *
An instance variable is a *variable initialised after an object is instantiated*. They are identified by the `@` symbol prepended to the variable name.

Instance variables are scoped at an object level, and are accessible to instance methods within an object, regardless of where they are defined. However, they are not accessible outside of an object, unless an explicit getter or setter method is defined in the class. 

Instance variables, and their assigned values, contribute to the state of an object. State is unique to an object (i.e. state is not shared between different instances of an object) and cannot be inherited. 

In our example below, we define a `Dog` class on `lines 1-7`. Within this class, we define an instance method `initialize` on `lines 4-6`, which is automatically called when an object is instantiated from the `Dog` class. We instantiate an object from `Dog` on `line 9` and assign it to the local variable `ted`, at which point the `initialize` method is automatically called. This will initialise a `@name` instance variable, and assign it the string object `"Ted"` which was passed to the `Dog#new` method when we instantiated the object. At this point, `ted` has state.

We can instantiate another object from `Dog`, `fred` (per `line 10`). Note how when we instantiate a new object from `Dog`, the state within the other object `ted`, is not affected, since state is unique to each object.
```ruby
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Ted")
puts ted.name
# "Ted"
# => nil

fred = Dog.new("Fred")
puts ted.name 
# "Ted"
# => nil
```
#### What is an instance method? *
An instance method is a method that is defined within a class. Once an object is instantiated from that class, it will have access to those methods, depending on the level of method access control applied to a method (all objects instantiated from a particular class will have access to the same set of methods). *Instance methods can be inherited from superclasses or mixed in through modules.*

In our below example, we define the `Dog` class on `lines 1-5` using the `class` and `end` reserved words. Within this class, we define a public `speak` instance method using the `def` and `end` reserved words. This method returns a string object, `"Woof!"`.

On `line 7-8`, we define another class, `Greyhound`, which subclasses `Dog` (denoted by the `<` symbol, followed by the `Dog` class). This means that `Greyhound` has access to the instance methods defined within the `Dog` class. 

This is shown on `line 11` - after we instantiate an object from the `Greyhound` class using the `new` method, we are able to call the `speak` method directly on the object (as it is a public instance method), even though the `speak` method was not explicitly defined within the `Greyhound` class.
```ruby
class Dog
  def speak
    "Woof!"
  end
end

class Greyhound < Dog
end

d = Greyhound.new
puts d.speak
# "Woof!"
# => nil
```
#### What is the scoping rule for instance variables? *
Instance variables are scoped at an object level. This means that after they are initialised (and have values assigned to them), instance methods are able to access them, regardless of where they are defined. However, instance variables need to be initialised and values assigned to those instance variables in order for them to constitute state.

In our example below, we have a `Dog` class definition. Within this class, we have two public instance methods, `Dog#age` and `Dog#name`. These instance methods are able to access the `@age` and `@name` instance variables respectively, even though these methods were not explicitly passed references to these instance variables as arguments, and the instance variables are initialised and assigned values elsewhere (i.e. the `initialize` method once an object is instantiated from the `Dog` class). 

However, we also have defined a public getter method, `Dog#breed` which is provided by the `attr_reader` method. However, the `@breed` instance variable is never initialised after the object has been created, and as such, returns `nil` when called. The string object `"greyhound"` passed to the `initialize` method is simply ignored. As such, `@breed` is not part of the `ted` object's state.
```ruby
class Dog
  attr_reader :breed

  def initialize(name, age, breed = "greyhound")
    @name = name
    @age = age
  end

  def age
    "I am #{@age * 7} years old!"
  end

  def name
    "My name is #{@name}!"
  end
end

ted = Dog.new("Teddy", 3)
puts ted.age
# "I am 21 years old!"
# => nil

puts ted.name
# "My name is Teddy!"
# => nil

puts ted.breed
# => nil
```
#### How do you see if an object has instance variables? *
We can call the `Object#instance_variables` method on an object, which will return an array of *initialised* instance variables, cast as symbols. Uninitialised instance variables or instance variables without values assigned to them will not be displayed.

In our example below, we define a `Dog` class on `lines 1-6`, with an `initialize` instance method on `lines 2-5`. When we instantiate an object from the `Dog` class on `line 8`, the `initialize` method is called, and the `"Ted"` string object passed to the `Dog.new` method call is forwarded to the `initialize` method. At this point, the instance variable `@name` is initialised and has a value assigned to it. As such, the `ted.instance_variables` method call returns an array with `:name`. 

The `@age` instance variable __does not__ appear in this array, because while we initialised the `@age` variable in the `initialize` method, we never assigned it a value. Hence, it will not show up in the `ted.instance_variables` method call.
```ruby
class Dog
  def initialize(name)
    @name = name
    @age
  end
end

ted = Dog.new("Ted")
ted.instance_variables
# => [:name]
```
#### What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?
A class is a template for an object. Objects are instantiated from classes. Objects are defined using the `class` and `end` reserved words. Within a class, we can define the instance methods that an object instantiated from that class has access to (depending on the level of method access control we exert over these instance methods).

Classes can inherit methods from other classes, while objects cannot be inherited or inherit from other objects (since objects are just instances of classes). Objects do not inherit state from classes - classes provide the instance methods that can initialise instance variables within an object. Only once an object is instantiated from a class, can state exist.

#### When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?
Behaviours refer to the instance methods that are defined within a class, that an object can have access to once they are instantiated from that class. Behaviours can be explicitly defined within the class, inherited from a superclass or mixed in via modules. All objects instantiated from the same class will gain access to the same set of instance methods (whether they can call those methods depends on method access control).

State refers to the series of instance variables and their assigned values encapsulated within an object. State does not exist until the instance variable is initialised and a value assigned to it, which can only occur after an object is instantiated. State is unique to each object (i.e. different instances of the same class do not share state between them) and cannot be inherited, since objects and their data cannot be inherited (only classes can be inherited).

#### How do objects encapsulate state? *
Objects encapsulate state as the instance variables (and their assigned values) are not accessible outside of the object unless a getter or setter method exists. Thus the data within the object is protected unless there is an explicit method to interface with it. 

Another interpretation is that state is unique to each object - i.e. the instance variables and their assigned values are unique to each object (they are not shared between instances of the same class). Each object encapsulates it's own state, meaning that changes to the state of one object will not change the state of all other objects instantiated from the same class.

In our example below, we define a `Dog` class on `lines 1-5` using the `class` and `end` reserved words. We instantiate an object from the `Dog` class on `line 7` using the `Dog.new` method. This will automatically call the `initialize` method, which accepts the string object `"Teddy"` we passed to the `Dog.new` method call. 

The `initialize` method then initialises a `@name` instance variable and assigns it to `"Teddy"`. At this point, the `@name` instance variable and it's assigned value becomes part of `ted`'s state, and is encapsulated within that object. As we do not define a getter method for the `@name` instance variable, it is not accessible outside of the object.
```ruby
class Dog
  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
ted.name
# NoMethodError (undefined method `name' for #<Dog:0x00007fb2159cf8f0 @name="Teddy">)
```
#### What is a collaborator object, and what is the purpose of using collaborator objects in OOP? *
A collaborator object is any object that is assigned to an instance variable after an object is instantiated from a class. They are useful in helping programmers define associative relationships between different classes (e.g. "has-a" relationships), where those classes may not fit within a hierarchical, inheritance style relationship (e.g. "is-a" relationships). We can think of collaborator objects as lower levels of abstraction of the owner object whose class incorporates them.

Collaborator objects allow us to achieve encapsulation, as behaviours can be kept specific to the relevant classes, and the interactions between these classes can be defined through collaborative relationships. The collaborative relationship only exists once the instance variables are initialised and values assigned to them.

In our example below, we define a `Dog` and `Owner` class with the `class` and `end` reserved words. These classes have no hierarchical relationship to each other. 

We first instantiate an object from the `Owner` class and assign it to the local variable `jeff`.
When we instantiate an object from the `Dog` class (assigning it to the `ted` local variable), the `Dog#initialize` method is called. 

At this point, the `@name` instance variable is initialised, and the string object `"Teddy"` that was passed to the `Dog.new` method is assigned to the `@name` instance variable. At this point, the string object `"Teddy"` has become a collaborator object of the `ted` object (since now `ted` "has-a" name). 

The same principle applies for the `@owner` instance variable. However in this case, the object assigned to the `@owner` instance variable is a custom object, which has it's own instance methods (`Owner#identify`), which are encapsulated within the `Owner` class, but are accessible to the `ted` object through a collaborative relationship (since `ted` "has-a" owner).
```ruby
class Owner
  def initialize(name)
    @name = name
  end

  def identify
    "Hello! My name is #{@name}!" 
  end
end

class Dog
  attr_reader :name

  def initialize(name, owner)
    @name = name
    @owner = owner
  end

  def owner
    @owner.identify + " I am #{name}'s owner!"
  end
end

jeff = Owner.new("Jeff")
ted = Dog.new("Teddy", jeff)
puts ted.name
# "Teddy"
# => nil

puts ted.owner
# "Hello! My name is Jeff! I am Teddy's owner!"
# => nil
```
#### Why should a class have as few public methods as possible? *
In keeping with the principles of encapsulation, classes should avoid using public methods where possible, as the more public methods accessible to objects, the larger the number of ways that an accidental change to the state of an object is possible. Reducing the number of public methods improves data protection.

In our example below, we define a `Dog` class using the `class` and `end` reserved words on `lines 1-7`. Within this method, we have a single public instance method provided through the `attr_reader` method, `Dog#name` (since `initialize` is private by default). This enables us to access the `@name` instance variable directly on an object instantiated from `Dog`. 

We instantiate an object from `Dog` on `line 9`, passing a string object `"Teddy"` to the `Dog.new` method, which is passed to the `initialize` method which is automatically called when an object is instantiated from the `Dog` class. At this point, the instance variable `@name` is initialised and a value assigned to it (thus becoming part of the object's state).

Note that we have not explicitly defined a setter method that would allow us to change the `@name` instance variable. However, because the `@name` instance variable points to a string object `"Teddy"`, that object has access to instance methods of the `String` class, allowing a destructive change to the value assigned to `@name`. 

This destructive change was possible because we created a public instance method. We could have solved this by simply not allowing direct access to the `@name` instance variable, or creating a custom getter method where the method would return a clone of the `@name` instance variable.
```ruby
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
ted.name
# => "Teddy"

ted.name.reverse!
# => "yddeT"

ted.name
# => "yddeT"
```
#### What is the private method call used for? *
The `private` method is a form of method access control. It ensures that instance methods defined as `private` cannot be called directly on objects instantiated from the class (attempting to do so will result in a `NoMethodError`). Private methods are accessible within the class, however.

In our example below, we have defined a `Dog` class using the `class` and `end` reserved words (`lines 1-13`). We have also made use of the `private` method, underneath which we have defined the `attr_reader` method, which creates a getter method that returns the `@name` instance variable. 

Because the `Dog#name` getter method is a `private` method, it cannot be called directly on objects instantiated from `Dog` - this will raise a `NoMethodError` per `line 16`. However, private methods can be referenced within the class - per `line 6-8`, we define a public instance method `Dog#identify`, which calls the `Dog#name` method, even though it is private. 

The `Dog#identify` method can be called directly on objects instantiated from the `Dog` class and are able to reference the return value of the `Dog#name` private method.
```ruby
class Dog
  def initialize
    @name = "Ben"
  end

  def identify
    "Hello! My name is #{name}!"
  end

  private

  attr_reader :name
end

ben = Dog.new
ben.name
# NoMethodError (private method `name' called for #<Dog:0x00007f94d097d580 @name="Ben">)

puts ben.identify
# "Hello! My name is Ben!"
# => nil
```
#### What is the protected method used for? *
Protected methods are a form of method access control. They ensure the protected methods cannot be called directly on objects, but only from within the class where the instance method was defined, or by other instances of the same class. They act as a 'middle' ground between public and private methods.

In our below example, we have a `Spy` class. On `line 10`, we use the `protected` method call to ensure that the getter method provided for the `@name` instance variable through the `attr_reader` method is protected. 

This prevents the `Spy#name` instance method from being called directly on objects instantiated from the `Spy` class. However, the protected method is still accessible throughout the class, since the `Spy#meet` method is able to call the protected `name` method. 

Protected methods are also accessible by other instances of the same class - this is how the `Spy#meet` method is able to access the `name` instance method within the `k` object despite being protected.
```ruby
class Spy
  def initialize(name)
    @name = name
  end

  def meet(other)
    "Codename: #{name[0]} meets with Codename: #{other.name[0]}."
  end

  protected

  attr_reader :name
end

j = Spy.new("Jessica")
k = Spy.new("Kevin")
puts j.name
# NoMethodError (protected method `name' called for #<Spy:0x00007fedf38d8180 @name="Jessica">)

puts j.meet(k)
# "Codename: J meets with Codename: K."
# => nil
```
#### Classes also have behaviors not for objects (class methods). How do you define a class method? *
A class method is a method that is only callable directly on a class (they cannot be called on instances of the class). They can be inherited. We define them by appending a `self` to the method name when defining a method within the class. When `self` is used outside of an instance method definition, it refers to the class, so in the case of a class method definition, we are literally defining the method directly on the class.

In our example below, we define a `Dog` class using the `class` and `end` reserved words (`lines 1-5`). We then define a class method on `lines 2-4`; we prepend the `self` keyword to the method name. As we have used `self` outside of an instance method definition, the use of `self` refers to the class - hence we are defining the method directly on the class. 

The `Greyhound` class subclasses the `Dog` class, and so has access to the `identify` class method.
```ruby
class Dog
  def self.identify
    self
  end
end

class Greyhound < Dog
end

Greyhound.identify
# => Greyhound
```
#### What is polymorphism? *
Polymorphism describes the ability of different objects to respond to a common interface (i.e. method). It enables code to be flexible and reusable, reducing the amount of repetition that is required in our code. Polymorphism can be implemented through mixing in modules, method overriding, duck-typing and inheritance (to name a few). 

*Polymorphism can act as an opposite counterpart to encapsulation - encapsulation is concerned with reducing functionality of objects, while polymorphism extends functionality to reduce repetition and improve flexibility. This is often a tradeoff that must be made in the program design.*

In our below example, we define an `Animal` class, which superclasses the `Dog`, `Bird` and `Turtle` class. As such, objects instantiated from each of those subclasses will have access to the `speak` and `move` instance methods defined in the `Animal` class (class inheritance), despite being different objects. However, the `Dog` class has it's own implementation of the `speak` method; an example of method overriding (a type of polymorphism).

Another example of polymorphism in this example is interface inheritance, or mixing in modules to classes to extend those classes' behaviours. We have a `Swimmable` module, which is mixed into the `Dog` and `Turtle` classes. Objects instantiated from these classes will also have access to the `swim` module.

Finally, we also have an example of duck-typing within our code. In the `Party` class, we define the `party` instance method. This takes an argument of iterable objects, each of which is assumed to have a `speak` method (but there is no assumption that the `speak` method will do the same thing across each of these classes).
```ruby
module Swimmable
  def swim
    "Swimming!"
  end
end

class Animal
  def speak
    "Hello!"
  end

  def move
    "Moving!"
  end
end

class Dog < Animal
  include Swimmable

  def speak
    "Woof!"
  end
end

class Bird < Animal
end

class Turtle < Animal
  include Swimmable
end

class Party
  def party(friends)
    friends.each { |friend| puts friend.speak }
  end
end

Party.new.party([Dog.new, Bird.new, Turtle.new])
# Woof
# Hello!
# Hello!
# => [#<Dog:0x00007fd2998561c8>, #<Bird:0x00007fd2998560b0>, #<Turtle:0x00007fd299856088>]
```
#### What is inheritance? *
Inheritance is a mechanism that allows classes to access behaviours from classes higher in an hierarchical chain. Classes can inherit methods from a single superclass, which gives them access to methods defined in that superclass without having to explicitly define those methods in the subclass. *Note that a class can only inherit from a single other class.*

Inheritance enables us to model classes that fit a hierarchical relationship (i.e. "is-a" relationships between classes) and reduce the amount of repeated code in our program. We can make a class inherit from another class by adding a `<` symbol next to a class definition, followed by the name of the class from which it should inherit methods from.

In our example below, we define a `Dog` class, which inherits from the `Animal` class (we set up the hierarchical inheritance relationship by using the `<` symbol followed by the superclass). This means that objects instantiated from the `Dog` class will also have access to instance methods defined in the `Animal` superclass through the method lookup path. 

When we attempt to call the `speak` method on an instance of `Dog`, Ruby will first attempt to find a method definition in the `Dog` class. Since this does not exist, Ruby will look up the method lookup chain to the superclass `Animal`, where it finds the appropriate definition. Ruby will then call the `speak` method from the `Dog` class, taking the definition from the `Animal` class. This is how the object instantiated from the `Dog` class on `line 10` is able to call the `Animal#speak` method.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class Dog < Animal
end

puts Dog.new.speak
# "Hello!"
# => nil
```
#### What is duck-typing? *
Duck typing is a form of polymorphism. Duck-typing can be implemented by defining a method of the same name across classes that are not related through inheritance (though this does not imply that the methods should have the same functionality). Through duck-typing, we ensure that objects are flexible enough to respond to a common method call.

In our example below, we have three classes, `Kite`, `Bird` and `Plane` which are unrelated to each other, either through collaboration or inheritance. Each of these classes has a public `fly` instance method, which returns a string object.

We also define an `Airshow` class, with the `show_off` instance method designed to take advantage of duck-typing. In this instance method, we pass an array of objects as an argument. Ruby is simply assuming that each object will have a `fly` method, and attempts to call that method on each object, irrespective of what that method actually does or returns.
```ruby
class Kite
  def fly
    "I drift through the wind"
  end
end

class Bird
  def fly
    "I glide through the air"
  end
end

class Plane
  def fly
    "I blast through the sky"
  end
end

class Airshow
  def show_off(attendees)
    attendees.each { |attendee| puts attendee.fly }
  end
end

Airshow.new.show_off([Kite.new, Bird.new, Plane.new])
# I drift through the wind
# I glide through the air
# I blast through the sky
# => [#<Kite:0x00007f9f2f8e0578>, #<Bird:0x00007f9f2f8e0500>, #<Plane:0x00007f9f2f8e04d8>]
```
#### What is the super method? *
The `super` method is a way we can call methods of the same name defined in a superclass or a mixed-in module - it is a way we can implement method overriding and polymorphism into our code. The functionality of the `super` method can differ, depending on whether arguments are provided to it:
- Calling `super` without any parentheses or arguments will forward all arguments provided to the subclass method to the superclass/module method, and call that method.
- Calling `super()` with parentheses but without arguments will call the superclass/module method without any arguments. This is often the safest way to avoid `ArgumentErrors` when the superclass/module method does not take any arguments.
- Calling `super(arg1, arg2)` will forward `arg1` and `arg2` to the superclass/module method, and then call that method.

In our example below, we define an `initialize` and `speak` method in the `Animal` class. The `Dog` class subclasses the `Animal` class (denoted by the `<` operator followed by the `Animal` class name). This means that the `Dog` class has access to the instance methods defined in the `Animal` class. Within `Dog`, there is method overriding across the `initialize` and `speak` method. 

In the `initialize` method, the `Dog` implementation uses the `super(name)` method, meaning when an object is instantiated from the `Dog` class, the `Dog#initialize` method will call the `Animal#initialize` method, passing the `name` argument to the `Animal#initialize` method. The `Dog# initialize` method takes a second argument, `age`, which we also pass an object on `line 22`, extending the state encapsulated within the object.

In the `Dog#speak` method, we make use of `super()`, which when invoked, will call the `Animal#speak` method without any arguments. The `Dog#speak` method then appends an additional string object with string interpolation, extending the functionality of `Animal#speak`.
```ruby
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    "Hello!"
  end
end

class Dog < Animal
  def initialize(name, age)
    super(name)
    @age = age
  end

  def speak
    super() + " My name is #{@name} and I am a #{@age} year old #{self.class}!"
  end
end

teddy = Dog.new("Teddy", 4)
puts teddy.speak
# "Hello! My name is Teddy and I am a 4 year old Dog!"
# => nil
```
#### Why can't we use the `self` prefix on private getter methods? *
Prior to Ruby 2.7, we were unable to use the `self` prefix on private getter method when referencing those methods in other instance methods. This is because `self`, when used in the context of an instance method definition, refers to the calling object. 

Thus when a private method is called in another instance method using `self`, this would be the equivalent of calling the private getter method directly on the object iself, which is prohibited by the `private` method. As of Ruby 2.7 and beyond, it is now possible to use the `self` keyword as a caller for a private getter method, but it appears to be generally accepted practice to simply not use `self` for private getter methods (one likely factor is to ensure pre-2.7 Ruby compatibility).

In our below example, we have defined a private getter method `name`. In the `identify` instance method, we call the `name` instance method through the string interpolation. However, since we have prefixed the method call with `self`, when inside an instance method (the `identify` method), the `self` actually refers to the calling object, `ted`. Since private methods cannot be directly called on objects, this raises a `NoMethodError`. We could remedy this by removing `self` from the `name` method call.
```ruby
class Dog
  def initialize(name)
    @name = name
  end

  def identify
    "Hello! My name is #{self.name}!"
  end

  private

  def name
    @name
  end
end

ted = Dog.new("Ted")
ted.identify
# NoMethodError (private method `name' called for #<Dog:0x00007fddd80ab348 @name="Ted">)
```
#### What is method overriding? *
Method overriding is a way of implementing polymorphism in code. When a class has access to a method through inheritance or a mixed in module, the class can implement it's own version of that particular method by explicitly defining a method of the same name, but have different functionality (thus overriding the original functionality). This allows us to extend the flexibility of code.

In our example below, we define a class `Animal` with an instance method `speak`. Since the `Dog` class subclasses `Animal`, it would ordinarily have access to the `Animal#speak` method as well. However, we have overridden the `Animal#speak` method with a custom implementation within the `Dog` class, which will be called instead of `Animal#speak`. This is because when an instance of `Dog` calls the `speak` method, the method lookup path starts with the immediate class from which the object was instantiated.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class Dog < Animal
  def speak
    "Woof!"
  end
end

puts Dog.new.speak
# "Woof!"
# => nil
```
#### What is a module? When would we use a module? (classes and methods, or just methods?)
A module can be a grouping of methods that can be mixed into classes, allowing those classes to access the methods defined in the module. Modules are a way that we can implement polymorphism into our code, since *any number of modules can be mixed into any class* (there is no requirement that classes be related to each other), though *objects cannot be instantiated from modules*.

Modules can also be used for namespacing, or grouping classes and methods together. Namespacing assists in organising code, as well as preventing naming conflicts where methods may have the same name across different classes by allowing us to reference which class a module method comes from, with the namespace resolution operator `::`.

#### Why should methods in mixin modules be defined without using `self.` in the name? *
Methods in mixin modules should not be defined using `self`. Typically, when `self` is used outside of an instance method definition, it refers to the class. If we use the `self` keyword in a method definition, it will refer to the class, creating a class method definition. 

Even if we mix in a module to a class, attempting to call the method on the class which has the module mixed in will return a `NoMethodError`, since through the `self` keyword, have directly defined the method *on the module*. When we call the class method, we need to specify the class in which the method was defined. Ruby will then look for the class method definition in the class from which the object was instantiated (where it does not exist). Thus the only way to call the method would be to reference the module specifically, using the namespace resolution operator `::`.

In our example below, we define a `Walkable` module, with a method prepended with a `self` keyword, thus creating the equivalent of a 'class' method. However, when `self` is appended to a method definition, it refers to the class. In the below example, this refers to the module itself (`Walkable`) This means that even if we mix `Walkable` into other classes, the classes where `Walkable` is mixed in will never be able to call `walk`, since the class on which the method is defined is the `Walkable` module. We would only be able to call `walk` using the namespace resolution operator on the `Walkable` module.
```ruby
module Walkable
  def self.walk
    "I can walk!"
  end
end

class Person
  include Walkable
end

Person.walk
# NoMethodError (undefined method `walk' for Person:Class)

ted = Person.new
ted.walk
# NoMethodError (undefined method `walk' for #<Person:0x00007fddd7145138>)

puts Walkable::walk
# I can walk!"
# => nil
```
#### What is the method lookup path? *
The method lookup path is the chain of classes and modules Ruby will look through in order to find a method definition. When caling a method, Ruby will first search the class from which the object was instantiated when looking for a definition (or the class itself, in the case of a class method).

If Ruby does not find a method definition, it will then search any mixed in modules (starting from the last mixed in module), then repeat the process in the superclass (if applicable), and again until reaching the `BasicObject` class (the highest point in the method lookup path). A `NoMethodError` will be raised if the method definition cannot be found. Otherwise, Ruby will stop looking along the method lookup path at the first instance when it identifies a method definition for the method called.

In our below example, we define an `Animal` class on `lines 1-5` and `Dog` class which inherits from `Animal` on `lines 7-12`. We instantiate a `Dog` object on `line 14`, calling the `Dog#speak` method. Ruby will first attempt to look in the `Dog` class for a `speak` method definition, which it does find. However, the `Dog#speak` method calls another method, `sound`. 

Ruby will again attempt to look in the `Dog` class for a `sound` instance method. However, there is no explicit definition of `sound` in the `Dog` class, so Ruby will travel up the method lookup chain to the `Animal` class, which superclasses `Dog`. Here, a instance method definition is found, which will be called in the `Dog#speak` method.
```ruby
class Animal
  def sound
    "Hello!"
  end
end

class Dog < Animal
  def speak
    sound
  end
end

puts Dog.new.speak
# Hello!
# => nil
```
#### What are class variables? Why is it not recommended to use them? *
A class variable is a variable scoped at the class level. It can be identified by the `@@` symbols preceding the variable name and is *initialised when the class is evaluated by Ruby. Class variables are accessible to both class and instance methods, regardless of where a class variable is defined*.

They can be useful when tracking data that is not linked to the state of objects, but can prove problematic for the fact that all instances of the class where the class variable was defined (and subclasses of that class, and objects instantiated from those subclasses) share a single copy of that class variable, meaning that any change to the class variable across any of those classes or objects will mean that change will be reflected across all of the subclasses and objects instantiated from the class and subclasses.

In our example below, we define a `@@legs` class variable (denoted by the `@@` symbols prior to the variable name) and assign it to the Integer object `4` in the `Animal` class. We also define class and instance methods to return the value of `@@legs`.

As we call `Dog#legs` (instance method) and `Dog::legs` (class method), these return the integer object `4`, as expected. However, once we define a `Bird` class (which subclasses `Animal`) and reassign the `@@legs` class variable to reference the integer object `2`, this change is now reflected in the `Dog` class, as well as all objects instantiated from the `Dog` class. This is why it is not generally recommended to use class variables.
```ruby
class Animal
  @@legs = 4

  def self.legs
    @@legs
  end

  def legs
    @@legs
  end
end

class Dog < Animal
end

Dog.new.legs
# => 4

Dog.legs
# => 4

class Bird < Animal
  @@legs = 2
end

Dog.legs
# => 2

Dog.new.legs 
# => 2
```
#### What are constants? What do we need to be careful of when dealing with constants? *
Constants are variables that should not have their value reassigned throughout the course of the program's operation (Ruby does allow reassignment of values, but will raise a warning). They can be identified by a variable name with a capital letter (though convention usually dictates that the entire variable name is in capital letters). 

Constants are *defined at a class level (attempting to define a constant within an instance or class method will return a `SyntaxError - dynamic constant assignment`)*. As such, *constants are accessible to both class and instance methods*, and have lexical scope. Constants are also unique compared with class or instance variables in that they can be referenced from other, unrelated classes by using the namespace resolution operator `::`.

This means that when Ruby encounters a method that requires evaluation of the constant, Ruby will look at the class or module where that method was defined for the definition of the constant, which can prove problematic if a constant is defined in a different class to where the method is defined.

In our example below, we define the `LEGS` constant and assign it to the integer object `4` in the `Animal` class. We also define an instance method, `legs`, which returns the value of the constant. We define a second class, `Bird` which subclasses `Animal`. 

When we instantiate an object from the `Bird` class (assigned to the local variable `oscar`), we are able to call the `legs` method, as `Bird` has access to the instance methods defined in `Animal` due to class inheritance. The `legs` method references the `LEGS` constant.

However, because constants have lexical scope, when attempting to evaluate `LEGS`, Ruby will look to the class where the `legs` instance method references `LEGS` - i.e. in the `Animal` class. This is why `oscar.legs` returns `4`, despite `Bird` reassigning the `LEGS` constant to another integer object. We could rectify this by appending `self.class::` to the return value of the `legs` instance method, as:
- As this is an instance method, `self` refers to the calling object (`oscar`, in our case). We can then chain the `.class` method onto this, to refer to the `Bird` class. 
- We use the namespace resolution operator `::` to point the `LEGS` constant to a particular class from which reference a value.
```ruby
class Animal
  LEGS = 4

  def legs
    LEGS
  end
end

class Bird < Animal
  LEGS = 2
end

oscar = Bird.new
oscar.legs
# => 4
```
#### What is a getter/setter/accessor method? What do each of these return?
A getter instance method is a method normally that returns an instance variable. We can use the `attr_reader` method in Ruby to quickly create a getter method. A setter instance method is a method that allows us to change the value assigned to an instance variable. It will return the value that was provided as an argument to the method. 

#### When should we use getter/setter methods? *
We should use a getter or setter method only if we want other parts of our program to have direct access to/ability to change instance variables within an object. We might also want to format the instance variable or change the presentation of that instance variable for other parts of the program to consume through a custom getter or setter method.

In our below example, we define a `Spy` class on `lines 1-9`. When we instantiate an object from the `Spy` class on `line 11`, we pass a string object `"Tim"` to the `new` method. As the object is instantiated, the `initialize` method is called, and the string object `"Tim"` is forwarded to the `initialize` method, at which point the `@name` instance variable is initialised and the string object assigned to it. 

As spies typically don't want to give out their name, we don't want to simply rely on the `attr_reader` to generate an instance getter method, as this would simply return the value referenced by the `@name` instance variable, without obfuscation. Instead, we define our own custom getter method on `lines 6-8` to return a hidden version of the value referenced by the `@name` instance variable.
```ruby
class Spy
  def initialize(name)
    @name = name
  end

  def name
    "Codename: #{@name[0]}"
  end
end

t = Spy.new("Tim")
puts t.name
# "Codename: T"
# => nil
```
#### What is the self keyword? How do we use it? *
The `self` keyword can change the way a method behaves, and it's meaning can change depending on the context which it is used. 
- When used outside of an instance method definition, it refers to the class where it is used. This means that we can define methods on a class (i.e. class methods) by appending `self` to a method definition.
- When used inside of an instance method definition, it refers to the calling object. This may have method access control implications if we attempt to append `self` to a private getter method (since we cannot call private methods directly on objects) on versions of Ruby prior to 2.7. There is no issue with using `self` on private *setter* methods, however (in fact we need to use `self` on all setter methods - otherwise Ruby will interpret the setter method call as a local variable assignment).
  - We can use `self` to reference public and protected getter methods.
- When referencing getter methods in other instance methods, there is an implicit `self` on the getter method call (this is how we can call private instance methods - by only using the implicit `self` and __not__ the explicit `self`).

In our below example, we show a number of different usages of `self`. 

On `lines 2-4`, we append the `self` keyword to a method definition. In this context, `self` is used outside of an instance method, and thus refers to the class. This has the effect of defining a class method, which can only be called on the `Robot` class, per `line 37`. 

On `lines 18-19`, we show a different usage of `self`. In this case, we append `self` to a instance method name. This is necessary as these are setter methods - without the `self` reference, Ruby will interpret `lines 18-19` as being local variable assignments, which would not reassign the `@name` and `@age` instance variables, leaving `ted`'s state unchanged. In this case, `self` refers to the calling object, `ted`.

In versions of Ruby prior to 2.7, we could not typically append `self` to private methods, since private methods prevent objects from directly calling private instance methods - this is what we observe on `line 31`, which raises a `NoMethodError`, since calling `self.name` is the equivalent to calling the private `name` method directly on the `ted` object. However, setter methods are an exception to this (to avoid issues of Ruby misinterpreting setter method calls as being local variable assignments) - this is how the `Robot#remake` method is able to change the state of the `ted` object.
```ruby
class Robot
  def self.species
    self
  end

  def identify
    "My name is #{name} and I am a #{age} year old robot."
  end

  def initialize(name, age)
    @name = name
    @age = age
  end

  def remake(name, age)
    self.name = name
    self.age = age
  end

  def my_name
    self.name
  end

  private

  attr_accessor :name, :age
end

ted = Robot.new("Ted", 4)

ted.my_name
# NoMethodError (private method `name' called for #<Robot:0x00007febd182e7f8 @name="Ted", @age=4>)

puts ted.identify
# My name is Ted and I am a 4 year old robot.
# => nil

Robot.species
# => Robot

ted.remake("Bob", 2)

puts ted.identify
# My name is Bob and I am a 2 year old robot.
# => nil
```
#### What is the default `to_s` method in Ruby? How/why would you override this? *
The default `Object#to_s` method, when called on an object, will return a string representation of the class name and an encoding of the object id. The `to_s` method is also automatically called on the argument provided to the `puts` method call, as well as during string interpolation.

This output is not particularly useful for human consumption, so we often make use of method overriding in order to change the implementation of the `to_s` to a more appropriate feature (e.g. returning an instance variable instead). 

We could achieve this by defining a public `to_s` instance method within a class, which would enable the human readable implementation to be called on the object directly.

In our example below, we define a custom `to_s` method on `lines 6-8` that overrides the `Object#to_s` method. This is why when we pass the object referenced by `davy` as an argument to the `puts` method call, the `@name` instance variable is returned, instead of the `Person` class name and an encoding of `davy`'s object id (since the `to_s` method is called automatically on the object passed by reference as an argument to the `puts` method).
```ruby
class Person
  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end
end

davy = Person.new("Davy")
puts davy
# "Davy"
# => nil
```
#### What is a fake operator?
A fake operator is a method that looks like an operator due to the syntactical sugar in Ruby. Examples include `+`, `<`, `[]`. Because these are methods and not operators, their functionality can be changed through method overriding. 

#### How does equivalence work in Ruby?
The concept of equivalence in Ruby can have two meanings:
1. Whether the value of two objects are the same
2. Whether the two objects occupy the same space in memory.

In Ruby, the `BasicObject#==` method compares whether two objects occupy the same space in memory (i.e. are the same object). However, most classes have their own implementation of the `==` method that overrides the `BasicObject#==` implementation in favour of comparing the values of two objects (e.g. `String#==`, `Array#==`). `Integer` and `Symbol` `#==` methods do the same thing; however in Ruby, if an `Integer` or `Symbol` object have the same value, they are also the same object (this is a performance optimisation concern though).

However, the `Object#equal?` method does compare whether two objects occupy the same space in memory, and is seldom overridden by custom methods within classes, as this is a consistent way of comparing object identities. 

#### What is the `===` method?
By default, the `Object#===` method returns `true` if two objects occupy the same space in memory (same as the `BasicObject#==` method). However, most classes override this method to compare whether the object passed as an argument is part of the set on which the method is called. It is commonly used in `case` statements when evaluating whether conditions in the `when` statements are met.
```ruby
String === 'hello'
# => true
'hello' === 'hello'
# => true

# Case statement implementation
num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end

# Is equivalent to
num = 25

# Using Range#===
if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end
```
#### What is the `eql?` method? *
The `Object#eql?` method returns true if two objects have the same value and occupy the same space in memory. Most classes have their own implementation of this, such that it compares whether the values of the two objects are the same (e.g. `String#eql?`). 

While not a commonly used method, the `Hash` implementation is probably the most frequently used, which returns true if the the key-value pairs of the two hash objects being compared have the same values.

In our example below, we use the `String#eql?` method on `line 1`, which evaluates whether two string objects have the same value. On `line 9`, since we have not defined a custom `eql?` method within our `Dog` class, attempting to use the `eql?` method will call the `Object#eql?` method, which evaluates whether the two objects occupy the same space in memory. Since `ted` and `james` are different objects, this returns `false`. 

On `line 14`, we use the `Hash#eql?` method to evaluate whether the `a` and `b` hashes have the same key-value pairs. They do, so `true` is returned.
```ruby
'hello'.eql? 'hello'
# => true

class Dog
end

ted = Dog.new
james = Dog.new
ted.eql? james
# => false

a = { a: 10, b: 11 }
b = { a: 10, b: 11 }
a.eql? b
# => true
```
#### Explain element reference getter and element assignment setter methods? *
Element reference getter methods and setter methods appear to be operators, but are actually methods due to the heavy level of syntactical sugar applied. The element reference getter method returns an object in a collection, based on the index position provided as an argument. 

The element assignment setter method mutates the collection by reassigning the object at the index position provided as an argument, *returning the object that was passed in as an argument*.

As such, when we instantiate objects from custom classes, we are able to define our own implementation of these. However, since the Core API in Ruby already establishes a usage pattern (through the `Array` class), we should endeavour to follow those patterns to avoid confusion for people reading our code.

In our below example, we instantiate an object from the `Library` class. We also define custom getter (`lines 6-8`) and setter (`lines 10-12`) methods, so that we can use the `Array#[]` and `Array#[]=` element getter and setter methods to interface directly with the `@books` instance variable within the `local_lib` object.
```ruby
class Library
  def initialize
    @books = ['Redwall']
  end

  def [](position)
    @books[position]
  end

  def []=(position, object)
    @books[position] = object
  end
end

local_lib = Library.new
local_lib[0]
# => "Redwall"

local_lib[1] = "Peter Rabbit"
# => "Peter Rabbit"

local_lib[1]
# => "Peter Rabbit"
```
