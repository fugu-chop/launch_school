# https://www.codewars.com/kata/55953e906851cf2441000032/train/ruby
def scramble(word)
  word = word.chars.select do |letter|
    ('a'..'z').include?(letter)
  end.join
  first_letter = word[0]
  last_letter = word[-1]
  mid = word[1...-1].chars.sort.join
  first_letter + mid + last_letter
end

def scramble_words(sentence)
  sentence = sentence.split
  sentence.map do |word|
    scrambled = scramble(word).chars
    word.chars.map do |letter|
      if ('a'..'z').include?(letter)
        scrambled.shift
      else
        letter
      end
    end.join
  end.join(' ')
end

# https://www.codewars.com/kata/51e056fe544cf36c410000fb/train/ruby 
def cleaner(word)
  word.chars.each do |letter|
    if !('a'..'z').include?(letter)
      word.sub!(letter, '')
    else
      break
    end
  end

  return word if word.empty?

  end_idx = -1
  loop do 
    break if ('a'..'z').include?(word[end_idx])
    word.sub!(word[end_idx], '') if !('a'..'z').include?(word[end_idx])
    end_idx -= 1
  end

  word
end

def top_3_words(sentence)
  return [] if sentence.empty?
  sentence = sentence.downcase.split.map do |word|
    cleaner(word)
  end

  return [] if sentence.empty?

  word_counts = sentence.each_with_object(Hash.new(0)) do |word, hash|
    hash[word] += 1 if !word.empty?
  end

  word_counts.keys.max_by(3) do |key|
    word_counts[key]
  end
end

# https://www.codewars.com/kata/5a7f58c00025e917f30000f1
def longest(input)
  current_str = ''
  alpha_chars = []
  input.chars.each_index do |idx|
    if input.chars[idx + 1] != nil && input.chars[idx] <= input.chars[idx + 1]
      current_str << input.chars[idx]
    else
      current_str << input.chars[idx]
      alpha_chars << current_str
      current_str = ''
    end
  end
  alpha_chars << current_str
  alpha_chars.sort_by { |element| -element.length }.first
end

# https://www.codewars.com/kata/5b1b27c8f60e99a467000041
def anagram_difference(str1, str2)
  str1_dup, str2_dup = str1.dup, str2.dup
  str1_arr = str1.chars
  str2_arr = str2.chars

  str1_arr.each do |letter1|
    str2_dup.sub!(letter1, '') if str2_arr.include?(letter1)
  end

  str2_arr.each do |letter2|
    str1_dup.sub!(letter2, '') if str1_arr.include?(letter2)
  end

  str1_dup.length + str2_dup.length
end

# https://www.codewars.com/kata/53bb1201392478fefc000746
def find_suspects(suspects, allowed_items)
  return nil if suspects.empty?
  illegals = suspects.each_with_object([]) do |pair, arr|
    next if pair[1] == nil
    arr << pair[0] if pair[1].any? { |item| !allowed_items.include?(item) }
  end

  illegals.empty? ? nil : illegals
end

# https://www.codewars.com/kata/5894318275f2c75695000146/train/ruby
def alphabetized(input)
  input.chars.select do |letter|
    ('a'..'z').include?(letter.downcase)
  end.sort_by { |char| char.downcase }.join
end

# https://www.codewars.com/kata/58539230879867a8cd00011c/train/ruby
def find_children(people)
  people.chars.sort_by do |person|
    [person.downcase, person]
  end.join
end

# https://www.codewars.com/kata/56b5afb4ed1f6d5fb0000991
def reverse_it?(chunk_string)
  chunk_num = chunk_string.chars.map do |char|
    char.to_i
  end
  chunk_num.map do |digit|
    digit ** 3
  end.reduce(:+) % 2 == 0
end

def revrot(str, sz)
  return '' if sz <= 0 || str.length == 0 || sz > str.length
  str.chars.each_slice(sz).map do |slice|
    if slice.length < sz
      next
    elsif reverse_it?(slice.join)
      slice.reverse.join
    else 
      a = slice.shift
      slice << a
      slice.join
    end
  end.compact.join
end

# https://www.codewars.com/kata/56b861671d36bb0aa8000819/train/ruby
def reverse_word(pair)
  pair.map do |word|
    word.reverse
  end.join
end

def reverse_and_combine_text(string)
  string = string.split

  loop do 
    string = string.each_slice(2).map do |slice|
      reverse_word(slice)
    end
    break string.first if string.length == 1
  end
end

# https://www.codewars.com/kata/59fd6d2332b8b9955200005f/ruby
def solve(num, times)
  num = num.to_s

  times.times do |_|
    removal_digit = ''
    dig_arr = num.chars
    dig_arr.each_with_index do |digit, index|
      if dig_arr[index + 1] != nil && dig_arr[index] <= dig_arr[index + 1]
        next
      else
        break removal_digit = dig_arr[index]
      end
    end
    removal_digit == '' ? dig_arr.pop : num.sub!(removal_digit, '')
  end
  
  num
end