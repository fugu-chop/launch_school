#### *What is OOP and why is it important?
OOP (Object oriented programming) is a programming paradigm that allows programmers to simplify complex programs by *breaking up functionality into smaller pieces and defining the interactions between these different parts. This enables programs to reduce the number of dependencies by creating relevant functionality encapsulated within classes, limit unnecessary access to important parts of our program through method access control, reduce repeated code through inheritance and make the code more easily maintainable.*

#### *What is encapsulation? How does encapsulation relate to the public interface of a class?
Encapsulation is the hiding of certain functionality within our program from the rest of the code base. It is a method of data protection, such that data cannot be accessed or changed without obvious intent. 

One way of achieving encapsulation is by defining methods (interfaces) in classes. This way, objects instantiated from classes only have specific ways of interacting with other parts of our code base based on the instance methods we define within the class. *This creates clearer boundaries between different parts of the code base in defining what each class or object's role is in the broader program - we can simply define what methods a class might need for it's role in the broader program, instead of having to mix in many modules for interfaces or rely on interfaces from other classes to achieve functionality.*

Another part of encapsulation is method access control, which restricts how instance methods defined within a class can be accessed. There are three types of method access control:
- Public methods: With the exception of the `initialize` instance method, instance methods defined within a class are by default, public. This means that the instance method can be called on objects instantiated from the class. 
- Private methods: Private methods can only be called within the class, and not on the objects instantiated from the class. We can define methods as public by using the `private` method call
- Protected methods: Protected methods can be accessed from within the class like a public method; however, outside the class, they can only be accessed by other instances of the same class. 

In our example below, we demonstrate method access control in the context of encapsulation. We have an `owner` and `age_comparison` instance method, both of which are public methods (since we have not called the `private` or `protected` methods above those method definitions). Both of these methods can be called on the object instantiated from the `Dog` class assigned to the local variable `ted`. 

We also have a private instance method, `name`, which is defined under the `private` method. This means that we return a `NoMethodError` when attempting to call the `name` method on the `ted` object. Although our `age_comparison` instance method is public, it calls a protected method, `age` (as we have defined that instance method under the `protected` method). This means that we are able to reference the method within the class definition (hence being able to call it within the `age_comparison` instance method definition), but also on instances from the same class, which is how we are able to access the `age` instance method in the object assigned to the local variable `bob`. 
```
class Dog
  def initialize(name, age, owner)
    @name = name
    @age = age
    @owner = owner
  end

  def owner
    @owner
  end

  def age_comparison(other)
    age > other.age
  end

  private

  def name
    @age
  end

  protected

  def age
    @age
  end
end

ted = Dog.new("Ted", 4, "Fred")
bob = Dog.new("Bob", 3, "Fred")

ted.owner
# => "Fred"

ted.name
# => NoMethodError (private method `name' called for #<Dog:0x00007f90b7920410 @name="Ted", @age=4, @owner="Fred">)

ted.age
# => NoMethodError (protected method `age' called for #<Dog:0x00007f90b7920410 @name="Ted", @age=4, @owner="Fred">)

ted.age_comparison(bob)
# => true
```
#### *What is an object? How do you initialize a new object/instance of a class?
*In Ruby, an object is anything that can be said to have a value (this excludes things like variables, blocks and methods.* An object is an instance of a class. We create an object (instantiate) by calling the `Class#new` or `Class#allocate` method. Upon instantiation of an object, the `initialize` method is called, which initialises instance variables and assigns values to those instance variables. 

*Objects usually comprise of state and behaviours.*
- State refers to instance variables and their assigned values. State exists after instantiation of the object when values are assigned to initialised instance variables. Objects are unique, even if they are initialised with the same values (i.e. the same state). 
- Behaviour refers to the instance methods defined within the class. Behaviour determines what functionality objects have, and how they interact with other objects (whether from the same class or not). Instance methods can enable access to state, depending on the level of method access control. 

In our example below, we define the `Dog` class using the `class..end` reserved words on `line 1-9`. Within this class, we define the `initialize` method on `lines 2-4`, which will be called when an object is instantiated from the `Dog` class. On `line 11`, we instantiate an object from the `Dog` class by calling `Dog.new`, and passing it a string object. This object is assigned to the local variable `ted`. 

Once the object is instantiated, the `initialize` method is automatically called, which passes the string object provided to the `Dog.new` method and assigns it to the instance variable `@name`. Since instance methods are by default public, the `ted` object has access to the `name` instance method, we invoke this method on `line 12`, returning the string object `"Ted"`.
```
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

ted = Dog.new("Ted")
# => #<Dog:0x00007f90b7920410 @name="Ted", @age=4, @owner="Fred">

ted.name
# => "Ted"
```
#### What is instantiation versus a constructor method?
A constructor method is a method that instantiates an object from a class. In Ruby, this could be `Class#new` or `Class#allocate`. We should be precise and distinguish this from the `initialize` method, which is called __after__ an object is instantiated from a class using the `Class#new` instance method. While `initialize` does get invoked immediately after object instantiation, the `initialize` method itself does not instantiate the object.

