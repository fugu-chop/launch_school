# 1) How would you order this array of number strings by descending numeric value?
arr = ['10', '11', '9', '7', '8']

arr.sort do |a, b|
  b.to_i <=> a.to_i
end

# 2) How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by do |entry|
  entry[:published].to_i
end

# 3) For each of these collection objects demonstrate how you would reference the letter 'g'?
arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].keys[0]

# 4) For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4.
arr1 = [1, [2, 3], 4]
arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4

# 5) Figure out the total age of just the male members of the family.
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

sum_val = 0
munsters.each_value do |value|
  sum_val += value["age"] if value['gender'] == 'male'
end

sum_val

# 6) Given this previously seen family hash, print out the name, age and gender of each family member, like this: (Name) is a (age)-year-old (male or female).
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  puts "#{key} is a #{value["age"]}-year-old #{value["gender"]}."
end

# 7) Given this code, what would be the final values of a and b? Try to work this out without running the code.
a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

puts "The value of a didn't change because we are not referencing a at any point. 

This code arr[0] += 2 was modifying the array, arr not a. In effect we are assigning a new object at that index of the array so that instead of arr[0] containing a it now contains 4. 

The value of b did change because b is an array and we are modifying that array by assigning a new value at index 0 of that array."

# 8) Using the each method, write some code to output all of the vowels from the strings.
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

VOWELS = %w(a e i o u)
string_vowels = []
hsh.each do |_key, value|
  value.each do |element|
    element.chars.each do |letter|
      string_vowels << letter if VOWELS.include?(letter)
    end
  end
end

puts string_vowels

# 9) Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |sub_arr|
  sub_arr.sort do |a, b|
    b <=> a
  end
end

# 10) Given the following data structure and without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].each_with_object([]) do |element, array|
  array << element.each do |key, value|
    element[key] = value + 1
  end
end

# 11) Given the following data structure use a combination of methods, including either the select or reject method, to return a new array identical in structure to the original but containing only the integers that are multiples of 3.
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr.map do |subarr|
  subarr.select do |element|
    element % 3 == 0
  end
end

# 12) Given the following data structure, and without using the Array#to_h method, write some code that will return a hash where the key is the first item in each sub array and the value is the second item.
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

empty_hash = {}
arr.each do |subarr|
  empty_hash[subarr[0]] = subarr[1]
end

empty_hash

# 13) Given the following data structure, return a new array containing the same sub-arrays as the original but ordered logically by only taking into consideration the odd numbers they contain.
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

arr.sort_by do |subarr|
  subarr.select do |num|
    num.odd?
  end
end

# 14) Given this data structure write some code to return an array containing the colors of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

hsh.map do |key, value|
  if value[:type] == 'fruit'
    value[:colors].map do |color|
      color.to_s.capitalize
    end
  else
    value[:size].to_s.upcase
  end
end

# 15) Given this data structure write some code to return an array which contains only the hashes where all the integers are even.
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

arr.select do |element|
  element.all? do |_key, value|
    value.all? do |num|
      num.even?
    end
  end
end

puts "If all of the integers in an inner array are even, then the inner block returns true to the innermost call to all?. 

If all of the inner blocks for a particular hash return true then the middle block returns true to the outer call to all? which in turn causes the outer block to return true to the select method for that iteration."

# 16) Write a method that returns one UUID when called with no parameters. Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string. It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

def generate_uuid
  eligible_chars = []
  (0..9).each { |num| eligible_chars << num.to_s }
  ('a'..'z').each { |letter| eligible_chars << letter.to_s }
  
  uuid = ''
  8.times { uuid << eligible_chars.sample } 
  uuid << '-'
  4.times { uuid << eligible_chars.sample }
  uuid << '-'
  4.times { uuid << eligible_chars.sample }
  uuid << '-'
  12.times { uuid << eligible_chars.sample }  
  uuid
end

=begin
def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end  
=end