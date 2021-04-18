# 1) Add a class method to your MyCar class that calculates the gas mileage of any car.
class MyCar
  def initialize(year, color, model)
    @year, @color, @model, @current_speed = year, color, model, 0
  end

  def self.gas_mileage(distance, volume)
    puts "Your car does #{distance / volume}km per litre of petrol."
  end
end

MyCar.gas_mileage(500, 30)

# 2) Override the to_s method to create a user friendly print out of your object.
class MyCar
  attr_reader :year, :color, :model

  def initialize(year, color, model)
    @year, @color, @model, @current_speed = year, color, model, 0
  end

  def to_s
    "My car is a #{color} #{year} model #{model}"
  end
end

test_car = MyCar.new(2005, 'White', 'Toyota Camry.')
# The "puts" method calls "to_s" automatically
puts test_car

# 3) When we run the following code, we get this error. Why, and how do we fix it?
=begin
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

undefined method `name=' for #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
=end
puts "This error occurs because we only have a getter method for the name instance variable - we haven't provisioned a method to change the name instance variable. We could change this by changing attr_reader to attr_accessor."
