# 1) Modify this class so both flip_switch and the setter method switch= are private methods.
=begin
class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
=end
class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# 1b) Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.
class Machine
  def initialize
    @switch = :off
  end

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def read_switch
    switch
  end

  private

  attr_writer :switch
  attr_reader :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# 2) A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:
=begin
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
=end
class FixedArray
  attr_reader :arr

  def initialize(elements)
    @arr = Array.new(elements)
  end

  def [](idx)
    arr.fetch(idx)
  end

  def []=(idx, new_element)
    # Use the method defined above to access IndexError via .fetch
    self[idx]
    arr[idx] = new_element
  end

  def to_a
    # We clone to prevent mutation of the underlying instance
    arr.clone
  end

  def to_s
    to_a.to_s
  end
end

# 3) Below we have 3 classes: Student, Graduate, and Undergraduate. The implementation details for the #initialize methods in Graduate and Undergraduate are missing. Fill in those missing details so that the following requirements are fulfilled - Graduate students have the option to use on-campus parking, while Undergraduate students do not. Graduate and Undergraduate students both have a name and year associated with them. Note, you can do this by adding or altering no more than 5 lines of code.
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  # Since we have a restriction of altering no more than 5 lines of code, we call super. Otherwise we could just dump the initialize method
  def initialize(name, year)
    super
  end
end

# 3b) There is one other "form" of the keyword super. We can call it as super(). This calls the superclass method of the same name as the calling method, but here no arguments are passed to the superclass method at all. Can you think of a way to use super() in another Student related class?
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end

  def say_hello
    'Hello'
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end

  def say_hello
    super + " from a graduate student!"
  end
end

class Undergraduate < Student
  def say_hello
    super + " from an undergraduate student!"
  end
end

# 4) & 4b) Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to CircularQueue::new, and should provide the following methods: enqueue to add an object to the queue, dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty. You may assume that none of the values stored in the queue are nil (however, nil may be used to designate empty spots in the buffer). The above code should display true 15 times.
=begin
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
=end
class CircularQueue
  def initialize(size)
    @buffer = Array.new(size)
    @next_position = 0
    @oldest_position = 0
  end

  def enqueue(object)
    unless @buffer[@next_position].nil?
      @oldest_position = increment(@next_position)
    end

    @buffer[@next_position] = object
    @next_position = increment(@next_position)
  end

  def dequeue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment(@oldest_position) unless value.nil?
    value
  end

  private

  def increment(position)
    (position + 1) % @buffer.size
  end
end

# 4b) There is a simpler solution that uses an Array, and the #push and #shift methods. See if you can find a solution that does this.
class CircularQueue
  attr_reader :queue

  def initialize(buffer)
    @buffer = buffer
    @queue = []
  end

  def enqueue(element)
    # In this solution, the position of the elements is incorrect per the given example, but what is pushed and removed from the array is correct per test cases
    @queue.shift if @queue.size == @buffer
    @queue.push(element)
  end

  def dequeue
    @queue.shift
  end
end

# 6) (Skipped 5) Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:
=begin
game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
=end
class GuessingGame
  attr_accessor :guesses, :answer

  def initialize
    @guesses = 7
    @correct_answer = (1..100).to_a.sample
    @answer = nil
  end

  def play
    loop do
      user_prompt
      number_validation
      return display_loss if guesses == 0
      break if answer == @correct_answer
    end
    display_victory
  end

  private

  def user_prompt
    loop do
      puts "You have #{guesses} guesses remaining."
      puts "Enter a number between 1 and 100: "
      self.answer = gets.chomp.to_f
      break if (1..100).include?(self.answer.to_i) && self.answer == self.answer.to_i
      puts "That's not a valid answer - please enter a whole number between 1 and 100."
    end
    self.answer = self.answer.to_i
    self.guesses -= 1
  end

  def number_validation
    if answer < @correct_answer
      puts "Your guess is too low."
    elsif answer > @correct_answer
      puts "Your guess is too high."
    else
      puts "That's correct!"
    end
  end

  def display_victory
    puts "You won!"
  end

  def display_loss
    puts "You have no more guesses. You lost!"
    puts "The correct number was #{@correct_answer}."
  end
end

GuessingGame.new.play