Per our example, we do not need an `initialize` method in order to instantiate an object from the `Dog` class on `line 4`. Hence it should not be regarded as a constructor method. 
```
class Dog
end

d = Dog.new
```
#### What is an instance variable, and how is it related to an object?
An instance variable is a variable that is defined and has values assigned to it on instantiation of an object. *They are denoted using the `@` symbol before the variable name.* They are scoped at an object level, meaning instance variables can be accessed across instance methods, even if they weren't defined within those instance methods. As instance variables are defined and values assigned to them (i.e. usually through the `initialize` method after the objects are instantiated), they contribute to the __state__ of an object - the series of instance variables and their values. *State is unique to each object (i.e. not shared among the instances of the same class), and cannot be inherited (since state only exists once objects are instantiated from classes and the instance variables initialised).*

In our example below, when we instantiate a new `Dog` object on `line 11` and assign it to the local variable `ted`, we pass a string object as an argument to the `initialize` method, which is automatically invoked after instantiation of an object. The `initialize` method initialises an instance variable `@name` and assigns the `"Ted"` string object to it. This now contributes to the __state__ of the `ted` object. We can also see on `lines 6-8` that instance methods are scoped at an object level, since the instance method `Dog#name` is able to access the `@name` instance variable, despite us not defining it specifically in that method, or passing the value assigned to `@name` to the `name` instance method as an argument. 
```
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

ted = Dog.new("Ted")
ted.name
# => "Ted"
```
#### What is an instance method? 
An instance method is a behaviour that an object __may__ able to access, depending on method access control (private methods cannot be accessed directly by objects, and protected methods can only be accessed through instances of the same class, but otherwise cannot be called directly by objects themselves). Instance methods are defined within classes and can be inherited. *All objects instantiated from the same class will have access to the same instance methods.*

In our example below, we define two instance methods in the `Animal` class - `initialize` on `line 2-4` and `legs` on `line 6-8`. We can see that instance methods can be inherited, as we have the `Dog` subclass which does not explicitly define any instance methods, yet an object instantiated from `Dog` is able to access the instance methods defined in the `Animal` class per `line 14`, where `ted` calls the `legs` method. We also demonstrate on `line 17` that different objects instantiated from the same class (i.e. `Dog`) are able to access the same instance methods. 
```
class Animal
  def initialize(legs)
    @legs = legs
  end

  def legs
    @legs
  end
end

class Dog < Animal
end

ted = Dog.new(4)
ted.legs

dobby = Dog.new(4)
dobby.legs
```
#### What is the scoping rule for instance variables?
Instance variables are scoped at an object level. This means that instance methods defined within a class are all able to access instance variables, regardless of where they are defined within that class. Instance variables cannot be directly accessed outside of the object, unless an appropriate getter or setter method is defined within the class.

In our example below, we define a class `Dog` on `lines 1-9` using the `class` and `end` keyword pair. When we instantiate an object and assign it to the local variable `ted` on `line 11`, we pass a string object `"Teddy"` as an argument. This object is passed by reference to the `initialize` method which is automatically called on instantiation of the `Dog` object, which then initialises a `@name` instance variable and assigns the `"Teddy"` string object to it. This instance variable is then accessible to the `name` instance method, defined on `lines 6-8`, despite not being defined within `name` (if we had not defined this `name` getter method, we would not be able to access the instance variable `@name`). As this is a public method, it can be invoked directly on the object itself, and returns the string `"Teddy"` per `line 12`. 
```
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

ted = Dog.new("Teddy")
ted.name
# => "Teddy"
```
#### How do you see if an object has instance variables?
We can call the `Object#instance_variables` instance method on an object. This will return an array of instance variables cast as symbols. 

In our example below, we define the `Dog` class on `lines 1-7` with the `class` and `end` reserved words. We then instantiate a new `Dog` object using the `Class#new` instance method on `line 9`, passing a string object `"Ted"` to the `new` instance method. Once the object is instantiated, the `initialize` method takes the argument passed to the `new` method and initialises an instance variable `@name` and assigns the `"Ted"` string object to it. At this point, the `@name` instance variable and the string object it points to becomes part of the `ted` object's state. We can then call the `Object#instance_variables` methods on `ted`, which returns an array of initialised instance variables.

Note that only initialised instance variables will be returned as part of the `ted.instance_variables` method call. We have defined a getter method for `age` on `line 2` - however because we never initialised the `@age` instance variable in the `initialize` method call, it does not become part of the object's state and is not shown in the `ted.instance_variables` method call.
```
class Dog
  attr_reader :age

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Ted")
ted.instance_variables
# => [:@name]
```
#### What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?
A class can be regarded as a template from which objects are created (objects require classes in order to be created). A class definition (denoted by the `class` and `end` reserved words) defines the behaviours that an object instantiated from that class will have. 

Depending on whether a class has an `initialize` method defined, it can also determine what state an object __can__ have (though state only __actually__ exists once the object is instantiated and instance variables are initialised and have values assigned to them). As such, classes can inherit behaviours from other classes, but do not inherit state (again, state is unique and exists once objects are instantiated and instance variables initialised and values assigned to them).

