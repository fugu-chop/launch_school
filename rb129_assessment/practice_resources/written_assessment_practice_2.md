#### *What is OOP and why is it important?
OOP (Object oriented programming) is a programming paradigm that allows programmers to simplify complex programs by breaking up functionality into smaller pieces and defining the interactions between these different parts. This enables programs to reduce the number of dependencies by creating relevant functionality encapsulated within classes, limit unnecessary access to important parts of our program through method access control, reduce repeated code through inheritance and make the code more easily maintainable. 

#### *What is encapsulation? How does encapsulation relate to the public interface of a class?
Encapsulation is the hiding of certain functionality within our program from the rest of the code base. It is a method of data protection, such that data cannot be accessed or changed without obvious intent. 

One way of achieving encapsulation is by defining methods (interfaces) in classes and instantiating objects from these classes. This way, objects instantiated from classes only have specific ways of interacting with other parts of our code base based on the instance methods we define within the class. *This creates clearer boundaries between different parts of the code base in defining what each class or object's role is in the broader program - we can simply define what methods a class might need for it's role in the broader program, instead of having to mix in many modules for interfaces, or look across different classes for constants.*

Another part of encapsulation is method access control, which restricts how instance methods defined within a class can be accessed. There are three types of method access control:
- Public methods: With the exception of the `initialize` instance method, instance methods defined within a class are by default, public. This means that the instance method can be called on objects instantiated from the class. 
- Private methods: Private methods can only be called within the class, and not on the objects instantiated from the class. We can define methods as public by using the `private` method call
- Protected methods: Protected methods can be accessed from within the class like a public method; however, outside the class, they can only be accessed by other instances of the same class. 

In our example below, we demonstrate method access control in the context of encapsulation. We have an `owner` and `age_comparison` instance method, both of which are public methods (since we have not called the `private` or `protected` methods above those method definitions). Both of these methods can be called on the object instantiated from the `Dog` class assigned to the local variable `ted`. 

We also have a private instance method, `name`, which is defined under the `private` method call. This means that we return a `NoMethodError` when attempting to call the `name` method on the `ted` object. Although our `age_comparison` instance method is public, it calls a protected method, `age` (as we have defined that instance method under the `protected` method call). This means that we are able to reference the method within the class definition (hence being able to call it within the `age_comparison` instance method definition), but also on instances from the same class, which is how we are able to access the `age` instance method in the object assigned to the local variable `bob`. 
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
*In Ruby, an object is anything that can be said to have a value (this excludes things like variables, blocks and methods.* An object is an instance of a class. We create an object (instantiate) by calling the `Class#new` or `Class#allocate` method. Upon instantiation of an object, the `initialize` method is called, which initialises instance variables and assigns values to those instance variables. *Objects usually comprise of state and behaviours.*
- State refers to instance variables and their assigned values. State exists after instantiation of the object when values are assigned to initialised instance variables. Objects are unique, even if they are initialised with the same values. 
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

#### What is an instance variable, and how is it related to an object?

#### What is an instance method? 

#### What is the scoping rule for instance variables