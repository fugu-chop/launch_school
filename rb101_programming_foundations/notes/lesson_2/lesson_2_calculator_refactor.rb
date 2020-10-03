def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number(number)
  number.to_i() != 0
end

def operator_to_msg(operator)
  case operator
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  else 'Dividing'
  end
end

num1 = nil
num2 = nil
name = nil
operator = nil

# This is an example of a heredoc in Ruby,
# This allows us to print multiline strings.
welcome_msg = <<-MSG
Welcome to Calculator!
You can use this application to do basic calculations, with two numbers.
Please enjoy!
MSG

prompt(welcome_msg)

loop do
  prompt("Please enter your name! ")
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt("That looked like there was no text in the input!")
  else
    break
  end
end

prompt("Welcome #{name.capitalize!}!")

# Initialising a loop creates it's own scope.
# Code outside the loop cannot access the variables created within that loop.
# We need to initialise the variables outside of this loop.
loop do
  loop do
    prompt("Please enter the first number! ")
    num1 = Kernel.gets().chomp()

    if valid_number(num1)
      break
    else
      Kernel.puts("That doesn't look like a valid number - please try again!")
    end
  end

  loop do
    prompt("Please enter the second number! ")
    num2 = Kernel.gets().chomp()

    if valid_number(num2)
      break
    else
      Kernel.puts("That doesn't look like a valid number - please try again!")
    end
  end

  operator_msg = <<-MSG
  What operation would you like to perform?
  You can press:
    1 to Add
    2 to Subtract
    3 to Multiply
    4 to Divide
  MSG
  prompt(operator_msg)

  loop do
    operator = Kernel.gets().chomp()

    # This allows us to quickly create an array of strings.
    # Elements will be separated by commas.
    valid_ops = %w(1 2 3 4)
    if valid_ops.include?(operator)
      break
    else
      prompt("Please enter a valid operator!")
    end
  end

  prompt("#{operator_to_msg(operator)} the two numbers...")

  result = case operator
           when '1'
             num1.to_i() + num2.to_i()
           when '2'
             num1.to_i() - num2.to_i()
           when '3'
             num1.to_i() * num2.to_i()
           when '4'
             num1.to_f() / num2.to_i()
           end

  prompt("The result is #{result}!")

  prompt("Do you want to perform another calculation? Press 'Y' if so!")
  answer = Kernel.gets().chomp()
  break unless answer.downcase() == 'y'
end

prompt("#{name}, thanks for using the calculator! I hope to see you again!")
