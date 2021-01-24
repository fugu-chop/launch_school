# 1) Given the below usage of the Person class, code the class definition.
=begin
bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
=end
class Person
  attr_accessor :name
end

bob = Person.new('bob')

# 2) Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.
=begin
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'
=end
class Person
  attr_accessor :last_name

  def initialize(n)
    @name = n
    @first_name = n
    @last_name = ''
  end

  def name
    last_name == '' ? @name : "#{first_name} #{last_name}"
  end
end

bob = Person.new('Robert')

# 3) Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.
=begin
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
=end
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  # Since our name getter and setter instance methods require different functionality, we define them separately. 
  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert')

# 4) Using the class definition from step #3, let's create a few more people, i.e. Person objects. If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?
=begin
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
=end
puts "We need to compare the return values of the name method in each object."

# 5) Continuing with our Person class definition, what does the below print out?
=begin
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
=end
puts "By default, the string interpolation will print out the name of the class from which the object was instantiated (not the return value of the name method) and an encoding of the object's object_id. This is because string interpolation automatically calls the .to_s method from the Object class, which has not overwritten in the Person class."

# 6) Let's add a to_s method to the class. Now, what does the below output?
=begin
class Person
  # ... rest of class omitted for brevity

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
=end
puts "This will print out the return value of the name instance method. String interpolation will call the .to_s method, which now returns the return value of the name instance method when called on the bob object."
