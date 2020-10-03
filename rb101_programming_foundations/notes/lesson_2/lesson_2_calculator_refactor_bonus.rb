require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number(number)
  number.to_i().to_s() == number || number.to_f().to_s() == number
end

def operator_to_msg(operator)
  word = case operator
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         else 'Dividing'
         end

  prompt("Thinking....")
  word
end

num1 = nil
num2 = nil
name = nil
operator = nil

prompt(MESSAGES['welcome_msg'])

loop do
  prompt(MESSAGES['name'])
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt(MESSAGES['empty_name'])
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
    prompt(MESSAGES['first_num_enter'])
    num1 = Kernel.gets().chomp()

    if valid_number(num1)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  loop do
    prompt(MESSAGES['second_num_enter'])
    num2 = Kernel.gets().chomp()

    if valid_number(num2)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  prompt(MESSAGES['operator_msg'])

  loop do
    operator = Kernel.gets().chomp()

    # This allows us to quickly create an array of strings.
    # Elements will be separated by commas.
    valid_ops = %w(1 2 3 4)
    if valid_ops.include?(operator)
      break
    else
      prompt(MESSAGES['invalid_operator'])
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

  prompt(MESSAGES['calculate_again'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase() == 'y'
end

prompt(name + MESSAGES['thank_you'])
