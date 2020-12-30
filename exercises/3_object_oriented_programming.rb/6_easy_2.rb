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

# 7b) Suppose the shelter has a number of not-yet-adopted pets, and wants to manage them through this same system. Thus, you should be able to add the following output to the example output shown above:
=begin
The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.
=end

# What is our solution design?
# I think we can use the existing adopt method, but with the 'Animal Shelter' as an owner
# When a pet is adopted, we remove it from the animal shelter owner
# We need a method to display the pets that are owned by the animal shelter (but requires a different message to the print_adoptions method).
class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
    # Remove pet from shelter owner
  end

  # Untested
  def print_unadopted_pets
    @owners['The Animal Shelter'].each_pair do |name, owner|
      puts "#{name} has the following unadopted pets:"
      owner.print_pets
    end
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end
