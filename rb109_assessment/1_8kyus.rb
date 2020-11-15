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