#### *What is OOP and why is it important?
OOP is a programming paradigm that was developed in response to programs of increasing complexity. It allowed programmers to break up their code in objects and classes to encapsulate functionality, thus defining the boundaries of different components of programs and how they interacted with each other. This allowed the breaking apart of a large blob of dependencies into a number of smaller, well defined interactions between different part of the code. 

OOP also espouses flexible reuse of code through inheritance and polymorphism, reducing the need for duplication. These concepts meant that complex programs could still be maintained and understood by programmers.

#### *What is encapsulation? How does encapsulation relate to the public interface of a class?
Encapsulation is the hiding of functionality within our program from other parts of the code base. It is a form of data protection, such that data cannot be changed within our classes or objects without obvious intent.

An aspect of encapsulation is the grouping of method definitions within classes. Objects instantiated from these classes all have access to these same set of method definitions, while objects from other classes will have different behaviours. By clearly defining what classes are responsible for specific functionality of a program (and how they interact with other parts of the program), we encapsulate behaviours within classes, breaking apart the program into smaller, more manageable parts and limiting the potential for inadvertently changing data within our program. 

Another aspect of encapsulation is method access control. This is a way that we can limit the accessibility of behaviours to objects instantiated from a class, when these behaviours are not necessary for objects to perform their function within the code. For example, `private` methods cannot be called from outside the class (and hence objects are unable to call these methods), while `private` methods can only be accessed from within the class, as well as by other instances of the same class. 

*Encapsulation also allows us to think about higher levels of abstraction, since objects often take the form of nouns, and their interactions with other objects as verbs, allowing us to more easily design a program without having to worry about specific implementation details upfront.*

#### *What is an object? How do you initialize a new object/instance of a class?
In Ruby, an object is anything that can be said to have a value, and are instantiated from classes. This covers most constructs in Ruby (excluding variables, methods and blocks). In order to create an object, we have to call the `Class#new` or `Class#allocate` method on a defined class.

#### What is an instance variable, and how is it related to an object?
An instance variable is a variable that is initialised through the `initialize` method that is called after the `Class#new` method, and assigned a value that is passed as an argument through the `initialize` method. They are denoted by the `@` symbol before the variable name. 

