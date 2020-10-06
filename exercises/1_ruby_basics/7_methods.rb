# 1) Write a method named print_me that prints "I'm printing within the method!" when invoked.
def print_me
  puts "I'm printing within the method!"
end

print_me

# 2) #Write a method named print_me that returns "I'm printing the return value!" when using the following code.
def print_me
  "I'm printing the return value!"
end

puts print_me

# 3) Write two methods, one that returns the string "Hello" and one that returns the string "World". Then print both strings using #puts, combining them into one sentence.
def hello
  "Hello"
end

def world
  "World"
end

puts "#{hello} #{world}"

# 4) Write a method named greet that invokes the following methods:
def hello
  "Hello"
end

def world
  "World"
end

def greet
  hello + " " + world
end

puts greet

# 5) Write a method called car that takes two arguments and prints a string containing the values of both arguments.
def car(model, make)
  puts "#{model} #{make}"
end

# 6) Write a method named time_of_day that, given a boolean as an argument, prints "It's daytime!" if the boolean is true and "It's nighttime!" if it's false. Pass daylight into the method as the argument to determine whether it's day or night.
daylight = [true, false].sample

def time_of_day(daylight)
  if daylight
    puts "It's daytime" 
  else 
    puts "It's nighttime!"
  end
end

# 7) Fix the following code:
=begin
def dog
  return name
end

def cat(name)
  return name
end

puts "The dog's name is #{dog('Spot')}."
puts "The cat's name is #{cat}."
=end
def dog(name)
  return name
end

def cat(name)
  return name
end

puts "The dog's name is #{dog('Spot')}."
puts "The cat's name is #{cat('Ginger')}."

# 8) Write a method that accepts one argument, but doesn't require it. The parameter should default to the string "Bob" if no argument is given. The method's return value should be the value of the argument.
def caller(name = 'Bob')
  name
end

puts caller == 'Bob'
puts caller("Tim") == 'Tim' 

# 9) Write the following methods so that each output is true
=begin
puts add(2, 2) == 4
puts add(5, 4) == 9
puts multiply(add(2, 2), add(5, 4)) == 36
=end

def add(a, b)
  a.to_i + b.to_i
end

def multiply(a, b)
  a.to_i * b.to_i
end

# 10) The variables below are both assigned to arrays. The first one, names, contains a list of names. The second one, activities, contains a list of activities. Write the methods name and activity so that they each take the appropriate array and return a random value from it. Then write the method sentence that combines both values into a sentence and returns it from the method.

names = ['Dave', 'Sally', 'George', 'Jessica']
activities = ['walking', 'running', 'cycling']

def name(names)
  names[rand(4)]
end

def activity(arr)
  arr[rand(3)]
end

def sentence(name, activity)
  "#{name} went #{activity} today!"
end

puts sentence(name(names), activity(activities))