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

# 15) Read this: https://www.codewars.com/kata/551dd1f424b7a4cdae0001f0. The input data consist of an array which contains at least 1 name, and single integer n.
=begin
For example, Penny drinks the third can of cola and the queue will look like this:
Rajesh, Howard, Sheldon, Sheldon, Leonard, Leonard, Penny, Penny

who_is_next(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 1) == "Sheldon"
who_is_next(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 52) == "Penny"
who_is_next(["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"], 7230702951) == "Leonard"
=end
def whoIsNext(names, r)
  r -= 1
  while r >= names.size
    r -= names.size
    r /= 2
  end
  names[r]
end

# 16) A perfect power is a classification of positive integers: In mathematics, a perfect power is a positive integer that can be expressed as an integer power of another positive integer. More formally, n is a perfect power if there exist natural numbers m > 1, and k > 1 such that mk = n. Your task is to check wheter a given integer is a perfect power. If it is a perfect power, return a pair m and k with mk = n as a proof. Otherwise return nil. For a perfect power, there might be several pairs. For example 81 = 3^4 = 9^2, so (3,4) and (9,2) are valid solutions. However, the tests take care of this, so if a number is a perfect power, return any pair that proves it.
=begin
isPP(4) => [2,2]
isPP(9) => [3,2]
isPP(5) => nil
=end
# The test cases are broken on Codewars
def isPP(num)
  (2..9).each do |power|
    if (power == 3 || power == 9) && (num ** (1.0 / power)).divmod(1)[1].to_s[2..7] == '999999'
      return [(num ** (1.0 / power)).to_i.round, power] 
    elsif (num ** (1.0 / power)).divmod(1)[1] == 0
      return [(num ** (1.0 / power)).to_i, power] 
    end
  end
  nil
end

# 17) See this kata: https://www.codewars.com/kata/559a28007caad2ac4e000083 (it has pictures)
=begin
perimeter(5) == 80
perimeter(7) == 216
perimeter(20) == 114624
perimeter(30) == 14098308
perimeter(100) == 6002082144827584333104
=end
def fibonacci(index)
  series = [1, 1]
  until series.length == index
    series << series[-1] + series[-2]
  end
  series
end

def perimeter(num)
  fibonacci(num+1).reduce(:+) * 4
end

# 18) See this kata: https://www.codewars.com/kata/5270d0d18625160ada0000e4 (too much text). Don't mutate the input.
=begin
Three 1's => 1000 points
Three 6's =>  600 points
Three 5's =>  500 points
Three 4's =>  400 points
Three 3's =>  300 points
Three 2's =>  200 points
One   1   =>  100 points
One   5   =>   50 point

score( [2, 3, 4, 6, 2] ) == 0
score( [2, 2, 2, 3, 3] ) == 200
score( [2, 4, 4, 5, 4] ) == 450
=end
def score(dice)
  counts = Hash.new(0)
  score_array = []
  dice.each do |die|
    counts.keys.include?(die) ? counts[die] += 1 : counts[die] = 1
  end

  loop do
    break if counts.values.all? { |value| value <= 0 }
    counts.each do |key, value|
      if key == 1 && value >= 3
        score_array << 1000
        counts[1] -= 3
      elsif key == 6 && value >= 3
        score_array << 600
        counts[6] -= 3
      elsif key == 5 && value >= 3
        score_array << 500
        counts[5] -= 3
      elsif key == 4 && value >= 3
        score_array << 400
        counts[4] -= 3
      elsif key == 3 && value >= 3
        score_array << 300
        counts[3] -= 3
      elsif key == 2 && value >= 3
        score_array << 200
        counts[2] -= 3
      elsif key == 1 && value > 0
        score_array << 100
        counts[1] -= 1            
      elsif key == 5 && value > 0
        score_array << 50
        counts[5] -= 1
      else
        counts[key] -= 1        
      end
    end
  end

  score_array.reduce(0, &:+)
end

# Much smarter method lol
def score( dice )
  [ dice.count(1) / 3 * 1000,
    dice.count(6) / 3 * 600,
    dice.count(5) / 3 * 500,
    dice.count(4) / 3 * 400,
    dice.count(3) / 3 * 300,
    dice.count(2) / 3 * 200,
    dice.count(1) % 3 * 100,
    dice.count(5) % 3 * 50 ].reduce(:+)
end

# 19) We will write a function gap with parameters. This function should return the first pair of two prime numbers spaced with a gap of g between the limits m, n if these numbers exist. Otherwise, return nil.
=begin
  g (integer >= 2) which indicates the gap we are looking for
  m (integer > 2) which gives the start of the search (m inclusive)
  n (integer >= m) which gives the end of the search (n inclusive)

