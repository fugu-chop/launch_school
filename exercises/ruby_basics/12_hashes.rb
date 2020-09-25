# 1) Create a hash that contains the following data and assign it to a variable named car.
=begin
type 	color 	mileage
sedan 	blue 	80_000
=end

car = {
  type: "sedan", 
  color: "blue", 
  mileage: 80000
}

# 2) Using the code below, add the key :year and the value 2003 to car.
car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80000
}

car[:year] = 2003

# 3) Using the following code, delete the key :mileage and its associated value from car.
car = {
  type:    'sedan',
  color:   'blue',
  mileage: 80000,
  year:    2003
}

car.delete(:year)

# 4) Using the following code, select the value 'blue' from car and print it with #puts.
car = {
  type:    'sedan',
  color:   'blue',
  year:    2003
}

puts car[:color]

# 5) Use Hash#each to iterate over numbers and print each element's key/value pair.
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

numbers.each do |key, value|
  puts "A #{key} number is #{value}."
end

# 6) Use Enumerable#map to iterate over numbers and return an array containing each number divided by 2. Assign the returned array to a variable named half_numbers and print its value using #p.
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

# Note that .map called on a hash returns an array!
half_numbers = numbers.map do |key, value|
  value / 2
end
p half_numbers

# 7) Use Hash#select to iterate over numbers and return a hash containing only key-value pairs where the value is less than 25. Assign the returned hash to a variable named low_numbers and print its value using #p.
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select do |key, value|
  value < 25
end
# Note how .select called on a hash returns a hash!
p low_numbers

# 8) In the following code, numbers isn't mutated because #select isn't a destructive method. However, there is a destructive version of #select named #select!. Modify the code to use #select! instead of #select.
=begin
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

low_numbers = numbers.select do |key, value|
  value < 25
end

p low_numbers
p numbers
=end
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

# The .select! method mutates the original hash, so we technically don't need a variable assignment here. 
low_numbers = numbers.select! do |key, value|
  value < 25
end
p low_numbers
p numbers

# 9) Create a nested hash using the following data.
=begin
Car
type 	color 	year
sedan 	blue 	2003

Truck
type 	color 	year
pickup 	red 	1998
=end

vehicle = {
  car: {type: 'sedan',color: 'blue', year: 2003},
  truck: {type: 'pickup', color: 'red', year: 1998}
}

# 10) Rewrite car as a nested array containing the same key-value pairs.
=begin
car = {
  type:  'sedan',
  color: 'blue',
  year:  2003
}
=end

car = [[:type, 'sedan'], [:color,'blue'], [:year, 2003]]