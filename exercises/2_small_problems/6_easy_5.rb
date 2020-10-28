# 1) Write a method that determines and returns the ASCII string value of a string that is passed in as an argument. The ASCII string value is the sum of the ASCII values of every character in the string. (You may use String#ord to determine the ASCII value of a character.)
=begin
ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0
=end
def ascii_value(str)
  str.chars.map { |char| char.ord }.reduce(0, :+)
end

# 2) The time of day can be represented as the number of minutes before or after midnight. If the number of minutes is positive, the time is after midnight. If the number of minutes is negative, the time is before midnight. Write a method that takes a time using this minute-based format and returns the time of day in 24 hour format (hh:mm). Your method should work with any integer input. You may not use ruby's Date and Time classes.
=begin
time_of_day(0) == "00:00"
time_of_day(-3) == "23:57"
time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"
=end
def time_of_day(integer)
  hour, minute = integer.divmod(60)

  if integer > 0
    while hour > 24 
      hour, _ = hour.divmod(24)
    end  
  elsif integer < 0
    while hour < -24
      hour, min = hour.divmod(24)
    end 
  end

  hour = min if integer < 0 && (hour != -24 && hour != -1)
  hour = 24 + hour if integer < 0 && hour < 0
  
  hour = hour.to_s
  minute = minute.to_s
  [hour, minute].map do |element|
    element.prepend('0') if element.length < 2
  end
  "#{hour}:#{minute}"
end

# Suggested solution
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def time_of_day(delta_minutes)
  delta_minutes =  delta_minutes % MINUTES_PER_DAY
  hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, minutes)
end

# 3) Write two methods that each take a time of day in 24 hour format, and return the number of minutes before and after midnight, respectively. Both methods should return a value in the range 0..1439
=begin
after_midnight('00:00') == 0
before_midnight('00:00') == 0
after_midnight('12:34') == 754
before_midnight('12:34') == 686
after_midnight('24:00') == 0
before_midnight('24:00') == 0
=end

def after_midnight(time)
  arr = time.split(':').map(&:to_i)
  (60 * arr[0] + arr[1]) % 1440
end

def before_midnight(time)
  arr = time.split(':').map(&:to_i)
  (1440 - (60 * arr[0] + arr[1])) % 1440
end

# 4) Given a string of words separated by spaces, write a method that takes this string of words and returns a string in which the first and last letters of every word are swapped. You may assume that every word contains at least one letter, and that the string will always contain at least one word. You may also assume that each string contains nothing but words and spaces.
=begin
swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
swap('Abcde') == 'ebcdA'
swap('a') == 'a'
=end

def swap(str)
  arr = str.split
  new_arr = arr.each do |element|
    first_char = element[0]
    end_char = element[-1]
    element[0] = end_char
    element[-1] = first_char
  end
  new_arr.join(' ')
end

# Suggested solution
def swap_first_last_characters(word)
  # the a, b = b, a allows exchange of elements
  # When Ruby sees something like this, it effectively creates a temporary array with the values from the right side ([b, a]), and then assigns each element from that array into the corresponding named variable.
  word[0], word[-1] = word[-1], word[0]
  word
end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word)
  end
  result.join(' ')
end

# 4) How come our solution passes word into the swap_first_last_characters method invocation instead of just passing the characters that needed to be swapped? Suppose we had this implementation and just called swap_first_last_characters(word[0], word[-1]) directly - what would happen?
=begin
def swap_first_last_characters(a, b)
  a, b = b, a
end
=end

puts "Calling the swap_first_last_characters method itself wouldn't work, since it would only work on the very first and last character of the string. The map method is required to apply this change to each word in a string, by breaking up the words in the string into elements of an array."

# 5) Given a string that consists of some words (all lowercased) and an assortment of non-alphabetic characters, write a method that returns that string with all of the non-alphabetic characters replaced by spaces. If one or more non-alphabetic characters occur in a row, you should only have one space in the result (the result should never have consecutive spaces).
=begin
cleanup("---what's my +*& line?") == ' what s my line '
=end

def cleanup(str)
  str.gsub(/\W/, ' ').squeeze(' ')
end

# 5b) Try writing the same method, without regex
def cleanup(str)
  alphabet = ('a'..'z')
  clean_chars = []
  str.chars.each do |element|
    if alphabet.include?(element)
      clean_chars << element
    else
      clean_chars << ' ' unless clean_chars.last == ' '
    end
  end
  clean_chars.join
end

# 6) Write a method that takes a string with one or more space separated words and returns a hash that shows the number of words of different sizes. Words consist of any string of characters that do not include a space.
=begin
word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
word_sizes('') == {}
=end

def word_sizes(str)
  words_hash = Hash.new
  str.split(' ').each do |el|
    if words_hash[el.length]
      words_hash[el.length] += 1
    else
      words_hash[el.length] = 1
    end
  end
  words_hash