# First pair between 3 and 50 with a 2-gap.
gap(2, 3, 50) == [3, 5]
gap(2, 5, 7) == [5, 7]
gap(2, 5, 5) == nil
gap(4, 130, 200) == [163, 167]
=end
# As expected, this passes test cases but is too slow (due to prime checking)
def gap(gap, start_prime, end_prime)
  prime_arr = (start_prime..end_prime).select do |prime|
    (2..Math.sqrt(prime)).none? { |i| prime % i == 0 }
  end

  prime_arr.each_cons(2).select do |a, b|
    b - a == gap
  end.first
end

# 20) Write a function done_or_not, passing a Sudoku board (list of lists) as an argument. If the board is valid return 'Finished!', otherwise return 'Try again!'
=begin
done_or_not([[5, 3, 4, 6, 7, 8, 9, 1, 2], 
            [6, 7, 2, 1, 9, 5, 3, 4, 8],
            [1, 9, 8, 3, 4, 2, 5, 6, 7],
            [8, 5, 9, 7, 6, 1, 4, 2, 3],
            [4, 2, 6, 8, 5, 3, 7, 9, 1],
            [7, 1, 3, 9, 2, 4, 8, 5, 6],
            [9, 6, 1, 5, 3, 7, 2, 8, 4],
            [2, 8, 7, 4, 1, 9, 6, 3, 5],
            [3, 4, 5, 2, 8, 6, 1, 7, 9]]) == 'Finished!'

done_or_not([[5, 3, 4, 6, 7, 8, 9, 1, 2], 
            [6, 7, 2, 1, 9, 0, 3, 4, 9],
            [1, 0, 0, 3, 4, 2, 5, 6, 0],
            [8, 5, 9, 7, 6, 1, 0, 2, 0],
            [4, 2, 6, 8, 5, 3, 7, 9, 1],
            [7, 1, 3, 9, 2, 4, 8, 5, 6],
            [9, 0, 1, 5, 3, 7, 2, 1, 4],
            [2, 8, 7, 4, 1, 9, 6, 3, 5],
            [3, 0, 0, 4, 8, 1, 1, 7, 9]]) == 'Try again!'            
=end

def row_test(board)
  board.each do |row|
    break 'Try again!' if row.sort != (1..9).to_a
  end != 'Try again!'
end

def col_test(board)
  index_counter = 0
  loop do 
    break if index_counter == 9
    col_nums = []
    board.each do |row|
      col_nums << row[index_counter]
    end
    break 'Try again!' if col_nums.sort != (1..9).to_a
    index_counter += 1
  end != 'Try again!'
end

def region_test(board)
  region_start = 0
  region_end = 2
  loop do 
    break if region_end > 8
    arr_test = []
    board.each_slice(3) do |rows|
      rows.each do |region|
        arr_test << region[region_start..region_end]
      end
    end
    break 'Try again!' if arr_test.each_slice(3) do |slice|
      break 'Try again!' if slice.flatten.sort != (1..9).to_a
    end == 'Try again!'
    region_start += 3
    region_end += 3
  end != 'Try again!'
end

def done_or_not(board)
  row_test(board) && col_test(board) && region_test(board) ? 'Finished!' : 'Try again!'
end

# 21) John and Mary want to travel between a few towns A, B, C ... Mary has on a sheet of paper a list of distances between these towns. ls = [50, 55, 57, 58, 60]. John is tired of driving and he says to Mary that he doesn't want to drive more than t = 174 miles and he will visit only 3 towns. Which distances, hence which towns, they will choose so that the sum of the distances is the biggest possible to please Mary and John? 
=begin
With list ls and 3 towns to visit they can make a choice between: [50,55,57],[50,55,58],[50,55,60],[50,57,58],[50,57,60],[50,58,60],[55,57,58],[55,57,60],[55,58,60],[57,58,60].

The sums of distances are then: 162, 163, 165, 165, 167, 168, 170, 172, 173, 175.

The biggest possible sum taking a limit of 174 into account is then 173 and the distances of the 3 corresponding towns is [55, 58, 60].
If this isn't possible, return nil.

choose_best_sum(163, 3, [50, 55, 56, 57, 58]) == 163
choose_best_sum(163, 3, [50]) == nil
choose_best_sum(230, 3, [91, 74, 73, 85, 73, 81, 87]) == 228
=end
def choose_best_sum(t, k, ls)
  perms = ls.combination(k).map do |perm|
    perm.sort
  end.uniq

  a = perms.select do |perm|
    perm.reduce(0, &:+) <= t
  end

  return nil if ls.length < k 

  a.map do |perm|
    perm.reduce(0, &:+)
  end.max
