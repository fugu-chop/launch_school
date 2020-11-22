# 1) Given a string, return the minimal number of parenthesis reversals needed to make balanced parenthesis. 
=begin
solve(")(") = 2 Because we need to reverse ")" to "(" and "(" to ")". These are 2 reversals. 
solve("(((())") = 1 We need to reverse just one "(" parenthesis to make it balanced.
solve("(((") = -1 Not possible to form balanced parenthesis. Return -1.


solve(")()(") == 2
solve("((()") == 1
solve("(((") == -1
solve("())(((") == 3
solve("())()))))()()(") == 4
=end
def solve(str)
  return -1 if str.length.odd?
  o, c, t = [0, 0, 0]
  
  str.each_char do |p|
    if p == '('
      o += 1
    else
      c += 1
      # If the total number of closing > opening, we add one to t, which is the total number of changes
      # I don't understand why we are modifying o or c in the loop. It must be something to do with the position of the parentheses?
      if c > o
        o += 1
        c -= 1
        t += 1
      end
    end
  end

  # Why do we not do anything if c > o?
  if o > c
    t += (o - c) / 2
  end
  t
end

# 2) Sort elements in an array by decreasing frequency of elements. If two elements have the same frequency, sort them by increasing value. 
=begin
solve([2,3,5,3,7,9,5,3,7]) == [3,3,3,5,5,7,7,2,9]
solve([1,2,3,0,5,0,1,6,8,8,6,9,1]) == [1,1,1,0,0,6,6,8,8,2,3,5,9])
solve([5,9,6,9,6,5,9,9,4,4]) == [9,9,9,9,4,4,5,5,6,6])
solve([4,4,2,5,1,1,3,3,2,8]) == [1,1,2,2,3,3,4,4,5,8])
solve([4,9,5,0,7,3,8,4,9,0]) == [0,0,4,4,9,9,3,5,7,8])
=end
def solve(array)
  hash_count = Hash.new(0)

  array.each do |number|
    if hash_count.keys.include?(number)
      hash_count[number] += 1
    else
      hash_count[number] = 1
    end
  end

  hash_count = hash_count.sort_by do |key, value|
    [value, key]
  end.reverse

  hash_count_sort = hash_count.sort do |a, b|
    [b[1], a[0]] <=> [a[1], b[0]]
  end

  final_arr = []
  hash_count_sort.each do |pair|
    pair[1].times do |_|
      final_arr << pair[0]
    end
  end

  final_arr
end

# Suggested solution lmao
def solve(arr)
  # The negative sign allows you to reverse!
  arr.sort_by { |element| [-arr.count(element), element] }
end

# 3) Assume "#" is like a backspace in string. This means that string "a#bc#d" actually is "bd". Your task is to process a string with "#" symbols.
=begin
clean_string('abc#d##c') == "ac"
clean_string('abc####d##c#') == "" 
clean_string("#######") == ""
clean_string("") == ""
=end
def clean_string(string)
  keep_letters = []
  string.each_char do |char|
    char == '#' ? keep_letters.pop : keep_letters << char
  end
  keep_letters.join
end

# Using each_with_object
def clean_string(str)
  str.chars.each_with_object([]) { |ch, o| ch == "#" ? o.pop : o << ch }.join
end

# 4) Define a function that takes one integer argument and returns logical value true or false depending on if the integer is a prime. Per Wikipedia, a prime number (or a prime) is a natural number greater than 1 that has no positive divisors other than 1 and itself. You can assume you will be given an integer input.You can not assume that the integer will be only positive. You may be given negative numbers as well (or 0).
=begin
is_prime(1) == false
is_prime(2) == true
is_prime(-1) == false
=end
# This works, but times out on Codewars' weaksauce computers
def is_prime?(integer)
  return false if integer <= 1
  (2..integer).each_with_object([]) do |num, arr|
    arr << num if integer % num == 0
    return false if arr.length > 1
  end.length == 1
end

# Optimised solution
def is_prime?(num)
  # I am not sure how 'clean' this solution is, tbh. Not every integer will have a clean square root...
  num < 2 ? false : (2..Math.sqrt(num)).none?{ |i| num % i == 0 }
end

# 5) You will create the classic Pascal's triangle. Your function will be passed the depth of the triangle and you code has to return the corresponding pascal triangle up to that depth. The triangle should be returned as a nested array.
=begin
pascal(5) # should return [[1], [1,1], [1,2,1], [1,3,3,1], [1,4,6,4,1]]
=end
def pascal(rows)
  push_array = [[1]]
  counter = 1
  loop do
    break if counter >= rows
    new_arr = []
    push_array.last.each_cons(2) { |a, b| new_arr << [a, b].reduce(:+) }
    new_arr.insert(0, 1)
    new_arr.insert(-1, 1)
    push_array << new_arr
    counter +=1
  end
  push_array
end

# 6) Your task, is to create NxN multiplication table, of size provided in parameter. 
=begin
multiplication_table(3) == [[1,2,3],[2,4,6],[3,6,9]]

1 2 3
2 4 6
3 6 9

1 2 3 4
2 4 6 8
3 6 9 12
4 8 12 16
=end
def multiplication_table(size)
  # size defines how many subarrays within our array
  # The first element of the each subarray increments by 1
  # The second element increments by 2
  # The third element increments by 3
  # And so on...

  # Create a blank array for us to push our sub arrays into (push_array)
  # Create a looping construct
  # Break our loop when push_array.length == size (put at start of loop)
    # When we create our first element, we can use (1..size).to_a
    # Push this to our push_array
    # Create a blank array []
    # we want to take the last element of our push_array (potentially use each_with_object), with index
      # [1,2,3]
      # [] << element + index + 1
    # Push the blank array to our push_array
  # Return the push_array
end
