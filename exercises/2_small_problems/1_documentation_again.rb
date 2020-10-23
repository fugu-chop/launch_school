# 1) Locate the ruby documentation for methods File::path and File#path. How are they different?
puts "File::path is a class method, while File#path is an instance method. Class methods are called on the class, while instance methods are called on objects. 

puts File.path('bin') -> calls the class method File::path since we're calling it on the File class.

f = File.new('my-file.txt')
puts f.path -> calls the instance method File#path since we're calling it on an object of the File class, namely f."

# 2) Assume you have the following code. What will each of the 4 puts statements print?
require 'date'

puts Date.new
puts Date.new(2016)
puts Date.new(2016, 5)
puts Date.new(2016, 5, 13)

puts "The first statement will print '2020-10-23'.
The second statement will print '2016-01-01'.
The third statement will print '2016-05-01'.
The fourth statement will print '2016-05-13'."

# 3) Consider the following method and a call to that method. Use the ruby documentation to determine what this code will print.
def my_method(a, b = 2, c = 3, d)
  p [a, b, c, d]
end

my_method(4, 5, 6)

puts "This will print [4, 5, 3, 6]. Per the 'calling methods' documentation page, Ruby fills in the missing arguments from left to right, and also allows default values to appear in the middle of positional arguments. 

Positional arguments are filled out first, then the default arguments are set with any values supplied, and, finally, default values are applied to anything remaining."

# 4) The Array#bsearch method is used to search ordered Arrays more quickly than #find and #select can. Assume you have the following code. How would you search this Array to find the first element whose value exceeds 8?
a = [1, 4, 8, 11, 15, 19]

a.bsearch { |num| num > 8 }

# 5) What do each of these puts statements output?
a = %w(a b c d e)
puts a.fetch(7)
puts a.fetch(7, 'beats me')
puts a.fetch(7) { |index| index**2 }

puts "The first statement will throw an IndexError exception.
The second statement will print 'beats me' as the default statement when the index provided does not exist.
The third statement will print 49, since the index provided does not exist in the array, it will use the number provided as an input to the block."

# 6) What does this code print?
5.step(to: 10, by: 3) { |value| puts value }

puts "This should print 5, 8. The step method can be found under the Numeric class."

# 6) You should find that the following code prints a list of all of the public methods available to the String s; How would you modify this code to print just the public methods that are defined or overridden by the String class? That is, the list should exclude all members that are only defined in Object, BasicObject, and Kernel.
s = 'abc'
puts s.public_methods.inspect

puts s.public_methods(false).inspect

# 7) Find the documentation for the #min method and change the above code to print the two smallest values in the Array.
a = [5, 9, 3, 11]
puts a.min

puts a.min(2)

# 8) Find the documentation for YAML::load_file
puts "The YAML::load_file documentation can be found here: https://ruby-doc.org/stdlib-2.6.3/libdoc/psych/rdoc/Psych.html#method-c-load_file"
