# 1) Make a madlibs program that reads in some text from a text file that you have created, and then plugs in a selection of randomized nouns, verbs, adjectives, and adverbs into that text and prints it. You can build your lists of nouns, verbs, adjectives, and adverbs directly into your program, but the text data should come from a file or other external source. Your program should read this text, and for each line, it should place random words of the appropriate types into the text, and print the result.
def madlibs(filename = 'madlibs.txt') 

  filename = 'madlibs.txt'
  ADJECTIVES = %w(quick lazy sleepy ugly)
  NOUNS = %w(fox dog head leg)
  VERBS = %w(jumps lifts bites licks)
  ADVERBS = %w(easily lazily noisily excitedly)
  
  f = File.open(filename)
  # When we iterate through a File object, the argument passed to the block is a string, delimited by \n
  f.map do |line|
    # Remember that we can do multiple things within a block!
    line.gsub!('%{adjective}', ADJECTIVES.sample)
    line.gsub!('%{noun}', NOUNS.sample)
    line.gsub!('%{verb}', VERBS.sample)
    line.gsub!('%{adverb}', ADVERBS.sample)
    line
  end
  f.close
end

# Suggested solution
f.each do |line|
    # The format method lets you put strings of the form %{name} inside your format string, and then provide a bunch of keyword arguments. Each of the keyword arguments is matched to one of the %{name} strings, and if the name matches, the value associated with that name is plugged in.
    puts format(line, noun:      NOUNS.sample,
                      verb:      VERBS.sample,
                      adjective: ADJECTIVES.sample,
                      adverb:    ADVERBS.sample)
  end

# 2) Write a method that displays an 8-pointed star in an nxn grid, where n is an odd integer that is supplied as an argument to the method. The smallest such star you need to handle is a 7x7 grid.
=begin
star(7)

*  *  *
 * * *
  ***
*******
  ***
 * * *
*  *  *

star(9)

*   *   *
 *  *  *
  * * *
   ***
*********
   ***
  * * *
 *  *  *
*   *   *

star(11)
*    *    *
 *   *   *
  *  *  *
   * * *   
    ***
***********
    ***
   * * *
  *  *  *
 *   *   *
*    *    *
=end
def upper(spaces)
  0.upto(spaces - 1) do |num|
    puts ' ' * num + "*" + ' ' * (spaces - num - 1) + '*' + ' ' * (spaces - num - 1) + '*'
  end
end

def lower(spaces)
  (spaces - 1).downto(0) do |num|
    puts ' ' * num + "*" + ' ' * (spaces - num - 1) + '*' + ' ' * (spaces - num - 1) + '*'
  end
end

def star(num)
  return "The argument needs to be an odd integer object, 7 or greater" if num < 7 ||
    !num.instance_of?(Integer) ||
    !num.odd?

  spaces = (num / 2).floor
  upper(spaces)
  puts '*' * num
  lower(spaces)
end

# Suggested solution
grid_size = 9
distance_from_center = 4
def print_row(grid_size, distance_from_center)
  number_of_spaces = distance_from_center - 1
  spaces = ' ' * number_of_spaces
  output = Array.new(3, '*').join(spaces)
  # The center method appends and prepends spaces to the string, depending on how wide we want the output string to be
  puts output.center(grid_size)
end

def star(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(1) { |distance| print_row(grid_size, distance) }
  puts '*' * grid_size
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

# 2) Write a method that takes a 3 x 3 matrix in Array of Arrays format and returns the transpose of the original matrix. Note that there is a Array#transpose method that does this -- you may not use it for this exercise. You also are not allowed to use the Matrix class from the standard library. Your task is to do this yourself. Take care not to modify the original matrix: you must produce a new matrix and leave the original matrix unchanged.
=begin
matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]
=end
def transpose(matrix)
  new_matrix = []
  0.upto(2) do |counter|
    new_matrix << matrix.map do |el|
      el[counter]
    end
  end
  new_matrix
end

# 2b) Write a transpose! method that transposes a matrix in place. 
def transpose!(matrix)
  0.upto(2) do |row|
    0.upto(2) do |col|
      matrix[row][col], matrix[col][row] = matrix[col][row], matrix[row][col] if row < col
    end
  end
end

=begin
# Skipping steps when row >= col
[[1, 5, 8], [4, 7, 2], [3, 9, 6]]
matrix[0][1], matrix[1][0]
5, 4 = 4, 5
[[1, 4, 8], [5, 7, 2], [3, 9, 6]]
matrix[0][2], matrix[2][0]
8, 3 = 3, 8
[[1, 4, 3], [5, 7, 2], [8, 9, 6]]
matrix[1][2], matrix[2][1]
2, 9 = 9, 2
[[1, 4, 3], [5, 7, 9], [8, 2, 6]]
=end

# 3) Modify your transpose method from the previous exercise so it works with any matrix with at least 1 row and 1 column.
=begin
transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
transpose([[1]]) == [[1]]
=end
def transpose(matrix)
  result = []
  # The trickiest part of this is naming the variables so we know what are rows and columns
  number_of_rows = matrix.size
  number_of_columns = matrix.first.size
  # Remember, the outer loop holds constant while the inner loop continues to iterate
  (0...number_of_columns).each do |column_index|
    # Here, map returns an array of all the returned values
    new_row = (0...number_of_rows).map { |row_index| matrix[row_index][column_index] }
    result << new_row
  end
  result
end

# 4) Write a method that takes an arbitrary matrix and rotates it 90 degrees clockwise
=begin
matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2
=end
def rotate90(matrix)
  new_mat = []
  rows = matrix.size - 1
  columns = matrix.first.size - 1
  (0..columns).each do |col|
    new_mat << (0..rows).to_a.map do |row|
      matrix[row][col]
    end.reverse
  end

  new_mat
end

# 3b) Can you modify your solution to perform 90, 180, 270, and 360 degree rotations based on an argument?
def rotate(matrix, times)
  rows = matrix.size - 1
  columns = matrix.first.size - 1

  new_mat = []

  return matrix if times == 0
  rotations = (times / 90).floor

  rotations.times do |_|
    new_mat = []
    # Need to somehow use new_mat instead of matrix
    (0..columns).each do |col|
      new_mat << (0..rows).to_a.map do |row|
        matrix[row][col]
      end.reverse
    end
    matrix = new_mat
  end
  new_mat
end
