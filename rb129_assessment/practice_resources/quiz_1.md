# From Quiz 1 #

https://launchschool.com/quizzes/cc988e0b

* Explain why Object Oriented Programming was created. Give at least three examples of problems OO solves.
  
  OOP is a programming paradigm created in response to the increase in complexity of programs, mainly through the use of classes and objects. OOP uses a series of design principles that make maintaining these programs more manageable. These principles include:
    - *Encapsulation*, or the hiding of functionality behind different classes. This allows us to clearly define responsibilities within our code, allowing programmers to break up functionality into distinct parts and define the interactions between these parts/objects, rather than having a mess of dependencies. Encapsulation also serves as a data protection mechanism (through method access control), whereby data within objects can only be changed with obvious intent. 
    - *Polymorphism* refers to the ability of different objects to respond to a common interface (i.e. methods that share a common name). Polymorphism allows us to reduce the amount of repeated code (e.g. through methods inherited via class inheritance, or mixed in via modules through interface inheritance), but also extent the functionality of existing code (e.g. through use of the `super` method and duck-typing).

* Describe the relationship between an object and its class.
  - Classes serve as a template for objects. They define what instance methods can be called on objects instantiated from that class. While instance methods are shared between objects instantiated from the same class, state is unique to each object (i.e. state is not shared between different objects instantiated from the same class). 
  - State (which is the set of instance variables and their assigned values encapsulated within an object) cannot be inherited and only exists when the object is initialised, and the values actually assigned to the instance variables. 

* Describe how modules are different from classes.
  - Modules are different from state in that:
    - We cannot instantiate objects from modules - we can only mix in modules to existing classes. 
    - There is no limit to the amount of modules that can be mixed into a class; however, a class can only inherit from a single other class. 
    - Modules enable objects instantiated from classes that do not fit into a logical hierarchy of class inheritance to gain access to a shared set of methods. Instance methods can only be shared between superclasses and subclasses that have a direct chain of class hierarchy.

* Why is encapsulation used in writing programs? What benefits does it give?

  *Encapsulation* is the hiding of functionality of code behind classes and method access control. It serves as a data protection mechanism such that the data encapsulated within an object cannot be changed without obvious intent. 
  
  We can achieve encapsulation by defining classes and methods within those classes (including method access control) that limit the functionality of objects instantiated from those classes to specific roles in the program, allowing us to create boundaries between different parts of our code and control how those parts interact with other objects in our program. In this way, we define specific interactions within our code (rather than relying on massive dependencies), allowing easier debugging and maintenance of code.
  
  *Encapsulation also allows us to think about higher levels of abstraction, since objects often take the form of nouns, and their interactions with other objects as verbs, allowing us to more easily design a program without having to worry about specific implementation details upfront.*

* How does inheritance help make code more flexible and reusable?

  *Inheritance* is a concept that allows us to model logical hierarchical relationships. It makes code more resuable, as objects instantiated from a class that inherits from a superclass automatically has access to the same methods in the superclass. This removes the need to define a specific implementation for a method in each class through class inheritance (though classes can only inherit from a single superclass). We can also reuse existing code but extend or change part of it's functionality by using the `super` method within an instance method definition in the subclass.

