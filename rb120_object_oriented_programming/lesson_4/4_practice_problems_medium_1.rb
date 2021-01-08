# 1) Inspect the code - is it missing anything?
=begin
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
=end
puts "This appears to be valid code. We have a getter method defined for the @balance instance variable, and are able to reference the return value of this instance method (i.e. the @balance instance variable) in the positive_balance? method."

# 2) This will fail when update_quantity is called. What is the mistake here?
=begin
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
=end
puts "The mistake here is that we do not have a setter method defined for the @quantity instance variable. This means as the code stands, there is no functionality within the class to change the quantity instance variable. As is, this code will simply create a local variable called 'quantity' within the object, without updating the instance variable @quantity. We could fix this by defining a setter method, and appending self. to the 'quantity' variable. Otherwise, we could reference the instance variable directly within the method - i.e. using @quantity = instead of quantity = "

# 3) In this code below, what is the issue with using attr_accessor to enable a setter method for the @quantity instance variable?
=begin
class InvoiceEntry
  attr_accessor :quantity
  attr_reader :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end
=end
puts "There aren't any syntactical issues with using attr_accessor, however in OOP it's generally good practice to reduce the number of publically available methods on a class to ensure application validity, since clients of the class are able to change the @quantity instance variable directly, and circumvent protections in the update_quantity instance method."

# 4) Create a class called Greeting with a single instance method called greet that takes a string argument and prints that argument to the terminal. Now create two other classes that are derived from Greeting: one called Hello and one called Goodbye. The Hello class should have a hi method that takes no arguments and prints "Hello". The Goodbye class should have a bye method to say "Goodbye". Make use of the Greeting class greet method when implementing the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.
class Greeting
  def greet(input)
    puts input
  end
end

class Hello < Greeting
  def hi
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

#5) You are given the following class that has been implemented and the following specification of expected behavior. Write additional code for KrispyKreme such that the puts statements will work as specified.
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    @filling_type.nil? ? fill_string = 'Plain' : fill_string = @filling_type
    !@glazing.nil? ? glaze_string = " with #{@glazing}" : glaze_string = ''
    fill_string + glaze_string
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
# "Plain"

puts donut2
# "Vanilla"

puts donut3
# "Plain with sugar"

puts donut4
# "Plain with chocolate sprinkles"

puts donut5
# "Custard with icing"

# 6) If we have these two methods, what is the difference in the way the code works?
=begin
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
=end
puts "There is no effective difference in the way this code operates. In the second example, the self prefix is contained within an instance method, meaning it refers to the object on which the method is called. Here, the methods are the template getter and setter methods as defined by the attr_accessor. Generally speaking however, it's best not to use self where it's not necessary, so in the second example, the show_template method doesn't require a self."

# 7) How could you change the method name below so that the method name is more clear and less repetitive?
=begin
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end
=end
puts "When the class method is called, the syntax is Light.light_status, whch seems a bit redundant. Instead, we can rename it to status, which is much nicer to read when invoked as Light.status."