end

# 22) You are given an array of numbers, which represent fractions. You need to find the lowest common denominator among these and convert those fractions to that denominator. 
=begin
convertFracts([[1, 2], [1, 3], [1, 4]]) == [[6, 12], [4, 12], [3, 12]]
=end
# This passes, but times out
def convertFracts(array) 
  denominators = array.map do |pairs|
    pairs[1]
  end
  min_var = array.sort { |subarr| subarr[1] }.reverse.first[1]
  counter = min_var

  loop do 
    lcd = denominators.select { |denom| counter % denom == 0 }
    break if lcd.length == denominators.length
    counter += min_var
  end

  multipliers = denominators.map { |denom| counter / denom }

  numerators = array.map do |pairs|
    pairs[0]
  end

  idx = 0
  new_numerators = []
  until idx == numerators.length
    new_numerators << numerators[idx] * multipliers[idx]
    idx += 1
  end

  new_numerators.map { |num| [num, counter] }
end

# This passes (built method)
def convertFracts(lst)
  # x represents the accumulator, y represents the subarray in lst
  # On each iteration, x is replaced by the lowest common multiple of the subarray[1] elements - e.g. x = 1.lcm(2), which is 2.
    # On the next iteration, x = 2, 2.lcm(3) == 6, x is now equal to 6
  lcm = lst.reduce(1) { |x, y| x.lcm(y[1]) }
  lst.map { |x| [lcm / x[1] * x[0], lcm] }
end

# 23) Your job is to write a function which increments a string, to create a new string. If the string already ends with a number, the number should be incremented by 1. If the string does not end with a number. the number 1 should be appended to the new string. If the number has leading zeros the amount of digits should be considered.
=begin
increment_string("foo") == "foo1"
increment_string("foobar001") == "foobar002"
increment_string("foobar1") == "foobar2"
increment_string("foobar00") == "foobar01"
increment_string("foobar99") == "foobar100"
increment_string("") == "1"
=end
def increment_string(string)
  string = "dttxqwlnc8"
  num_comparison = ('0'..'9').to_a
  num_start_index = nil
  string.chars.each_with_index do |char, index| 
    break num_start_index = index if num_comparison.include?(char)
  end

  return string + '1' if num_start_index == nil || !num_comparison.include?(string[-1])
  
  num_portion = string[num_start_index..-1]

  digit_portion = num_portion.chars.map.with_index do |digit_str, index|
    if digit_str == '0' || digit_str == '9'
      digit_str
    elsif digit_str != '0' && digit_str != '9' && index == num_portion.length - 1
      (digit_str.to_i + 1).to_s
    else
      digit_str
    end
  end.join

  if digit_portion.include?('9')
    nines = digit_portion.chars.reverse.map.with_index do |digit, index|
      if digit == '9'
        next
      else
        break digit_portion.length - index - 1
      end
    end
  end

  if digit_portion.include?('9') && nines != nil && [nines].flatten.include?(nil) && string[-1] == '9'
    digit_portion = (digit_portion.to_i + 1).to_s
  elsif digit_portion.include?('9') && string[-1] == '9'
    digit_portion[nines..-1] = (digit_portion[nines..-1].to_i + 1).to_s
  end

  digit_portion[-1] = '1' if digit_portion[-1] == '0' && !string.include?('9')

  string[0...num_start_index] + digit_portion
end

# 24) Our goal is to create a function that will check if there is a winner in Tictactoe. Assume that the board comes in the form of a 3x3 array, where the value is 0 if a spot is empty, 1 if it is an "X", or 2 if it is an "O", like so. You may assume that the board passed in is valid in the context of a game of Tic-Tac-Toe.
=begin
[[0, 0, 1],
[0, 1, 2],
[2, 1, 0]]

We want our function to return:
  -1 if the board is not yet finished (there are empty spots),
  1 if "X" won,
  2 if "O" won,
  0 if a draw occurs