In our example below, we define the `Animal` class on `lines 1-5` using the `class` and `end` reserved words. We also define the `Dog` class on `line 7-8` using the same syntax. We use the `<` symbol to denote that `Dog` inherits from `Animal`. The implication of this is that `Dog` inherits the same behaviours (i.e. the `initialize` instance method) as those defined in the `Animal` class. As such, when we instantiate a `Dog` object on `line 10`, the `Dog` class has access to the `initialize` method defined in `Animal` and requires an argument to be passed to the method parameter `name` on instantiation (since the `initialize` method is called immediately after the object is instantiated).
```
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
end

ted = Dog.new("Ted")
```
#### When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?
State is the series of instance variables and the values they point towards in an object. They are an object level concern and do not exist until an object has been instantiated and the instance variables initialised and values assigned to them. They cannot be inherited, and are unique to each object (i.e. objects instantiated from the same class do not share state). 

Behaviours are the instance methods defined within a class that an object can have access to (depending on method access control). These can be inherited by subclasses and are shared between all instances of the same class (i.e. all objects instantiated from a class, despite being unique themselves, all have access to the same set of instance methods)

In our example below, we define the `Animal` class on `lines 1-7` using the `class` and `end` reserved words. We also define a number of instance methods. On `line 9-10`, we define a `Dog` class, which inherits instance methods from the `Animal` class (we make the `Dog` class inherit from `Animal` using the `<` symbol). When we instantiate a `Dog` object on `line 13`, we pass a local variable `name` (which references the string object `"Ted"`) as an argument, which is forwarded to the `initialize` method (which is automatically invoked when an object is instantiated). 

Note that the `Dog.new` method automatically calls `initialize`, despite us not explicitly defining an `initialize` method within the `Dog` class - this is possible because classes can inherit methods. On `line 14`, we instantiate another `Dog` object, passing in the same string object. We then use the setter method defined through the `Animal#attr_accessor` method to change the value referenced by `@name` in `ted` on `line 15`. 

Despite us passing in the same string object when we instantiated the object referenced by `ted1` and `ted2`, we are able to change the state of `ted1` using a setter method without changing the state (i.e. instance variable `@name`) in `ted2`, since objects do not share state. 
```
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Dog < Animal
end

name = 'Ted'
ted1 = Dog.new(name)
ted2 = Dog.new(name)

ted1.name = "Teddy"
ted1.name
# => "Teddy"
ted2.name 
# => "Ted"
```
#### *How do objects encapsulate state?
State is unique to each object (i.e. objects do not share state). This means that objects, despite being instantiated from the same class, do not affect the state of other objects when their individual state is changed (e.g. through setter methods). As such, the state of each object is encapsulated (or protected from changes to other objects).

In our example below, we define a `Dog` class on `lines 1-7` using the `class` and `end` reserved words. We instantiate two `Dog` objects on `lines 10-11`, passing the same string object `"Ted"` referenced by the local variable `name`. We then utilise the setter method defined through the `Dog#attr_accessor` to change the state of the object referenced by `bob`. However, this change does not affect the state of the `ted` object, since state is unique to each object (i.e. state is not shared between objects instantiated from the same class) and encapsulated within that object.
```
class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

name = "Ted"
ted = Dog.new(name)
bob = Dog.new(name)

bob.name = "Bob"
ted.name
# => "Ted"
```
#### *What is a collaborator object, and what is the purpose of using collaborator objects in OOP?
A collaborator object is any object (whether an object instantiated from a custom class, or a class predefined within the Ruby Core API) that we assign to an instance variable when an object is instantiated from a class. 

In general, collaborator objects allow us to model relationships between objects instantiated from classes that don't necessarily fit within a logical hierarchy - a collaborative relationship between objects can be thought of as a "has-a" or associative relationship, while relationships between classes through inheritance can be thought of as "is-a" relationship.

In our example below, we have two different classes that are not related through inheritance. In our particular implementation, we want to associate a `Dog` object with an `Owner` object, since a `Dog` object "has-an" owner (inheritance would not make sense here, since that would imply that a `Dog` object "is-a" `Owner` object). 

As such, we instantiate a `Dog` object on `line 14`, passing in a string object `"Teddy"` as an argument, which after instantiation, will be passed to the `initialize` method that is automatically called. This will initialise the `@name` instance variable and assign the string object to it (thus creating the state of the `Dog` object assigned to local variable `ted`). This is also an example of a collaborative relationship, since we are assigning a string object to the `@name` instance variable (a `Dog` object "has-a" name).

