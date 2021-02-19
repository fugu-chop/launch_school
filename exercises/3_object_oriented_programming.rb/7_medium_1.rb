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
    # We remove self. for compatibility with versions of Ruby <2.7
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

  attr_accessor :switch

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
  def initialize(elements)
    @arr = Array.new(elements)
  end

  def [](idx)
    @arr.fetch(idx)
  end

  def []=(idx, new_element)
    # Use the method defined above to access IndexError via .fetch. Since it's not the last line of the method and there's no explicit return, it's a check done behind the scenes
    # Remember also this is just syntactical sugar for @arr.[](idx)
    self[idx]
    @arr[idx] = new_element
  end

  def to_a
    # We clone to prevent mutation of the underlying array
    @arr.clone
  end

  def to_s
    @to_a.to_s
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
    super() + " from a graduate student!"
  end
end

class Undergraduate < Student
  def say_hello
    super() + " from an undergraduate student!"
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

  protected

  attr_accessor :guesses, :answer

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

# 7) Update your solution to accept a low and high value when you create a GuessingGame object, and use those values to compute a secret number for the game. You should also change the number of guesses allowed so the user can always win if she uses a good strategy. 
class GuessingGame
  def initialize(lower, upper)
    @guesses = Math.log2(upper - lower).to_i + 1
    @correct_answer = (lower..upper).to_a.sample
    @answer = nil
    @lower_bound = lower
    @upper_bound = upper
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

  protected

  attr_accessor :guesses, :answer

  private

  def user_prompt
    loop do
      puts "You have #{guesses} guesses remaining."
      puts "Enter a number between #{@lower_bound} and #{@upper_bound}: "
      self.answer = gets.chomp.to_f
      break if (@lower_bound..@upper_bound).include?(self.answer.to_i) && self.answer == self.answer.to_i
      puts "That's not a valid answer - please enter a whole number between #{@lower_bound} and #{@upper_bound}."
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

GuessingGame.new(100, 350).play

# 8) Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects. Numeric cards are low cards, ordered from 2 through 10. Jacks are higher than 10s, Queens are higher than Jacks, Kings are higher than Queens, and Aces are higher than Kings. 

# The suit plays no part in the relative ranking of cards. If you have two or more cards of the same rank in your list, your min and max methods should return one of the matching cards; it doesn't matter which one. 

# Besides any methods needed to determine the lowest and highest cards, create a #to_s method that returns a String representation of the card, e.g., "Jack of Diamonds", "4 of Clubs", etc.
=begin
cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8
=end
class Card
  NUM_RANKING = (('2'..'10').to_a + %w(Jack Queen King Ace)).zip((2..14).to_a).to_h

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other)
    rank == other.rank &&
    suit == other.suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end

  protected

  # The min and max methods rely on the spaceship operator being available within the class
  # We use protected since we want to compare different instances of the same Card class
  def <=>(other)
    ranked_value <=> other.ranked_value
  end

  def ranked_value
    NUM_RANKING.fetch(rank.to_s)
  end
end

# 8b) Update the Card class so that #min and #max pick the card of the appropriate suit if two or more cards of the same rank are present in the Array, where Spades > Hearts > Clubs > Diamonds.
=begin
cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min == Card.new(4, 'Diamonds')
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min == Card.new(8, 'Diamonds')
puts cards.max == Card.new(8, 'Spades')

=end
class Card
  NUM_RANKING = (('2'..'10').to_a + %w(Jack Queen King Ace)).zip((2..14).to_a).to_h
  SUIT_RANKING = (%w(Diamonds Clubs Hearts Spades).zip((1..4).to_a)).to_h

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other)
    rank == other.rank &&
    suit == other.suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end

  protected

  def <=>(other)
    ranked_value <=> other.ranked_value
  end

  def ranked_value
    # You can put multiple criteria for the spaceship operator in an array
    [NUM_RANKING.fetch(rank.to_s), SUIT_RANKING.fetch(suit.to_s)]
  end
end

# 9) Using the Card class from the previous exercise, create a Deck class that contains all of the standard 52 playing cards. The Deck class should provide a #draw method to deal one card. The Deck should be shuffled when it is initialized and, if it runs out of cards, it should reset itself by generating a new set of 52 shuffled cards.
class Deck
  # attr is the same as attr_reader
  attr :shoe

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    if shoe.size > 0
      shoe.pop
    else
      initialize
      shoe.pop
    end
  end

  private

  def reset
    # The product method multiplies each object of the caller with each object of the argument
    # Map converts each returned subarray into a format that can be consumed by the Card.new method
    @shoe = SUITS.product(RANKS).map do |suit, rank|
      Card.new(rank, suit)
    end.shuffle
  end
end

x = Deck.new
51.times { |_| x.draw }

# 10) In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.
=begin
hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
=end
class PokerHand
  attr_reader :hand

  def initialize(deck)
    # This doesn't work with test cases that override the general logic, unless you use the Monkey Patch module
    @hand = []
    5.times { |_| @hand << deck.draw }
    @card_count = @hand.each_with_object(Hash.new(0)) do |card, hash|
      hash[card.rank] += 1
    end
  end

  def print
    "Your hand is " + @hand.map do |card|
      card.to_s
    end.join(', ')
  end

  def evaluate
    case 
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    flush? &&
    @hand.map do |card|
      card.rank.to_s
    end.sort == ["10", "Ace", "Jack", "King", "Queen"]
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    @card_count.any? { |_, count| count == 4 }
  end

  def full_house?
    @card_count.any? { |_, count| count == 3 } &&
    @card_count.any? { |_, count| count == 2 }
  end

  def flush?
    @hand.map do |card|
      card.suit
    end.uniq.size == 1
  end

  def straight?
    @card_count.all? { |_, count| count <= 1 } &&
    Card::NUM_RANKING[@hand.max.rank.to_s] - Card::NUM_RANKING[@hand.min.rank.to_s] == 4
  end

  def three_of_a_kind?
    @card_count.any? { |_, count| count == 3 }
  end

  def two_pair?
    @card_count.select { |_, value| value == 2 }.size == 2
  end

  def pair?
    @card_count.any? { |_, count| count == 2 }
  end
end
