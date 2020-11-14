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
  # Track:
    # Which iteration of the loop we are on 
    # index of switches on

  # Logic
    # At the start, everything is off
    # Round 1 you turn everything on (we could presumably skip this step - set everything to 1, and subtract one from the switches number to remove edge case logic)
    # Round two, you start at index 1, only turn on every second light
    # Round 3, you start at index 2, turn on every second light

  # Data structures
    # Create an array on/off states (could be 0/1, could be even/odd)
    # Iterate through the on/off states n times, where n = switches
    # On each iteration, you start at a different index of the array
    # Increment index += 1 on each pass
    # At each index, turn that light, 
  
  switches = 5

  switchboard = Array.new(switches, 1)
  even_indices = []
  odd_indices = []
  light_indices = []

  switchboard.each_with_index do |num, index| 
    if index.even?
      even_indices << index
    else
      odd_indices << index
    end
  end

  # this goes through each switch and returns the index. 
  # It skips the first one because you never go back to the first switch after turning it on
  1.upto(switches - 1) do |index1|
    
  end

  # Return:
    # Which switches are on, in an array, 
    
end
