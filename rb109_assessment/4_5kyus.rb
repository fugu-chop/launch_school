# 1) Move the first letter of each word to the end of it, then add "ay" to the end of the word. Leave punctuation marks untouched.
=begin
pig_it('Pig latin is cool') == 'igPay atinlay siay oolcay'
pig_it('This is my string') == 'hisTay siay ymay tringsay'
=end
def pig_it(sentence)
  sentence.split.map do |word|
    word_var = word.chars
    if !('a'..'z').include?(word_var.first.downcase)
      word_var
    else
      first = word_var.shift
      word_var << first << 'ay'
      word_var.join
    end
  end.join(' ')
end

# 2) Write a function called that takes a string of parentheses, and determines if the order of the parentheses is valid. The function should return true if the string is valid, and false if it's invalid. Along with opening (() and closing ()) parenthesis, input may contain any valid ASCII characters. Furthermore, the input string may be empty and/or not contain any parentheses at all. Do not treat other forms of brackets as parentheses (e.g. [], {}, <>).
=begin
valid_parentheses("  (") == false
valid_parentheses(")test") == false
valid_parentheses("") == true
valid_parentheses("hi())(") == false
valid_parentheses("hi(hi)()") == true
valid_parentheses("((())()())")
=end

def valid_parentheses(string)
  return false if (string.count(')') != string.count('('))
  parentheses_arr = []
  string.each_char do |char|
    if char == '('
      parentheses_arr << char
    elsif char == ')'
      parentheses_arr.last == '(' ? parentheses_arr.pop : parentheses_arr << char
    end
  end
  parentheses_arr.empty?
end

# This is smart
def valid_parentheses(string)
  open = 0
  string.chars.each do |c|
    open += 1 if c == "("
    open -= 1 if c == ")"
    return false if open < 0
  end
  open == 0
end

# 3) Write a function that will find all the anagrams of a word from a list. You will be given two inputs a word and an array with words. You should return an array of all the anagrams or an empty array if there are none. 
=begin
anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']
anagrams('laser', ['lazing', 'lazy',  'lacer']) == []
=end
def anagrams(search_string, search_words)
  search_words.select do |word|
    word if word.chars.sort == search_string.chars.sort
  end
end

# 4) I can't be bothered writing this. See this: https://www.codewars.com/kata/550f22f4d758534c1100025a
=begin
dirReduc(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]) == ["WEST"]
dirReduc(["NORTH", "WEST", "SOUTH", "EAST"]) == ["NORTH", "WEST", "SOUTH", "EAST"]
=end
def dirReduc(directions)
  opposites = {
  "NORTH" => "SOUTH",
  "SOUTH" => "NORTH",
  "EAST"  => "WEST",
  "WEST"  => "EAST"
}

  reduced_directions = []
  directions.each do |direction|
      reduced_directions.last == opposites[direction] ? reduced_directions.pop : reduced_directions << direction
  end
  reduced_directions
end

# 4) ROT13 is a simple letter substitution cipher that replaces a letter with the letter 13 letters after it in the alphabet. ROT13 is an example of the Caesar cipher. Create a function that takes a string and returns the string ciphered with Rot13. If there are numbers or special characters included in the string, they should be returned as they are. Only letters from the latin/english alphabet should be shifted.
=begin
rot13("test") == "grfg"
rot13("Test") == "Grfg"
=end
def rot13(string)
  origin = ('a'..'z').to_a.join + ('A'..'Z').to_a.join
  cipher = ('a'..'z').to_a.rotate(13).join + ('A'..'Z').to_a.rotate(13).join
  string.tr(origin, cipher)
end

# 5) The maximum sum subarray problem consists in finding the maximum sum of a contiguous subsequence in an array or list of integers. Easy case is when the list is made up of only positive numbers and the maximum sum is the sum of the whole array. If the list is made up of only negative numbers, return 0 instead. Empty list is considered to have zero greatest sum. Note that the empty list or array is also a valid sublist/subarray.
=begin
max_sequence([]) == 0
max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
max_sequence([11]) == 11
max_sequence([-32]) == 0
max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12
=end
def max_sequence(array)
  return 0 if array.length == 0 || array.all? { |num| num < 0 }
  combos = []

  array.each_with_index do |_, start_idx|
    array.each_with_index do |_, end_idx|
      combos << array[start_idx..end_idx] if start_idx <= end_idx
    end
  end
  
  combos.map do |subarr|
    subarr.reduce(:+)
  end.max  
end

# 6) Generate a function that calculates whether the input number can be obtained by multiplying two consecutive Fibonacci numbers. It should return the two Fibonacci numbers, and a boolean (depending on whether the numbers are consecutive), in an array. If you can't multiply consecutive Fibonacci numbers to get to the input number, return the two closest consecutive Fibonacci numbers.
=begin
productFib(714) # should return [21, 34, true], since F(8) = 21, F(9) = 34 and 714 = 21 * 34
productFib(800) # should return [34, 55, false], since F(8) = 21, F(9) = 34, F(10) = 55 and 21 * 34 < 800 < 34 * 55

