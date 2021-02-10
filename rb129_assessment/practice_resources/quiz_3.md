# From Quiz 3

* In Ruby, what operators are true operators? (https://launchschool.com/lessons/d2f05460/assignments/9a7db2ee)

  'True' operators are operators in Ruby that are not methods disguised as operators through syntactical sugar - i.e. their functionality should not change according to what type of objects they are called upon.

* Describe the differences between `==`, `===`, `equal?` and `eql?`.

  `==` is a method in Ruby whose functionality changes according to the object it is called on. The default implementation comes from `BasicObject`, which returns true if both variables compared point to objects occupying the same space in memory (i.e. are the same object). However, many classes (e.g. `String`, `Array`) have a custom interpretation of the `==` method that overrides the `BasicObject#==` method, and effectively compare the value of the objects (i.e. return true if the two objects have the same value).

  The `===` is a method that by default, compares whether the object passed by reference as an argument is part of the set referenced by the calling object. It's most frequently used in `case` statements.
  ```ruby
  String === 'hello'
  # => true
  (10...45) === 15
  # => true
  ```
  The `equal?` method comes from the `Object` class, and returns `true` if two variables point to the same object (i.e. the same space in memory). We typically don't see classes overriding this method, as it's a common way to compare if objects are the same (contrast this with the `==` method).

  The `eql?` method also by default, comes from the `Object` class, comparing whether two variables reference the same object (same space in memory). Most classes have their own interpretation of the `eql?` method - e.g. the `Hash` class has an `eql?` method that is used to compare whether two hashes have the same key-value pairs, where the values are compared on a value basis (i.e. don't have to be the same object in order for `eql?` to return true).

* In the following code, describe why the last line returns false.

  By default, the `==` method comes from the `BasicObject` class, which tests whether two variables are pointing towards the same object. In our implementation. since `wallet1` and `wallet2` are two different instantiations of the `Wallet` class, they are different objects.

* What is needed in the class definition to make it return true? Describe how your code works.
  ```ruby
  class Wallet
    def initialize(ones, fives = 0, tens = 0, twenties = 0)
      @bills = { 1 => ones, 5 => fives, 10 => tens, 20 => twenties }
    end
    
    def total
      @bills.inject(0) do |sum, (value, qty)|
        sum + value * qty
      end
    end

    # Custom implementation of == method
    def ==(other)
      total == other.total
    end
  end

  wallet1 = Wallet.new(5, 1, 1)
  wallet2 = Wallet.new(0, 0, 0, 1)
  p wallet1.total #=> 20
  p wallet2.total #=> 20
  p wallet1 == wallet2 #=> false
  ```
  If we wanted the last line to return `true`, we would need to define a custom `==` method for the `Wallet` class. It would make sense to compare the return value of the `total` between two objects of the `Wallet` class, so we make use of the `Integer#==` method, which enables us to compare `integer` objects (which is what the `total` instance method returns).

* What method(s) are used for comparison in the following case statement?
  ```ruby
  number = 42

  case number
  when 1          then 'first'
  when 10, 20, 30 then 'second'
  when 40..49     then 'third'
  end
  ```
  In the above example, we use the `Range#===` method on `line 6`, when we are testing whether `42` is part of the range `40...49`. We also use `Integer#===` on `lines 4-5` to compare integer objects.

* What is something to be careful of when using class variables? Show an example in code.

  Something to keep in mind when using class variables is that all subclasses, and objects instantiated from those subclass (and the class where the class variable is defined) all share a single copy of the same class variable. This means any changes to a class variable in any one those objects or subclasses will be reflected across all objects and subclasses.

  
  ```ruby
  class Animal
    @@legs = 4

    def legs
      @@legs
    end
  end

  giraffe = Animal.new
  giraffe.legs
  # => 4

  class Dog < Animal
  end

  ted = Dog.new
  ted.legs
  # => 4

  class Bird < Animal
    @@legs = 2
  end

  bird = Bird.new
  bird.legs
  # => 2

  ted.legs
  # => 2
  giraffe.legs
  # => 2
  ```
* Review these posts about the Constant Lookup Path:
    * https://launchschool.com/posts/699fb006
    * https://launchschool.com/posts/49bb94e9
    * https://launchschool.com/lessons/d2f05460/assignments/b8928e96
* Fix this code so it produces the expected output. Explain why your fixes work:
  ```ruby
  module Describable
    def describe_shape
      # Reference self.class::
      "I am a #{self.class} and have #{self.class::SIDES} sides."
    end
  end

  class Shape
    include Describable

    def self.sides
      # Change to reference class
      self::SIDES
    end

    # Create instance method
    def sides
      self.class::SIDES
    end
  end

  class Quadrilateral < Shape
    SIDES = 4
  end

  class Square < Quadrilateral; end

  Square.sides # => 4
  Square.new.sides # => 4
  Square.new.describe_shape # => "I am a Square and have 4 sides."
  ```
  We need change the `Shape::sides` method to use the namespace resolution operator `::`. This is because constants have lexical scope. In our particular implementation, the `sides` class method is defined in the `Shape` class. When attempting to call the `sides` class method on the `Square` class, Ruby looks up the inheritance hierarchy chain to find a class method definition for `sides`. Since there is an inheritance chain from `Square` -> `Quadrilateral` -> `Shape`, Ruby finds a class method definition of `sides` in the `Shape` class. This class method attempts to return the `SIDES` constant. 
  
  However, because constants have lexical scope, Ruby will attempt to evaluate the `SIDES` constant in the same class in which the `sides` class method was defined (`Shape`). As this constant definition does not exist in `Shape`, Ruby will return a `NameError`. We fix this by adding `self::` to the `SIDES` constant. As `self` is used outside of an instance method (as `self.sides` is a class method), it refers to the class. We can then use the namespace resolution operator to reference the class on which the `sides` class method is called, ensuring this method will reference the class from which this class method is called.

  We also need to add an instance method `sides` to `Shape`, as we only have a class method `sides` defined in the `Shape` class, which cannot be called directly on objects instantiated from `Shape`. As such, we need to create a public instance method that also returns the value of the constant. We run into the same issues as described above with constant lexical scope - we need to have `self.class::SIDES` so that:
    - `self` refers to the calling object
    - `class` chained onto the calling object references the class of the calling object
    - `::` allows us to reference the `SIDES` constant in a particular class (in our class, the class of the calling object).

  Our `Describable` module also needs to reference `self.class::SIDES` instead of just `SIDES`. Again, constants have lexical scope, meaning that if we attempt to call the `describe_shape` method on an object instantiated from a class with the `Describable` module mixed in, this will return a `NameError`, as when calling the `describe_shape` method, when attempting to evaluate `SIDES`, Ruby will attempt to find the object referenced by the `SIDES` constant in the `Describable` module (i.e. where `describe _shape` is defined), which does not exist.

* Explain what variables are instantiated when the new `Greyhound` object is instantiated, and why.
  ```ruby
  module Speedy
    def run_fast
      @speed = 70
    end
  end

  class Animal
    def initialize(name, age)
      @name = name
      @age = age
    end
  end

  class Dog < Animal
    DOG_YEARS = 7

    def initialize(name, age)
      @dog_age = age * DOG_YEARS
    end
  end

  class Greyhound < Dog
    include Speedy
  end

  grey = Greyhound.new('Grey', 3)
  ```
  When a `Greyhound` object is instantiated, Ruby will attempt to call an `initialize` method. Since `Greyhound` subclasses `Dog`, Ruby is able to find a definition in the `Dog` class (overriding the `Animal#initialize` method, which would have initialised two different instance variables) and stops looking any further up the inheritance hierarchy chain. 
  
  The `Dog#initialize` method is called, which initialises instance variables and assigns values to them. In the `Greyhound` class implementation of `initialize`, the `@dog_age` instance variable is initialised. The `name` argument provided to the `initialize` method is ignored - no instance variable is initialised and assigned to the object referenced by the `name` argument. Thus it does not contribute to `grey`'s state. 

  While we also mix in the `Speedy` module, we never call the `run_fast` method in our code. Thus the `@speed` instance variable is never initialised or assigned a value. It thus does not contribute to the state of `grey`. 