We then instantiate an `Owner` object, passing in the `"Frank"` string object, and local variable referencing the `Dog` object as arguments, assigning it to the local variable `frank`. After the `Owner` object is instantiated, the `@pet` instance variable is initialised, and the `Dog` object is assigned as a value (this occurs with the `@name` instance variable). At this point, a collaborative relationship exists between the objects referenced by the `ted` and `frank` local variable, allowing the two objects a degree of interaction with each other (e.g. if we had a setter method and changed the string object referenced by the `@name` instance variable, this would be reflected in the object referenced by `frank`).
```
class Owner
  def initialize(name, pet)
    @name = name
    @pet = pet
  end
end

class Dog
  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Teddy")
frank = Owner.new("Frank", ted)
```
#### Why should a class have as few public methods as possible?
By default, instance method definitions within a class are public. This enables these methods to be called outside of the object, which can influence the state of an object. In keeping with the principle of encapsulation, it is generally a good idea to limit behaviours (instance methods) of objects to protect the data encapsulated within, since can allow the user to unintentionally change the state of an object from almost anywhere in the program.

In our example below, we define a getter `name` method through the `attr_reader` method in our `Dog` class definition. As this is a public method, a user can access the value referenced by the `@name` instance variable on the `ted` object by calling the `name` getter method from anywhere in our program. 

We can then call the `String#reverse!` method on the return value of the `Dog#name` instance method, which mutates the return value to `"yddeT"`. Thus despite only having a public getter method, we have destructively changed the state of the `ted` object, which can significantly alter or break the functionality of our program. As such, it is recommended we don't have public methods unless necessary.
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

ted.name.reverse!
# => "yddeT"

ted.name
# => "yddeT"
```
#### What is the private method call used for?
The `private` method call is a way that we can implement method access control within our classes and achieve encapsulation. If we define instance methods underneath the `private` method, this prevents those instance methods from being called outside of the class definition (i.e. they cannot be called directly on objects instantiated from that class) - only instance methods in the class definition will have access to those private methods. Attempting to call a private instance method on an object will return a `NoMethodError`.

In our example below, we define a `Human` class with the `class` and `end` reserved words on `lines 1-19`. When we attempt to instantiate an object from the `Human` class using the `Class::new` method, the `initialize` method defined in the `Human` class is automatically called, which accepts the objects `"Tim"` and `25` we passed as arguments to the `new` method. This initialises the `@name` and `@age` instance variables and assigns them to the `"Tim"` and `25` objects. 

In our class definition, we also defined a private `age` method on `lines 16-18`, denoted by the definition of the instance method beneath the `private` method on `line 14`. This prevents the `age` instance method from being directly called on objects instantiated from the `Human` class, returning a `NoMethodError` per `line 22`. 

However, the `can_i_drive` instance method (defined on `lines 7-12`) is able to access the `age` method, as private methods are accessible from within the class definition, meaning other instance methods in the `Human` class are able to access the private `age` method. This is how we are able to implement a public method that references the return value of the private `age` method, while preventing direct access to the `@age` instance variable from outside the class. 
```
class Human
  def initialize(name, age)
    @name = name
    @age = age
  end

  def can_i_drive
    if age > 18 
      "I am able to drive"
    else 
      "I am unable to drive"
    end
  end

  private

  def age
    @age
  end
end

tim = Human.new("Tim", 25)

tim.age
# NoMethodError (private method `age' called for #<Human:0x00007f842a9645a0 @name="Tim", @age=25>)

tim.can_i_drive
# => "I am able to drive"
```
#### *What is the protected method used for?
The `protected` method in Ruby is a form of method access control that limits the ability to call instance methods defined within a class. *It acts as a 'middle-ground' between private and public instance methods.*
- Within a class, protected methods act like public methods - they can be called anywhere within the class definition.
- Outside of a class, protected methods act somewhat like private classes - they cannot be called directly on objects, but can be called on other instances of the same class. 

In our example below, we define the `Dog` class on `lines 1-15` using the `class` and `end` reserved words. Within this class definition, we call the `protected` method on `line 10`, after which we define the `name` instance method (`lines 12-14`). This means that objects instantiated directly from the `Dog` class cannot call the `name` instance method (this returns a `NoMethodError`, per `line 20`).

However, we also define a public instance method `play_with`, which is able to access the `play_with` instance method (since instance methods are able to access protected methods defined in the `Dog` class). Once we instantiate two `Dog` objects and assign them to local variables `ted` and `sparky` on `lines 17-18`, we are able to call the `play_with` instance method on the `ted` object, passing in the `sparky` object as an argument. Since the `name` instance method is protected, Ruby is able to access the `name` instance method in the `sparky` object through the public `play_with` instance method, as the object referenced by the local variable `sparky` is instantiated from the same `Dog` class as the `ted` object. 
```
class Dog
  def initialize(name)
    @name = name
  end

  def play_with(other_dog)
    "#{@name} plays with #{other_dog.name}"
  end

  protected

  def name
    @name
  end
end

ted = Dog.new("Ted")
sparky = Dog.new("Sparky")

ted.name
# NoMethodError (protected method `name' called for #<Dog:0x00007fee87961bf8 @name="Ted">)

