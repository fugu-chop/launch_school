# Note we don't have to master any of the below the content for the purposes of an assessment. 

=begin
Thus far, we've been using methods like each and map, which are internal iterators - the process and implementation of that iteration is hidden from us, and the process that allows us to progress through a collection is part of that hidden implementation.

There's also "External Iteration". This is iteration that takes place at the behest of the user. Ruby gives us the option to use this type of iteration with the Enumerator class.
=end

# 1) Your task is to create a new Enumerator object. When creating a new Enumerator, you may define what values are iterated upon. We'll want to create an Enumerator that can iterate over an infinite list of factorials. Once you make this new Enumerator, test it out by printing out the first 7 factorial values, starting with zero factorial.

# More specifically, print the first 7 factorials by using an "External Iterator". Once you have done so, see what happens if you print 3 more factorials (the results won't be correct). Now, reset your Enumerator (use the rewind method). Finally, print 7 more factorials.

# Iteration is defined by the given block, in which a “yielder” object, given as block parameter, can be used to yield a value by calling the yield method (can be aliased as <<)
factorial = Enumerator.new do |yielder|
  # Our method doesn't need to take an explicit parameter - it just runs a specified number of times
  accumulator = 1
  number = 0
  # We don't have an explicit break condition as the user controls how many times the method iterates
  loop do
    number == 0 ? accumulator = 1 : accumulator *= number
    # This is actually what the Enumerator returns (i.e. when #next is called)
    yielder << accumulator
    number += 1
  end
end

# We're not passing any arguments to the Enumerator object - we just run the Enumerator object 6 times
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="
# The state of the Enumerator object is preserved between runs (i.e. accumulator and number remain the same)
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="
# The Enumerator#rewind method resets the Enumerator (i.e. all local variables are reset)
factorial.rewind
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="

# Internal iterator - the iteration is handled by the each_with_index method, which doesn't have a natural break point - we need to explicitly specify it
factorial.each_with_index do |value, number|
  puts "#{number}! == #{value}"
  break if number >= 5
end

# 2) Run the code below, and find the differences:
# Group 1
=begin
A new Proc object can be created with a call of proc instead of Proc.new, and is an object of the Proc class. A Proc object does not require that the correct number of arguments are passed to it. If nothing is passed, then nil is assigned to the block variable. 
=end
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
=begin
Lambdas objects are an instance of the Proc class. 
We can instantiate a lambda object using lambda or ->, but not Lambda.new (it's not a class itself)
While a Lambda is a Proc, it maintains a separate identity from a plain Proc. This can be seen when displaying a Lambda object: the string displayed contains an extra "(lambda)" that is not present for regular Procs. 
Lambdas have strict arity rules.
=end
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

# Group 3
=begin 
This is a method that takes a block, but must have it provided since we didn't call block_given?
A block passed to a method does not require the correct number of arguments. If a block variable is defined, and no value is passed to it, then nil will be assigned to that block variable. 
=end
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')

# Group 4
=begin
Once provided, blocks have lenient arity rules with respect of the number of arguments provided, but still require an argument to be provided in the first place if we want to reference something passed from the method
Blocks will throw an error if a variable is referenced that doesn't exist in the block's scope.
=end
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}