They are scoped at an object level (meaning all instance methods within the object have access to them, wherever they are defined) and are inaccessible outside of the object, unless getter or setter methods are defined to access them. Instance variables and their associated values are not shared between objects (i.e. each object has it's own instance variables, which are not linked to instance variables of the same name of other objects).

Instance variables only exist once the object is instantiated and a value assigned to them, at which point they become part of an object's state, or the series of instance variables and their values that contribute to the data within an object. State is an object level concern, and cannot be inherited.

#### What is an instance method?
An instance method is a method defined within a class. They define the behaviours of a particular object instantiated from the class, though whether they can be called on the object depends on the level of method access control applied (instance methods are accessible within the __class__, irrespective of method access control). They are inheritable through class inheritance, and all objects instantiated from the same class will have access to the same set of instance methods.

#### What is the scoping rule for instance variables?
Instance variables are scoped at an object level, meaning that all instance methods have access to instance variables, regardless of where they are defined. *We need to be careful about whether instance variables are initialised however* - attempting to reference an uninitialised instance variable will return `nil` in an instance method (not a `NoNameError` like a uninitialised local variable would), which can cause confusion depending on the context of the instance method in question.

#### How do you see if an object has instance variables?
We can call the `instance_variables` method on an object, which will return an array of __initialised__ instance variables represented as symbols. We could also output the object itself (provided a custom `to_s` method has not been defined), which will list the class name, an encoding of the object id and the instance variables (and their associated values).

#### What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?
A class is a template for an object, defining the behaviours (i.e. instance methods) that an object has. We can instantiate objects from classes. We use the `class` and `end` reserved words to define a class. *Classes can inherit method definitions from other classes, but not state*, since state comprises of instance variables and their assigned values, and state only exists once an object has been instantiated from a class and those instance variables initialised and assigned values.

#### When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?
Behaviours in this context usually refers to the instance methods that an object instantiated from a class has. State refers to the instance variables and their assigned values that are encapsulated in an object. *Behaviours are defined and inheritable through class inheritance, while state is not inheritable*, since state is only defined once an object is instantiated from a class, and values assigned to initialised instance variables. Behaviours are shared between all instances of the same class, while state is unique to objects (i.e. objects instantiated from the same class do not share state between themselves).

#### How do objects encapsulate state?
Objects encapsulate state *because state is typically not accessible from outside the object, unless a custom getter/setter method is defined within the class*. Also, state is unique to each object (i.e. objects instantiated from the same class do not share state between the different instances of that class), meaning that the data encapsulated by any given object is specific to only that object (similar to the idea that different classes will have different methods according to their role in the program).

#### *What is a collaborator object, and what is the purpose of using collaborator objects in OOP?
A collaborator object is any object that is assigned to an instance variable in an object (this could be objects created from custom classes, or objects instantiated from the Ruby Core API classes, like `String`, `Integer`, `Array`). Collaborator objects allow us to model associative ("has-a") relationships between different objects that wouldn't fit into hierarchical ("is-a") relationships, but *also allow for encapsulation, since the collaborator objects may have their own instance methods which are kept separate from the object's own methods.* The collaboration actually exists once the instance variable is initialised and the object assigned to that instance variable.

#### Why should a class have as few public methods as possible?
A class having fewer public methods aligns with the principle of encapsulation. Fewer public methods means there are fewer ways to interface directly with an object, meaning there is a stronger degree of data protection for the state of that object (reduced chance for inadvertently changing state), and any other objects that rely on the state of that object.

#### What is the private method call used for?
The `private` method call is a method we can use in a class definition to apply method access control over instance methods. In particular, defining instance methods as `private` means these instance methods cannot be accessed outside of the class - i.e. they cannot be called directly on objects instantiated from the class, but only in other public methods accessible to that object (attempting to call a `private` method directly on the object will raise a `NoMethodError`).

#### *What is the protected method used for?
A `protected` method is another form of method access control we can apply in a class definition to limit the accessibility of instance methods to an object. Specifically, a `protected` method can be accessed within a class definition like any other method, but cannot be called directly on an object instantiated from that class. `Protected` methods can only be called by other instance methods (which would need to be public if called directly on an object), or by other instances of the same class.

#### Classes also have behaviors not for objects (class methods). How do you define a class method?
A class method is a method that can only be called directly on a class (i.e. objects instantiated from that class cannot call class methods). We can define a class method within a class by appending the `self` keyword to the method definition. In this context, `self` refers to the class (since `self` is being used outside of a method definition). As such, by using `self.method_name`, we are defining a method directly on the class.

#### *What is polymorphism?
Polymorphism is the ability for different objects to respond to a common method. It is a principle of OOP that allows increased flexibility of code (through duck-typing or method overriding), but also also reduces the amount of repetition of code (through class inheritance of methods, but also interface inheritance through mixing in modules).

*Polymorphism serves as a counter point to encapsulation. Where polymorphism extends the functionality of existing objects, encapsulation seeks to limit object functionality through method access control and limiting method definitions within classes.*

#### What is inheritance?
Inheritance is the ability to model classes in a hierarchical fashion (i.e. "is-a" relationships), enabling classes lower in the hierarchy to access methods from classes higher in the hierarchy via the method lookup chain, even where those methods are mixed in through modules (thus reducing the amount of repeated code). Inheritance also enables classes to access constants and class variables defined in a superclass.

In Ruby, classes can only inherit from a single superclass (though many classes can inherit from a single superclass). We define a hierarchical relationship (i.e. indicating our intention for a class to inherit from another) by using the `<` symbol, followed by the name of the superclass in our class definition.

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
