# From Quiz 3

* In Ruby, what operators are true operators? (https://launchschool.com/lessons/d2f05460/assignments/9a7db2ee)
* Describe the differences between `==`, `===`, `equal?` and `eql?`.
* In the following code, describe why the last line returns false.
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
  end

  wallet1 = Wallet.new(5, 1, 1)
  wallet2 = Wallet.new(0, 0, 0, 1)
  p wallet1.total #=> 20
  p wallet2.total #=> 20
  p wallet1 == wallet2 #=> false
  ```

* What method(s) are used for comparison in the following case statement?
  ```ruby
  number = 42

  case number
  when 1          then 'first'
  when 10, 20, 30 then 'second'
  when 40..49     then 'third'
  end
  ```
* What is something to be careful of when using class variables? Show an example in code.
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
