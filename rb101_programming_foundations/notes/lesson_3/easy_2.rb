# 1) See if "Spot" is present.
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.include?("Spot")

# 1b) Bonus: What are two other hash methods that would work just as well for this solution?
ages.key?("Spot")
ages.member?("Spot")

# 2) Convert the string in the following ways
munsters_description = "The Munsters are creepy in a good way."

# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.swapcase!

# "The munsters are creepy in a good way."
munsters_description.capitalize!

# "the munsters are creepy in a good way."
munsters_description.downcase!

# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.upcase!

# 3) Add the subsequent hash to the former
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)

# 4) See if the name "Dino" appears in the string
advice = "Few things in life are as important as house training your pet dinosaur."

advice.include?('Dino')
advice.match?('Dino')
# Note that this is not a perfect solution, as it would match any substring with Dino in it.

# 5) Show an easier way to write this array:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# 6) How can we add the family pet "Dino" to our usual array:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push('Dino')

# 7) How can we add multiple items to our array? (Dino and Hoppy)
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push('Dino', 'Hoppy')

# 8) Remove everything starting from "house". Make the return value "Few things in life are as important as ". But leave the advice variable as "house training your pet dinosaur.".
advice = "Few things in life are as important as house training your pet dinosaur."

advice.slice!(0, advice.index('house'))

# 9) Write a one-liner to count the number of lower-case 't' characters in the following string:
statement = "The Flintstones Rock!"

statement.count('t')

# 10)  If we had a 40 character wide table of Flintstone family members, how could we easily center that title above the table with spaces?
title = "Flintstone Family Members"

title.center(40)