end

# Suggested solution
# If we initialize counts as {}, we will get an exception the first time counts[word.size] += 1 is executed. This is because that element doesn't exist, so counts[word.size] returns nil, and nil cannot be added to 1. To fix this, we use the default value form of initializing counts - counts = Hash.new(0), which forces any references to non-existing keys in counts to return 0.
def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    counts[word.size] += 1
  end
  counts
end

# 7) Modify the word_sizes method from the previous exercise to exclude non-letters when determining word size. For instance, the length of "it's" is 3, not 4.
=begin
word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
word_sizes('') == {}
=end
def word_sizes(str)
  words_hash = Hash.new
  str.gsub(/[^a-zA-Z\s]/, '').split(' ').each do |el|
    if words_hash[el.length]
      words_hash[el.length] += 1
    else
      words_hash[el.length] = 1
    end
  end
  words_hash
end

# Suggested solution
def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    clean_word = word.delete('^A-Za-z')
    counts[clean_word.size] += 1
  end
  counts
end

# 8) Write a method that takes an Array of Integers between 0 and 19, and returns an Array of those Integers sorted based on the English words for each number - zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
=begin
alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]
=end

def alphabetic_number_sort(arr)
  values = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  arr.sort_by { |number| values[number] }
end

# For an extra challenge, rewrite your method to use Enumerable#sort
def alphabetic_number_sort(arr)
  values = %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  arr.sort do |a, b|
    values[a] <=> values[b]
  end
end

# 9) Write a method that takes a string argument and returns a new string that contains the value of the original string with all consecutive duplicate characters collapsed into a single character. You may not use String#squeeze or String#squeeze!.
=begin
crunch('ddaaiillyy ddoouubbllee') == 'daily double'
crunch('4444abcabccba') == '4abcabcba'
crunch('ggggggggggggggg') == 'g'
crunch('a') == 'a'
crunch('') == ''
=end

def crunch(str)
  chars_to_keep = str[0]
  str.chars.each do |letter|
    chars_to_keep << letter if chars_to_keep[-1] != letter
  end
  chars_to_keep
end

#10 Write a method that will take a short line of text, and print it within a box.
=begin
print_in_box('To boldly go where no one has gone before.')
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

print_in_box('')
+--+
|  |
|  |
|  |
+--+
=end

def print_in_box(str)
  edge = "+#{'-' * (str.length + 2)}+"
  space = "|#{' ' * (str.length + 2)}|"

  puts edge
  puts space
  puts "| #{str} |"
  puts space
  puts edge
end

# 10b) Modify this method so it will truncate the message if it will be too wide to fit inside a standard terminal window (80 columns, including the sides of the box). 
def print_in_box(str)
  max_text_length = 76
  str = str[0..76] if str.length > max_text_length
  edge = "+#{'-' * (str.length + 2)}+"
  space = "|#{' ' * (str.length + 2)}|"

  puts edge
  puts space
  puts "| #{str} |"
  puts space
  puts edge
end

# 10c) For a real challenge, try word wrapping very long messages so they appear on multiple lines, but still within a box.
def print_in_box(str)
  max_text_length = 76
  length_to_use = [max_text_length, str.length + 4]
  string_holder = []

  str.chars.each_slice(74) do |block|
    string_holder << block
  end

  string_holder.map! do |element|
    element.join
  end

  edge = "+#{'-' * (length_to_use.min)}+"
  space = "|#{' ' * (length_to_use.min)}|"

  puts edge
  puts space
  string_holder.each { |el| puts "| #{el}#{' ' * (max_text_length - (el.length + 1))}|" }
  puts space
  puts edge
end

# 11 You are given a method named spin_me that takes a string as an argument and returns a string that contains the same words, but with each word's characters reversed. Given the method's implementation, will the returned string be the same object as the one passed in as an argument or a different object?
=begin
def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

spin_me("hello world") # "olleh dlrow"
=end

puts "Your initial hunch might have been that the method will return the same string object. Since we are using mutating method String#reverse! inside of the do..end block, and we are also calling each method on the resulting array, which also returns the original array.

However, as soon as we have converted string into an array by calling split method on it, it is no longer possible for us to get back the original object again. Even just doing str.split.join(" ") returns a different object since you are splitting the string into an array and then joining that array back into a new string, with the same sequence of characters but still, a different object.

Let's also break down what happens inside of the spin_me method. str.split converts the string into array ['hello', 'world']. When we call each method on this array and reverse each word inside of the array, our original array gets mutated and now it's values are ['olleh', 'dlrow'].

So we have mutated the array that we got by splitting the string, but, when we join this array back into a string, a completely new string is returned.

However, if we rework this method to use an array argument instead of a string and we reversed each word in it by calling the same methods, then the array that was passed in as an argument and the array that was returned from the method would be the same object."