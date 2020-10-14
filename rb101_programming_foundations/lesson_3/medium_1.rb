# 1) Write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:
=begin
The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!
=end

10.times { |number| puts (' ' * number) + 'The Flintstones Rock!' }

# 2) The result of the following statement will be an error. Why is this and what are two possible ways to fix this?
# puts "the value of 40 + 2 is " + (40 + 2)
puts "This will result in an error because this expression is trying to concatenate strings and integers, which Ruby does not allow. One way to solve this is to convert 40 + 2 to a string using the to_s method after (40+2). The other is to use string interpolation."

# 3) Alan wrote the following method, which was intended to show all of the factors of the input number. How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

=begin
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end
=end

def factors(number)
  divisor = number
  factors = []
  until divisor == 0 do
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# 3A) What is the purpose of the number % divisor == 0 ?
puts "The 'number % divisor == 0' line is intended to see if the number can be divided by the divisor without leaving a remainder, thus checking whether the divisor is a factor of the number."

# 3B) What is the purpose of the second-to-last line in the method (the factors before the method's end)?
puts "The second to last line is intended to return an array of the number's factors after the method is finished executing."

# 4) Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?
=begin
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end
=end

puts "The difference between the first and second methods is that since the buffer variable is initialised within the method definition for rolling_buffer_2, when we execute the second method, it does not mutate any variables outside of it's method scope. This means that the input_array does not accurately reflect the size of the buffer after the method is run"

# 5) Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?
=begin
limit = 15

def fib(first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"
=end
puts "Method definitions create their own scope. Variables defined outside of the method definition scope cannot be accessed within that method's scope. In order to access the limit variable, we either need to define it within the method, or pass it as an argument to the fib method."

# 6) What is the output of this code?
=begin
answer = 42
def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)
p answer - 8
=end
puts "answer will equal to 34. When we pass in variables initialised in the outer scope as an argument, the parameter assigned to it acts as a pointer to the original object. Ruby does not create a copy of the object, and hence the reassignment operator does not mutate the original object, but rather adds 8 to another object pointing to the 42 object."

# 7) Does this method mutate the hash?
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

puts "This method will mutate the original hash, since this is not an assignment, but a method call to the hash class. While the values of the hash will have different object_ids, the original hash is permanently mutated (and will have the same object id)."

# 8) What is the result of this method call?
=begin
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
=end
puts "This method should print paper"

# 9) Consider the two methods. What is the return value of the method invocation below
=begin
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo)
=end
puts "This method should return no. The foo method will always return yes."

