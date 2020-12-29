# 1) Correct the following program so it will work properly. Assume that the Customer and Employee classes have complete implementations; just make the smallest possible change to ensure that objects of both types have access to the print_address method.
=begin
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
=end
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

# 2) Correct the following program so it will work properly. Assume that the Car class has a complete implementation; just make the smallest possible change to ensure that cars have access to the drive method.
=begin
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
=end
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# 3) Modify the House class so that the above program will work. You are permitted to define only one new method in House.
=begin
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

Home 1 is cheaper
Home 2 is more expensive
=end
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def price_comparison(other)
    price > other.price ? "Home 1 is cheaper" : "Home 2 is more expensive"
  end
end

# Could also use the comparable module (might get funky for string values and numerical values like postcode)
class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end
