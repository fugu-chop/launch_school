# 1) Return the average of the given array rounded down to its nearest integer. The array will never be empty.
def get_average(marks)
  (marks.reduce(:+) / marks.length).floor
end

# 2) Given a string setence, reverse the order of the sentence.
def solution(sentence)
  sentence.split.reverse.join(' ')
end

# 3) Complete the square sum function so that it squares each number passed into it and then sums the results together.
def square_sum(numbers)
  numbers = [0] if numbers.length == 0
  numbers.reduce(0) do |accumulator, number|
    accumulator += number ** 2
  end
end

# 4) Write a function named setAlarm which receives two parameters. The first parameter, employed, is true whenever you are employed and the second parameter, vacation is true whenever you are on vacation. The function should return true if you are employed and not on vacation (because these are the circumstances under which you need to set an alarm). It should return false otherwise. 
def set_alarm(employed, vacation)
  employed && !vacation
end

# 5) Return an array containing elements which are the sum of the elements in two arrays
def array_plus_array(arr1, arr2)
  (arr1 + arr2).reduce(:+)
end

# 6) Bob is bored during his physics lessons so he's built himself a toy box to help pass the time. The box is special because it has the ability to change gravity. There are some columns of toy cubes in the box arranged in a line. The i-th column contains a_i cubes. At first, the gravity in the box is pulling the cubes downwards. When Bob switches the gravity, it begins to pull all the cubes to a certain side of the box, d, which can be either 'L' or 'R' (left or right).
def flip(dir, boxes)
  dir == 'R' ? boxes.sort : boxes.sort.reverse
end

# 7) Make a function that will return a greeting statement that uses an input; your program should return, "Hello, <name> how are you doing today?".
def greet(name)
  "Hello, #{name} how are you doing today?"
end

# 8) Clock shows 'h' hours, 'm' minutes and 's' seconds after midnight. Your task is to make 'Past' function which returns time converted to milliseconds. Input constraints: 0 <= h <= 23, 0 <= m <= 59, 0 <= s <= 59
def past(h, m, s)
  h * 3600000 + m * 60000 + s * 1000
end

# 9) You need to double the input integer
def double_integer(i)
  2 * i
end

# 10) Create a function which answers the question "Are you playing banjo?". If your name starts with the letter "R" or lower case "r", you are playing banjo! The function takes a name as its only argument, and returns one of the following strings. Names given are always valid strings.
=begin
name + " plays banjo" 
name + " does not play banjo"
=end
def are_you_playing_banjo(name)
  name[0].downcase == 'r' ? "#{name} plays banjo" : "#{name} does not play banjo" 
end

# 11) Nathan knows it is important to stay hydrated, he drinks 0.5 litres of water per hour of cycling. You get given the time in hours and you need to return the number of litres Nathan will drink, rounded to the smallest value.
def litres(time)
  (time * 0.5).floor
end

# 12) Given a set of numbers, return the additive inverse of each. Each positive becomes negatives, and the negatives become positives. You can assume that all values are integers. Do not mutate the input array/list.
=begin
invert([1,2,3,4,5]) == [-1,-2,-3,-4,-5]
invert([1,-2,3,-4,5]) == [-1,2,-3,4,-5]
invert([]) == []
=end
def invert(array)
  array.map { |num| num * -1 }
end

# 13) Write a program that finds the summation of every number from 1 to num. The number will always be a positive integer greater than 0.
=begin
summation(2) -> 3
1 + 2

summation(8) -> 36
1 + 2 + 3 + 4 + 5 + 6 + 7 + 8
=end
def summation(num)
  (1..num).reduce(:+)
end

# 14) Implement a function named generateRange(min, max, step), which takes three arguments and generates a range of integers from min to max, with the step. The first integer is the minimum value, the second is the maximum of the range and the third is the step. (min < max). Note that min < max, step > 0 & the range does not HAVE to include max (depending on the step)

=begin
generate_range(2, 10, 2) # should return array of [2,4,6,8,10]
generate_range(1, 10, 3) # should return array of [1,4,7,10]
=end
def generate_range(start, last, step)
  array = [start]

  while array.last + step <= last
    array << array.last + step
  end
  array
end

# 15) A hero is on his way to the castle to complete his mission. However, he's been told that the castle is surrounded with a couple of powerful dragons! each dragon takes 2 bullets to be defeated, our hero has no idea how many bullets he should carry. Assuming he's gonna grab a specific given number of bullets and move forward to fight another specific given number of dragons, will he survive? Return True if yes, False otherwise.
def hero(bullets, dragons)
  bullets >= 2 * dragons
end

# 16) Your task is to create function isDivideBy (or is_divide_by) to check if an integer number is divisible by each out of two arguments.
=begin
(-12, 2, -6)  ->  true
(-12, 2, -5)  ->  false
(45, 1, 6)    ->  false
(45, 5, 15)   ->  true
(4, 1, 4)     ->  true
(15, -5, 3)   ->  true
=end
def is_divide_by(number, a, b)
  number % a == 0 && number % b == 0
end

# 17) Suppose that the falling speed of a petal is 5 centimeters per second (5 cm/s), and it takes 80 seconds for the petal to reach the ground from a certain branch. Write a function that receives the speed (in cm/s) of a petal as input, and returns the time it takes for that petal to reach the ground from the same branch. If the initial velocity is non-positive, the return value should be 0.
def sakura_fall(velocity)
  distance = 5 * 80
  velocity <= 0 ? 0 : distance / velocity.to_f   
end

# 18) Define a method hello that returns "Hello, Name!" to a given name, or says Hello, World! if name is not given (or passed as an empty String). Assuming that name is a String and it checks for user typos to return a name with a first capital letter (Xxxx).
=begin
hello "john"   => "Hello, John!"
hello "aliCE"  => "Hello, Alice!"
hello          => "Hello, World!" # name not given
hello ''       => "Hello, World!" # name is an empty String
=end
def hello(name='World')
  name.length > 0 ? "Hello, #{name.downcase.capitalize}!" : "Hello, World!" 
end

# 19) checkAlive/CheckAlive/check_alive should return true if the player's health is greater than 0 or false if it is 0 or below. The function receives one parameter health which will always be a whole number between -10 and 10.
def check_alive(health)
  health > 0
end

# 20) You need a method, which returns the smallest unused ID for your next new data item. You use zero-based, non-negative IDs. Note: The given array of used IDs may be unsorted. For test reasons there may be duplicate IDs, but you don't have to find or remove them!
=begin
next_id([0,1,2,3,4,5,6,7,8,9,10]) # 11
next_id([5,4,3,2,1]) # 0
next_id([0,1,2,3,5]) # 4
next_id([0,0,0,0,0,0]) # 1
next_id([]) # 0
=end
def next_id(array)
  return 0 if array.length == 0
  ((0..array.max).to_a - array).first == nil ? array.max + 1 : ((0..array.max).to_a - array).first
end

# 21) You are given the length and width of a 4-sided polygon. The polygon can either be a rectangle or a square. If it is a square, return its area. If it is a rectangle, return its perimeter. Note: for the purposes of this kata you will assume that it is a square if its length and width are equal, otherwise it is a rectangle.
=begin
area_or_perimeter(6, 10) --> 32
area_or_perimeter(4, 4) --> 16
=end
def area_or_perimeter(length, width)
  return length ** 2 if length == width
  2 * (length + width)
end

# 22) 
