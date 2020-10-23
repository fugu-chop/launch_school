# 1) Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.
=begin
repeat('Hello', 3)

Hello
Hello
Hello
=end

def repeat(str, times)
  times.times { puts str }
end

# 2) Write a method that takes one integer argument, which may be positive, negative, or zero. This method returns true if the number's absolute value is odd. You may assume that the argument is a valid integer value.
=begin
puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true
=end

def is_odd?(num)
  num.abs % 2 == 1
end

# 3) Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.
=begin
puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true
=end

def digit_list(num)
  num.to_s.split('').map { |num| num.to_i }
end

# We could also shorten this to:
def digit_list(number)
  number.to_s.chars.map(&:to_i)
end