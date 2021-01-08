# 1) What happens in each of the following cases?
=begin
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi

hello = Hello.new
hello.bye

hello = Hello.new
hello.greet

hello = Hello.new
hello.greet("Goodbye")

Hello.hi
=end
puts "In case 1, the code will output \"Hello\", since the Hello object inherits the greet method from the Greeting class. 

In case 2, a NoMethodError will be returned, since the bye method does not exist in the Hello class. 
  
In case 3, an ArgumentError will be returned - while the Hello object inherits the greet method, the greet method expects an argument (which has not been provided). 
  
In case 4, the method will output \"Goodbye\". 
  
In case 5, a NoMethodError will be returned, as the hi method is an instance method (it is only defined for instances of the Hello class, rather than on the class itself), and can only be called on an instance of the Hello object (and not the class itself)."

# 2) If we call Hello.hi we get an error message. How would you fix this?
=begin
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
=end
puts "To avoid an error, we could instantiate an object from the Hello class and then call the hi method. Otherwise, we could define a class method within the Hello class, self.hi."

class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

puts "Note that we cannot simply call greet in the self.hi method definition because the Greeting class itself only defines greet on its instances, rather than on the Greeting class itself."

# 3) When objects are created they are a separate realization of a particular class. Given the class below, how do we create two different instances of this class with separate names and ages?
=begin
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
=end
puts "We would initialise two different local variables, and pass different ages and names to the initialize method when instantiating the object from the AngryCat class. These would be two different objects, with different state."

# 4) Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>". How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).
puts "We can define a custom to_s method within the Cat class that will return \"I am a #\{type\} cat\". This will override the existing to_s method that exists in the Object class."

# 5) If I have the following class, what would happen if I called the methods like shown below?
=begin
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
=end
puts "The tv.manufacturer would return a NoMethodError, as there is no 'manufacturer' instance method (there is only a class method). The tv.model method wouldn't likely return an exception due to the instance method being defined within the Television class. Similarly, the Television.model method call would also return a NoMethodError, as there is no class model method. The Television.manufacturer method call wouldn't likely return an exception due to a class method being defined in the Television class."

# 6) If we have a class such as the one below, in the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?
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
puts "In this code, there is a setter method defined for the @age instance variable. This means that instead of referencing the setter method, we could use the instance variable @age, instead."

# 7) What is used in this class but doesn't add any value?
=begin
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end
=end
puts "Here, the return keyword is not required, as by default, Ruby will return the last evaluated line of code in a method without the return keyword."
