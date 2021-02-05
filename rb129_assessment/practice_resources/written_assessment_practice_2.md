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
A class can be regarded as a template from which objects are created (objects require classes in order to be created). A class definition (denoted by the `class` and `end` reserved words) defines the behaviours that an object instantiated from that class will have. Depending on whether a class has an `initialize` method defined, it can also determine what state an object __can__ have (though state only __actually__ exists once the object is instantiated and instance variables are initialised and have values assigned to them). As such, classes can inherit behaviours from other classes, but do not inherit state (again, state is unique and exists once objects are instantiated and instance variables initialised and values assigned to them).

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
#### How do objects encapsulate state?
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