ted.play_with(sparky)
# => "Ted plays with Sparky"
```
#### Classes also have behaviors not for objects (class methods). How do you define a class method?
A class method is a method that is defined directly on the class. This means that we can only call a class method on the class, and not on objects instantiated from that class. We define a class method by appending a `self.` prefix to the method name in a method definition. *This is because the self keyword, when used outside of an instance method, refers to the class itself. This means we are defining a method directly on the class.*

In our example below, we define a `Dog` class using the `class` and `end` reserved words on `lines 1-5`. Within the `Dog` class, we define a class method on `lines 2-4`, as per the `self.` prefix on the `species` method name, which returns `self` *- since `self` here is used outside of an instance method, this will return the class*. This means that we can call the `Dog::species` class method directly on the `Dog` class (per `line 7`), but not on objects instantiated from the `Dog` class (which raises a `NoMethodError`, per `line 9`).
```
class Dog
  def self.species
    self
  end
end

Dog.species
# => Dog

Dog.new.species
# NoMethodError (undefined method `species' for #<Dog:0x00007fc9210adb78>)
```
#### *What is polymorphism?
Polymorphism refers to the ability of different objects to respond to a common interface. It is a principle within Object Oriented Programming that allows us to reduce the amount of code that we write *and a way to extend the functionality of objects through inheritance (class inheritance of methods), or apply common behaviours to classes instantiated from different, unrelated classes that might otherwise not fit into a logical inheritance-based hierarchy (through mix-in modules, also known as interface inheritance). Duck-typing is another form of polymorphism, where unrelated class each have their own implementation of a particular instance method.*

Polymorphism serves as a counterpart to the concept of encapsulation - encapsulation limits the functionality of objects by encapsulating instance methods within classes and applying method access control to those instance methods, while polymorphism extends the functionality of objects instantiated from different classes by ensuring those objects all have an ability to call a commonly named instance method (though this does not necessarily imply the instance method will have the same functionality across those different classes) through inheritance, mixing in modules, or duck-typing.

In our example below, we have a superclass `Animal`, which both the `Dog` and `Fish` classes inherit from. We defined a public `speak` instance method in the `Animal`, which allows objects instantiated from `Animal` and it's subclasses to call the `speak` method (which we can observe on `lines 22 and 24`).

We also have a `Walkable` module defined on `lines 1-3` that create a method that can be mixed in to our classes with the use of the `include` keyword. We mix in the `Walkable` module in the `Dog` class, on `line 14`, which enables objects instantiated from `Dog` to call the public instance method `walk` (which we observe on `line 26`).
```
module Walkable
  def walk
    "I can walk!"
  end
end

class Animal
  def speak
    "Hello!"
  end
end

class Dog < Animal
  include Walkable
end

class Fish < Animal
end

Fish.new.speak
# => "Hello!"
Dog.new.speak
# => "Hello!"
Dog.walk
# => "I can walk!"
```
#### What is inheritance?
Inheritance is the ability of classes to inherit behaviours (both instance and class methods) as well as *access to* certain types of variables (e.g. constants and class variables) from other classes. It is a way of modelling logical hierarchical ("is-a") relationships between different classes and enables us to reduce the amount of code we write. We can allow a class to inherit methods, class variables and constants by using the `<` symbol alongside the class name when defining a class.

In our example below, we define an `Animal` class on `lines 1-14`, with instance methods (`Animal#speak`, `Animal#creations`), class methods (`Animal::speak`) and a class variable (`@@instances`). We then define a `Dog` class (`lines 16-20`), which subclasses the `Animal` class through the `<` symbol on `line 16`. This enables the `Dog` class to inherit all of the methods defined in the `Animal` class without having to explicitly define them inside the `Dog` class. As such, we are able to call the explicitly methods defined in `Animal` on the `d` object instantiated from the `Dog` class. We can also observe that the instance method `creations` allows objects instantiated from the `Dog` class to access the class variable `@@instances` defined in `Animal`.
```
class Animal
  @@instances = 0

  def self.speak
    self
  end

  def speak
    "I am a sentient being"
  end

  def creations
    @@instances
  end
end

class Dog < Animal
  def initialize
    @@instances += 1
  end
end

d = Dog.new
Dog.speak
# => Dog

d.speak
# => "I am a sentient being"

d.creations
# => 1
```
#### What is duck-typing?
Duck-typing is a form of polymorphism, where unrelated classes all define an instance method of the same name, though this does not imply that each instance method will behave in the same way or return the same value. It is a way to ensure that different objects are able to respond to a common method call.

In our example below, we have two unrelated classes, `Cat` and `Dog`. Within each class definition, there is a public `speak` instance method that returns a string object. We also have a `Party` class that has a public `introductions` instance method that calls a `speak` instance method on each object passed to it as an argument (The public `introductions` instance method does not verify whether a `speak` method exists prior to execution - it simply expecting each of those objects to actually have a public `speak` instance method). 

