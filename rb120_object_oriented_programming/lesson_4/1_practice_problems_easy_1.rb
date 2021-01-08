# 1) Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?
=begin
true
"hello"
[1, 2, 3, "happy days"]
142
=end
puts "All of the examples are objects in Ruby (everything is an object in Ruby). We can see what class they belong to by using the #class method"

# 2) If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?
=begin
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
=end
puts "We could use the syntax include Speed within both Car and Truck classes. We could then call the go_fast method on objects instantiated from either of those classes."

# 3) Assume we include the Speed module in the Car class. When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?
=begin
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast
=> "I am a Car and going super fast!""
=end
puts "This is possible because of the self.class string interpolation within the Speed module. In this context, self is used in an instance method, which refers to the calling object. This allows the module to reference the class of the object that calls the go_fast method."

# 4) If we have a class AngryCat how do we create a new instance of this class?
puts "We would use the syntax AngryCat.new, which would instantiate an object from the class."

# 5) Which of these two classes has an instance variable and how do you know?
=begin
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
=end
puts "The Pizza class has an instance variable, @name. We can tell because instance variables are prepended with an @ symbol. We can also see if an object has instance variables by calling the .instance_variables method on it."

# 6) What could we add to the class below to access the instance variable @volume?
=begin
class Cube
  def initialize(volume)
    @volume = volume
  end
end
=end
puts "We could add a getter method, either by defining it specifically, or using attr_reader :volume. We could also (though not advised) use the .instance_variable_get(\"@volume\") method."

# 7) What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?
puts "By default, the .to_s method will return the name of the object and an encoding of the object_id. We can verify this behaviour by looking at the official documentation."

# 8) If we have a class such as the one below, You can see in the make_one_year_older method we have used self. What does self refer to here?
=begin
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
=end
puts "In this example, as self occurs within an instance method, it refers to the calling object. In our case, it refers to the age method defined within the class when it's instantiated as an object."

# 9) If we have a class such as the one below, in the name of the cats_count method we have used self. What does self refer to in this context?
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
puts "Here, self refers to a class method. This is a method that refers to the class itself. By default, this method cannot be called on objects instantiated from the class."

# 10) If we have the class below, what would you need to call to create a new instance of this class?
=begin
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
=end
puts "We would need to call Bag.new and provide two arguments, as the initialize method requires two arguments on instantiation of an object created from the Bag class."
