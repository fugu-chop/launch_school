# 1) Write a regex that matches any sequence of three characters delimited by whitespace characters.
words = ['reds and blues', 'the lazy cat sleeps']
words.select { |word| word.match(/\s...\s/) }
puts "'the' also matches on Rubular - the newline between the first and second lines of text is a whitespace character."

# 2) Observe the /\s...\s/ pattern in #1. Why is it that this pattern doesn't include the three-letter words Doc, red, box, or Hup, but it does match 2 3?
=begin
words = ['Doc in a big red box.', 'Hup! 2 3 4']
=end
puts "'Doc' doesn't match since 'Doc' doesn't follow any whitespace.
'big' matches since it is three characters with both leading and trailing whitespace.
'red' doesn't match since the regex engine consumes the space character that precedes red when it matches big (note the trailing space). 
Once consumed as part of a match, the character is no longer available for subsequent matches.
'box' doesn't match since a . follows it.
'Hup' doesn't match since an exclamation point follows it.
'2 3' matches since 2 3 is three characters long and it has both leading and trailing whitespace."

# 3) Write a regex that matches any four digit hexadecimal number that is both preceded and followed by whitespace. Note that 0x1234 is not a hexadecimal number in this exercise: there is no space before the number 1234.
words = ['Hello 4567 bye CDEF - cdef', '0x1234 0x5678 0xABCD', '1F8A done']
words.select { |word| word.match(/\s\h\h\h\h\s/) }
puts "cdef has a trailing whitespace character in the form of a newline, and 1F8A has a preceding whitespace that is a newline."

# 4) Write a regex that matches any sequence of three letters.
words = ['The red d0g chases the b1ack cat.', 'a_b c_d']
words.select { |word| word.match(/[a-z][a-z][a-z]/i) }
