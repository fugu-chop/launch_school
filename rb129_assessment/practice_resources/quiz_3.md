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
      "I am a #{self.class} and have #{SIDES} sides."
    end
  end

  class Shape
    include Describable

    def self.sides
      SIDES
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
