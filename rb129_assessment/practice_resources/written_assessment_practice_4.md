#### What is OOP and why is it important?
OOP is a programming paradigm that was created in response to programs becoming more complex and more difficult to maintain. Through use of classes, we break up our programs into a number of components designed for specific roles, allowing programmers to define the points of interaction between different components, reducing dependencies and improving maintainability of the code base.

OOP also allows us the flexibility to reuse and extend the functionality of code through polymorphism, or extending behaviours through modules and inheritance, and overriding methods.

OOP also lets us think about the functionality at a higher level of abstraction, allowing programmers to plan and design very complex programs using objects represented as 'nouns', with methods as the 'verbs'.

#### What is encapsulation? How does encapsulation relate to the public interface of a class?
Encapsulation is the hiding of functionality within our program from the rest of the code base. It is a form of data protection such that the state of an object cannot be changed without deliberate and obvious intent. 

One form of encapsulation is the breaking up of a program's functionality into classes, where classes represent discrete parts of a program designed for specific functionality. Each class encapsulates a set of behaviours, and objects instantiated from those classes interact in specific ways with other objects, allowing for boundaries to be set for how objects interact with each other, reducing dependencies and making the program more maintainable. 

Another form of encapsulation is method access control. Method access control is a way to limit the behaviour of objects defined in classes, so that only strictly necessary interactions between objects are allowed. While most instance methods are public by default, private and protected methods also exist, which limit the ability of an object to call methods or directly interface with it's state thus protecting it's encapsulated data from external change.

#### What is an object? How do you initialize a new object/instance of a class?
In Ruby, anything that can be said to have a value can be regarded as an object (notable exceptions to this include variables, blocks and methods). Objects are instantiated from classes, using the `Class#new` or `Class#allocate` methods. 

When instantiated from a class, an object is able to access the methods that were defined within the class (depending on the level of method access control) - all objects instantiated from a class have access to the same set of methods. 

Objects can also have instance variables with assigned values after instantiation. These instance variables and their assigned values constitute the state of an object. State is unique to an object (i.e. state is not shared between different objects instantiated from the same class), and cannot be inherited, as it can only exists after objects are instantiated from a class (only classes can inherit from other classes).

#### What is an instance variable, and how is it related to an object? *
An instance variable is a variable initialised after an object is instantiated. They are identified by the `@` symbol prepended to the variable name.

Instance variables are scoped at an object level, and are accessible to instance methods within an object, regardless of where they are defined. However, they are not accessible outside of an object, unless an explicit getter or setter method is defined in the class. 

Instance variables, and their assigned values, contribute to the state of an object. State is unique to an object (i.e. state is not shared between different instances of an object) and cannot be inherited. 

#### What is an instance method? *
An instance method is a method that is defined within a class. Once an object is instantiated from that class, it will have access to those methods, depending on the level of method access control applied to a method (all objects instantiated from a particular class will have access to the same set of methods). Instance methods can be inherited from superclasses.

#### What is the scoping rule for instance variables? *
Instance variables are scoped at an object level. This means that after they are initialised (and have values assigned to them), instance methods are able to access them, regardless of where they are defined. However, instance variables need to be initialised and values assigned to those instance variables in order for them to constitute state.

#### How do you see if an object has instance variables? *
We can call the `Object#instance_variables` method on an object, which will return an array of *initialised* instance variables, cast as symbols. Uninitialised instance variables or instance variables without values assigned to them will not be displayed.

#### What is a class? What is the relationship between a class and an object? How is defining a class different from defining a method?
A class is a template for an object. Objects are instantiated from classes. Objects are defined using the `class` and `end` reserved words. Within a class, we can define the instance methods that an object instantiated from that class has access to (depending on the level of method access control we exert over these instance methods).

Classes can inherit methods from other classes, while objects cannot be inherited or inherit from other objects (since objects are just instances of classes). Objects do not inherit state from classes - classes provide the instance methods that can initialise instance variables within an object. Only once an object is instantiated from a class, can state exist.

