# 1) What does the each method in the following program return after it is finished executing?
=begin
x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end
=end
puts "Per Ruby documentation, the .each method will always return the original array on which it is called"

# 2) Write a while loop that takes input from the user, performs an action, and only stops when the user types "STOP". Each loop can get info from the user.
puts "I am the annoyance machine. Only one response can save you. Type that response, or I'll keep annoying you"
resp = gets.chomp
while resp != "STOP"
  puts "Let's keep going! Type that response, or I'll keep annoying you!"
  resp = gets.chomp    
end

# 3) Write a method that counts down to zero using recursion.
def countdown(n)
  if n < 0
    puts n
    return "All done!"
  else 
    puts n
    countdown(n-1)
  end
end