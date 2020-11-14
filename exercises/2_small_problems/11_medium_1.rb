# 1) Write a method that rotates an array by moving the first element to the end of the array. The original array should not be modified. Do not use the method Array#rotate or Array#rotate! for your implementation.
=begin
rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true
=end
def rotate_array(array)
  new_array = array.map { |element| element }
  first_char = new_array.shift
  new_array << first_char
  new_array
end

# Alternate method
def rotate_array(array)
  array[1..-1] + [array[0]]
end

# 2) Write a method that can rotate the last n digits of a number. You may assume that n is always a positive integer. Note that rotating just 1 digit results in the original number being returned.
=begin
rotate_rightmost_digits(735291, 1) == 735291
rotate_rightmost_digits(735291, 2) == 735219
rotate_rightmost_digits(735291, 3) == 735912
rotate_rightmost_digits(735291, 4) == 732915
rotate_rightmost_digits(735291, 5) == 752913
rotate_rightmost_digits(735291, 6) == 352917
=end
def rotate_rightmost_digits(number, digits)
  num_array = number.to_s.chars
  spin_digit = num_array.delete(num_array[-digits])
  num_array << spin_digit
  num_array.join.to_i
end

# 3) If you take a number like 735291, and rotate it to the right, you get 352917. If you now keep the first digit fixed in place, and rotate the remaining digits, you get 329175. Keep the first 2 digits fixed in place and rotate again to 321759. Keep the first 3 digits fixed in place and rotate again to get 321597. Finally, keep the first 4 digits fixed in place and rotate the final 2 digits to get 321579. The resulting number is called the maximum rotation of the original number. Write a method that takes an integer as argument, and returns the maximum rotation of that argument. Note that you do not have to handle multiple 0s.
=begin
max_rotation(735291) == 321579
max_rotation(3) == 3
max_rotation(35) == 53
max_rotation(105) == 15 # the leading zero gets dropped
max_rotation(8_703_529_146) == 7_321_609_845
=end
def max_rotation(number)
  num_array = number.to_s.chars
  index = 0

  while index < num_array.length - 1
    spin_digit = num_array.delete(num_array[index])
    num_array << spin_digit
    index += 1
  end

  num_array.join.to_i
end

# 4) You have a bank of switches before you, numbered from 1 to n. Each switch is connected to exactly one light that is initially off. You walk down the row of switches and toggle every one of them. You go back to the beginning, and on this second pass, you toggle switches 2, 4, 6, and so on. On the third pass, you go back again to the beginning and toggle switches 3, 6, 9, and so on. You repeat this process and keep going until you have been through n repetitions. Write a method that takes one argument, the total number of switches, and returns an Array that identifies which lights are on after n repetitions.
=begin
Example with n = 5 lights:

round 1: every light is turned on
round 2: lights 2 and 4 are now off; 1, 3, 5 are on
round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
round 5: lights 2, 3, and 5 are now off; 1 and 4 are on

The result is that 2 lights are left on, lights 1 and 4. The return value is [1, 4].

With 10 lights, 3 lights are left on: lights 1, 4, and 9. The return value is [1, 4, 9].
=end
def lights(switches)
  switchboard = Array.new(switches, 1)
  light_indices = []
  lights_on = []
  first_switch_change = 2

  first_switch_change.upto(switches) do |switch|
    light_indices = (switch..switches).to_a.select { |element| element % switch == 0 }.map { |number| number - 1 }
    light_indices.each do |index|
      switchboard[index] += 1
    end
  end

  switchboard.each_with_index do |light, index|
    lights_on << index + 1 if light.odd?
  end

  lights_on
end

# 5) Write a method that displays a 4-pointed diamond in an n x n grid, where n is an odd integer that is supplied as an argument to the method. You may assume that the argument will always be an odd integer.
=begin
diamond(1)

*

diamond(3)

 *
***
 *

 diamond(9)

    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
=end
def diamond(integer)
  spaces = integer / 2
  stars = 1
  loop do 
    puts ' ' * spaces + '*' * stars 
    spaces -= 1
    stars += 2
    break if stars > integer
  end

  spaces = 1
  stars = integer - 2
  loop do 
    puts ' ' * spaces + '*' * stars
    spaces += 1
    stars -= 2
    break if stars < 1
  end
end

# 5b) Try modifying your solution or our solution so it prints only the outline of the diamond
=begin
diamond_outline(5)

  *
 * *
*   *
 * *
  *
=end

def diamond_outline(integer)
  # Assume integer is odd again
  # The spaces logic is still the same - i.e. floor of integer / 2, decremented by 
  # The stars logic - we could just print out the same string, but replace everything except index 0 and -1 with spaces?
end