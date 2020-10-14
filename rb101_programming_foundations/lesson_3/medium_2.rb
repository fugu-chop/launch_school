# 1) Predict how the values and object ids will change throughout the flow of the code below.
=begin
def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    puts

    a_outer = 22
    b_outer = "thirty three"
    c_outer = [44]
    d_outer = c_outer[0]

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    puts


    a_inner = a_outer
    b_inner = b_outer
    c_inner = c_outer
    d_inner = c_inner[0]

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    puts
  end

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end
=end

puts "The first set of puts statements will print:
a_outer is 42 with an id of: 85 before the block.
b_outer is forty two with an id of: 2152729580 before the block.
c_outer is [42] with an id of: 2152729540 before the block.
d_outer is 42 with an id of: 85 before the block."

puts "The second set of puts statements will print:
a_outer id was 85 before the block and is: 85 inside the block.
b_outer id was 2152729580 before the block and is: 2152729580 inside the block.
c_outer id was 2152729540 before the block and is: 2152729540 inside the block.
d_outer id was 85 before the block and is: 85 inside the block.

Note how the object_ids do not change - this is passing by reference."

puts "The third set of puts statements will print:
a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
b_outer inside after reassignment is thirty three with an id of: 2152729580 before and: 2152728320 after.
c_outer inside after reassignment is [44] with an id of: 2152729540 before and: 2152728280 after.
d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

Notice that changing the values has forced Ruby to create new objects and refer to them with the original variable names."

puts "The fourth set of puts statements will print:
a_inner is 22 with an id of: 45 inside the block (compared to 45 for outer).
b_inner is thirty three with an id of: 2152728320 inside the block (compared to 2152728320 for outer).
c_inner is [44] with an id of: 2152728280 inside the block (compared to 2152728280 for outer).
d_inner is 44 with an id of: 89 inside the block (compared to 89 for outer).

Notice that Ruby re-uses the objects under the hood when it can, but uses different ones for different values."

puts "The fifth set of puts statements will print:
a_outer is 22 with an id of: 85 BEFORE and: 45 AFTER the block.
b_outer is thirty three with an id of: 2152729580 BEFORE and: 2152728320 AFTER the block.
c_outer is [44] with an id of: 2152729540 BEFORE and: 2152728280 AFTER the block.
d_outer is 44 with an id of: 85 BEFORE and: 89 AFTER the block.

Notice that each variable keeps its new object/object_id even when we leave the block."

puts "The sixth set of puts statements will error out, since it does not have access to variables created within the block scope of the .times block."

# 2) Predict how the values and object ids will change throughout the flow of the code below:
=begin
def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)


  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call."
  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts
end

def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)

  puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method."
  puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method."
  puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method."
  puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method."
  puts

  a_outer = 22
  b_outer = "thirty three"
  c_outer = [44]
  d_outer = c_outer[0]

  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
  puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
  puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
  puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
  puts

  a_inner = a_outer
  b_inner = b_outer
  c_inner = c_outer
  d_inner = c_inner[0]

  a_inner_id = a_inner.object_id
  b_inner_id = b_inner.object_id
  c_inner_id = c_inner.object_id
  d_inner_id = d_inner.object_id

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer)."
  puts
end
=end
puts "The first set of puts statements will print:
a_outer is 42 with an id of: 85 before the block.
b_outer is forty two with an id of: 2152753560 before the block.
c_outer is [42] with an id of: 2152753540 before the block.
d_outer is 42 with an id of: 85 before the block."

puts "The second set of puts statements will print:
a_outer id was 85 before the method and is: 85 inside the method.
b_outer id was 2152753560 before the method and is: 2152753560 inside the method.
c_outer id was 2152753540 before the method and is: 2152753540 inside the method.
d_outer id was 85 before the method and is: 85 inside the method."

puts "The third set of puts statements will print:
a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
b_outer inside after reassignment is thirty three with an id of: 2152753560 before and: 2152752300 after.
c_outer inside after reassignment is [44] with an id of: 2152753540 before and: 2152752280 after.
d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after."

puts "The fourth set of puts statements will print:
a_inner is 22 with an id of: 45 inside the method (compared to 45 for outer).
b_inner is thirty three with an id of: 2152752300 inside the method (compared to 2152752300 for outer).
c_inner is [44] with an id of: 2152752280 inside the method (compared to 2152752280 for outer).
d_inner is 44 with an id of: 89 inside the method (compared to 89 for outer)."

puts "The fifth set of puts statements will print:
a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.
b_outer is forty two with an id of: 2152753560 BEFORE and: 2152753560 AFTER the method call.
c_outer is [42] with an id of: 2152753540 BEFORE and: 2152753540 AFTER the method call.
d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.

Even though we changed the values of our 'outer' variables inside the method call, we still have the same values and the same object id's down here AFTER the method call as we had before it!

This is because our method call accepts VALUES as arguments. The names we give to those values in the definition of our method are SEPARATE from any other use of those same names.

We used the same names there for convenience. We could just as easily have called the first parameter of our method definition a_Fred instead of a_outer.

The method gets the VALUES of the arguments we pass, but the parameter variables inside the method have no other relationship to those outside of the method."

puts "The sixth set of puts statements will error out, since it does not have access to variables created within the block scope of the an_illustrative_method method."

# 3) Study the following code and state what will be displayed...and why:
=begin
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
=end
puts "tricky_method will return 'pumpkins rutabaga' and ['pumpkins, 'rutabaga'].

my_string remains as 'pumpkins', since we have only passed the value associated with my_string into  tricky_method. Also, the method definition does not have access to variables initialised outside of it's scope. my_array is mutated due to the << method being applied. 

In both cases, Ruby passes the arguments 'by value', but unlike some other languages, the value that gets passed is a reference to some object. The string argument is passed to the method as a reference to an object of type String. Similarly, the array is passed to the method as a reference to an object of type Array.

The important distinction is that while a reference is passed, the method initializes a new local variable for both the string and the array and assigns each reference to the new local variables. These are variables that only live within the scope of the method definition.

The String#+= operation is re-assignment and creates a new String object. The reference to this new object is assigned to a_string_param. The local variable a_string_param now points to 'pumpkinsrutabaga, not 'pumpkins'. It has been re-assigned by the String#+= operation. This means that a_string_param and my_string no longer point to the same object.

With the array, one array object can have any number of elements. When we attach an additional element to an array using the << operator, Ruby simply keeps using the same object that was passed in, and appends the new element to it.
"

# 4) Study the following code and state what will be displayed...and why:
=begin
def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
=end
puts "my_string is now 'pumpkinsrutabaga', while an_array_param is [pumpkins]. This is opposite situation of our previous question, where the mutating method is applied to the 'pumpkins' object referenced by my_string, while an_array_param is a local variable that references a new array object compared with the object referenced when passed in as an argument. "

# 5) How can we refactor this practice problem to make the result easier to predict and easier for the next programmer to maintain?
=begin
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
=end
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# 6) How could the unnecessary duplication in this method be removed?
=begin
def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end
=end
def color_valid(color)
  color == 'blue' || color == 'green'
end

puts 'Ruby will automatically evaluate statements.'