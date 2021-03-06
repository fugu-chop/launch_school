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
