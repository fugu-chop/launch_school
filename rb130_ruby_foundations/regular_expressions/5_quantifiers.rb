# 1) Write a regex that matches any word that begins with b and ends with an e, and has any number of letters in-between. You may limit your regex to lowercase letters.
words = ['To be or not to be' =, 'Be a busy bee', 'I brake for animals.']
words.select { |word| word.match(/\bb[a-z]*e\b/) }

# 2) Write a regex that matches any line of text that ends with a ?
words = ["What's up, doc?", "Say what? No way.", "?", "Who? What? Where? When? How?"]
words.select { |word| word.match(/^.*\?$/) }

# 3) Write a regex that matches any line of text that ends with a ?, but does not match a line that consists entirely of a single ?
words = ["What's up, doc?", "Say what? No way.", "?", "Who? What? Where? When? How?"]
words.select { |word| word.match(/^.+\?$/) }

# 4) Write a regex that matches any line of text that contains nothing but a URL. 
# For this exercise, a URL begins with http:// or https://, and continues until it detects a whitespace character or end of line. 
words = ["http://launchschool.com/", "https://mail.google.com/mail/u/0/#inbox", "htpps://example.com", "Go to http://launchschool.com/", "https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello", "    http://launchschool.com/"]
words.select { |word| word.match(/^https?:\/\/\S*$/) }

# 5) Modify your regex from the previous exercise so the URL can have optional leading or trailing whitespace, but is otherwise on a line by itself. 
words = ["http://launchschool.com/ ", "https://mail.google.com/mail/u/0/#inbox ", "htpps://example.com", "Go to http://launchschool.com/", "https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello", "    http://launchschool.com/"]
words.select { |word| word.match(/^\s*https?:\/\/\S*\s*$/) }

# 6) Modify your regex from the previous exercise so the URL can appear anywhere on each line, so long as it begins at a word boundary.
words = ["http://launchschool.com/", "https://mail.google.com/mail/u/0/#inbox", "htpps://example.com", "Go to http://launchschool.com/", "https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello", "    http://launchschool.com/"]
words.select { |word| word.match(/\bhttps?:\/\/\S*/) }

# 7) Write a regex that matches any word that contains at least three occurrences of the letter i
words = ['Mississippi', 'ziti 0minimize7', 'inviting illegal iridium']
words.select { |word| word.match(/\b([a-z]*i){3,}[a-z]*\b/i) }

# 8) Write a regex that matches the last word in each line of text. For this exercise, assume that words are any sequence of non-whitespace characters. 
words = ["What's up, doc?", "I tawt I taw a putty tat!", "Thufferin' thuccotath!", "Oh my darling, Clementine!", "Camptown ladies sing this song, doo dah."]
words.select do { |word| word.match(/\b\S+$/) }

# 9) Write a regex that matches lines of text that contain at least 3, but no more than 6, consecutive comma separated numbers. 
# You may assume that every number on each line is both preceded by and followed by a comma.
words = [",123,456,789,123,345,", ",123,456,,789,123,", ",23,56,7,", ",13,45,78,23,45,34,", ",13,45,78,23,45,34,56,"]
words.select { |word| word.match(/^,(\d+,){3,6}$/) }

# 10) Write a regex that matches lines of text that contain at least 3, but no more than 6, consecutive comma separated numbers. 
# In this exercise, you can assume that the first number on each line is not preceded by a comma, and the last number is not followed by a comma.
words = ["123,456,789,123,345", "123,456,,789,123", "23,56,7", "13,45,78,23,45,34", "13,45,78,23,45,34,56"]
words.select { |word| word.match(/^(\d+,){2,5}\d+$/) }

# 11) Write a regex that matches lines of text that contain either 3 comma separated numbers or 6 or more comma separated numbers. 
words = [ "123,456,789,123,345", "123,456,,789,123", "23,56,7", "13,45,78,23,45,34", "13,45,78,23,45,34,56"]
words.select { |word| word.match(/(^(\d+,){2}\d+$|^(\d+,){5,}\d+$)/) }

# 12) Write a regex that matches HTML h1 header tags and the content between the opening and closing tags. 
# If multiple header tags appear on one line, your regex should match the opening and closing tags and the text content of the headers, but nothing else. 
# You may assume that there are no nested tags in the text between <h1> and </h1>.
words = ["<h1>Main Heading</h1>", "<h1>Another Main Heading</h1>", "<h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1><p>Done</p>"]
words.select { |word| word.match(/<h1>.*?<\/h1>/) }
puts "We need to use a 'lazy' quantifier instead of the default greedy quantifier,
so that in our 3rd test case, the regex doesn't highlight the text in the <p> tag."
