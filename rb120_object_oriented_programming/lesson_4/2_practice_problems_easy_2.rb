# 1) You are given the following code. What is the result of executing the following code?
=begin
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future
=end
puts "This code will instantiate an object from the Oracle class, and assign it to the oracle local variable. The predict_the_future method will then output a string object, \"You will\", followed by a randomly selected string returned by the choices instance method."

# 2) We have an Oracle class and a RoadTrip class that inherits from the Oracle class. What is the result of the following code?
=begin
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future
=end
puts "This will instantiate an object from the RoadTrip class and assign it to the local variable trip. The predict_the_future method (which is inherited from the Oracle class) will then output a string object \"You will\", followed by a randomly selected string object from the choices instance method in the RoadTrip class, since this choices method overrides the choices method defined in the Oracle superclass. By default, Ruby will look in the RoadTrip class for the method definition, before it looks higher up in the inheritance chain."

# 3) How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors? What is the lookup chain for Orange and HotSauce?
=begin
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
=end
puts "By default, Ruby will look for an instance method in the class from which the object was instantiated. It will then look in any modules mixed into that class, and then any superclasses and modules mixed into those superclasses. We can find an object's ancestors by calling the .ancestors method on the class (note that this is class method, and will not work on an instance of that class). In this case, the lookup chain for Orange is Orange -> Taste. The same is true for HotSauce."

# 4) What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?
=begin
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
=end
class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

# 5) There are a number of variables listed below. What are the different types and how do you know which is which?
=begin
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
=end
puts "The first example is a local variable. The second is an instance variable, defined by the @ symbol before the variable name. The third is a class variable, denoted by the @@ symbols before the variable name."

# 6) If I have the following class, which one of these is a class method (if any) and how do you know? How would you call a class method?
=begin
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
=end
puts "The self.manufacturer method is a class method. We can tell by the use of the self. prefix on the method name. We can call this method directly on the class (we cannot call this on instances of this class)."

# 7) Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?
=begin
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
=end
puts "The @@cats_count variable is a class variable, meaning it is a common variable to all instances created from this class. In this implementation, @@cats_count references an integer object that is reassigned to it's previous value + 1 every time a new object is instantiated from the Cat class. 

In order to test this, we could run the .cats_count class method on the Cat class, instantiate a new object from the Cat class, and run the .cats_count class method again to see if the integer object returned has increased by 1. Alternatively, we could add a puts @@cats_count method on the initialize method."

#8) What can we add to the Bingo class to allow it to inherit the play method from the Game class?
=begin
class Game
  def play
    "Start the game!"
  end
end

class Bingo
  def rules_of_play
    #rules of play
  end
end
=end
puts "In order to allow inheritance of methods, we need to add < Game to the first line of the Bingo class definition."

# 9) What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.
=begin
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
=end
puts "If we added another play instance method to the Bingo class, whenever we instantiate an object from the Bingo class and call the play method, Ruby would execute the play instance method defined in the Bingo class. This is because of Ruby looks in the immediate class from which the object was instantiated for a method definition. Only if this cannot be found does Ruby look further up the inheritance class chain."

# 10) What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.
puts "Object oriented programming allows us to create modularised code with less dependencies. It protects information through encapsulation, is prone to fewer exceptions due to polymorphism and is easier to maintain by breaking up code into distinct entities (objects). It is generally also easier to conceptualise when designing applications through the use of nouns and verbs."