Thus when we instantiate a `Party` object and call the public instance method `introductions`, we can pass in objects instantiated from the `Cat` and `Dog` classes, which the `introductions` instance method calls a public `speak` method on.
```
class Cat
  def speak
    "Meow!"
  end
end

class Dog
  def speak
    "Woof!"
  end
end

class Party
  def introductions(participants)
    participants.each do { |participant| puts participant.speak }
  end
end

Party.new.introductions([Cat.new, Dog.new])
# Meow!
# Woof!
# => [#<Cat:0x00007fdc3894bb48>, #<Dog:0x00007fdc3894bb20>]
```
#### What is the super method?
The `super` method is a method we can invoke within an instance method to call a method of the same name higher in the inheritance hierarchy. It is useful when we want to utilise functionality from an instance method in the superclass but extend it's functionality in a subclass. Depending on whether it is called with arguments (or even parentheses), it's functionality can change.
- When called without arguments or parentheses (i.e. `super`), the `super` method will pass any arguments provided in the subclass instance method to the superclass instance method and call the superclass instance method of the same name. This can pose problems when there are a different number of accepted arguments in the superclass instance method to the subclass method. 
- When called with parentheses but no arguments (i.e. `super()`), the `super` method will disregard any arguments provided to the subclass instance method and call the superclass instance method. This is often the safest way to call a superclass instance method that does not take any arguments. 
- When called with parentheses and arguments (i.e. `super(arg1, arg2)`), the `super` method will pass the specified arguments to the superclass method and call it with those arguments. This is a common way to extend functionality of the superclass instance method to the subclass instance method. 

In our below example, we have two classes, `Animal` and `Dog`. `Dog` subclasses `Animal`, and inherits the public instance method `speak`. Within the `Dog` class, we extend the functionality of the public `speak` instance method, by using the `super()` method call, which calls the `Animal#speak` method and returns the string object `"I can speak!"`, which is appended to the string `"My name is #{@name} and "`. When we instantiate a `Dog` object and call the `Dog#speak` instance method, this returns `"My name is Timmy and I can speak!"`.
```
class Animal
  def speak
    "I can speak!"
  end
end

class Dog < Animal
  def initialize(name)
    @name = name
  end

  def speak
    "My name is #{@name} and " + super()
  end
end

Animal.new.speak
# => "I can speak!"
Dog.new("Timmy").speak
# => "My name is Timmy and I can speak!"
```
#### Why can't we use the `self` prefix on private methods?
Prior to Ruby 2.7, we were not able to use the `self.` prefix on private instance methods. This is because in the context of instance methods, `self.` refers to the calling object. When we instantiate an object from a class, this is equivalent to calling the method directly on the object, which is prohibited by the `private` method in the class definition. As of Ruby 2.7, calling private methods with a `self.` prefix is permitted.

In our example below, we define the `Dog` class. Within the `Dog` class, we have define an instance method `name` underneath the `private` method, which makes this a private instance method. We also have a public instance method `identify`, which calls the private `name` instance method, but appends the `self.` keyword to the method call. As such, after we instantiate an object from the `Dog` class, the `identify` method is effectively calling the `name` method on the object itself, which is prohibited by the `private` method. 

We could fix this `NoMethodError` by removing the `self.` prefix on `self.name` within the `identify` instance method, since private methods can still be accessed within a class definition. It's also generally accepted practice to not include `self.` on getter methods, because it's not necessary to call those getter methods, and to avoid compatibility issues with older versions of Ruby. 
```
class Dog
  def initialize(name)
    @name = name
  end

  def identify
    "I am a dog and my name is #{self.name}!"
  end

  private

  def name
    @name
  end
end

Dog.new("Tim").identify
# => NoMethodError (private method `name' called for #<Dog:0x00007f82c81274b8 @name="Tim">)
```
#### What is method overriding?
Method overriding refers to the ability of classes to have a custom implementation of an instance or class method that is either inherited from a superclass or mixed in through a module, by redefining a method of the same name in the class. *Method overriding takes advantage of class and instance method scoping rules - via the method lookup path, Ruby will first look to the immediate class from which an object is instantiated when a method is called, meaning that if we define a method within a subclass and superclass, when instantiating an object from the subclass, Ruby will look to call a method from the subclass first, and only look to the mixed-in modules or superclass if it cannot find the method explicitly defined in the subclass from which the object was instantiated.*

In our example below, we have defined `Walkable` module on `lines 1-5`, an `Animal` superclass on `lines 7-15` with a class method (`Animal::identify`) and instance method (`Animal#speak`). We then define a `Dog` subclass on `lines 17-29`, with new definitions of the methods it inherits from the `Animal` class (we allow the `Dog` class to inherit from the `Animal` class using the `<` symbol) and the methods mixed in from the `Walkable` module. This overrides the functionality of the methods in the `Animal` class and `Walkable` module, returning different values (per return values observed by calling the `Dog::identify` class method  on `line 31`and `Dog#speak` and `Dog#walk` instance methods on `lines 34 and 37`).
```
module Walkable
  def walk
    "I am walking!"
  end
end

class Animal
  def self.identify
    self
  end

  def speak
    "Hello!"
  end
end

class Dog < Animal
  def self.identify
    "I am a #{self}!"
  end

  def speak
    "Woof!"
  end

  def walk
    "I am pottering about!"
  end
end

Dog.identify
# => "I am a Dog!"

Dog.new.speak
# => "Hello!"

Dog.new.walk
# => "I am pottering about!"
```
#### What is a module? When would we use a module? (classes and methods, or just methods?)
A module is a series of methods that we bundle together using the `module` and `end` reserved words. With modules, we are able to incorporate their functionality by mixing them into classes with the `include` keyword. They are useful when we want classes that may not necessarily fit into a logical hierarchy to access common functionality, but cannot inherit methods from one another because class hierarchy does not exist between the classes (which is how classes can also access methods from other classes without having to explicitly define separate instances of those methods). *This is particularly useful since classes can only inherit from a single class, but can mix in as many modules as needed. Note that we cannot instantiate objects from modules - we can only mix in the module methods into a class, and instantiate an object directly from that class.*

