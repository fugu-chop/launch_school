#### *What is OOP and why is it important?
OOP is a programming paradigm that was developed in response to programs of increasing complexity. 

Large, complex programs can be difficult to maintain due to dependencies throughout the program. OOP lets programmers write programs in which there are classes that handle particular roles in the program (encapsulating behaviours within classes), which allow programmers to define clear boundaries between different parts of the programs and how these parts interact, thus reducing dependencies and facilitating maintenance.

Coding in a non-OO way often means writing code that is useful solely within a single context. Defining basic classes and leveraging concepts like polymorphism to introduce more detailed behaviors provides a greater level of reusability through inheritance and mixing in modules, as well as flexibility though concepts like method overriding, duck-typing.

Complex coding problems are often difficult to break down and solve in a clear and systematic way. Using OOP to model classes appropriate to the problem, using real-world nouns to represent objects and using verbs to define the interactions between objects, lets programmers think at a higher level of abstraction that helps them break down and solve problems.

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
Duck typing is a form of polymorphism where unrelated classes each have their own implementation of a method that has the same name. It means that different object instantiated from those classes can each call a particular method (though this does not imply that the implementation of that method will be the same across all classes), extending the functionality of our program without having to define hierarchical relationships between those classes. 

#### What is the super method?
The `super` method is a method that, when embedded in another method, calls an equivalently named method higher in the hierarchical chain, forwarding any arguments passed to it to the method defined in the superclass. It allows us to use functionality defined in a superclass, but extend or modify that functionality in subclasses. It's behaviour changes according to whether the `super` method is called with arguments or not. 
- When called without arguments or parentheses, `super` will forward all arguments provided to it to the method in the superclass
- When called without arguments (but providing parentheses), `super()` will call the method in the superclass *without any arguments at all*. This is often the safest way to call a method in the superclass that doesn't accept any arguments. 
- When called with arguments, `super(arg1, arg2)` will forward any arguments to the method defined in the superclass.

#### Why can't we use the `self` prefix on private getter methods?
Prior to Ruby 2.7, we are not able to use the `self` prefix on private instance methods, since in the context of private instance methods, `self` refers to the calling object. This effectively means that we would be calling the private instance method directly on the object, which the `private` method prevents. This can usually be remedied by not using the `self` keyword, since private methods are accessable to all other methods within the class definition, so we can define a public method that calls the private instance method (without `self`). Ruby 2.7 and older versions support using `self` as a prefix for private instance getter methods. 

#### What is method overriding?
Method overriding is a form of polymorphism, where we have a method in a class that either inherits from a superclass or a method mixed in from a module, but define a different implementation of that method (using the same method name) in that subclass, such that the functionality is changed. This allows us to make an object's behaviours more flexible.

#### What is a module? When would we use a module? (classes and methods, or just methods?)
A module is a series of classes and methods that can be mixed into another class to give that class additional functionality it does not have through class inheritance. When mixing in modules, it's useful in that it provides common functionality to classes that may not fit into a logical hierarchy (i.e. an inheritance, "is-a" relationship), but is also useful for namespacing, whereby we can organise classes and prevent naming conflicts when attempting to call methods of the same name from different classes. 

Key differences between modules and classes is that in Ruby, a class can mix in any number of modules, but a class can only inherit from a single class. Also, a class can instantiate any number of objects, but objects cannot be instantiated from a module.

#### Why should methods in mixin modules be defined without using `self.` in the name?
Methods in modules should avoid using `self` in their definition. When used outside of instance methods, `self` refers to the class. When we mix this method into a class and call the method directly on the class, Ruby will interpret `self` as the class which mixes in the module. Since the method comes from the mixed in module and not the class, Ruby will not be able to find the method definition and raise a `NoMethodError`. 

#### What is the method lookup path?
The method lookup path is the sequence of classes and modules that Ruby will attempt to find a method definition in. Through inheritance or modules, we do not necessarily need to have an explicit definition that can be called on an object in each class. When we call a method, Ruby will attempt to find the method definition in the most immediate class (i.e. for an instance method, this is the class from which an object was defined on, or for class methods, the class on which the method was called). 

If Ruby fails to find a definition in the most immediate class, it will look to any modules mixed in, starting from the last module that was mixed in. If a method definition is still not found, Ruby will repeat this process in the superclass and so on, until the method is found, or it reaches the `BasicObject` class and cannot find the method, at which point a `NoMethodError` will be raised.

#### What are class variables? Why is it not recommended to use them?
Class variables are variables defined at a class level, and are identified through the `@@` symbols before the variable name. They are accessible throughout the class, to both class and instance methods. They can be problematic because from the class where the class variable is defined, all subclasses and objects instantiated from that class or subclasses have access to a single copy of that variable, making it very easy to inadvertently change the value assigned to the class variable, at which point all subclasses, objects instantiated from that class or subclass will reflect the new value referenced by that class variable.

