#### *What is OOP and why is it important?
OOP is a programming paradigm that was developed in response to programs of increasing complexity. It allowed programmers to break up their code in objects and classes to encapsulate functionality, thus defining the boundaries of different components of programs and how they interacted with each other. This allowed the breaking apart of a large blob of dependencies into a number of smaller, well defined interactions between different part of the code. 

OOP also espouses flexible reuse of code through inheritance and polymorphism, reducing the need for duplication. These concepts meant that complex programs could still be maintained and understood by programmers.

#### *What is encapsulation? How does encapsulation relate to the public interface of a class?
Encapsulation is the hiding of functionality within our program from other parts of the code base. It is a form of data protection, such that data cannot be changed within our classes or objects without obvious intent.

An aspect of encapsulation is the grouping of method definitions within classes. Objects instantiated from these classes all have access to these same set of method definitions, while objects from other classes will have different behaviours. By clearly defining what classes are responsible for specific functionality of a program (and how they interact with other parts of the program), we encapsulate behaviours within classes, breaking apart the program into smaller, more manageable parts and limiting the potential for inadvertantly changing data within our program. 

Another aspect of encapsulation is method access control. This is a way that we can limit the accessibility of behaviours to objects instantiated from a class, when these behaviours are not necessary for objects to perform their function within the code. For example, `private` methods cannot be called from outside the class (and hence objects are unable to call these methods), while `private` methods can only be accessed from within the class, as well as by other instances of the same class. 

#### *What is an object? How do you initialize a new object/instance of a class?
In Ruby, an object is anything that can be said to have a value, and are instantiated from classes. This covers most constructs in Ruby (excluding variables, methods and blocks). In order to create an object, we have to call the `Class#new` or `Class#allocate` method on a defined class.

#### What is an instance variable, and how is it related to an object?
An instance variable is a variable that is initialised through the `initialize` method that is called after the `Class#new` method, and assigned a value that is passed as an argument through the `initialize` method. 

They are scoped at an object level (meaning all instance methods within the object have access to them, wherever they are defined) and are inaccessible outside of the object, unless getter or setter methods are defined to access them. Instance variables are not shared between objects (i.e. each object has it's own instance variables, which are not linked to instance variables of the same name of other objects).

Instance variables only exist once the object is instantiated and a value assigned to them, at which point they become part of an object's state, or the series of instance variables and their values that contribute to the data within an object. State is an object level concern, and cannot be inherited. 

#### What is an instance method? 

#### What is the scoping rule for instance variables?

#### How do you see if an object has instance variables?

#### What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?

#### When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?

#### How do objects encapsulate state?

#### *What is a collaborator object, and what is the purpose of using collaborator objects in OOP?

#### Why should a class have as few public methods as possible?

#### What is the private method call used for?

#### *What is the protected method used for?

#### Classes also have behaviors not for objects (class methods). How do you define a class method?

#### *What is polymorphism?

#### What is inheritance?

#### What is duck-typing?

#### What is the super method?

#### Why can't we use the `self` prefix on private getter methods?

#### What is method overriding?

#### What is a module? When would we use a module? (classes and methods, or just methods?)

#### Why should methods in mixin modules be defined without using `self.` in the definition?

#### What is the method lookup path?

#### What are class variables? Why is it not recommended to use them?

#### What are constants? What do we need to be careful of when dealing with constants?

#### What is a getter/setter/accessor method? What do each of these return?

#### When should we use getter/setter methods?

#### What is the self keyword? How do we use it?

#### What are class methods?

#### What is the default `to_s` method in Ruby? How/why would you override this?

#### What is a fake operator?

#### How does equivalence work in Ruby?

#### What is the `===` method?

#### What is the `eql?` method?

#### Explain element reference getter and element assignment setter methods?
