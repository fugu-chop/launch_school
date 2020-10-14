# 1) What do you expect to happen when the greeting variable is referenced in the last line of the code below?
if false
  greeting = “hello world”
end

greeting

puts 'Typically, when you reference an uninitialized variable, Ruby will raise an exception, stating that it’s undefined. However, when you initialize a local variable within an if block, even if that if block doesn’t get executed, the local variable is initialized to nil.'

# 2) What is the result of the last line in the code below?
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

puts "greetings will return { a: 'hi there' }. A setter is used to mutate the greetings[:a] object, which is referenced by informal_greeting. However, since informal_greeting is referencing the original greetings[:a] object, mutations performed to informal_greeting will also apply to greetings."

# 3) What will be printed by each of these code groups?
=begin
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
=end

puts "The puts statements will print 
one is one
two is two
three is three
This is because local variables initialised in a method definition are confined to operating in that scope. We pass in references to the one, two and three objects, which the method then initialises local variables with references to the 'one', 'two' and 'three' values passed in. The variables outside the method are unaffected."

# 3b)
=begin
def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
=end
puts "The puts statement will print
one is one
two is two
three is three
This is because again, variables initialised within a method definition are local to that method only. When we pass in references to 'one', 'two', 'three' as arguments, the variables initialised are different to those outside of the method."

# 3c) 
=begin
def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
=end
puts "The puts statements will display
one is two
two is three
three is one
This is because the mess_with_vars method accepts references to objects as arguments. Once these references are passed in as arguments, the .gsub! method mutates those original objects."

# 4) Help Ben fix his code. You're not returning a false condition, and you're not handling the case that there are more or fewer than 4 components to the IP address.
=begin
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end
=end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  if dot_separated_words.length == 4
    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      return false unless is_an_ip_number?(word)
    end
    true
  else
    false
  end
end