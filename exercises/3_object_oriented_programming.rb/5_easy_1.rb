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
puts "The issue with this code is that the author has mutated the original name variable when calling the to_s method, which is automatically called when the puts method is invoked. This means whenever a puts method call is made, the original name variable will be mutated. We can fix this by creating a duplicate copy of the name local variable, and moving the upcase from the to_s method to the initialize method."

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
