# How do we create an object in Ruby? Give an example of the creation of an object.
puts "We create an object by defining a class and instantiating it by using the .new method to create an instance, also known as an object."

class TerriblePerson
end

pickle = TerriblePerson.new

# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.
puts "A module is a collection of behaviors that is usable in other classes via mixins. It enables a classes to access specific behaviours defined elsewhere (i.e. extend class functionality based on what's in the module). A module is 'mixed in' to a class using the `include` method invocation."

module Rage
  def rage(subject)
    puts "I hate #{subject}!"
  end
end

class TerriblePerson
  include Rage
end

porkish = TerriblePerson.new
porkish.rage("beer")
