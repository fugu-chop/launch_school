# From Quiz 1 #

https://launchschool.com/quizzes/cc988e0b

* Explain why Object Oriented Programming was created. Give at least three
  examples of problems OO solves.
* Describe the relationship between an object and its class
* Describe how modules are different from classes
* Why is encapsulation used in writing programs? What benefits does it give?
* How does inheritance help make code more flexible and reusable?
* What does inheritance mean in the context of a Ruby class definition?
* Describe the different ways that polymorphism can be achieved in a Ruby
  program?
* What is polymorphism?
* Describe the inheritance structure in the code below. Be sure to include the
  super-class of each class.
    ```ruby
    class Thing
    end

    class AnotherThing < Thing
    end

    class SomethingElse < AnotherThing
    end
    ```
* What will the method lookup path be for the as a result of the call to the
  `fly` method on line 25? Explain how you know this.
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

* Write code for the omitted code, to achieve the desired output:
    ```ruby
    class Person
      attr_writer :first_name, :last_name

      def full_name
        # omitted code
      end
    end

    mike = Person.new
    mike.first_name = 'Michael'
    mike.last_name = 'Garcia'
    mike.full_name # => 'Michael Garcia'
    ```
* In the following code, why does `change_grade` not produce the desired result?
  Change the method so that it will produce the desired result. Why does your
  solution work?
    ```ruby
    class Student
      attr_accessor :name, :grade

      def initialize(name)
        @name = name
        @grade = nil
      end
      
      def change_grade(new_grade)
        grade = new_grade
      end
    end

    priya = Student.new("Priya")
    priya.change_grade('A')
    priya.grade # => "A"
    ```
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