* What does inheritance mean in the context of a Ruby class definition?

  Class inheritance means that a subclass has access to the methods that are defined in the superclass. This can reduce the amount of duplicate code (since we don't have to explicitly define the same method in the subclass), but also extend the functionality of existing code in the superclass (we can define a similarly named method in the subclass, and extend the functionality using the `super` method).

* Describe the different ways that polymorphism can be achieved in a Ruby program?

  Polymorphism can be achieved through:
    
  - *Class inheritance*; subclasses are able to inherit methods from their subclasses. Objects instantiated from the same class all share the same methods (even if those methods have different implementations, like in the case of method overriding). Since objects instantiated from the same class are unique (even if the components of their state reference the exact same objects), this fulfils the definition of polymorphism. Note that in Ruby, a class can only directly inherit from a single class.
  
  - *Interface inheritance*. The name of this concept is misleading - it's not related to inheritance, but rather refers to mixing in modules to classes, allowing the class and objects of that class to access those methods defined within the module. A class may have as many modules mixed in as it needs; however objects cannot be instantiated from modules.

* What is polymorphism?

  Polymorphism is the ability of objects of different types to respond to a commonly named method. 
  
  One form of polymorphism is class inheritance. Classes that inherit from a superclass have access to the instance methods defined in that superclass. This means that objects instantiated from different subclasses all have access to the same set of instance methods. Objects instantiated from these subclasses will be different objects, but will still have access to a commonly named method
  
  Another particular form of polymorphism is interface inheritance. This definition is slightly misleading, as it isn't inheritance so much as mixing in modules to classes to allow those classes access to the methods defined in the module, rather than classes 'inheriting' methods from another class in a logical hierarchy. Interface inheritance also reduces duplication of code, as we can simply define a method once in a module, and mix in this module into as many classes as required. It is also more flexible in that we do not require classes to be related to one another in a logical hierarchy to mix in a module (although we cannot instantiate objects from modules).
  
  Another type of polymorphism is duck-typing, whereby unrelated classes can have their own implementation of a commonly named method, such that objects instantiated from these unrelated classes can nonetheless all access a method of the same name (though there is no guarantee that the implementation of that method will return the same values or have the same side-effects).

* Describe the inheritance structure in the code below. Be sure to include the super-class of each class.
    ```ruby
    class Thing
    end

    class AnotherThing < Thing
    end

    class SomethingElse < AnotherThing
    end
    ```
    We have a class, `SomethingElse` that subclasses `AnotherThing` (i.e. inherits from), as denoted by the `<` symbol next to the class name during class definition. `AnotherThing` inherits from the `Thing` class. This also means that if `Thing` had any methods defined within the class, `SomethingElse` would also have access to that method, given the direct inheritance chain between the `Thing`, `AnotherThing` and `SomethingElse` classes.

* What will the method lookup path be for the as a result of the call to the `fly` method on line 25? Explain how you know this.
    ```ruby
    module Flight
      def fly; end
    end

    module Aquatic
      def swim; end
    end

    module Migratory
      def migrate; end
    end

    class Animal
    end

    class Bird < Animal
    end

    class Penguin < Bird
      include Aquatic
      include Migratory
    end

    pingu = Penguin.new
    pingu.fly
    ```
  The `pingu.fly` method call will return a `NoMethodError`, as the `Flight` module is never mixed into any of the classes that the `Penguin` or it's superclass inheritance chain inherit from. The method lookup path for the `fly` method will be (in the following order):
    - The `Penguin` class
    - The `Migratory` module
    - The `Aquatic` module
    - The `Bird` class
    - The `Animal` class
    - The `Object` class
    - The `Kernel` module
    - The `BasicObject` class
  We can verify this calling the `.ancestors` method on the `Penguin` class.

* Why does this code output "Daisy says mooooooooooooo!"?
    ```ruby
    class Animal
      def initialize(name)
        @name = name
      end

      def speak
        puts sound
      end

      def sound
        "#{@name} says "
      end
    end

    class Cow < Animal
      def sound
        super + "moooooooooooo!"
      end
    end

    daisy = Cow.new("Daisy")
    daisy.speak
    ```
  The `Cow` class from which the `daisy` object is instantiated inherits from the `Animal` class (as denoted by the `<` symbol next to the class name in the class definition). As this is an instance method, the `daisy` object has access to the `speak` method in the `Animal` class. When the `daisy` object calls the `speak` method, Ruby will not be able to find a `speak` method definition in the `Cow` class. As such, Ruby will travel up the inheritance chain, looking for a method definition for the `speak` method, which it finds in the `Animal` class.
  
  The `speak` method itself calls the `puts` method, passing in the return value of the `sound` method. There is a `sound` instance method defined in the `Cow` class, which is where Ruby will first look when attempting to evaluate the `sound` method. Within the `Cow#sound` method, there is a `super` method call. The `super` method call calls the `sound` method in the `Animal` superclass (i.e. a method of the same name higher in the inheritance chain), passing it's return value to `Cow#sound`, which in this case is `"Daisy says "`, and concatenates this with the string object "moooooooooooo!". As such, this code will output "Daisy says mooooooooooooo!" and return `nil` (since `puts` returns `nil`).
  
* Write code for the omitted code, to achieve the desired output:
    ```ruby
    class Person
      attr_writer :first_name, :last_name

      def full_name
        # omitted code
        "#{@first_name} #{@last_name}"
      end
    end

    mike = Person.new
    mike.first_name = 'Michael'
    mike.last_name = 'Garcia'
    mike.full_name # => 'Michael Garcia'
    ```
* In the following code, why does `change_grade` not produce the desired result?
  Change the method so that it will produce the desired result. Why does your solution work?
    ```ruby
    class Student
      attr_accessor :name, :grade

      def initialize(name)
        @name = name
        @grade = nil
      end
      
      def change_grade(new_grade)
        #Change made here with self
        self.grade = new_grade
      end
    end

    priya = Student.new("Priya")
    priya.change_grade('A')
    priya.grade # => "A"
    ```
  The original implementation fails to change the object referenced by the instance variable `@grade`, because within the `Student#change_grade` instance setter method, we fail to append a `self.` keyword prefix to `grade`. 
  
  Without `self.grade`, when evaluating this method, Ruby will assume that `grade = ` is a local variable assignment, rather than a setter method call enabled by the `attr_accessor` method. As such, `Student#change_grade('A')` will simply return the string object "A" without reassigning `@grade` (and `@grade` continues to reference the `nil` object). Alternatively, we could have used `@grade` instead of the setter instance method to directly interface with the instance variable.

* Describe what each `self` references in this code:
    ```ruby
    class MeMyselfAndI
      self

      def self.me
        self
      end

      def myself
        self
      end
    end

    i = MeMyselfAndI.new
    ```
    On `line 2`, `self` references the class, as it is used outside of an instance method definition. This returns `MeMyselfAndI`.
    
    On `line 4`, the `self` also refers to the class `MeMyselfAndI`. When appended to a method definition within a class, `self` refers to the class, such that the method is being defined directly on the class (hence we are defining a class method).

    On `line 5`, the `self` refers to the class, `MeMyselfAndI`, as this is a class method definition (__not__ an instance method definition).

    On `line 9`, `self` refers to the calling object, as `line 8-10` is an instance method definition. This will return a string interpretation of the class name (`MeMyselfAndI`) and an encoding of the object id of the `i` object.
