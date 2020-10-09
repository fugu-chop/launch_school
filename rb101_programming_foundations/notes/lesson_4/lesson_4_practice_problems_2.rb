# 1) Given the array below, turn this array into a hash where the names are the keys and the values are the positions in the array.
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

my_hash = Hash.new
flintstones.each_with_index do |element, index|
  my_hash[element] = index
end

# 2) Add up all of the ages from the Munster family hash.
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

sum_value = 0
ages.each do |_key, value| 
  sum_value += value
end
sum_value
# We could also use ages.values.inject(:+)

# 3) In the age hash, remove people with age 100 and greater.
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.select! { |_key, value| value < 100 }
# We could also use ages.keep_if { |_, age| age < 100 }

# 4) Pick out the minimum age from our current Munster family hash
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

min_age = ages.values[0]
ages.values.each do |value| 
  if value < min_age
    min_age = value
  end
end

min_age
# We could also use ages.values.min

# 5) Find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

person = ''
person_index = nil
flintstones.each_with_index do |element, index| 
  person = element
  person_index = index
  break if element =~ /Be/
end

person_index
# flintstones.index { |name| name[0, 2] == "Be" }

# 6) Amend this array so that the names are all shortened to just the first three characters
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |person| person[0, 3] }

# 7) Create a hash that expresses the frequency with which each letter occurs in this string (case sensitive). 
statement = "The Flintstones Rock"

count_hash = Hash.new
clean_statement = statement.delete(' ').chars

clean_statement.each do |letter|
  if count_hash.keys.include?(letter)
    count_hash[letter] += 1
  else
    count_hash[letter] = 1
  end 
end

count_hash

=begin
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end
=end

# 8) What happens when we modify an array while we are iterating over it? What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

puts "Modifying an array while iterating it is generally not a great idea, as it can change indices whilst the index is being used for evaluation. In the above example, the block would print out each number as it is removed from the array permanently, while the numbers array would be empty."

# 8b) What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

puts "This would print 1, 2, and the numbers array would be [1, 2], as by the time the each method would have reached the 3rd element, it has been removed from the numbers array, leaving nothing to iterate over."

# 9) Write your own version of the rails titleize implementation.
def titleize (sentence)
  sentence_array = sentence.split
  sentence_array.map { |word| word.capitalize }.join(' ')
end

# 10) Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+. 
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each_key do |key| 
  if munsters[key]["age"] <= 17
    munsters[key]["age_group"] = 'kid'
  elsif munsters[key]["age"] > 17 && munsters[key]["age"] <= 64
    munsters[key]["age_group"] = 'adult'
  else 
    munsters[key]["age_group"] = 'senior'
  end
end

=begin
munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end
=end
