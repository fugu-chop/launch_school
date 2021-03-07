# 1) Assume we have a Tree class that implements a binary tree. A binary tree is just one of many forms of collections, such as Arrays, Hashes, Stacks, Sets, and more. 
# All of these collection classes include the Enumerable module, which means they have access to an each method, as well as many other iterative methods such as map, reduce, select, and more. For this exercise, modify the Tree class to support the methods of Enumerable. You do not have to actually implement any methods -- just show the methods that you must provide.
class Tree
  include Enumerable

  # Note that the Enumerable module actually does not include an 'each' method
  def each
  end
end

# 2) Write a method that takes an optional block. If the block is specified, the method should execute it, and return the value returned by the block. If no block is specified, the method should simply return the String 'Does not compute.'.
=begin
compute { 5 + 3 } == 8
compute { 'a' + 'b' } == 'ab'
compute == 'Does not compute.'
=end
def compute
  block_given? ? yield : "Does not compute"
end

# 2b) Modify the compute method so it takes a single argument and yields that argument to the block. Provide at least 3 examples of calling this new version of compute, including a no-block call.
def compute(arg)
  block_given? ? yield(arg) : "Does not compute"
end

compute("hello") { |arg| arg + " there!" }
compute(9) { |arg| arg + 10 }
compute(9)

# 3) Write a method that takes a sorted array of integers as an argument, and returns an array that includes all of the missing integers (in order) between the first and last elements of the argument.
=begin
missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
missing([1, 2, 3, 4]) == []
missing([1, 5]) == [2, 3, 4]
missing([6]) == []
=end
def missing(arr)
  min_val = arr.min
  max_val = arr.max
  full_range = (min_val..max_val).to_a
  full_range - arr
end

# 4) Write a method that returns a list of all of the divisors of the positive integer passed in as an argument. The return value can be in any sequence you wish.
=begin
divisors(1) == [1]
divisors(7) == [1, 7]
divisors(12) == [1, 2, 3, 4, 6, 12]
divisors(98) == [1, 2, 7, 14, 49, 98]
divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
=end
def divisors(num)
  divisor_arr = (1..Math.sqrt(num)).to_a << num
  low_divs = divisor_arr.select { |divisor| num % divisor == 0 }
  high_divs = low_divs.map { |divisor| num / divisor }
  final = (low_divs + high_divs).uniq.sort
end

# 5) Write a program that deciphers and prints each of these names. The names are encrypted using the ROT13 cipher
=begin
Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unvog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu
=end
pioneers = ["Nqn Ybirynpr",
"Tenpr Ubccre",
"Nqryr Tbyqfgvar",
"Nyna Ghevat",
"Puneyrf Onoontr",
"Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv",
"Wbua Ngnanfbss",
"Ybvf Unvog",
"Pynhqr Funaaba",
"Fgrir Wbof",
"Ovyy Tngrf",
"Gvz Orearef-Yrr",
"Fgrir Jbmavnx",
"Xbaenq Mhfr",
"Fve Nagbal Ubner",
"Zneiva Zvafxl",
"Lhxvuveb Zngfhzbgb",
"Unllvz Fybavzfxv",
"Tregehqr Oynapu"]

def decipher(string)
  alpha_arr = ('a'..'z').to_a

  arr.map do |string|
    string.downcase.split.map do |word|
      word.chars.map do |letter|
        alpha_arr.index(letter).nil? ? next : start_index = alpha_arr.index(letter)
        alpha_arr.rotate(start_index - 13).first
      end.join.capitalize
    end.join(' ')
  end
end

# Alternative solution
def rot13_1(cypher_string)
  cypher_string.tr('A-Za-z', 'N-ZA-Mn-za-m')
end

# Alt solution 2
def rot13_2(encrypted_text)
  encrypted_text.each_char.reduce('') do |result, encrypted_char|
    result + decipher_character(encrypted_char)
  end
end

def decipher_character(encrypted_char)
  case encrypted_char
  when 'a'..'m', 'A'..'M' then (encrypted_char.ord + 13).chr
  when 'n'..'z', 'N'..'Z' then (encrypted_char.ord - 13).chr
  else                         encrypted_char
  end
end

# 6) Write a method called any? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for any of the element values. Otherwise, it should return false. Your method should stop processing elements of the Array as soon as the block returns true. If the Array is empty, any? should return false, regardless of how the block is defined. Your method may not use any standard ruby method that is named all?, any?, none?, or one?.
=begin
any?([1, 3, 5, 6]) { |value| value.even? } == true
any?([1, 3, 5, 7]) { |value| value.even? } == false
any?([2, 4, 6, 8]) { |value| value.odd? } == false
any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
any?([1, 3, 5, 7]) { |value| true } == true
any?([1, 3, 5, 7]) { |value| false } == false
any?([]) { |value| true } == false
=end
def any?(arr)
  for i in arr
    return true if yield(i)
  end
  false
