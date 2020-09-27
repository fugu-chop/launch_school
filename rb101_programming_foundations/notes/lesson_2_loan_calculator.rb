welcome_msg = <<-MSG
Welcome to the Home Loan calculator!
This handy little tool will allows you to calculate your monthly payment, based on a few inputs:
1. The annual interest rate (e.g. 5%)
2. The loan amount ($)
3. The loan duration (months)

Let's get started!
MSG

# Create function to calculate the monthly repayment
def monthly_payment(annual_interest_rate, loan_duration, loan_amount)
  monthly_interest_rate = annual_interest_rate.to_f / 1200.0
  loan_duration = loan_duration.to_f * 12.0
  loan_amount.to_i * (monthly_interest_rate / (1 -
    (1 + monthly_interest_rate)**-(loan_duration)))
end

# Create a function to verify that the input is an integer
def verify_number(input)
  input.to_i.to_s == input && input.to_i > 0
end

puts welcome_msg

annual_interest_rate = nil
loan_duration = nil
loan_amount = nil

# loop to take in loan amount
loop do
  loop do
    puts 'Please enter your loan amount without any commas or $ signs: '
    loan_amount = gets.chomp
    if verify_number(loan_amount)
      puts "Thanks, your loan amount has been recorded as $#{loan_amount}."
      puts "\n"
      break
    else
      puts 'That doesn\'t look like a valid amount.
      Did you remember to remove commas and $ signs?'
      puts "\n"
    end
  end

  # loop to take in annual interest rate
  loop do
    puts 'Please enter your annual interest rate, as a whole number: '
    annual_interest_rate = gets.chomp
    # The || statement accounts for where APR doesn't have a decimal place.
    if annual_interest_rate.to_i > 0 &&
       (annual_interest_rate.to_f.to_s == annual_interest_rate ||
        annual_interest_rate.to_i.to_s == annual_interest_rate)
      puts "Thanks, your annual interest rate has
      been recorded as #{annual_interest_rate}%."
      puts "\n"
      break
    else
      puts 'That doesn\'t look like a valid rate.
      Did you enter the rate as a whole number, without a % sign?'
      puts "\n"
    end
  end

  # loop to grab loan duration
  loop do
    puts 'Please enter your loan duration, in years: '
    loan_duration = gets.chomp
    if verify_number(loan_duration)
      puts "Thanks, your loan duration has
      been recorded as #{loan_duration} years."
      puts "\n"
      break
    else
      puts 'That doesn\'t look like a valid loan duration.
      Please try again.'
    end
  end

  puts "Your monthly payment is $#{format('%.2f',
                                          monthly_payment(annual_interest_rate,
                                                          loan_duration,
                                                          loan_amount))}."
  puts "\n"
  puts 'Do you want to run another calculation? Press \'y\' if so!'
  puts "\n"
  if gets.chomp.downcase != 'y'
    puts 'Thanks for using the home loan calculator. We hope to see you again!'
    break
  end
end
