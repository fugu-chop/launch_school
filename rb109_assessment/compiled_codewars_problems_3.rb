# 51) https://www.codewars.com/kata/550498447451fbbd7600041c
=begin
Problem
Given two arrays a and b write a function comp(a, b) that checks whether the two arrays have the "same" elements, with the same multiplicities. "Same" means, here, that the elements in b are the elements in a squared, regardless of the order.

  Input
    Two arrays of integer objects

  Output
    Boolean

  Rules
    "Same" means, here, that the elements in b are the elements in a squared, regardless of the order.
    a or b might be []
    If a or b are nil (could be nil), the problem doesn't make sense so return false.
    a and b will be the same length

Examples
  comp([121, 144, 19, 161, 19, 144, 19, 11], [11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19]) == true

Data Structures
  Array

Algo
  a as our input array
  b as our 'test' array
  we sort a and b
  Iterate through a, checking if that number squared exists in b at the same index (sorted)
  If this is true for all numbers, return true
  Return false if a or b are nil, or are empty
=end
def comp(a, b)
  return false if b == nil || a == nil
  a = a.sort
  b = b.sort
  a == a.select.with_index do |num, idx|
    num ** 2 == b[idx]
  end
end

# 52) https://www.codewars.com/kata/53a452dd0064085711001205
=begin
Problem 
Your goal is to write the group_and_count method, which should receive an array as unique parameter and return a hash. Empty or nil input must return nil instead of a hash. This hash returned must contain as keys the unique values of the array, and as values the counting of each value.

  Input
    Array (though this could be empty or nil)

  Output
    Hash, with numbers as keys, and counts as values

  Rules
    We cannot use Array#count or Array#length
    Empty or nil input must return nil instead of a hash.

Examples
  group_and_count([0,1,1,0]) == {0=>2, 1=>2}

Data Structures
  Array
  Hash

Algo
  Return false if the input array is nil or empty  
  If not, we want to iterate through our input array
    We set up an empty hash
    If the hash does not include the letter on a given iteration
      Create a key in the hash, and set the value to 1
    Else if the key does exist already, increment the value
  Return the hash
=end
def group_and_count(input)
  return nil if input == nil || input.empty?
  input.each_with_object(Hash.new(0)) do |element, hash|
    hash[element] += 1
  end
end

# 53) https://www.codewars.com/kata/5453dce502949307cf000bff
=begin
Problem
Complete the method that takes a hash of users, and find the nexus: the user whose rank is the closest/is equal to his honor. Return the rank of this user. For each user, the key is the rank and the value is the honor.

If nobody has an exact rank/honor match, return the rank of the user who comes closest. If there are several users who come closest, return the one with the lowest rank (numeric value). The hash will not necessarily contain consecutive rank numbers; return the best match from the ranks provided.

  Input
    Hash, where keys and values are integer objects

  Output
    Integer object

  Rules
    If possible, return the rank (key) of the user where key == value
    Otherwise, return the lowest difference between key and value
      If there are multiple key-value pairs with lowest difference, return the lowest key

Example
users = {1 => 3, 3 => 3, 5 => 1}
nexus(users) == 3

users = {1 => 10, 2 => 6, 3 => 4, 5 => 1}
nexus(users) == 3

Data Structures
  Hash
  Array

Algo
  We're given a hash
  We want to iterate through our hash (key, value)
  Select all the keys where key == value
    return the min key
  
  If that's empty, we want to map through our hash (keys and values)
  we want to take the absolute value of subtracting the key and value, as well as the key
  This will return an array of subarrays
  We want to find the subarray with the smallest difference and return the key (the first element)
=end
def nexus(input)
  equal_arr = input.keys.select do |key|
    key if key == input[key]
  end
  return equal_arr.min if !equal_arr.empty?

  min_diff = input.map do |key, value|
    [key, (key - value).abs]
  end

  min_diff.sort_by do |subarr|
    [subarr.last, subarr.first]
  end.first.first
end
