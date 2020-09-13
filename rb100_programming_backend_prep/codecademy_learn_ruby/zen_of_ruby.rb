# One liner code
ruby_is_eloquent = true
ruby_is_ugly = false

puts "Ruby is eloquent!" if ruby_is_eloquent
puts "Ruby's not ugly!" unless ruby_is_ugly

# Ternary operator
puts true ? "I am the best":"I am a fool"

# Folded case when
language = "Python"

case language
  when "JS" then puts "Websites!"
  when "Python" then puts "Science!"
  when "Ruby" then puts "Web apps!"
  else puts "I don't know!"
end

# Implicit return. Note that if you have multiple statements to return, only the last one will be implicit (last evaluated expression)
def add(a, b)
  a + b
end

puts add(1,2)

# Respond (Check whether an object will respond to a method)
puts [1, 2, 3].respond_to?(:to_sym)

# Next (Increment an integer)
puts 7.next

# Push (appending items to an array - also works for strings)
puts [1, 2, 3].push(4)
puts [1, 2, 3] << 6
puts "I am the best" << " person"
