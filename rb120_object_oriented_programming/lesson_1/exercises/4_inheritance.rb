# 1) Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles. Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.
class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @@number_of_vehicles_created += 1
    @year, @color, @model, @current_speed = year, color, model, 0
  end
end

class MyCar < Vehicle
  TOWING_CAPACITY = false

  def to_s
    "My car is a #{color} #{year} model #{model}."
  end
end

class MyTruck < Vehicle
  TOWING_CAPACITY = true

  def to_s
    "My truck is a #{color} #{year} model #{model}."
  end
end

# 2) Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.
class Vehicle
  @@number_of_vehicles_created = 0

  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @@number_of_vehicles_created += 1
    @year, @color, @model, @current_speed = year, color, model, 0
  end

  def self.vehicles_created
    puts "This class has created #{@@number_of_vehicles_created} vehicles."
  end
end

class MyCar < Vehicle
  TOWING_CAPACITY = false

  def to_s
    "My car is a #{color} #{year} model #{model}."
  end
end

class MyTruck < Vehicle
  TOWING_CAPACITY = true

  def to_s
    "My truck is a #{color} #{year} model #{model}."
  end
end

# 3) Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.
module Towable
  def deploy_hook
    puts 'Deploying towing hook!'
  end
end

class Vehicle
  @@number_of_vehicles_created = 0

  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @@number_of_vehicles_created += 1
    @year, @color, @model, @current_speed = year, color, model, 0
  end

  def self.vehicles_created
    puts "This class has created #{@@number_of_vehicles_created} vehicles."
  end
end

class MyCar < Vehicle
  TOWING_CAPACITY = false

  def to_s
    "My car is a #{color} #{year} model #{model}."
  end
end

class MyTruck < Vehicle
  include Towable

  TOWING_CAPACITY = true

  def to_s
    "My truck is a #{color} #{year} model #{model}."
  end
end

# 4) Print to the screen your method lookup for the classes that you have created.
puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors

# 5) Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that all of your previous method calls are working when you are finished.
module Towable
  def deploy_hook
    puts 'Deploying towing hook!'
  end
end

class Vehicle
  @@number_of_vehicles_created = 0

  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @@number_of_vehicles_created += 1
    @year, @color, @model, @current_speed = year, color, model, 0
  end

  def speed_up(num)
    @current_speed += num
    puts "You've accelerated to #{@current_speed}km/h."
  end

  def brake(num)
    @current_speed -= num
    puts "You've deccelerated #{num}km/h to #{@current_speed}km/h."
  end

  def shut_off
    @current_speed = 0
    puts "You've stopped the vehicle."
  end

  def current_speed
    puts "Your current speed is #{@current_speed}."
  end

  def spray_paint(c)
    self.color = c
    puts "Your vehicle color has changed to #{self.color}!"
  end

  def self.vehicles_created
    puts "This class has created #{@@number_of_vehicles_created} vehicles."
  end
end

class MyCar < Vehicle
  TOWING_CAPACITY = false

  def to_s
    "My car is a #{color} #{year} model #{model}."
  end
end

class MyTruck < Vehicle
  include Towable

  TOWING_CAPACITY = true

  def to_s
    "My truck is a #{color} #{year} model #{model}."
  end
end

# Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.
module Towable
  def deploy_hook
    puts 'Deploying towing hook!'
  end
end

class Vehicle
  @@number_of_vehicles_created = 0

  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @@number_of_vehicles_created += 1
    @year, @color, @model, @current_speed = year, color, model, 0
  end

  def speed_up(num)
    @current_speed += num
    puts "You've accelerated to #{@current_speed}km/h."
  end

  def brake(num)
    @current_speed -= num
    puts "You've deccelerated #{num}km/h to #{@current_speed}km/h."
  end

  def shut_off
    @current_speed = 0
    puts "You've stopped the vehicle."
  end

  def current_speed
    puts "Your current speed is #{@current_speed}."
  end

  def spray_paint(c)
    self.color = c
    puts "Your vehicle color has changed to #{self.color}!"
  end

  def self.vehicles_created
    puts "This class has created #{@@number_of_vehicles_created} vehicles."
  end

  def age
    puts "Your vehicle is #{how_old} years old."
  end

  private

  def how_old
    Time::now.year - year
  end
end

class MyCar < Vehicle
  TOWING_CAPACITY = false

  def to_s
    "My car is a #{color} #{year} model #{model}."
  end
end

class MyTruck < Vehicle
  include Towable

  TOWING_CAPACITY = true

  def to_s
    "My truck is a #{color} #{year} model #{model}."
  end
end

# 7) Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that contains the following: puts "Well done!" if joe.better_grade_than?(bob)
class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student_b)
    grade > student_b.grade
  end

  protected
  
  def grade
    @grade
  end
end

joe = Student.new('Joe', 86)
bob = Student.new('Bob', 95)

# 8) Given the following error message: NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>, what is the problem and how would you solve it?
puts "We are attempting to call a private method outside of the class in which it was defined. We could solve this by moving the hi method above the private reserved word."
