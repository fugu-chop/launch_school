# 1) You come across the following code. What errors does it raise for the given examples and what exactly do the error messages mean?
=begin
def find_first_nonzero_among(numbers)
  numbers.each do |n|
    return n if n.nonzero?
  end
end

# Examples
find_first_nonzero_among(0, 0, 1, 0, 2, 0)
find_first_nonzero_among(1)
=end
puts "This method should raise an exception for receiving too many numbers, since the method only accepts a single argument. You also can't use the .each method on an integer."

# 2) Our predict_weather method should output a message indicating whether a sunny or cloudy day lies ahead. However, the output is the same every time the method is invoked. Why? Fix the code so that it behaves as expected.
=begin
def predict_weather
  sunshine = ['true', 'false'].sample

  if sunshine
    puts "Today's weather will be sunny!"
  else
    puts "Today's weather will be cloudy!"
  end
end
=end
def predict_weather
  sunshine = [true, false].sample

  if sunshine
    puts "Today's weather will be sunny!"
  else
    puts "Today's weather will be cloudy!"
  end
end

# 3) When the user inputs 10, we expect the program to print The result is 50!, but that's not the output we see. Why not?
=begin
def multiply_by_five(n)
  n * 5
end

puts "Hello! Which number would you like to multiply by 5?"
number = gets.chomp

puts "The result is #{multiply_by_five(number)}!"
=end
puts "This function throws an error as the gets method converts user input to a string. The method then tries to multiply a string by an integer, which Ruby can't do. Instead, we should add a .to_i method to gets.chomp."

#4) Magdalena has just adopted a new pet! She wants to add her new dog, Bowser, to the pets hash. After doing so, she realizes that her dogs Sparky and Fido have been mistakenly removed. Help Magdalena fix her code so that all three of her dogs' names will be associated with the key :dog in the pets hash.
=begin
pets = { cat: 'fluffy', dog: ['sparky', 'fido'], fish: 'oscar' }
pets[:dog] = 'bowser'
p pets #=> {:cat=>"fluffy", :dog=>"bowser", :fish=>"oscar"}
=end
pets = { cat: 'fluffy', dog: ['sparky', 'fido'], fish: 'oscar' }
pets[:dog].push('bowser')
p pets

# 5) We want to iterate through the numbers array and return a new array containing only the even numbers. However, our code isn't producing the expected output. Why not? How can we change it to produce the expected result?
=begin
numbers = [5, 2, 9, 6, 3, 1, 8]

even_numbers = numbers.map do |n|
  n if n.even?
end

p even_numbers
=end
puts "I don't think map is the right method to use here, since map attempts to apply a transformation to each element in an array and returns a transformed array. The .even? method does not exclude numbers for us - it returns true for even numbers and nil for odd numbers. This, combined with the .map method, means we get an array of nil and true. The .select method allows us to filter elements in an array, without transforming them."

numbers = [5, 2, 9, 6, 3, 1, 8]
even_numbers = numbers.select do |n|
  n.even?
end
p even_numbers

# 6) You want to have a small script delivering motivational quotes, but with the following code you run into a very common error message: no implicit conversion of nil into String (TypeError). What is the problem and how can you fix it?
=begin
def get_quote(person)
  if person == 'Yoda'
    'Do. Or do not. There is no try.'
  end
  if person == 'Confucius'
    'I hear and I forget. I see and I remember. I do and I understand.'
  end
  if person == 'Einstein'
    'Do not worry about your difficulties in Mathematics. I can assure you mine are still greater.'
  end
end

puts 'Confucius says:'
puts '"' + get_quote('Confucius') + '"'
=end
puts "The get_quote method does not explicitly return anything. This means the last line of code in our method will be returned, which is the 'Einstein' statement. This means anything else will return nil, and nil cannot be concatenated with strings."

def get_quote(person)
  if person == 'Yoda'
    'Do. Or do not. There is no try.'
  elsif person == 'Confucius'
    'I hear and I forget. I see and I remember. I do and I understand.'
  elsif person == 'Einstein'
    'Do not worry about your difficulties in Mathematics. I can assure you mine are still greater.'
  end
end

puts 'Confucius says:'
puts '"' + get_quote('Confucius') + '"'

# 7) The output of the code below tells you that you have around $70. However, you expected your bank account to have about $238. What did we do wrong?
=begin
balance = 0

january = {
  income: [ 1200, 75 ],
  expenses: [ 650, 140, 33.2, 100, 26.9, 78 ]
}

february = {
  income: [ 1200 ],
  expenses: [ 650, 140, 320, 46.7, 122.5 ]
}

