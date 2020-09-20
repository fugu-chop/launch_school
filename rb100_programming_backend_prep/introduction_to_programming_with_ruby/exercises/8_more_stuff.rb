# 1) Write a program that checks if the sequence of characters "lab" exists in the following strings. If it does exist, print out the word.
string = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

string.each do |word|
  if word.match("lab")
    p word
  end
end

# 2) What will the following program print to the screen? What will it return?
=begin
def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }
=end
puts "This method won't print anything, since there's no .call method on the block parameter. It will return a Proc object."

# 3) What is exception handling and what problem does it solve?
puts "Exception handling is building in the ability for a program to handle unexpected inputs without stopping execution of the overall program"

# 4) Modify the code in exercise 2 to make the block execute properly.
def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

# 5) Why does the following code give us the following error when we run it?
=begin
def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

block.rb1:in `execute': wrong number of arguments (0 for 1) (ArgumentError) from test.rb:5:in `<main>'
=end
puts "The error occurs because we have not put a `&` sign on the block argument in the execute method. Without this symbol, the block cannot be passed as a parameter. The method is just expecting a regular variable and so the error indicates that an argument hasn't been provided, when the method is expecting one."