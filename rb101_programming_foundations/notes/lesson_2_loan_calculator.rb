def welcome_msg
  puts 'Welcome to the Home Loan calculator!
This handy little tool will allow you to calculate your monthly payment,
based on a few inputs:
1. The annual interest rate (e.g. 5%)
2. The loan amount ($)
3. The loan duration (years)

Let\'s get started!'
end

def verify_number(input)
  input.to_i.to_s == input && input.to_i > 0
end

def verify_interest_rate(input)
  input.to_i > 0 &&
    (input.to_f.to_s == input ||
     input.to_i.to_s == input)
end

def get_loan_amount
  loop do
    puts "\n"
    puts 'Please enter your loan amount without any commas or $ signs: '
    loan_amount = gets.chomp
    if verify_number(loan_amount)
      puts "Thanks, your loan amount has been recorded as $#{loan_amount}."
      return loan_amount
    else
      puts 'That doesn\'t look like a valid amount.
Please enter a non-zero amount without commas and $ signs'
    end
  end
end

def get_interest_rate
  loop do
    puts "\n"
    puts 'Please enter your annual interest rate, as a whole number: '
    annual_interest_rate = gets.chomp
    if verify_interest_rate(annual_interest_rate)
      puts "Thanks, your annual interest rate has
been recorded as #{annual_interest_rate}%."
      return annual_interest_rate
    else
      puts 'That doesn\'t look like a valid rate.
Please enter a non-zero rate, expressed as a whole number,
without a % sign.'
    end
  end
end

def get_loan_duration
  loop do
    puts "\n"
    puts 'Please enter your loan duration, in years: '
    loan_duration = gets.chomp
    if verify_number(loan_duration)
      puts "Thanks, your loan duration has
been recorded as #{loan_duration} years."
      return loan_duration
    else
      puts 'That doesn\'t look like a valid loan duration.
Please try again.'
    end
  end
end

def calculate_monthly_payment(annual_interest_rate, loan_duration, loan_amount)
  monthly_interest_rate = annual_interest_rate.to_f / 1200.0
  loan_duration = loan_duration.to_f * 12.0
  loan_amount.to_i * (monthly_interest_rate / (1 -
    (1 + monthly_interest_rate)**-(loan_duration)))
end

def display_output(loan_amount, annual_interest_rate,
                   loan_duration, monthly_payment)
  puts "\n"
  puts "We've calculated your monthly payment at:
#{format('$%.2f', monthly_payment)}.

This calculation is based on a:
- Loan payment of $#{loan_amount},
- Annual interest rate of #{annual_interest_rate}% and
- Loan duration of #{loan_duration} years."
end

def another_calculation?
  puts "\n"
  puts 'Would you like to perform another calculation?
Please press \'y\' or \'n\'.'
  loop do
    answer = gets.chomp.downcase
    if answer == 'y'
      return true
    elsif answer == 'n'
      puts 'Thanks for using our loan calculator. We hope you found it useful.'
      return false
    else
      puts 'That isn\'t a valid input. Please try again.'
    end
  end
end

annual_interest_rate = nil
loan_duration = nil
loan_amount = nil

welcome_msg
loop do
  loan_amount = get_loan_amount
  annual_interest_rate = get_interest_rate
  loan_duration = get_loan_duration
  monthly_payment = calculate_monthly_payment(annual_interest_rate,
                                              loan_duration, loan_amount)
  display_output(loan_amount, annual_interest_rate,
                 loan_duration, monthly_payment)
  break unless another_calculation? == true
end