productFib(4895) == [55, 89, true]
productFib(5895) == [89, 144, false]
=end
def fibonacci(number)
  latest_val = 0
  fibos = [0, 1]
  until fibos.length > number
    latest_val = fibos[-2] + fibos.last
    fibos << latest_val
  end
  fibos.last
end

def productFib(num)
  series_counter = 0
  loop do 
    if fibonacci(series_counter) * fibonacci(series_counter + 1) > num
      return [fibonacci(series_counter), fibonacci(series_counter + 1), false]
    elsif fibonacci(series_counter) * fibonacci(series_counter + 1) == num
      return [fibonacci(series_counter), fibonacci(series_counter + 1), true]
    else
      series_counter += 1
    end
  end
end

# 7) One of those long-ass descriptions: https://www.codewars.com/kata/55c6126177c9441a570000cc
=begin
order_weight("103 123 4444 99 2000") == "2000 103 123 4444 99"
order_weight("2000 10003 1234000 44444444 9999 11 11 22 123") == "11 11 2000 10003 22 123 1234000 44444444 9999")
=end
def order_weight(string)
  string.split.sort do |a, b|
    if a.chars.map(&:to_i).reduce(:+) == b.chars.map(&:to_i).reduce(:+)
      a <=> b
    else
      a.chars.map(&:to_i).reduce(:+) <=> b.chars.map(&:to_i).reduce(:+)
    end
  end.join(' ')
end

# 8) Write a function cakes(), which takes the recipe (a hash) and the available ingredients (also a hash) and returns the maximum number of cakes Pete can bake (integer). The first hash is the recipe, while the second is the ingredients. 
=begin
cakes({"flour"=>500, "sugar"=>200, "eggs"=>1},{"flour"=>1200, "sugar"=>1200, "eggs"=>5, "milk"=>200}) == 2
cakes({"cream"=>200, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>1700, "flour"=>20000, "milk"=>20000, "oil"=>30000, "cream"=>5000}) == 11
cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000}) == 0
cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000, "apples"=>15, "oil"=>20}) == 0
cakes({"eggs"=>4, "flour"=>400},{}) == 0
cakes({"cream"=>1, "flour"=>3, "sugar"=>1, "milk"=>1, "oil"=>1, "eggs"=>1},{"sugar"=>1, "eggs"=>1, "flour"=>3, "cream"=>1, "oil"=>1, "milk"=>1}) == 1
=end
def cakes(recipe, ingredients)
  relevant_ingredients = ingredients.select do |key, _|
    recipe[key]
  end
  return 0 if recipe.keys.all? { |key| ingredients.keys.include?(key) } == false
  relevant_ingredients.map do |key, value|
    relevant_ingredients[key] / recipe[key]
  end.min
end

# 9) Create a function that generates a hashtag. It must start with a hashtag (#). All words must have their first letter capitalized. If the final result is longer than 140 chars it must return false. If the input or the result is an empty string it must return false.
=begin
generateHashtag("") == false
generateHashtag(" " * 200) == false
generateHashtag("Do We have A Hashtag") == "#DoWeHaveAHashtag"
generateHashtag("Codewars") == "#Codewars"
generateHashtag("Codewars Is Nice") == "#CodewarsIsNice"
generateHashtag("Codewars is nice") == "#CodewarsIsNice"
generateHashtag("code" + " " * 140 + "wars") == "#CodeWars"
generateHashtag("Looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong Cat") == false
generateHashtag("a" * 139) == "#A" + "a" * 138
generateHashtag("a" * 140) == false
=end
def generateHashtag(str)
  return false if str.split.join.length == 0 || str.split.join.length > 139
  str.split.map { |word| word.capitalize }.insert(0, '#').join
end

# 10) Write a function named first_non_repeating_letter that takes a string input, and returns the first character that is not repeated anywhere in the string. Upper and lowercase letters are considered the same character, but the function should return the correct case for the initial letter. For example, the input 'sTreSS' should return 'T'. If a string contains all repeating characters, it should return an empty string ("")
=begin
first_non_repeating_letter('a') == 'a'
first_non_repeating_letter('stress') == 't'
first_non_repeating_letter('moonmen') == 'e'
first_non_repeating_letter('') == ''
=end
def first_non_repeating_letter(string)
  return '' if string.length == 0
  string.chars.select do |letter|
    string.downcase.count(letter.downcase) == 1
  end.first == nil ? '' : string.chars.select do |letter|
    string.downcase.count(letter.downcase) == 1
  end.first
end

