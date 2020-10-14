Kernel.puts("Welcome to Calculator!")
Kernel.puts("You can use this application to do basic calculations with two numbers.")

Kernel.puts("Please enter the first number!")
num1 = Kernel.gets().chomp().to_i()

Kernel.puts("Please enter the second number!")
num2 = Kernel.gets().chomp().to_i()

Kernel.puts("What operation would you like to perform?")
Kernel.puts("Add, subtract, multiply or divide?")
operator = Kernel.gets().chomp().downcase()

if operator == 'add'
  result = num1 + num2
elsif operator == 'subtract'
  result = num1 - num2
elsif operator == 'multiply'
  result = num1 * num2
elsif operator == 'divide'
  result = num1.to_f() / num2
else "That wasn't a recognised command!"
end

puts result