Modules enable us to reduce the amount of repeated code in our programs (enabling DRY code), but also allow for namespacing, which is the grouping of common code under classes to avoid name conflicts between methods of the same name defined in multiple classes.

In our example below, we define a `Walkable` module (`lines 1-5`), which enables classes where it is mixed in to access the `walk` method. We then define two unrelated classes, `Cat` (`lines 7-9`) and `Dog` (`lines 11-13`), mixing in the `Walkable` module in each class with the `include` keyword. This enables us to call the `walk` method directly from objects instantiated from the `Cat` and `Dog` classes, per `lines 15` and `18`.
```
module Walkable
  def walk
    "I can walk!"
  end
end

class Cat
  include Walkable
end

class Dog
  include Walkable
end

Cat.new.walk
# => "I can walk!"

Dog.new.walk
# => "I can walk!"
```
#### Why should methods in mixin modules be defined without using `self.` in the definition?
When we use the `self.` keyword outside of instance methods, they refer to the class in which they are defined. When we use `self.` on a module method, this will refer to the Module itself, meaning that even if we mix in the module to a class, we will not be able to call the method on the class, unless we specifically reference the name of the module itself with the namespace resolution operator `::`.

In our example below, we define the `Walkable::walk` method on `lines 2-4`. We then mix in this module using the `include` keyword in our `Cat` class definition on `line 8`. However, since `self` is used outside of an instance method in the `Walkable` module, it refers to the class (in this case, `Walkable`). This means in our current implementation, we can only call the `walk` method through `Walkable::walk`.
```
module Walkable
  def self.walk
    "I am walking"
  end
end

class Cat
  include Walkable
end

Cat.walk
# => NoMethodError (undefined method `walk' for Cat:Class)
```
#### What is the method lookup path?
The method lookup path is the chain of classes and modules that Ruby will look for the definition of a method when that method is called. The method lookup chain starts in the class which instantiates the object, then any modules mixed into that class sequentially, starting from the last module mixed in. This process repeats in the superclass of that class, continuing up until the `BasicObject` class. *It is most relevant when calling a method that is not explicitly defined within a class, but may have been defined in a superclass or mixed in module.*

Once Ruby finds a method definition of the same name as the method called, it will stop looking higher up in the method lookup path. If Ruby cannot find an appropriate method definition, it will raise a `NoMethodError`. We can see a full sequence of a method lookup path by calling the `.ancestors` method on an object or class, which returns an array of the classes and modules that superclass/are mixed in, all the way up to the `BasicObject` class (though the method lookup path will stop before reaching the `BasicObject` class if Ruby finds an appropriate method definition in a subclass or module).

In our example below, when we call `Dog.new.walk`, Ruby will first look in the `Dog` class to see if there is a `walk` instance method. Since this does not exist, it will then look at the `Pet` class definition, then the `Animal` class definition, then the `Swimmable` module, then the `Walkable` module, where it finds the `walk` method definition, at which point it will stop looking further up the method lookup chain, and call the `walk` method. 
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

Dog.new.walk
# => "I can walk!"
```
#### What are class variables? Why is it not recommended to use them?
Class variables are variables defined at a class level. They are defined by appending the `@@` symbols before the variable name. They are initialised when the class is evaluated by Ruby. Class variables can be accessed *by instance or class methods* through all subclasses of the class where it is defined, as well as any objects instantiated from that class or subclasses. The issue is that objects and subclasses all share a single copy of the class, meaning it is very easy to unintentionally change the value referenced by this class, causing all objects and subclasses to reflect this change.

In our example below, we define an `Animal` class with a class variable `@@legs`, assigned to the integer object `4`. We also have a `Dog` and `Bird` class which subclass `Animal`. We can see that both instance methods and class methods in the `Animal` and `Dog` subclass are able to access this class variable through the `legs` and `self.legs` methods respectively (`line 19` and `line 16`). However, once we define the `Bird` class (which subclasses `Animal`), which reassigns the value of the class variable `@@legs` to reference the integer object `2` (`line 26`) and this is evaluated by Ruby, we note that all other objects and classes that reference the `@@legs` class variable now reference the integer object `2` when the appropriate class or instance method is called (`line 29` and `line 32`).
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

class Dog < Animal
end

Animal.new.legs
# => 4

Animal.legs
# => 4

Dog.new.legs
# => 4

