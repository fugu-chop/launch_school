# 1) Write a regex that matches the word The when it occurs at the beginning of a line.
words = ['The lazy cat sleeps.', 'The number 623 is not a word.', 'Then, we went to the movies.', 'Ah. The bus has arrived.']
words.select { |word| word.match(/^The\b/) }
puts "'/\AThe/\b/' does not work in Rubular, as Rubular treats the test string as a single multi-line string, so you need to use ^ instead."

# 2) Write a regex that matches the word cat when it occurs at the end of a line.
words = ['The lazy cat sleeps', 'The number 623 is not a cat', 'The Alaskan drives a snowcat']
words.select { |word| word.match(/\bcat$/) }
puts "'/\bcat\z/' does not work in Rubular, as Rubular treats the test string as a single multi-line string, so you need to use $ instead."

# 3) Write a regex that matches any three-letter word; a word is any string comprised entirely of letters.
words = ['reds and blues', 'The lazy cat sleeps.', 'The number 623 is not a word. Or is it?']
words.select { |word| word.match(/\b[a-z][a-z][a-z]\b/i) }

# 4) Write a regex that matches an entire line of text that consists of exactly 3 words as follows:
=begin
The first word is A or The.
There is a single space between the first and second words.
The second word is any 4-letter word.
There is a single space between the second and third words.
The third word -- the last word -- is either dog or cat.
=end
words = ['A grey cat', 'The lazy dog', 'The white cat', 'A loud dog', 'Go away dog', 'The ugly rat', 'The lazy, loud dog']
words.select { |word| word.match(/^(A|The)\s[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z]\s(dog|cat)$/) }
puts "A proper Ruby solution would use /\A and /\z instead of ^ and $, but to allow for Rubular limitations, we use ^ and $ instead."
