# 1) Write a regex that matches an uppercase K in the following strings.
words = %w(Kx BlacK kelly)
words.select { |word| word.match(/K/) }

# 2) Write a regex that matches an uppercase or lowercase H.
words = %w(Henry perch golf)
words.select { |word| word.match(/h/i) }

# 3) Write a regex that matches the string dragon.
words = ['snapdragon', 'bearded dragon', 'dragoon']
words.select { |word| word.match(/dragon/)}

# 4) Write a regex that matches any of the following fruits: banana, orange, apple, strawberry. The fruits may appear in other words.
words = %w(banana orange pineapples strawberry raspberry grappler)
words.select { |word| word.match(/(banana|orange|apple|strawberry)/) }

# 5) Write a regex that matches a comma or space.
words = ['This line has spaces', 'This,line,has,commas,', 'No-spaces-or-commas']
words.select { |word| word.match(/( |,)/) }

# 6) Write a regex that matches blueberry or blackberry, but write berry precisely once. 
words = ['blueberry', 'blackberry', 'black berry', 'strawberry']
words.select { |word| word.match(/(black|blue)berry/) }