class Bird < Animal
  @@legs = 2
end

Dog.legs
# => 2

Dog.new.legs
# => 2
```
#### What are constants? What do we need to be careful of when dealing with constants?
Constant variables (or constants) are variables defined at a class level. They can be identified through variable names starting with a capital letter (though typically most Rubyists will use all caps for the variable name). Constants should be used when we have a value that does not change throughout the operation of the program (it is possible to reassign the value of a constant, though Ruby will raise a warning). Constants are unique to class or instance variables in that we can reference the value of a constant in specific class in a potentially unrelated class by using the namespace resolution operator `::`.

An important point to note about constants is that they have lexical scope. This means that when Ruby encounters a method that references the value of a constant, it will look in the immediate class where that method is defined for the value of the constant, and then look in any superclasses in the hierarchy chain. This can lead to certain unexpected behaviours. 

In our example below, we define two classes, `Animal` and `Bird`. In the `Animal` class, we define a `LEGS` constant and assign the integer object `4` to it. In the `Bird` subclass, we redefine the `LEGS` constant to the integer object `2`. When we call the `legs` instance method on an object instantiated from the `Bird` class (the public `legs` instance method is available through class inheritance), we see that despite defining `LEGS` in the `Bird` class, the returned value is still `4` (from the `Animal` class). This is because of lexical scope - because the the `legs` method is inherited from the `Animal` class, when Ruby attempts to call the `legs` method on the object instantiated from `Bird` (which references the `LEGS` constant), it uses the method definition from the `Animal` class. Ruby then looks within the `Animal` class (which is where `legs` is defined) for the value of the `LEGS` constant, which is `4`. 

We could fix this by either:
1. Appending `self.class::` to the `LEGS` constant reference in the `Animal#legs` method (as this will now reference the class in which the `legs` method is called to find the value of `LEGS`); or 
2. Define a separate getter method within the `Bird` class - since constants have lexical scope, the `Bird` class will have it's own getter method, which means that when calling `legs` from an object instantiated from the `Bird` class, Ruby will look within the `Bird` class for the value of `LEGS`.
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
#### What is a getter/setter/accessor method? What do each of these return?
Getter/setter methods are instance methods defined within a class that we can use to access or modify respectively, the state of an object (i.e. an instance variable defined within an object). Ruby has specific methods that allow us to quickly create getter and setter methods - `attr_reader` and `attr_writer` respectively (we pass method names as symbols to these methods to create the relevant getter/setter methods). The `attr_accessor` method allows us to create both getter and setter methods at once. 

A getter method will return whatever the last evaluated expression is within the method definition, while a setter method will return the value of whatever argument was passed to it when the method was called. 

When deciding whether to create getter or setter methods, per the principles of encapsulation, we should consider whether it is really necessary for our objects to have direct access to their own state. This can be problematic when inappropriate method access controls are implemented.

In our example below, we define a `Dog` class with a public `attr_reader` method to create a `name` instance method that enables access the `@name` instance variable. After we instantiate an object from the `Dog` class on `line 9`, we can access the `@name` instance variable by calling the `name` instance method (per `line 11`). However, on `line 14`, we call the `String#upcase!` method on the return value of `Dog#name`, which destructively changes the value of `"Ted"` to `"TED"`, causing a permanent change to the state of the object (`line 17`). 

Even though we only defined a getter method, we were still able to dstructively change the state of our object by calling another method on top of it. We *could* solve this problem by defining a custom method which returns a duplicate of the `@name` instance variable; however, we should also consider whether our Dog objects need direct read access to their state in the broader scope of our program.
```
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Ted")

ted.name
# => 'Ted'

ted.name.upcase!
# => 'TED'

ted.name
# => 'TED'
```
#### When should we use getter/setter methods?
We should consider using getter/setter methods when:
- From a design perspective, we believe that objects instantiated from a class should be able to directly access or change their state (i.e. their instance variables and assigned values)
- For getter methods, we might want to define custom getter methods if we want to transform or format the instance variable differently to what was defined when the object was instantiated

In our example below, we define a `Person` class. Upon instantiation of an object from `Person`, two arguments are forwarded to the `initialize` method; `name` and `gender`. In our `name` getter instance method, when called on an object, we want to incorporate the gender on what is displayed and hide part of the string object referenced by the `@name` instance variable, and thus define our own custom getter method. If we had relied purely on the `attr_reader` method, this would only return the entirety of our instance variable `@name`.
```
class Person
  def initialize(name, gender)
    @name = name
    @gender = gender
  end

  def name
    gender = 'F' ? "Ms. #{@name[0]}" : "Mr. #{@name[0]}"
  end
end

Person.new("Jessica", "F").name
# => "Ms. J"
```
#### What is the self keyword? How do we use it?

#### What are class methods?

#### What is the default `to_s` method in Ruby? How/why would you override this?

#### What is a fake operator?

#### How does equivalence work in Ruby?

#### What is the `===` method?

#### What is the `equal?` method?

#### What is the `eql?` method?

#### Explain element reference getter and element assignment setter methods