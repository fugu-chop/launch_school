# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.
class MyCar
  def initialize(year, color, model)
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
    puts "You've stopped the car."
  end

  def current_speed
    puts "Your current speed is #{@current_speed}."
  end
end

test_car = MyCar.new(1991, 'red', 'Honda Civic')
test_car.current_speed
test_car.speed_up(50)
test_car.current_speed
test_car.brake(50)
test_car.current_speed
test_car.shut_off
test_car.current_speed

# Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.
class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
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
    puts "You've stopped the car."
  end

  def current_speed
    puts "Your current speed is #{@current_speed}."
  end
end

test_car = MyCar.new(1991, 'red', 'Honda Civic')
test_car.year
test_car.color
test_car.color = 'blue'
test_car.color

# Create a method called spray_paint that can be called on an object and will modify the color of the car.
class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
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
    puts "You've stopped the car."
  end

  def current_speed
    puts "Your current speed is #{@current_speed}."
  end

  def spray_paint(c)
    self.color = c
    puts "Your car color has changed to #{self.color}!"
  end
end

test_car = MyCar.new(1991, 'red', 'Honda Civic')
test_car.color
test_car.spray_paint('blue')
test_car.color