is_solved([[0,0,1],[0,1,2],[2,1,0]]) == -1
is_solved([[0,0,1],[2,2,2],[2,1,0]]) ==  2
is_solved([[1,0,1],[0,1,2],[2,1,1]]) ==  1
=end
def is_solved(board)
  board.each do |rows|
    return 1 if rows.count(1) == 3
    return 2 if rows.count(2) == 3
  end

  col_counter = 0
  until col_counter > 3
    col = board.map do |row|
      row[col_counter]
    end
    return 1 if col.count(1) == 3
    return 2 if col.count(2) == 3
    col_counter += 1
  end

  diag_counter = 0
  diags1 = []
  diags2 = []
  until diag_counter == 3
    diags1 << board[diag_counter][diag_counter]
    diag_counter += 1
  end

  until diag_counter < 1
    diag_counter -= 1
    diags2 << board[2 - diag_counter][diag_counter]
  end

  return 1 if diags1.count(1) == 3 || diags2.count(1) == 3
  return 2 if diags1.count(2) == 3 || diags2.count(2) == 3
  
  return -1 if board.flatten.count(0) > 0
  
  0
end

# 25) Josephus permutation - see description here: https://www.codewars.com/kata/5550d638a99ddb113e0000a2
=begin
josephus(7,3)
  n=7
  k=3

[1,2,3,4,5,6,7] - initial sequence
[1,2,4,5,6,7] => 3 is counted out and goes into the result [3]
[1,2,4,5,7] => 6 is counted out and goes into the result [3,6]
[1,4,5,7] => 2 is counted out and goes into the result [3,6,2]
[1,4,5] => 7 is counted out and goes into the result [3,6,2,7]
[1,4] => 5 is counted out and goes into the result [3,6,2,7,5]
[4] => 1 is counted out and goes into the result [3,6,2,7,5,1]
[] => 4 is counted out and goes into the result [3,6,2,7,5,1,4]

josephus([1,2,3,4,5,6,7,8,9,10],1) == [1,2,3,4,5,6,7,8,9,10]
josephus([1,2,3,4,5,6,7,8,9,10],2) == [2, 4, 6, 8, 10, 3, 7, 1, 9, 5]
josephus(["C","o","d","e","W","a","r","s"],4) == ['e', 's', 'W', 'o', 'C', 'd', 'r', 'a']
josephus(["C",0,"d",3,"W",4,"r",5],4) == [3, 5, 'W', 0, 'C', 'd', 'r', 4]
josephus([1,2,3,4,5,6,7],3) == [3, 6, 2, 7, 5, 1, 4]
josephus([],3) == []
josephus([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50],11) == [11, 22, 33, 44, 5, 17, 29, 41, 3, 16, 30, 43, 7, 21, 36, 50, 15, 32, 48, 14, 34, 1, 20, 39, 9, 28, 2, 25, 47, 24, 49, 27, 8, 38, 19, 6, 42, 35, 26, 23, 31, 40, 4, 18, 12, 13, 46, 37, 45, 10]
josephus([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],40) == [10, 7, 8, 13, 5, 4, 12, 11, 3, 15, 14, 9, 1, 6, 2]
josephus([1],3) == [1]
josephus([true,false,true,false,true,false,true,false,true],9) == [true, true, true, false, false, true, false, true, false]
=end
def josephus(items,k)
  # The Array.new function takes the items.length as an argument, which creates an empty array of items.length elements
  # When we pass it a block, the array is populated from element 0 to items.length sequentially by the return value of the block.
  # The rotate method takes an argument, which takes k-1 elements from the front of the array and deposits them at the end of the array. 
  Array.new(items.length) { items.rotate!(k-1).shift }
end

# 26) In this kata, we need to find the last element of the Josephus array. The challenge here is that the arrays can be very large, so we need to find a more efficient way of doing this. 
=begin
josephus_survivor(7,3) == 4
josephus_survivor(11,19) == 10
josephus_survivor(1,300) == 1
josephus_survivor(14,2) == 13
josephus_survivor(100,1) == 100
=end
def josephus_survivor(n, k)
  a = (1..n).to_a
  arr_test = []
  n.times do |sth|
    arr_test << a.rotate!(k - 1).shift
  end
  arr_test.last
end

