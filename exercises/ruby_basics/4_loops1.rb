# 1) The code below is an example of an infinite loop. Modify the code so the loop stops after the first iteration.
=begin
loop do
  puts 'Just keep printing...'
end
=end
loop do
  puts 'Just keep printing...'
  break
end

# 2) The code below is an example of a nested loop. Both loops currently loop infinitely. Modify the code so each loop stops after the first iteration.
=begin
loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
  end
end

puts 'This is outside all loops.'
=end
loop do
  puts 'This is the outer loop.'
  loop do
    puts 'This is the inner loop.'
    break
  end
  break
end
puts 'This is outside all loops.'

# 3) Modify the following loop so it iterates 5 times instead of just once.
=begin
iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  break
end
=end
iterations = 1

loop do 
  puts "Number of iterations = #{iterations}"
  iterations += 1
  if iterations > 5
    break
  end
end