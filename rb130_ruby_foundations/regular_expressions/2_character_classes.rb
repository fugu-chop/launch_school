# 1) Write a regex that matches uppercase or lowercase K or a lowercase s
words = ['Kitchen Kaboodle', 'Reds and blues','kitchen Servers']
words.select { |word| word.match(/[Kks]/) }

# 2) Write a regex that matches any of the strings cat, cot, cut, bat, bot, or but, regardless of case
words = ['My cats, Butterscotch and Pudding, like to', 'sleep on my cot with me, but they cut my sleep', 'short with acrobatics when breakfast time rolls', 'around. I need a robotic cat feeder.']
words.select { |word| word.match(/[b-c][aou]t/i) }

# 3) Base 20 digits include the decimal digits 0 through 9, and the letters A through J in upper or lowercase. Write a regex that matches base 20 digits.
words = ['0xDEADBEEF', '1234.5678', 'Jamaica', 'plow ahead']
words.select { |word| word.match(/[0-9a-j]/i) }

# 4) Write a regex that matches any letter except x or X
words = ['0x1234', 'Too many XXXXXXXXXXxxxxxxXXXXXXXXXXXX to count.', 'The quick brown fox jumps over the lazy dog', 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG']
words.select { |word| word.match(/[a-wy-z]/i) }

# 5) Write a regex that matches any character that is not a letter
words = ['0x1234abcd', '1,000,000,000s and 1,000,000,000s.', 'THE quick BROWN fox JUMPS over THE lazy DOG!']
words.select { |word| word.match(/[^a-z]/i) }

# 6) Are /(ABC|abc)/ and /[Aa][Bb][Cc]/ equivalent regex? If not, how do they differ? Can you provide an example of a string that would match one of these regex, but not the other?
puts "These are not equivalent.  The former matches nothing but the strings 'ABC' or 'abc'; the latter matches any string consisting of the letters a, b, c in sequence, 
regardless of case. The string 'Abc' would match the second pattern, but not the first."

# 7) Are /abc/i and /[Aa][Bb][Cc]/ equivalent regex? If not, how do they differ? Can you provide an example of a string that would match one of these regex, but not the other?
puts "These patterns are identical."

# 8) Challenge: write a regex that matches a string that looks like a simple negated character class range, e.g., '[^a-z]'
words = ['The regex /[^a-z]/i matches any character that is', 'not a letter. Similarly, /[^0-9]/ matches any', 'non-digit while /[^A-Z]/ matches any character', 'that is not an uppercase letter. Beware: /[^+-<]/', 'is at best obscure, and may even be wrong.']
# Each set of brackets in our pattern only corresponds to the first character of our text
words.select { |word| word.match(/\[\^[0-9a-z]-[0-9a-z]\]/i) }
