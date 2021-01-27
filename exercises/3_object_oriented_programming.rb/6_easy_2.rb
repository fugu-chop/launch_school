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
  # This module gives us access to <, = and > methods
  include Comparable

  def initialize(price)
    @price = price
  end

  # Per the documentation, the <, = and > method all rely on the <=> method being implemented within the class
  def <=>(other)
    price <=> other.price
  end
end

# 4) Write a class to fit the following use case:
=begin
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

ABC
xyz
=end
class Transform
  def initialize(string)
    @string = string
  end

  def uppercase
    @string.upcase
  end

  def self.lowercase(input)
    input.downcase
  end
end

# 5) What will the following code print?
=begin
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
=end
puts "This will print ByeBye for Something.dupdata, and HelloHello for thing.dupdata."

# 6) Modify this code so it works. Do not make the amount in the wallet accessible to any method that isn't part of the Wallet class.
=begin
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end
=end
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)

if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# 7) Write the classes and methods that will be necessary to make this code run, and print the following output. The order of the output does not matter, so long as all of the information is presented.
=begin
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
=end
class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    # We modified the to_s method in the Pets class to ensure we would be printing a useful string instead of an object when we add a pet from the Pets class to the array in the Owner class.
    puts pets
  end
end

class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    # a ||= b is a conditional assignment operator. It means if a is undefined or falsey, then evaluate b and set a to the result. Equivalently, if a is defined and evaluates to truthy, then b is not evaluated, and no assignment takes place.
    # We keep track of who has what pets in the Owner class, plus we also have access to the pets in the Shelter class. 
    # The hash value is an object, with it's own methods (i.e. useful for calling the print_pets method).
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end

# 8) What is wrong with the following code? What fix(es) would you make?
=begin
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
=end

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # Prior to Ruby 2.7, private methods could never be called with an explicit caller, even when that caller is self. 
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

# 9) You have the following classes. You need to modify the code so that this works. You are only allowed to write one new method to do this.
=begin
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
=end
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

# 10) We need a new class Noble that shows the title and name when walk is called. We must have access to both name and title because they are needed for other purposes that we aren't showing here.
=begin
byron = Noble.new("Byron", "Lord")
p byron.walk
=> "Lord Byron struts forward"

byron.name
=> "Byron"
byron.title
=> "Lord"
=end
module Walkable
  def walk
    # When you perform interpolation on some value in a string, ruby automatically calls #to_s for you. So, #{self} in the string is actually #{self.to_s} in disguise. 
    # self, within an instance method, refers to the object it's called on (so, the object initialised from a class)
    # We have also defined the to_s method in all of our other classes, so when printed via puts, it will display the name, instead of the object.
    "#{self} #{gait} forward"
  end
end

class Person
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title

  include Walkable

  def initialize(name, title)
    @title = title
    @name = name
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end