end

# Alternative solution - this works for hashes and sets (which our above solution doesn't)
def any?(collection)
  collection.each { |item| return true if yield(item) }
  false
end

# 7) Write a method called all? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for all of the element values. Otherwise, it should return false. Your method should stop processing elements of the Array as soon as the block returns false. If the Array is empty, all? should return true, regardless of how the block is defined. Your method may not use any standard ruby method that is named all?, any?, none?, or one?.
=begin
all?([1, 3, 5, 6]) { |value| value.odd? } == false
all?([1, 3, 5, 7]) { |value| value.odd? } == true
all?([2, 4, 6, 8]) { |value| value.even? } == true
all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
all?([1, 3, 5, 7]) { |value| true } == true
all?([1, 3, 5, 7]) { |value| false } == false
all?([]) { |value| false } == true
=end
def all?(arr)
  assessment = []
  for i in arr
    assessment << yield(i)
  end
  assessment.include?(false) ? false : true
end

# Alternative solution that works with hashes
def all?(collection)
  collection.each { |item| return false unless yield(item) }
  true
end

# 8) Write a method called none? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns false for all of the element values. Otherwise, it should return false. Your method should stop processing elements of the Array as soon as the block returns true. If the Array is empty, none? should return true, regardless of how the block is defined. Your method may not use any of the following methods from the Array and Enumerable classes: all?, any?, none?, one?. 
=begin
none?([1, 3, 5, 6]) { |value| value.even? } == false
none?([1, 3, 5, 7]) { |value| value.even? } == true
none?([2, 4, 6, 8]) { |value| value.odd? } == true
none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
none?([1, 3, 5, 7]) { |value| true } == false
none?([1, 3, 5, 7]) { |value| false } == true
none?([]) { |value| true } == true
=end
def none?(arr)
  counter = 0
  while counter < arr.size
    return false if yield(arr[counter])
    counter += 1
  end
  true
end

# Alternative solution
def none?(collection)
  collection.each { |item| return false if yield(item) }
  true
end

# Another alt solution. Note that we have to pass in the block explicitly, since blocks aren't passed down the calling chain by default. We then pass &block to any?, where it is treated as if the call to any? included the block.
def none?(collection, &block)
  !any?(collection, &block)
end
=begin
# This wouldn't work - Ruby would raise a LocalJumpError
def none?(collection)
  !any?(collection)
end
=end

# 9) Write a method called one? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for exactly one of the element values. Otherwise, it should return false. Your method should stop processing elements of the Array as soon as the block returns true a second time. If the Array is empty, one? should return false, regardless of how the block is defined. Your method may not use any standard ruby method that is named all?, any?, none?, or one?.
=begin
one?([1, 3, 5, 6]) { |value| value.even? } == true
one?([1, 3, 5, 7]) { |value| value.odd? } == false
one?([2, 4, 6, 8]) { |value| value.even? } == false
one?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
one?([1, 3, 5, 7]) { |value| true } == false
one?([1, 3, 5, 7]) { |value| false } == false
one?([]) { |value| true } == false
=end
def one?(arr)
  results = []
  for i in arr
    results << yield(i)
    return false if results.count(true) > 1
  end
  results.count(true) == 1
end

# Alt solution
def one?(collection)
  seen_one = false
  collection.each do |element|
    # if the block yields true, we set seen_one to true. If it's falsy, we skip to the next element
    next unless yield(element)
    # The next time the block runs, this statement is evaluated - if it's already true, that means false should be returned
    return false if seen_one
    seen_one = true
  end
  # Handle cases where there is only one truthy value, or if all block returns are falsy
  seen_one
end

# 10 & 10b) Write a method that takes an array as an argument, and a block that returns true or false depending on the value of the array element passed to it. The method should return a count of the number of times the block returns true. You may not use Array#count or Enumerable#count in your solution.
=begin
count([1,2,3,4,5]) { |value| value.odd? } == 3
count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
count([1,2,3,4,5]) { |value| true } == 5
count([1,2,3,4,5]) { |value| false } == 0
count([]) { |value| value.even? } == 0
count(%w(Four score and seven)) { |value| value.size == 5 } == 2
=end
def count(arr)
  truthy_results = []
  counter = 0
  while counter < arr.size
    truthy_results << arr[counter] if yield(arr[counter])
    counter += 1
  end
  truthy_results.size
end

# Alternative approach using incrementing a variable
def count(array)
  total = 0
  array.each { |value| total += 1 if yield(value) }
  total
end

# Alt solution using reduce. We need to pass in the 0 as an optional parameter since there's no first element to add against (i.e. the return values of the block will only be true or false)
def count(arr)
  # Need to return the accumulator at each iteration - if you skip it, you will start getting errors when your array doesn't include numerical items. Also it won't work if your block never yields true
  arr.reduce(0) { |count, el| yield(el) ? count + 1 : count }
end
