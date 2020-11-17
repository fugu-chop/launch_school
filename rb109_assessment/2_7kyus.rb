# 1) A number is called Automorphic number if and only if its square ends in the same digits as the number itself. Given a number determine if it Automorphic or not.
def automorphic(number)
  number.to_s == (number ** 2).to_s[-(number.to_s.length)..-1] ? 'Automorphic' : 'Not!!'
end

# 2) An element is leader if it is greater than The Sum all the elements to its right side. Given an array/list [] of integers , Find all the LEADERS in the array.
=begin
# 4 is greater than the sum all the elements to its right side. The last element 0 is equal to the sum of its right elements (abstract zero). 
arrayLeaders ([1, 2, 3, 4, 0]) ==> 4

# 5 and 17 are greater than the sum all the elements to its right side. The last element 2 is greater than the sum of its right elements (abstract zero). 
arrayLeaders ([16, 17, 4, 3, 5, 2]) ==> [17, 5, 2]

# The last element -1 is less than the sum of its right elements (abstract zero).
arrayLeaders ([5, 2, -1]) ==> [5, 2]

# The last element 2 is greater than the sum of its right elements (abstract zero). 
arrayLeaders ([0, -1, -29, 3, 2]) ==> [0, -1, 3, 2]
=end
def array_leaders(array)
  leader_array = []
  cum_sum = array[-1]
  leader_array << array[-1] if array[-1] > 0
  counter = array.length - 2
  while counter > -1
    leader_array.insert(0, array[counter]) if array[counter] > cum_sum
    cum_sum += array[counter]
    counter -= 1
  end
  leader_array
end

# Suggested solution
def array_leaders(numbers)
  numbers.select.with_index { |number, index| number > numbers[index + 1..-1].sum }
end

# 3) Write a function doubles that will remove double string characters that are adjacent to each other. The strings will contain lowercase letters only.
=begin
doubles('abbcccdddda') == 'aca'
a) There is only one 'a' on the left hand side, so it stays.
b) The 2 b's disappear because we are removing double characters that are adjacent. 
c) Of the 3 c's, we remove two. We are only removing doubles. 
d) The 4 d's all disappear, because we first remove the first double, and again we remove the second double.
e) There is only one 'a' at the end, so it stays.

doubles('abbbzz') == 'ab'

doubles('abba') == ""
When we remove the b's in 'abba', the double a that results is then removed.
=end
def doubles(string)
  new_string = 'abbcccdddda'.chars

  # Some looping will be required - break condition is when mutated new_string == mutated new_string.uniq
  # The count approach won't work, since key value pairs won't care about the order of the letters in the string
  # We need to iterate through the string_array instead, comparing the current character with the previous one. This should handle odd numbers of characters
  # If it's equal, append that letter to a chars_to_delete array
  # Take the uniq of this array, then delete 2 * chars from the new_string

end