march = {
  income: [ 1200, 10, 75 ],
  expenses: [ 650, 140, 350, 12, 59.9, 2.5 ]
}

def calculate_balance(month)
  plus  = month[:income].sum
  minus = month[:expenses].sum

  plus - minus
end

[january, february, march].each do |month|
  balance = calculate_balance(month)
end
=end
puts "This code is not appending each month's balance. Each time the .each method loops through a month, it is overwriting the balance variable with the most recent month's value, rather than adding it."

balance = 0

january = {
  income: [ 1200, 75 ],
  expenses: [ 650, 140, 33.2, 100, 26.9, 78 ]
}

february = {
  income: [ 1200 ],
  expenses: [ 650, 140, 320, 46.7, 122.5 ]
}

march = {
  income: [ 1200, 10, 75 ],
  expenses: [ 650, 140, 350, 12, 59.9, 2.5 ]
}

def calculate_balance(month)
  plus  = month[:income].sum
  minus = month[:expenses].sum

  plus - minus
end

[january, february, march].each do |month|
  balance += calculate_balance(month)
end

# 8) The following code throws an error. Find out what is wrong and think about how you would fix it.
=begin
colors = ['red', 'yellow', 'purple', 'green', 'dark blue', 'turquoise', 'silver', 'black']
things = ['pen', 'mouse pad', 'coffee mug', 'sofa', 'surf board', 'training mat', 'notebook']

colors.shuffle!
things.shuffle!

i = 0
loop do
  break if i > colors.length

  if i == 0
    puts 'I have a ' + colors[i] + ' ' + things[i] + '.'
  else
    puts 'And a ' + colors[i] + ' ' + things[i] + '.'
  end

  i += 1
end
=end
puts "This throws an error because there is a mismatch in the number of objects in the colors and things arrays. We need to drop an object in the colors array order for this to work. We also need to change the break condition to colors.length - 1, since array indexes start from 0."

colors = ['red', 'yellow', 'purple', 'green', 'dark blue', 'turquoise', 'silver', 'black']
things = ['pen', 'mouse pad', 'coffee mug', 'sofa', 'surf board', 'training mat', 'notebook']

colors.shuffle!
things.shuffle!
colors.pop

i = 0
loop do
break if i > colors.length - 1

  if i == 0
    puts 'I have a ' + colors[i] + ' ' + things[i] + '.'
  else
    puts 'And a ' + colors[i] + ' ' + things[i] + '.'
  end

  i += 1
end

# 9) Given a String of digits, our digit_product method should return the product of all digits in the String argument. You've been asked to implement this method without using reduce or inject. When testing the method, you are surprised by a return value of 0. What's wrong with this code and how can you fix it?
=begin
def digit_product(str_num)
  digits = str_num.chars.map { |n| n.to_i }
  product = 0

  digits.each do |digit|
    product *= digit
  end

  product
end

p digit_product('12345')
=end
puts "The issue here is that the product variables starts at zero and is multiplied against each digit. This means that the result will always be zero. We can fix this by changing product to 1."

def digit_product(str_num)
  digits = str_num.chars.map { |n| n.to_i }
  product = 1

  digits.each do |digit|
    product *= digit
  end

  product
end

p digit_product('12345')

# 10) We started writing an RPG game, but we already run into an error message. Find the problem and fix it.
=begin
player = { strength: 10, dexterity: 10, charisma: 10, stamina: 10 }

character_classes = {
  warrior: { strength:  20 },
  thief:   { dexterity: 20 },
  scout:   { stamina:   20 },
  mage:    { charisma:  20 }
}

puts 'Please type your class (warrior, thief, scout, mage):'
input = gets.chomp.downcase

player.merge(character_classes[input])

puts 'Your character stats:'
puts player
=end
puts "The issue here is that the player object is a hash, and to access the values, we need to provide a key. These are symbols, whereas the input variable provided is a string, and so doesn't match any key in the hash. We can change this by converting the input variable to a symbol. We also see that merge is not a destructive method, so the merge doesn't actually change the player hash. We can change this by using the bang operator."

player = { strength: 10, dexterity: 10, charisma: 10, stamina: 10 }

character_classes = {
  warrior: { strength:  20 },
  thief:   { dexterity: 20 },
  scout:   { stamina:   20 },
  mage:    { charisma:  20 }
}

puts 'Please type your class (warrior, thief, scout, mage):'
input = gets.chomp.downcase

player.merge!(character_classes[input.to_sym])

puts 'Your character stats:'
puts player