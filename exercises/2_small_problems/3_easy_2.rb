# 1) Build a program that randomly generates and prints Teddy's age. To get the age, you should generate a random number between 20 and 200.
=begin
Teddy is 69 years old!
=end
def greeter
  puts "Teddy is #{rand(20..200)} years old!"
end

# 1b) Modify this program to ask for a name, and then print the age for that person. For an extra challenge, use "Teddy" as the name if no name is entered.

def greeting
  puts 'Please enter your name!'
  name = gets.chomp.capitalize
  puts "#{name.empty? ? 'Teddy' : name} is #{rand(20..200)} years old!"
end

# 2) Build a program that asks a user for the length and width of a room in meters and then displays the area of the room in both square meters and square feet. Note: 1 square meter == 10.7639 square feet. Do not worry about validating the input at this time.
=begin
Enter the length of the room in meters:
10
Enter the width of the room in meters:
7
The area of the room is 70.0 square meters (753.47 square feet).
=end

def room_size
  puts "Enter the length of the room in meters:"
  length = gets.chomp.to_f
  puts "Enter the width of the room in meters:"
  width = gets.chomp.to_f
  puts "The area of the room is #{(length * width.round(2))} square meters (#{(length * width * 10.7639.round(2))} square feet)."
end

# 3) Create a simple tip calculator. The program should prompt for a bill amount and a tip rate. The program must compute the tip and then display both the tip and the total amount of the bill.
=begin
What is the bill? 200
What is the tip percentage? 15

The tip is $30.0
The total is $230.0
=end

def tip_calculator
  puts 'What is the bill?'
  bill = gets.chomp.to_f
  puts 'What is the tip percentage?'
  tip = gets.chomp.to_f

  puts "The tip is $#{format('%.2f', (bill * tip / 100))}"
  puts "The total is $#{format('%.2f', (bill + (bill * tip / 100)))}"
end

# 4) Build a program that displays when the user will retire and how many years she has to work till retirement.
=begin
What is your age? 30
At what age would you like to retire? 70

It's 2016. You will retire in 2056.
You have only 40 years of work to go!
=end

def retirement
  puts 'What is your age?'
  current_age = gets.chomp.to_i
  puts 'At what age would you like to retire?'
  retire_age = gets.chomp.to_i

  puts "It's #{Time.now.year}. You will retire in #{Time.now.year + (retire_age - current_age)}."
  puts "You have only #{(retire_age - current_age)} years of work to go!"
end

# 5) Write a program that will ask for user's name. The program will then greet the user. If the user writes "name!" then the computer yells back to the user.
=begin
What is your name? Bob
Hello Bob.

What is your name? Bob!
HELLO BOB. WHY ARE WE SCREAMING?
=end

def screamer
  puts 'What is your name?'
  name = gets.chomp

  if name[-1] == '!'
    puts "HELLO #{name.chop.upcase}. WHY ARE WE SCREAMING?"
  else
    puts "Hello #{name}."
  end
end

# 6) Print all odd numbers from 1 to 99, inclusive. All numbers should be printed on separate lines.
puts (0..99).select { |num| num.odd? }

# 7) Print the even numbers from 1 to 99, inclusive. All numbers should be printed on separate lines.
def even_printer
  counter = 2
  while counter < 100
    puts counter
    counter += 2
  end
end

# 8) Write a program that asks the user to enter an integer greater than 0, then asks if the user wants to determine the sum or product of all numbers between 1 and the entered integer.
=begin
>> Please enter an integer greater than 0:
5
>> Enter 's' to compute the sum, 'p' to compute the product.
s
The sum of the integers between 1 and 5 is 15.
=end

def consec_integers
  integer = nil
  operator = ''
  loop do 
    puts '>> Please enter an integer greater than 0'
    integer = gets.chomp.to_i
    if integer > 0
      break
    else 
      puts 'That\'s not a valid input, please try again!'
    end
  end

  loop do
    puts '>> Enter \'s\' to compute the sum, \'p\' to compute the product.'
    operator = gets.chomp
    if ['s', 'p'].include?(operator)      
      break
    else
      puts 'That\'s not a valid input, please try again!'
    end
  end
  
  output = operator == 's' ? (1..integer).reduce(:+) : (1..integer).reduce(:*)
  operator_long = operator == 's' ? 'sum' : 'product'
  puts "The #{operator_long} of the integers between 1 and #{integer} is #{output}."
end

# 9) What does this print out? Can you explain these results?
name = 'Bob'
save_name = name
name.upcase!
puts name, save_name

puts 'This will print BOB twice. This is because variables are pointers to objects, and both save_name and name are pointing to the same object. Since the upcase method called here is destructive, it will modify the object (the string Bob) that both name and save_name are pointing to.'

# 10) What will the following code print, and why? Don't run the code until you have tried to answer.
array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
puts array2

puts 'array2 will contain a duplicate of array1 after upcase methods are applied. When the elements of array1 are being pushed to array2, this is mutating array2, but also creating references to the objects in array1. Therefore, any mutations to elements in array1 are spread to array2. 