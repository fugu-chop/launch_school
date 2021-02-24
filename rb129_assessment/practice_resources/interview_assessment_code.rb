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

# What is the super method?
class Animal
  def speak
    "Hello!"
  end

  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name, age)
    super(name)
    @age = age
  end

  def speak
    super() + " I am a #{self.class}!"
  end
end

ted = Dog.new("Ted", 4)
ted.speak

# What are class variables? Why do we need to be careful of class variables?
class Animal
  @@legs = 4

  def legs
    @@legs
  end

  def self.legs
    @@legs
  end
end

horse = Animal.new
dog = Animal.new

Animal.legs
horse.legs
dog.legs

class Bird < Animal
  @@legs = 2
end

Animal.legs
horse.legs
dog.legs

# What are constants? What do we need to be careful of when dealing with constants?
class Animal
  LEGS = 4

  def self.legs
    self::LEGS
  end

  def legs
    self.class::LEGS
  end
end

class Bird < Animal
  LEGS = 2
end

Bird.legs
Bird.new.legs

# What is the self keyword? How do we use it?
class Animal
  def self.identify
    self
  end

  def initialize(name, age)
    @name = name
    @age = age
  end

  def say_hello
    "My name is #{name} and I am #{self.age} years old!"
  end

  def rename(name)
    self.name = name
  end

  protected
  attr_reader :age

  private
  attr_accessor :name
end

ted = Animal.new("ted", 4)

# What is the default `to_s` method in Ruby?
class Dog
  def initialize(name)
    @name = name
  end

  def to_s
    "Hello! My name is #{@name} and I am a #{self.class}!"
  end
end

ted = Dog.new("Ted")
puts ted
"#{ted}"

# What is the `===` method?
num = 25
case num
when 26 then puts "26!"
when 0..25 then puts "0 to 25!"
else puts "Nah"
end

if 26 === num
  puts "26!"
elsif (0..25) === num
  puts "0 to 25!"
else
  puts "Nah"
end

# Explain element reference getter and element assignment setter methods?
class Library
  attr_reader :books

  def initialize
    @books = ["The Bible"]
  end

  def [](position)
    @books[position]
  end

  def []=(position, element)
    @books[position] = element
  end

  def <<(book)
    @books.push(book)
  end
end

lib = Library.new
lib.books
lib[0]
lib[1] = "I am a champion"
lib << "A cool day"
lib.books
