# 1) How would you use String#upcase to create an uppercase version of the string "xyz"?
"xyz".upcase

# 2) How would you use Array#insert to insert the numbers 5, 6, and 7 between the elements with values 'c' and 'd'?
a = %w(a b c d e)
a.insert(3, 5, 6, 7)

# 3) What will each of the statements print?
s = 'abc def ghi,jkl mno pqr,stu vwx yz'
# puts s.split.inspect
puts "This will print an array, where each 'block' of three characters is surrounded by a quote. The 'ghi,jkl' and 'pqr,stu` is not separated."
# puts s.split(',').inspect
puts "This will print an array, with three six letter blocks separated by a comma, surrounded by a quote."
# puts s.split(',', 2).inspect
puts "This will print an array, with 'abc def ghi' surrounded quotes. The remaining letters are chunked together, with the comma retained due to the '2' argument set as a limit."


