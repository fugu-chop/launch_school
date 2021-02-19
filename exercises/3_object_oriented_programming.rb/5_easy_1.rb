# 1) Behold this incomplete class for constructing boxed banners. Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public. You may assume that the input will always fit in your terminal window.
=begin
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

banner = Banner.new('')
puts banner
+--+
|  |
|  |
|  |
+--+
=end
class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * (@message.length + 2)}+"
  end

  def empty_line
    "|#{' ' * (@message.length + 2)}|"
  end

  def message_line
    "| #{@message} |"
  end
end

# 1b) Modify this class so new will optionally let you specify a fixed banner width at the time the Banner object is created. The message in the banner should be centered within the banner of that width. Decide for yourself how you want to handle widths that are either too narrow or too wide.
class Banner
  def initialize(message, width = message.length)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def width_smaller_than_message?
    @width < @message.length
  end

    def width_bigger_than_message?
    @width > @message.length
  end

  def horizontal_rule
    "+#{'-' * (@width + 2)}+"
  end

  def empty_line
    "|#{' ' * (@width + 2)}|"
  end

  def banner_space_length_end
    if (@width - @message.length).odd? 
      ((@width - @message.length) / 2)
    else
      ((@width - @message.length) / 2) - 1
    end
  end

def banner_space_length_start
    ((@width - @message.length) / 2) - 1
  end

  def message_line
    if width_smaller_than_message? 
      "| #{@message[0...@width]} |" 
    elsif width_bigger_than_message?
      "| #{' ' * banner_space_length_start} #{@message} #{' ' * banner_space_length_end} |"
    else 
      "| #{@message} |"
    end
  end
end

# 2) What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer. Leave the .to_s method call in the initialize method for now.
=begin
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
=end
puts "The issue with this code is that the author has mutated the original name instance variable when calling the to_s method, which is automatically called when the puts method is invoked. This means whenever a puts method call is made, the original name instance variable will be mutated. We can fix this by creating a duplicate copy of the name local variable, and moving the upcase from the to_s method to the initialize method."

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# 2b) This code "works" because of that mysterious to_s call in Pet#initialize. However, that doesn't explain why this code produces the result it does. Can you?
=begin
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
=end
puts "On line 1, we initialise a local variable 42 and assign the integer object 42 to it. On line 2, we instantiate a new object from the Pet class, passing in the integer object 42 to the method parameter name, and assign it to the fluffy local variable. When this object is created, the initialize method is immediately called, which in our implementation, calls the Object#to_s method on the integer object 42.

The object referenced by the local variable name is not linked in a deeper fashion to the object referenced by fluffy. Once the object has been instantiated from the Pet class, it does not update if the object passed to it on initialisation changes."

# 3) Complete this program so that it produces the expected output:
=begin
class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end
class Book
  attr_reader :title, :author

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# 3b) What are the differences between attr_reader, attr_writer, and attr_accessor? Why did we use attr_reader instead of one of the other two? Would it be okay to use one of the others? Why or why not?
puts "The attr_ methods allow us to quickly create getter and setter methods on the class. We used attr_reader because we did not want all users to have the ability to change the title or author of a book once an object has been initialised (which attr_writer and attr_accessor would have provided)."

# 4) Complete this program so that it produces the expected output:
=begin
class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end
class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# 4b) What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps?
puts "Initialising an object by sequentially setting instance variables seems time consuming and prone to error - e.g. if the user had attempted to utilise the to_s instance method before setting either the title or author instance variables would still enable the `title` and `author` instance methods to be called. However, because neither instance variable is initialised, these both return nil. Calling the String#to_s method nil objects return blank string objects. This could be prevented by getting all this information upfront when the object is first initialised."

# 5) Complete this program so that it produces the expected output:
=begin
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

John Doe
Jane Smith
=end
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name=(name)
    @first_name = name.capitalize
  end

  def last_name=(name)
    @last_name = name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

# 6) There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?
=begin
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
=end
puts "It seems like the user has unnecessary access to the database_handle instance variable through attr_accessor, since it's initialised without requiring user input. We should remove this attr_accessor method."

# 7) Fix the below code so it works properly.
=begin
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
=end
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    self.mileage += miles
  end

  def print_mileage
    puts mileage
  end
end

# 8)* Given the following class, write a class called Square that inherits from Rectangle:
=begin
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"
=end
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(dimension)
    super(dimension, dimension)
  end
end

# 9) Update this code so that when you run it, you see the following output.
=begin
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
=end
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, fur_color)
    super(name, age)
    @fur_color = fur_color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@fur_color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# 9b An alternative approach to this problem would be to modify the Pet class to accept a colors parameter. If we did this, we wouldn't need to supply an initialize method for Cat. Why would we be able to omit the initialize method? Would it be a good idea to modify Pet in this way? Why or why not? How might you deal with some of the problems, if any, that might arise from modifying Pet?
puts "We would be able to omit the initialize method because the Cat class would inherit all of the instance methods defined in the Pet class. It might not be a good idea to add the color parameter to an initialize method in the Pet class, depending on whether our pets will always have fur. If we did move the color parameter to the Pets class, we might have to manually set the parameter in subsequent objects that don't have fur."

# 10) Consider the following classes. Refactor these classes so they all use a common superclass, and inherit behavior as needed.
=begin
class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end
=end
class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