# 27) We need to find the prime factors of a given number. Each prime factor might need to be raised to a certain power in order for the equation to work. We should return a string of the factors, separated by brackets and raised to the power where necessary.
=begin
prime_factors(86240) == "(2**5)(5)(7**2)(11)"
prime_factors(7775460) == "(2**2)(3**3)(5)(7)(11**2)(17)"
=end
def prime_factors(n)
  factors = Hash.new
  divisor = 2
  # This solution relies on the ability to 'exhaust' a factor before you move onto the next one (i.e. assuming there is only one valid solution)
  # We set up the outer loop, which iterates through a bunch of numbers
  while divisor <= n
    # This inner loop continues to decrement n by the same divisor, until that divisor no longer cleanly divides into n (i.e. n % divisor != 0) - on the first iteration, we continually divide by 2, incrementing the hash value, which represents the number of iterations and the power to which we raise 2.
    # My key question would be how do you ensure that divisor is limited to just prime numbers? Is it that every number that's not a prime can be achieved by multiplying primes (sometimes to the power) together? 
    while n % divisor == 0
      n /= divisor
      factors.has_key?(divisor.to_s) ? factors[divisor.to_s] += 1 : factors[divisor.to_s] = 1
    end
    divisor += 1
  end
  factors.map { |key,value| value == 1 ? "(" + key + ")" : "(" + key + "**" + value.to_s + ")" }.join
end

# 28) Complete the function/method so that it takes CamelCase string and returns the string in snake_case notation. Lowercase characters can be numbers. If method gets number, it should return string.
=begin
to_underscore('TestController') == 'test_controller'
to_underscore('MoviesAndBooks') == 'movies_and_books'
to_underscore('App7Test') == 'app7_test'
to_underscore(1) == '1'
=end
def to_underscore(string)
  string_nums = ('0'..'9').to_a
  return string.to_s if !string.instance_of?(String)
  string.chars.map do |char|
    char == char.upcase && !string_nums.include?(char) ? '_' + char.downcase : char
  end.join[1..-1]
end

# 29) You have a positive number n consisting of digits. You can do at most one operation: Choosing the index of a digit in the number, remove this digit at that index and insert it back to another or at the same place in the number in order to find the smallest number you can get. 
=begin
Return an array with
    1) the smallest number you got
    2) the index i of the digit d you took, i as small as possible
    3) the index j (as small as possible) where you insert this digit d to have the smallest number.

smallest(261235) == [126235, 2, 0]
smallest(209917) == [29917, 0, 1]
smallest(285365) == [238565, 3, 1]
smallest(269045) == [26945, 3, 0]
smallest(296837) == [239687, 4, 1]

=end
def smallest(number)
  num_arr = number.digits.reverse
  min_num = if num_arr.min == num_arr[0]
    num_arr[1..-1].min
  else
    num_arr.min 
  end
  min_num_index = num_arr.index(min_num)
  num_arr.delete_at(num_arr.index(min_num))
  insert_index = 0

  num_arr.each_with_index do |num, index|
    if min_num < num
      num_arr.insert(index, min_num) 
      insert_index = index
      break
    end
  end

  [num_arr.join.to_i, min_num_index, insert_index]
end

# 30) Write a function called LCS that accepts two sequences and returns the longest subsequence common to the passed in sequences. A subsequence is different from a substring. The terms of a subsequence need not be consecutive terms of the original sequence.
=begin
lcs( "abcdef" , "abc" ) == "abc"
lcs( "abcdef" , "acf" ) == "acf"
lcs( "132535365" , "123456789" ) == "12356"
=end
def lcs(str1, str2)
  return '' if str1.chars & str2.chars == [] 
  comparer = str1.chars.length < str2.chars.length ? str1.chars : str2.chars
  base = str1.chars.length >= str2.chars.length ? str1.chars : str2.chars
  lowest_common_index = base.index(comparer[0])
  common_chars = []
  comparer.each do |b_letter|
    common_chars << b_letter if base[lowest_common_index..-1].include?(b_letter)
  end
  common_chars.join
end

# 31) Write an algorithm that takes an array and moves all of the zeros to the end, preserving the order of the other elements.
=begin
move_zeros([1,2,0,1,0,1,0,3,0,1]) == [ 1, 2, 1, 1, 3, 1, 0, 0, 0, 0 ]
=end
def move_zeroes(array)
  zero_count = array.count(0)
  array.delete(0)
  zero_count.times { |_| array.push(0) } 
  array
end

# 32) Complete the function that accepts two integer arrays of equal length, compares the value each member in one array to the corresponding member in the other, squares the absolute value difference between those two values and returns the average of those squared absolute value difference between each member pair.
=begin
[1, 2, 3], [4, 5, 6]              -->   9   because (9 + 9 + 9) / 3
[10, 20, 10, 2], [10, 25, 5, -2]  -->  16.5 because (0 + 25 + 25 + 16) / 4
[-1, 0], [0, -1]                  -->   1   because (1 + 1) / 2

solution([1, 2, 3], [4, 5, 6]) == 9
solution([10, 20, 10, 2], [10, 25, 5, -2]) == 16.5
solution([-1, 0], [0, -1]) == 1
=end
