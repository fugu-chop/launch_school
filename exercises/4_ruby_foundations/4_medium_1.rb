# 1) Finish the code so that it meets the requirements. Anything that is said is retrieved by this listening device via a block. If nothing is said, then no block will be passed in. The listening device can also output the most recent recording using a Device#play method.
=begin
listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
=end
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def play
    puts @recordings.last
  end

  def listen
    # We need this because the test case indicates we're able to call the method without a LocalJumpError being raised if no block is provided
    return if !block_given?
    # Capture the return value of the block (remember that blocks return values)
    recording = yield
    record(recording)
  end
end

# 2) Fill out the rest of the Ruby code below so it prints output like that shown in "Sample Output." You should read the text from a simple text file that you provide.
=begin
# Based on the sample text
3 paragraphs
15 lines
126 words
=end
class TextAnalyzer
  def process
    return if !block_given?
    file = File.open('sample_text.txt', 'r')
    # This leaves blank lines as an empty string element in our array, which is useful for counting total lines
    yield(file.readlines.map(&:chomp))
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |file| puts "#{file.count("") + 1} paragraphs" }
analyzer.process { |file| puts "#{file.size} lines" }
analyzer.process { |file| puts "#{file.reduce(0) { |accum, line| accum += line.split.size } } words" }

# Suggested solution
class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    # We don't strip out new lines for this implementation
    yield(file.read)
    file.close
  end
end

analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(' ').count} words" }

# 3) Modify the method below so that the display/output of items is moved to a block, and its implementation is left up to the user of the gather method.
def gather(items)
  puts "Let's start gathering food."
  # Remember, we don't always have to yield one item at a time
  yield(items)
  puts "Nice selection of food we have gathered!"
end

gather(['apples', 'corn', 'cabbage', 'wheat']) { |items| puts items.join(', ') }

# 4) Write a method that takes an array as an argument. The method should yield the contents of the array to a block, which should assign your block variables in such a way that it ignores the first two elements, and groups all remaining elements as a raptors array.
def grouper(arr)
  yield(arr)
end

# Same principle as when we iterate through a hash, but don't use one of the key or value assigned as a block variable
grouper(%w(raven finch hawk eagle)) do |_, _, *raptors| 
  puts "Raptors: #{raptors.join(', ')}"
end

# 5) Fill out the following method calls for gather so that they produce the corresponding output.
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

# 5a) Complete the code to achieve the output:
=begin
Let's start gathering food.
apples, corn, cabbage
wheat
We've finished gathering!
=end
gather(items) do |*first, last|
  puts first.join(', ')
  puts last
end

# 5b) Complete the code to achieve the output:
=begin
Let's start gathering food.
apples
corn, cabbage
wheat
We've finished gathering!
=end
gather(items) do |first, *mid, last|
  puts first
  puts mid.join(', ')
  puts last
end

# 5c) Complete the code to achieve the output:
=begin
Let's start gathering food.
apples
corn, cabbage, wheat
We've finished gathering!
=end
gather(items) do |first, *last|
  puts first
  puts last.join(', ')
end

# 5d) Complete the code to achieve the output:
=begin
Let's start gathering food.
apples, corn, cabbage, and wheat
We've finished gathering!
=end
gather(items) do |a,b,c,d|
  puts [a, b, c].join(', ') + " and #{d}"
end

# 6) Fill in the missing part of the following code so we can convert an array of integers to base 8 (octal numbers). It's enough to know that octal numbers use the digits 0-7 only, much as decimal numbers use the digits 0-9. Thus, the octal number 10 is equivalent to the decimal number 8, octal 20 is the same as decimal 16, octal 100 is the same as decimal 64, and so on. 
=begin
def convert_to_base_8(n)
  n.method_name.method_name # replace these two method calls
end

# The correct type of argument must be used below
base8_proc = method(argument).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc` with the correct object
[8, 10, 12, 14, 16, 33].map(&a_proc)

[10, 12, 14, 16, 20, 41]
=end
def convert_to_base_8(n)
  # The #to_s method converts an integer to Base 8
  n.to_s(8).to_i
end

# We can convert methods to procs with Method#to_proc. This requires a Method object, which we create with Object#method(:method_name) 
base8_proc = method(:convert_to_base_8).to_proc

[8, 10, 12, 14, 16, 33].map(&base8_proc)

# The equivalent code (i.e. without using Method#to_proc)
Proc.new { |n| n.to_s(8).to_i }

# When we use & to convert our Proc to a block, it expands out to
[8, 10, 12, 14, 16, 33].map { |n| n.to_s(8).to_i }

# 7) Your task in this assignment is to modify #bubble_sort! so it takes an optional block that determines which of two consecutive elements will appear first in the results.
=begin
array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
=end
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    # Necessary to break out of the loop if no sorting is needed (as swapped will never be set to true due to the next argument)
    break unless swapped
  end
  nil
end

# 7b) Modify your solution so it only passes one element to the block at a time; the block should perform some sort of transformation to the argument, and #bubble_sort! itself should just use <= to compare two values.
=begin
array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
=end
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?= 
        next if yield(array[index - 1]) <= yield(array[index])
      else
        next if array[index - 1] <= array[index]
      end
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end
