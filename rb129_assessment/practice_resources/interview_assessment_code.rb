# What is an instance variable, and how is it related to an object?
class Dog
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

ted = Dog.new("Ted", 3)

ted.name
ted.age

# What is an instance method?
class Human
  def initialize(name)
    @name = name
  end

  def show_name
    name
  end

  protected

  def name
    @name
  end
end

class Frank < Human
end

frank = Frank.new("Frank")
frank.show_name

# What is a collaborator object, and what is the purpose of using collaborator objects in OOP?
class Owner
  def initialize(name)
    @name = name
  end

  def identify
    "Hello! My name is #{@name}!" 
  end
end

class Dog
  attr_reader :name

  def initialize(name, owner)
    @name = name
    @owner = owner
  end

  def owner
    @owner.identify + " I am #{name}'s owner!"
  end
end

jeff = Owner.new("Jeff")
ted = Dog.new("Teddy", jeff)

puts ted.name
puts ted.owner

# Why should a class have as few public methods as possible?
class Dog
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ted = Dog.new("Ted")
ted.name
ted.name.reverse!
ted.name

# What is the private method call used for?
class Spy
  def initialize(name)
    @name = name
  end

  def identify
    "This is agent #{name[0]}, reporting in for duty."
  end

  private

  attr_reader :name
end

j = Spy.new("Jessica")
j.identify

# What is the protected method used for?
class Person
  attr_reader :name

  def initialize(name, age)
    @name = name
    @age = age
  end

  def age_comparison(other_person)
    self.age >= other_person.age ? "#{self.name} is older." : "#{other_person.name} is older."
  end

  protected

  attr_reader :age
end

ben = Person.new("Ben", 30)
james = Person.new("James", 26)

ben.age_comparison(james)

# Classes also have behaviors not for objects (class methods). How do you define a class method?
class Dog
  def self.identify
    "I am a #{self}!"
  end
end

class Greyhound < Dog
end

Dog.identify
Greyhound.identify

# What is polymorphism?
module Walkable
  def walk
    "I am a #{self.class} and I can walk!"
  end
end

class Stroller
  include Walkable
end

class Dog
  include Walkable

  def bark
    "Woof!"
  end
end

class Greyhound < Dog
  def bark
    "I don't really bark!"
  end
end

g = Greyhound.new
d = Dog.new
s = Stroller.new

[g, d, s].each { |object| puts object.walk }
[g, d].each { |object| puts object.bark }