#### When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?
Behaviours refer to the instance methods that are defined within a class, that an object can have access to once they are instantiated from that class. Behaviours can be explicitly defined within the class, inherited from a superclass or mixed in via modules. All objects instantiated from the same class will gain access to the same set of instance methods (whether they can call those methods depends on method access control).

State refers to the series of instance variables and their assigned values encapsulated within an object. State does not exist until the instance variable is initialised and a value assigned to it, which can only occur after an object is instantiated. State is unique to each object (i.e. different instances of the same class do not share state between them) and cannot be inherited, since objects and their data cannot be inherited (only classes can be inherited).

#### How do objects encapsulate state? *
Objects encapsulate state as the instance variables (and their assigned values) are not accessible outside of the object unless a getter or setter method exists. Thus the data within the object is protected unless there is an explicit method to interface with it. 

Another interpretation is that state is unique to each object - i.e. the instance variables and their assigned values are unique to each object (they are not shared between instances of the same class). Each object encapsulates it's own state, meaning that changes to the state of one object will not change the state of all other objects instantiated from the same class.

#### What is a collaborator object, and what is the purpose of using collaborator objects in OOP? *
A collaborator object is any object that is assigned to an instance variable after an object is instantiated from a class. They are useful in helping programmers define associative relationships between different classes (e.g. "has-a" relationships), where those classes may not fit within a hierarchical, inheritance style relationship (e.g. "is-a" relationships).

Collaborator objects allow us to achieve encapsulation, as behaviours can be kept specific to the relevant classes, and the interactions between these classes can be defined through collaborative relationships. The collaborative relationship only exists once the instance variables are initialised and values assigned to them.

#### Why should a class have as few public methods as possible? *
In keeping with the principles of encapsulation, classes should avoid using public methods where possible, as the more public methods accessible to objects, the larger the number of ways that an accidental change to the state of an object is possible. Reducing the number of public methods improves data protection. 

#### What is the private method call used for? *
The `private` method is a form of method access control. It ensures that instance methods defined as `private` cannot be called directly on objects instantiated from the class (attempting to do so will result in a `NoMethodError`). Private methods are accessible within the class, however.

#### What is the protected method used for? *
Protected methods are a form of method access control. They ensure the protected methods cannot be called directly on objects, but only from within the class where the instance method was defined, or by other instances of the same class.

#### Classes also have behaviors not for objects (class methods). How do you define a class method? *
A class method is a method that is only callable directly on a class (they cannot be called on instances of the class). They can be inherited. We define them by appending a `self` to the method name when defining a method within the class. When `self` is used outside of an instance method definition, it refers to the class, so in the case of a class method definition, we are literally defining the method directly on the class.

#### What is polymorphism? *
Polymorphism describes the ability of different objects to respond to a common interface (i.e. method). It enables code to be flexible and reusable, reducing the amount of repetition that is required in our code. Polymorphism can be implemented through mixing in modules, method overriding, duck-typing and inheritance (to name a few). 

Polymorphism can act as an opposite counterpart to encapsulation - encapsulation is concerned with reducing functionality of objects, while polymorphism extends functionality to reduce repetition and improve flexibility. This is often a tradeoff that must be made in the program design.

#### What is inheritance? *
Inheritance is a mechanism that allows classes to access methods from classes higher in an hierarchical chain. Classes can inherit methods from a single superclass, which gives them access to methods defined in that superclass without having to explicitly define those methods in the subclass.

Inheritance enables us to model classes that fit a hierarchical relationship (i.e. "is-a" relationships between classes) and reduce the amount of repeated code in our program. We can make a class inherit from another class by adding a `<` symbol next to a class definition, followed by the name of the class from which it should inherit methods from.

