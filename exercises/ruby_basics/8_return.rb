# 1) What will the following code print? Why?
=begin
def meal
  return 'Breakfast'
end

puts meal
=end
puts "The method will print 'breakfast'"

# 2) What will the following code print? Why?
=begin
def meal
  'Evening'
end

puts meal
=end
puts "The method will print 'Evening'"

# 3) What will the following code print? Why?
=begin
def meal
  return 'Breakfast'
  'Dinner'
end

puts meal
=end
puts "The method will print 'Breakfast', since the method will exit once 'Breakfast' is returned."

# 4) What will the following code print? Why?
=begin
def meal
  puts 'Dinner'
  return 'Breakfast'
end

puts meal
=end
puts "The method will print Dinner Breakfast. The method itself will print 'Dinner' when executed due to the puts method, while puts will also print out whatever is returned by the function."

# 5) What will the following code print? Why?
=begin
def meal
  'Dinner'
  puts 'Dinner'
end

p meal
=end
puts "The method will print Dinner, followed by nil. The p method does not convert outputs to strings, and will print both puts and returned values. A method will also always return the last line of code inside of it, unless return is explicitly called. The 'Dinner' above the puts method doesn't do anything, nor is it returned."

puts "In sequence, meal is defined. When we call meal (which is effectively the same thing as 'p meal'), it puts 'Dinner' as part of it's execution, and also prints nil (since puts returns nil, and p does not convert to string). Remember that a method can print a value, then return a different one."

# 6) What will the following code print? Why?
=begin
def meal
  return 'Breakfast'
  'Dinner'
  puts 'Dinner'
end

puts meal
=end
puts "The return keyword will trigger the method to end - thus the lines below return will not be executed. 'Breakfast' will be printed."

# 7) What will the following code print? Why?
=begin
def count_sheep
  5.times do |sheep|
    puts sheep
  end
end

puts count_sheep
=end
puts "The method will print out 0 1 2 3 4 5 on different lines. This is because in a .times method, |sheep| represents the range of numbers 0-4. The .times method also returns the original integer it was defined with - in this case, 5, because this is the last line (i.e returned) in the .times block."

# 8) What will the following code print? Why?
=begin
def count_sheep
  5.times do |sheep|
    puts sheep
  end
  10
end

puts count_sheep
=end
puts "This method will print out 0, 1, 2, 3, 4, 10. Although the .times block still returns a 5, nothing is done with it. Since 10 is the last line in this method, it will be returned and printing with puts."

# 9) What will the following code print? Why?
=begin
def count_sheep
  5.times do |sheep|
    puts sheep
    if sheep >= 2
      return
    end
  end
end

p count_sheep
=end
puts "The method will print 0, 1, 2, nil. The return keyword will break out of the method once the if condition is met, which is when sheep == 2. Since return doesn't provide a value, it defaults to returning nil, which is visible only if we use p (i.e. puts will print a blank line)."

# 10) What will the following code print? Why?
=begin
def tricky_number
  if true
    number = 1
  else
    2
  end
end

puts tricky_number
=end
puts "This method will return 1. As there's no explicit return keyword, the variable assignment will be returned. The value of a variable assignment is what is returned - here, 1." 

puts "There is no issue with the variable 'number' not being defined - method definitions create their own scope, and no other variables that are inaccessible to the method scope are being used, so the variable assignment to 'number' is valid (since we are creating 'b' in the local method scope). If we had assigned another variable to 'number' that was inaccessible to the method scope (e.g. b), then we would encounter an exception."