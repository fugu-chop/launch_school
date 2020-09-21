# 1) What will the following code print and why?
=begin
a = 7

def my_value(b)
  b += 10
end

my_value(a)
puts a
=end
puts "a will take the value of 7. Reassignment, including assignment operators like +=, does not mutate a variable; instead, it binds the variable to a new object. That is, += sets the variable to point to a different object."

puts "Another way to look at this is that numbers in Ruby are immutable. Thus, there is no way for my_value to mutate the value referenced by b, which means that my_value does not (and can not) change the object referenced by a"

# 2) What will the following code print and why?
=begin
a = 7

def my_value(a)
  a += 10
end

my_value(a)
puts a
=end
puts "a will take the value of 7. Reassignment, including assignment operators like +=, does not mutate a variable; instead, it binds the variable to a new object. That is, += sets the variable to point to a different object."

puts "We can do this because method definitions are self-contained with respect to local variables. Local variables outside the method definition are not visible inside the method definition; so the top level a is not available inside my_value. Furthermore, local variables inside the method definition are not visible outside the method definition; so the a inside my_value is a local variable with no top-level visibility."

# 3) What will the following code print, and why?
=begin
a = 7

def my_value(b)
  a = b
end

my_value(a + 5)
puts a
=end
puts "my_value should return 12, whereas a should print 7. The local variable a inside the my_value method definition is not visible outside the my_value method definition. Furthermore, the local variable a at the top level is not visible inside my_value because method definitions are self-contained with respect to local variables."

# 4) What will the following code print, and why?
=begin
a = "Xyzzy"

def my_value(b)
  b[2] = '-'
end

my_value(a + "y")
puts a
=end
puts "a will return Xy-zy. Strings are mutable - they can be modified. b[2] is a mutating method. Since we are actually modifying the string referenced by b, and b references the same string as a, the result from printing a shows an update to the value of the string."

# 5) What will the following code print, and why?
=begin
a = "Xyzzy"

def my_value(b)
  b = 'yzzyX'
end

my_value(a)
puts a
=end
puts "a will return Xyzzy. Reassignment, including assignment operators like =, do not mutate a variable in the context of a method definition; instead, it binds the variable to a new object."

# 6) What will the following code print, and why?
=begin
a = 7

def my_value(b)
  b = a + a
end

my_value(a)
puts a
=end
puts "a will return as 7, whereas the function will return an error. This is another example of method not having access to local variables outside of their definition, and so the my_value function does not know what a is."

# 7) What will the following code print, and why?
=begin
a = 7
array = [1, 2, 3]

array.each do |element|
  a = element
end

puts a
=end
puts "a will now return 3. This is because this is a method invocation with a block and not a method definition. This means there is no creation of inner scope, allowing for the a variable to be reassigned."

# 8) What will the following code print, and why?
=begin
array = [1, 2, 3]

array.each do |element|
  a = element
end

puts a
=end
puts "a will throw an error here. Since method invocations with a block do not create their own scope, it is relying on the a variable already existing in the local scope (which it does not)."

# 9) What will the following code print, and why?
=begin
a = 7
array = [1, 2, 3]

array.each do |a|
  a += 1
end

puts a
=end
puts "a will print as 7. The array is also unchanged. Although this is a method invocation with a block, and a already exists as a variable in the local outer scope, the 'a' represents elements within the array. This means that each element will have 1 added to itself (i.e. the inner block scope), rather than adding 1 to the a variable in the local outer scope."

puts "This problem demonstrates shadowing. Shadowing occurs when a block argument hides a local variable that is defined outside the block. Ruby will go looking for the definition for a from the inner most scope (the local block scope) and keep going outwards. In this case, it is able to find a definition of a in the local block scope - each element of the array. Since the outer a is shadowed, the a += 1 has no effect on it."

# 10) What will the following code print, and why?
=begin
a = 7
array = [1, 2, 3]

def my_value(ary)
  ary.each do |b|
    a += b
  end
end

my_value(array)
puts a
=end
puts "The variable a remains unchanged, since my_value is a method definition, it does not have context of the outer scope. The my_value method will throw an error."