#### What is duck-typing? *
Duck typing is a form of polymorphism. Duck-typing can be implemented by defining a method of the same name across classes that are not related through inheritance (though this does not imply that the methods should have the same functionality). Through duck-typing, we ensure that objects are flexible enough to respond to a common method call.

#### What is the super method?
The `super` method is a way we can call methods of the same name defined in a superclass or a mixed-in module - it is a way we can implement method overriding and polymorphism into our code. The functionality of the `super` method can differ, depending on whether arguments are provided to it:
- Calling `super` without any parentheses or arguments will forward all arguments provided to the subclass method to the superclass/module method, and call that method.
- Calling `super()` with parentheses but without arguments will call the superclass/module method without any arguments. This is often the safest way to avoid `ArgumentErrors` when the superclass/module method does not take any arguments.
- Calling `super(arg1, arg2)` will forward `arg1` and `arg2` to the superclass/module method, and then call that method.

#### Why can't we use the `self` prefix on private getter methods? *
Prior to Ruby 2.7, we were unable to use the `self` prefix on private getter method when referencing those methods in other instance methods. This is because `self`, when used in the context of an instance method definition, refers to the calling object. 

Thus when a private method is called in another instance method using `self`, this would be the equivalent of calling the private getter method directly on the object iself, which is prohibited by the `private` method. As of Ruby 2.7 and beyond, it is now possible to use the `self` keyword as a caller for a private getter method, but it appears to be generally accepted practice to simply not use `self` for private getter methods (one likely factor is to ensure pre-2.7 Ruby compatibility).

#### What is method overriding? *
Method overriding is a way of implementing polymorphism in code. When a class has access to a method through inheritance or a mixed in module, the class can implement it's own version of that particular method by explicitly defining a method of the same name, but have different functionality (thus overriding the original functionality). This allows us to extend the flexibility of code.

#### What is a module? When would we use a module? (classes and methods, or just methods?)
A module can be a grouping of methods that can be mixed into classes, allowing those classes to access the methods defined in the module. Modules are a way that we can implement polymorphism into our code, since any number of modules can be mixed into any class (there is no requirement that classes be related to each other), though objects cannot be instantiated from modules. 

Modules can also be used for namespacing, or grouping classes and methods together. Namespacing assists in organising code, as well as preventing naming conflicts where methods may have the same name across different classes by allowing us to reference which class a module method comes from, with the namespace resolution operator `::`.

#### Why should methods in mixin modules be defined without using `self.` in the name? *
Methods in mixin modules should not be defined using `self`. Typically, when `self` is used outside of an instance method definition, it refers to the class. If we use the `self` keyword in a method definition, it will refer to the class, creating a class method definition. 

In the case of a module, `self` will refer to the module name. Thus even if we mix in a module to a class, attempting to call the method on the class which has the module mixed in will return a `NoMethodError`, since the method will look for the definition in the class which has the module mixed in (where it does not exist). Thus the only way to call the method would be to reference the module specifically, using the namespace resolution operator `::`.

#### What is the method lookup path?
The method lookup path is the chain of classes and modules Ruby will look through in order to find a method definition. When caling a method, Ruby will first search the class from which the object was instantiated when looking for a definition (or the class itself, in the case of a class method).

If Ruby does not find a method definition, it will then search any mixed in modules (starting from the last mixed in module), then repeat the process in the superclass (if applicable), and again until reaching the `BasicObject` class (the highest point in the method lookup path). A `NoMethodError` will be raised if the method definition cannot be found. Otherwise, Ruby will stop looking along the method lookup path at the first instance when it identifies a method definition for the method called.

#### What are class variables? Why is it not recommended to use them? *
A class variable is a variable scoped at the class level. It can be identified by the `@@` symbols preceding the variable name and is initialised when the class is evaluated by Ruby. Class variables are accessible to both class and instance methods, regardless of where a class variable is defined. 

