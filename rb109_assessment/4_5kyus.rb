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
