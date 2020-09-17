# 1) Write a program that prints a greeting message. This program should contain a method called greeting that takes a name as its parameter and returns a string.
def greeting(name)
  puts "Greetings, #{name}!"
end

# 2) What do the following expressions evaluate to?
# x = 2
puts "This should return to 2"
# puts x = 2
puts "This should print 2, but return nil"

# p name = "Joe"
puts "This should print and return \"Joe\""

# four = "four"
puts "This should return \n"four\n""

# print something = "nothing"
puts "This should print \n"nothing\n", but return nil"

#3) Write a program that includes a method called multiply that takes two arguments and returns the product of the two numbers.
def multiple(num1, num2)
  num1 * num2
end

# 4) What will the following code print to the screen?
=begin
def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee") 
=end
puts "The scream function won't return anything, since the puts statement is not executed, and the words variable is not returned"

# 5) Edit the method definition in exercise #4 so that it does print words on the screen.
def scream(words)
  words = words + "!!!!"
  puts words
end

scream("Yippeee") 

# 6) What does the above function return now?
puts "The scream function returns nil, because there is a puts statement as the last line of the expression in the method"

# 7) What does the following error tell you? 
# ArgumentError: wrong number of arguments (1 for 2) in `calculate_product'
puts "The ArgumentError is indicating we have only put a single argument into the calculate_product method, where it expects 2"