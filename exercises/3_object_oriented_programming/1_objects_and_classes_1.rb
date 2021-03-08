# 1) Update the following code so that, instead of printing the values, each statement prints the name of the class to which it belongs.
=begin
puts "Hello"
puts 5
puts [1, 2, 3]
=end
puts 'Hello'.class
puts 5.class
puts [1, 2, 3].class

# 2) Create an empty class named Cat.
class Cat
end

# 3) Using the code from the previous exercise, create an instance of Cat and assign it to a variable named kitty.
class Cat
end

kitty = Cat.new

# 4) Using the code from the previous exercise, add an #initialize method that prints I'm a cat! when a new Cat object is initialized.
class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new

# 5) Using the code from the previous exercise, add a parameter to #initialize that provides a name for the Cat object. Use an instance variable to print a greeting with the provided name. (You can remove the code that displays I'm a cat!).
class Cat
  def initialize(n)
    @name = n
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')

# 6) Using the code from the previous exercise, move the greeting from the #initialize method to an instance method named #greet that prints a greeting when invoked.
class Cat
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# 7) Using the code from the previous exercise, add a getter method named #name and invoke it in place of @name in #greet.
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# 8) Using the code from the previous exercise, add a setter method named #name. Then, rename kitty to 'Luna' and invoke #greet again.
class Cat
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.name = 'Luna'
kitty.greet

# 9) Using the code from the previous exercise, replace the getter and setter methods using Ruby shorthand.
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.name = 'Luna'
kitty.greet

# 10) Using the following code, create a module named Walkable that contains a method named #walk. This method should print Let's go for a walk! when invoked. Include Walkable in Cat and invoke #walk on kitty.
=begin
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
=end
module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  attr_accessor :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk
