# Block method - .collect maps over an array without mutating it's contents
fibs = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
doubled_fibs = fibs.collect { |nums| nums * 2 }

puts fibs
puts doubled_fibs

# The yield keyword transfers control from the method to a block, and then returns it to the method
def block_test
  puts "We're in the method!"
  puts "Yielding to the block..."
  yield
  puts "We're back in the method!"
end

block_test { puts ">>> We're in the block!" }

# We can also use parameters with the yield keyword
def yield_name(name)
  puts "In the method! Let's yield."
  yield("Kim")
  puts "In between the yields!"
  yield(name)
  puts "Block complete! Back in the method."
end

yield_name("Eric") { |n| puts "My name is #{n}." }

# Procs - Procs allow us to "save" blocks to variables and use them
cube = Proc.new { |x| x ** 3 }
puts [1, 2, 3].collect!(&cube)

# Calling procs directly using .call
hi = Proc.new { "Hello!" }
puts hi.call

# Passing a proc to a method
numbers_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

strings_array = numbers_array.collect(&:to_s)
puts strings_array

# Lambdas
def lambda_demo(a_lambda)
  puts "I'm the method!"
  a_lambda.call
end

lambda_demo(lambda { puts "I'm the lambda!" })

# Passing a lambda to a method
my_array = ["raindrops", :kettles, "whiskers", :mittens, :packages]

symbol_filter = lambda { |param| param.is_a? Symbol }

symbols = my_array.select(&symbol_filter)

puts symbols
