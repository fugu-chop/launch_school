# 1) Our countdown to launch isn't behaving as expected. Why? Change the code so that our program successfully counts down from 10 to 1.
=begin
def decrease(counter)
  counter -= 1
end

counter = 10

10.times do
  puts counter
  decrease(counter)
end

puts 'LAUNCH!'
=end
# The counter variable fails to decrement as Ruby method invocations do not have access to local variables initialised outside of the method scope. Thus any attempt to decrement the `counter` variable initialised outside of the `decrease` method will fail - the decrement will only apply to the local method variable `counter`, which is initialised each time the method is called. We also don't use the return value of the method anywhere, so our counter variable outside of the method continues to reference the integer `10`.
def decrease(counter)
  counter - 1
end

counter = 10

10.times do
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'

# 1b) We specify 10 two times, which looks a bit redundant. It should be possible to specify it only once. Can you refactor the code accordingly?
(1..10).to_a.reverse.each do |n|
  puts n
end

puts 'LAUNCH!'

# 2) String#upcase! is a destructive method, so why does this code print HEY you instead of HEY YOU? Modify the code so that it produces the expected output.
=begin
def shout_out_to(name)
  name.chars.each { |c| c.upcase! }
  puts 'HEY ' + name
end

shout_out_to('you') # expected: 'HEY YOU'
=end
# The .each method returns the original object it was called on, regardless of the return value of the block. We can fix this by calling the upcase! method directly on the string object referenced by the local method variable `name`.
def shout_out_to(name)
  name.upcase!
  puts 'HEY ' + name
end

shout_out_to('you')

# 3) The valid_series? method checks whether a series of numbers is valid. For the purposes of this exercise, a valid series of numbers must contain exactly three odd numbers. Additionally, the numbers in the series must sum to 47. Unfortunately, our last test case is not returning the expected result. Why is that?
=begin
def valid_series?(nums)
  return false if nums.sum != 47

  odd_count = nums.count { |n| n.odd? }
  odd_count = 3 ? true : false
end

p valid_series?([5, 6, 2, 7, 3, 12, 4, 8])        # should return true
p valid_series?([1, 12, 2, 5, 16, 6])             # should return false
p valid_series?([28, 3, 4, 7, 9, 14])             # should return false
p valid_series?([20, 6, 9, 4, 2, 1, 2, 3])        # should return true
p valid_series?([10, 6, 19, 2, 6, 4])             # should return false
=end
# This fails to pass the final test case as the odd_count is not being compared to `3`, but evaluating as true due to the assignment operator `=` (everything in Ruby is truthy, except for `false` and `nil`). We can fix this by using `==`
def valid_series?(nums)
  return false if nums.sum != 47
  odd_count = nums.count { |n| n.odd? }
  # We could just remove the ternary operator since odd_count == 3 will return a boolean anyway. 
  odd_count == 3 ? true : false
end

# 4) The reverse_sentence method should return a new string with the words of its argument in reverse order, without using any of Ruby's built-in reverse methods. However, the code below raises an error. Change it so that it behaves as expected.
=begin
def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    reversed_words = words[i] + reversed_words
    i += 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'
=end
def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = words.length - 1
  until i < 0
    reversed_words << words[i]
    i -= 1
  end

  reversed_words.join(' ')
end

# 5) We started working on a card game but got stuck. Check out why the code below raises a TypeError. Once you get the program to run and produce a sum, you might notice that the sum is off: It's lower than it should be. Why is that?
=begin
cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

deck = { :hearts   => cards,
         :diamonds => cards,
         :clubs    => cards,
         :spades   => cards }

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit
player_cards = []
deck.keys.each do |suit|
  cards = deck[suit]
  cards.shuffle!
  player_cards << cards.pop
end

# Determine the score of the remaining cards in the deck
sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  remaining_cards.map do |card|
    score(card)
  end

  sum += remaining_cards.sum
end

puts sum
=end
cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

deck = { :hearts   => cards.clone,
         :diamonds => cards.clone,
         :clubs    => cards.clone,
         :spades   => cards.clone }

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit
player_cards = []
deck.keys.each do |suit|
  cards = deck[suit]
  cards.shuffle!
  player_cards << cards.pop
end

# Determine the score of the remaining cards in the deck
sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  remaining_cards.map! do |card|
    score(card)
  end

  sum += remaining_cards.sum
end

puts sum
=begin
Although we intended to apply shuffle! and pop to only one of the arrays (returned by deck[suit]), these method invocations impact all four arrays; they are all shuffled in the exact same way and they all miss the player card we picked.

This is because on lines 3-6 we assigned the same array object to each suit. The value associated with each key in our deck hash is thus the same object. When we mutate this object using shuffle! and pop, each value in our deck hash is affected by that mutation.

The most straightforward solution is to clone the cards array when adding it to the deck on lines 3-6.
=end

# 6) We wrote a method for moving a given number of elements from one array to another. We decide to test it on our todo list, but invoking move on line 11 results in a SystemStackError. What does this error mean and why does it happen?
=begin
def move(n, from_array, to_array)
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']
=end
# A SystemStackError usually means that the program is caught in an infinite loop. It happens when we fail to add a break condition that is executed to a looping construct within our code. In our case, we have recursion, but don't specify when to stop running the recursion.
def move(n, from_array, to_array)
  return if n == 0
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end