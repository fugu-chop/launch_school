# Control flow - basic if statement with branching logic
if false 
  puts "This is a false statement."
elsif true
  puts "This is a true statement"
else
  puts "You have broken the universe"
end

# Unless keyword checks if a variable is false.
hungry = false

unless hungry
  puts "I'm writing Ruby programs!"
else
  puts "Time to eat!"
end

# Comparison operators. These return booleans.
is_true = 2 == 3
puts is_true

is_false = 2 != 3
puts is_false

# && Operator - this will return true only if both sides are true.
boolean_a = 77 < 78 && 77 < 77
puts boolean_a

boolean_b = true && 100 >= 100
puts boolean_b

boolean_c = 2**3 == 8 && 3**2 == 9
puts boolean_c

## || Operator - this will return true if either side is true, or both sides are true
boolean_1 = 2**3 != 3**2 || true
puts boolean_1

boolean_2 = false || -10 > -9
puts boolean_2

boolean_3 = false || false
puts boolean_3

# ! operator
boolean_x = !true
puts boolean_x

boolean_y = !true && !true
# This evaluates to false
puts boolean_y

boolean_z = !(700 / 10 == 70)
puts boolean_z