#### What are constants? What do we need to be careful of when dealing with constants?
Constants (or constant variables) are variables that ideally, should not have their value changed throughout the operation of the program (it is possible to reassign the value of a constant, though Ruby will raise a warning). They can be identified through variables starting with a capital letter (though it is common to define a constant in all capital letters). *Constants are unique to class or instance variables, as we can point to the constants defined in unrelated classes (i.e. classes that do not inherit from each other) using the namespace resolution operator `::`.*

Constants are accessible to class and instance methods. They can be inherited, but also do have lexical scope. This means that when attempting to evaluate a constant through a class or instance method, Ruby will look to the immediate class where the method is defined for a constant value. This means that if we have constants defined in a subclass and superclass, the value of the constant returned will depend on where the method is defined.

#### What is a getter/setter/accessor method? What do each of these return?
A getter method is an instance method defined in a class that returns the value of an instance variable. We can quickly create getter methods in Ruby using the `attr_reader` method, followed by the relevant instance variable cast as a symbol. 

A setter method is an instance method defined in a class that allows modification of an instance variable. It returns the input that was provided as an argument to the method. `attr_writer` is a method defined in Ruby that allows us to quickly create setter methods.

Accessor methods create both setter and getter methods. We can create an accessor method using the `attr_accessor` method in Ruby, followed by the relevant instance variable name cast as a symbol.


#### When should we use getter/setter methods?
We should use getter or setter methods if we want objects to directly interface with instance variables encapsulated within our objects, or want to perform some transformation on top of the raw value referenced by the instance variable.

#### What is the self keyword? How do we use it?
The `self` keyword can modify the behaviour of methods defined within classes and can return different objects, depending on how it is used.
- When used outside of an instance method definition, it refers to the class in which `self` is used. This is how we can define class methods (appending `self` to a method name in the method definition).
- When used inside of an instance method definition, `self` refers to the calling object itself. This can cause issues if we fail to use `self` on setter methods (Ruby will interpret setter method calls without `self` as local variable assignments), or use `self` methods on private getter methods prior to Ruby 2.7.

#### What are class methods?
Class methods are methods that are defined at a class level. We can identify them through method names that have `self` prepended to them in the method definition. They can only be called directly on the class (and not on objects instantiated from that class). They are useful when we want to track data unrelated to the state of objects instantiated from that class.

#### What is the default `to_s` method in Ruby? How/why would you override this?
The `Object#to_s` method is the default implementation of `to_s` in Ruby. When called on an object, it returns a *string representation* of the object's class name and an encoding of the object's object id. It is automatically called when a `puts` method is called, or when using string interpolation. 

In the context of most programs, this default output is not particularly useful - in most cases, we will want to override the `Object#to_s` method with a custom implementation. We can do this by explicitly defining a `to_s` instance method within a class that returns a more meaningful output (perhaps returning the object referenced by an instance variable).

#### What is a fake operator?
A fake operator is a method that looks like an operator in Ruby due to syntactical sugar. Where the functionality of operators do not change from class to class, fake operators are methods, meaning that each class can have it's own implementation of a particular method. Examples of fake operators include `+`, `[]`, `<=`.

#### How does equivalence work in Ruby?
Equivalence can have different meanings in Ruby, depending on the context or method used. One definition of equivalence is that objects are equivalent if their values are the same, meaning the objects themselves do not have to be the same object. We see this definition commonly in Ruby's CoreAPI classes (e.g. `String#==`, `Array#==`). 

Another definition of equivalence is whether two objects occupy the same space in memory - we see this implementation in `BasicObject#==` (the default implementation of the `==` method) and the `equal?` method.

#### What is the `===` method?
The `===` method in Ruby compares whether the object passed as an argument to this method belongs to the set on which the method is called. It isn't a frequently used method - mostly through `case` statements.

In our example below, we use the `Range#===` method to evaluate whether the integer object `42` is within the set provided in each of our `when` statements - e.g. `(40...50).==(42)`
```ruby
number = 42

case number
when 40...50 then '40 to 50'
when 50...100 then '> 50'
else 
  '< 50'
end
```
#### What is the `eql?` method?
The default implementation of the `eql?` method, per `Object#eql?`, returns `true` if the two objects being compared have the same value and reference the same space in memory. However, most methods will define their own implementation of this method, such that `eql?` will return true if the values of the two objects being compared are the same. This is most frequently used through the `Hash` implementation, which returns true if two hashes have the same key-value pairs, where the hash values are compared by value (and not whether they are occupy the same space in memory).

#### Explain element reference getter and element assignment setter methods?
Element reference getter and elements assignment setter methods look like operators in Ruby, but are actually methods with heavy syntactical sugar applied. The element reference getter method allows us to return an object within a collection based on it's index position in that collection. The element assignment setter method mutates the collection, by reassigning the object in a particular index position with another. 