They can be useful when tracking data that is not linked to the state of objects, but can prove problematic for the fact that all instances of the class where the class variable was defined (and subclasses of that class, and objects instantiated from those subclasses) share a single copy of that class variable, meaning that any change to the class variable across any of those classes or objects will mean that change will be reflected across all of the subclasses and objects instantiated from the class and subclasses.

#### What are constants? What do we need to be careful of when dealing with constants? *
Constants are variables that should not have their value reassigned throughout the course of the program's operation (Ruby does allow reassignment of values, but will raise a warning). They can be identified by a variable name with a capital letter (though convention usually dictates that the entire variable name is in capital letters). Constants are accessible to both class and instance methods, and have lexical scope. Constants are also unique in that they can be referenced from other, unrelated classes by using the namespace resolution operator `::`.

This means that when Ruby encounters a method that requires evaluation of the constant, Ruby will look at the class or module where that method was defined for the definition of the constant, which can prove problematic if a constant is defined in a different class to where the method is defined.

#### What is a getter/setter/accessor method? What do each of these return? *
A getter instance method is a method normally that returns an instance variable. We can use the `attr_reader` method in Ruby to quickly create a getter method. A setter instance method is a method that allows us to change the value assigned to an instance variable. It will return the value that was provided as an argument to the method. 

#### When should we use getter/setter methods? *
We should use a getter or setter method only if we want other parts of our program to have direct access to/ability to change instance variables within an object. We might also want to format the instance variable or change the presentation of that instance variable for other parts of the program to consume through a custom getter or setter method.

#### What is the self keyword? How do we use it? *
The `self` keyword can change the way a method behaves, and it's meaning can change depending on the context which it is used. 
- When used outside of an instance method definition, it refers to the class where it is used. This means that we can define methods on a class (i.e. class methods) by appending `self` to a method definition.
- When used inside of an instance method definition, it refers to the calling object. This may have method access control implications if we attempt to append `self` to a private getter method (since we cannot call private methods directly on objects) on versions of Ruby prior to 2.7. There is no issue with using `self` on private *setter* methods, however (in fact we need to use `self` on private setter methods - otherwise Ruby will interpret the setter method call as a local variable assignment.)

#### What is the default `to_s` method in Ruby? How/why would you override this? *
The default `Object#to_s` method, when called on an object, will return a string representation of the class name and an encoding of the object id. The `to_s` method is also automatically called on the argument provided to the `puts` method call, as well as during string interpolation.

This output is not particularly useful for human consumption, so we often make use of method overriding in order to change the implementation of the `to_s` to a more appropriate feature (e.g. returning an instance variable instead). 

We could achieve this by defining a public `to_s` instance method within a class, which would enable the human readable implementation to be called on the object directly.

#### What is a fake operator?
A fake operator is a method that looks like an operator due to the syntactical sugar in Ruby. Examples include `+`, `<`, `[]`. Because these are methods and not operators, their functionality can be changed through method overriding. 

#### How does equivalence work in Ruby?
The concept of equivalence in Ruby can have two meanings:
1. Whether the value of two objects are the same
2. Whether the two objects occupy the same space in memory.

In Ruby, the `BasicObject#==` method compares whether two objects occupy the same space in memory (i.e. are the same object). However, most classes have their own implementation of the `==` method that overrides the `BasicObject#==` implementation in favour of comparing the values of two objects (e.g. `String#==`, `Array#==`). 

However, the `Object#equal?` method does compare whether two objects occupy the same space in memory, and is seldom overridden by custom methods within classes, as this is a consistent way of comparing object identities. 

#### What is the `===` method?
The `===` method returns `true` if the object passed as an argument is part of the set on which the method is called. It is commonly used in `case` statements when evaluating whether conditional statements are met.
```ruby
String === 'hello'
# => true
'hello' === 'hello'
# => true

number = 42

case number
# Using Range#===
when 10...40 then 'A'
# Using Integer#===
when 42 then 'B'
else 'N/A'
end
```
