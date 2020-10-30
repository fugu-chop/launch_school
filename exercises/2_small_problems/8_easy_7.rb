# 1) Write a method that combines two Arrays passed in as arguments, and returns a new Array that contains all elements from both Array arguments, with the elements taken in alternation. You may assume that both input Arrays are non-empty, and that they have the same number of elements.
=begin
interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']
=end

def interleave(arr1, arr2)
  new_arr = []
  counter = 0
  while counter < arr1.length
    new_arr << arr1[counter]
    new_arr << arr2[counter]
    counter += 1
  end
  new_arr
end

# 1b) See if you can rewrite interleave to use zip.
def interleave(arr1, arr2)
  arr1.zip(arr2).flatten
end

# 2) Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the number of characters in the string that are lowercase letters, one the number of characters that are uppercase letters, and one the number of characters that are neither.
=begin
letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }
=end
def letter_case_count(string)
  lowercase = ('a'..'z').to_a
  uppercase = ('A'..'Z').to_a
  result_hash = { lowercase: 0,
                  uppercase: 0,
                  neither: 0 }
  string.chars.each do |char|
    if lowercase.include?(char)
      result_hash[:lowercase] += 1
    elsif uppercase.include?(char)
      result_hash[:uppercase] += 1
    else
      result_hash[:neither] += 1
    end
  end
  result_hash
end

# 3) Write a method that takes a single String argument and returns a new string that contains the original value of the argument with the first character of every word capitalized and all other letters lowercase. You may assume that words are any sequence of non-blank characters.
=begin
word_cap('four score and seven') == 'Four Score And Seven'
word_cap('the javaScript language') == 'The Javascript Language'
word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'
=end
def word_cap(string)
  string.downcase.split.map(&:capitalize).join(' ')
end

# 3) Without capitalize, how would you solve this problem? 
def word_cap(string)
  new_arr = []
  string_arr = string.downcase.split
  string_arr.each do |word|
    word[0] = word[0].upcase!
  end
  string_arr.join(' ')
end

# 4) Write a method that takes a string as an argument and returns a new string in which every uppercase letter is replaced by its lowercase version, and every lowercase letter by its uppercase version. All other characters should be unchanged. You may not use String#swapcase; write your own version of this method.
=begin
swapcase('CamelCase') == 'cAMELcASE'
swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'
=end

def swapcase(string)
  lowercase_letters = ('a'..'z').to_a
  string.chars.map do |letter|
    if lowercase_letters.include?(letter)
      letter.upcase
    else
      letter.downcase
    end
  end.join
end

# 5) Write a method that takes a String as an argument, and returns a new String that contains the original value using a staggered capitalization scheme in which every other character is capitalized, and the remaining characters are lowercase. Characters that are not letters should not be changed, but count as characters when switching between upper and lowercase.
=begin
staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
staggered_case('ALL_CAPS') == 'AlL_CaPs'
staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'
=end

def staggered_case(string)
  # Break the string into array of words
  # Iterate through the words
  # iterate through the letters in the words (nested)
  # Where the index is odd, upcase
  # Where index is even, downcase
  # Join the words array back together
end