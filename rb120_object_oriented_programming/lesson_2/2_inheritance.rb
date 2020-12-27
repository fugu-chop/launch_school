# 1) Given the following class, One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviors. For example, bulldogs can't swim, but all other dogs can. Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"
=begin
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
=end
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

bruce = Bulldog.new
puts bruce.speak
puts bruce.swim

# 2) Create a new class called Cat, which can do everything a dog can, except swim or fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste all methods in Dog into Cat; try to come up with some class hierarchy.
=begin
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end
=end
class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

pete = Animal.new
kitty = Cat.new
dave = Dog.new

pete.run
pete.speak

kitty.run
kitty.speak
kitty.fetch

dave.speak

# 3) Draw a class hierarchy diagram of the classes from step #2
puts "Done elsewhere."

# 4) What is the method lookup path and how is it important?
puts "The method lookup path is how Ruby determines where to find methods within a given class. It will look first within the immediate class, then any mixed in modules (starting with the last mixed in module), then in any other superclasses and modules mixed into those superclasses."