# 11) Write a program that will calculate the number of trailing zeros in a factorial of a given number. Hint: You're not meant to calculate the factorial. Find another way to find the number of zeros.
=begin
# 6! = 1 * 2 * 3 * 4 * 5 * 6 = 720 --> 1 trailing zero
zeros(6) == 1

# 12! = 479001600 --> 2 trailing zeros
zeros(12) == 2
=end
def zeros(n)
  zeros = 0
  zeros += n /= 5 while n >= 1
  zeros
end

# 12) Complete the function scramble(str1, str2) that returns true if a portion of str1 characters can be rearranged to match str2, otherwise returns false. Only lower case letters will be used (a-z). No punctuation or digits will be included.
=begin
scramble('rkqodlw', 'world') == true
scramble('cedewaraaossoqqyt', 'codewars') == true
scramble('katas', 'steak') == false
=end
def scramble(base, search)
  base_chars = base.chars
  a = search.chars.each do |character|
    if base_chars.include?(character)
      base_chars.delete_at(base_chars.index(character)) 
    else
      break false
    end
  end
  a != false
end

# 13) Given two integers m, n (1 <= m <= n) we want to find all integers between m and n whose sum of squared divisors is itself a square. 
=begin
42 is such a number, since:
Divisors of 42 are : 1, 2, 3, 6, 7, 14, 21, 42. These divisors squared are: 1, 4, 9, 36, 49, 196, 441, 1764. The sum of the squared divisors is 2500 which is 50 * 50, a square!

list_squared(1, 250) == [[1, 1], [42, 2500], [246, 84100]]
list_squared(42, 250) == [[42, 2500], [246, 84100]]
=end
# This passes, but is too slow
def list_squared(start_num, end_num)
  divisors = (start_num..end_num).map do |num|
    [num, (1..Math.sqrt(num)).select do |divisor|
      num % divisor == 0
    end]
  end

  divisor_squares = divisors.map do |original_num, subarr|
    [original_num, subarr.map do |element|
      element ** 2
    end]
  end
  
  sums = divisor_squares.map { |original_num, subarr| [original_num, subarr.reduce(:+)] }
  sums.select do |num, reduced_num|
    Math.sqrt(reduced_num).divmod(1)[1] == 0
  end
end

# This executes quickly enough
def list_squared(m, n)
  res = []
  (m..n).each do |num|
    divisor = []
    i = 1
    while i*i <= num
      if (num % i == 0)
        divisor.push(num/i) if i*i != num
        divisor.push(i)
      end
      i += 1
    end
    sum = divisor.reduce(0){|sum, i| sum + i*i}
    res << [num, sum] if sum**0.5 == (sum**0.5).round
  end
  res
end

# 14) Given a list of integers and a single sum value, return the first two values (parse from the left please) in order of appearance that add up to form the sum.
=begin
sum_pairs([11, 3, 7, 5],         10)
#              ^--^      3 + 7 = 10
== [3, 7]

sum_pairs([4, 3, 2, 3, 4],         6)
#          ^-----^         4 + 2 = 6, indices: 0, 2 *
#             ^-----^      3 + 3 = 6, indices: 1, 3
#                ^-----^   2 + 4 = 6, indices: 2, 4
#  entire pair is earlier, and therefore is the correct answer
== [4, 2]

sum_pairs([0, 0, -2, 3], 2)
#  there are no pairs of values that can be added to produce 2.
== None/nil/undefined (Based on the language)

sum_pairs([10, 5, 2, 3, 7, 5],         10)
#              ^-----------^   5 + 5 = 10, indices: 1, 5
#                    ^--^      3 + 7 = 10, indices: 3, 4 *
#  entire pair is earlier, and therefore is the correct answer
== [3, 7]
=end
# This passes, but is too slow because of the sort
def sum_pairs(array, target)
  stored_nums = []
  array.each_with_index do |first_num, index1|
    array.each_with_index do |second_num, index2|
      stored_nums << [index1, index2] if first_num + second_num == target && index1 != index2
    end
  end

  stored_nums = stored_nums.map do |pair|
    pair.sort
  end.uniq.sort_by { |a, b| b[1] <=> a[1] }

  a, b = stored_nums.last
  stored_nums.empty? ? nil : [array[a], array[b]]
end

# Suggested solution
def sum_pairs(ints, s)
  ints = [1, 2, 3, 4, 1, 0]
  s = 2
  seen = {}
  ints.each do |int|
    # You're adding key value pairs as you iterate through the array. It's nice because you don't have to dick around with indices.
    # On each iteration:
      # Check the other number required to make the pair, by subtracting int from s
      # Check if the subtracted number already exists in the hash
      # If it does, return the pair, since that means it's the earliest possible pair.
      # Otherwise, set that subtracted key-value pair to true for future iterations
    return [s-int, int] if seen[s-int]
    seen[int] = true
  end
  nil
end
