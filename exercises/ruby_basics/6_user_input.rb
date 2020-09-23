# 1) Write a program that asks the user to type something in, after which your program should simply display what was entered.
def repeat()
  puts "Type something in!"
  answer = gets.chomp
  puts answer
end

# 2) Write a program that asks the user for their age in years, and then converts that age to months.
def ask_age
  puts "Enter your age please!"
  age = gets.chomp.to_i
  puts "Your age is #{age * 12} months!"
end

# 3) Write a program that asks the user whether they want the program to print "something", then print it if the user enters y. Otherwise, print nothing.
def something
  puts "Do you want to print something? Enter y if so!"
  answer = gets.chomp.downcase
  puts "something" if answer == 'y'
end

# 4) Modify your above program so it prints an error message for any inputs that aren't y or n, and then asks you to try again. Keep asking for a response until you receive a valid y or n response. In addition, your program should allow both Y and N (uppercase) responses.
loop do
  puts "Do you want to print something?"
  answer = gets.chomp.downcase
  if answer == 'y' 
    puts "something"
    break  
  elsif answer == 'n'
    break
  else
    puts "I don't recognise that response. Please try again."
  end
end

# 5) Write a program that prints 'Launch School is the best!' repeatedly until a certain number of lines have been printed. The program should obtain the number of lines from the user, and should insist that at least 3 lines are printed.

answer = nil
loop do
  puts "Please enter a number of lines to repeat!"
  answer = gets.chomp.to_i
  break if answer >= 3
  puts "That's not enough repetition, please try again!"
end

answer.times { puts "Launch School is the best!" }

# 6) Write a program that displays a welcome message, but only after the user enters the correct password, where the password is a string that is defined as a constant in your program. 
PASSWORD = "bingobango"

loop do
  puts "Please enter your password: "
  pw = gets.chomp
  if PASSWORD == pw
    puts "Welcome home"
    break
  else 
    puts "That's not correct. Please try again"
  end
end

# 7) In this exercise, you should modify the program so it also requires a user name. The program should solicit both the user name and the password, then validate both, and issue a generic error message if one or both are incorrect; the error message should not tell the user which item is incorrect.
USERNAME = 'whingy'
PASSWORD = 'puppingy'

loop do
  puts "Please enter your username"
  un = gets.chomp
  puts "Please enter your password"
  pw = gets.chomp
  if un == USERNAME && pw = pw
    puts "Welcome back my friend!"
    break
  else 
    puts "One or more of your details were incorrect. Please try again."
  end
end

# 8) Write a program that obtains two Integers from the user, then prints the results of dividing the first by the second. The second number must not be 0, and both numbers should be validated using this method
def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end

loop do
  puts "Please enter a number"
  num1 = gets.chomp
  puts "Please enter another number"
  num2 = gets.chomp
  if num2.to_i == 0
    puts "You can't divide by zero, friend."
  elsif valid_number?(num1) && valid_number?(num2)
    puts "#{num1.to_i} divided by #{num2.to_i} is equal to #{num1.to_f / num2.to_i}"
    break
  else 
    puts "You haven't entered valid numbers. Please try again"
  end
end

# 9) Modify this program in Exercise 5 so it repeats itself after each input/print iteration, asking for a new number each time through. The program should keep running until the user enters q or Q.
answer = nil
loop do
  puts "Please enter a number of lines to repeat! Or press Q to exit"
  answer = gets.chomp
  break if answer.downcase == 'q'
  if answer.to_i < 3
    puts "That's not enough repetition, please try again!"
  else 
    answer.to_i.times { puts "Launch School is the best!" }
  end
end

# 10) Write a program that requests two integers from the user, adds them together, and then displays the result. Furthermore, insist that one of the integers be positive, and one negative; however, the order in which the two integers are entered does not matter. Do not check for the positive/negative requirement until both integers are entered, and start over if the requirement is not met.
loop do
  puts "Please enter a number: "
  num1 = gets.chomp.to_i
  puts "Please enter another number: "
  num2 = gets.chomp.to_i
  break puts "The sum of #{num1} and #{num2} is #{num1 + num2}" if num1 * num2 < 0
  puts "One of your numbers must be positive, and the other negative"
end