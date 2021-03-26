require 'minitest/autorun'
# Two require_relative are necessary to gain access to both classes
require_relative 'cash_register'
require_relative 'transaction_1'

class CashRegisterTest < MiniTest::Test
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(30)
  end

  # 4) Write a test that verifies that Transaction#prompt_for_payment sets the amount_paid correctly. 
  def test_prompt_for_payment
    # When testing interactive programs, you don't want to sit at the keyboard and provide the same inputs over and over. It would be nice if we could "mock" the keyboard input - that is, send input to the program in such a way that it can read it without changing any code. 
    # Ruby provides a string stream class called StringIO. To use it, all you need to do is create a StringIO object that contains all of your simulated keyboard inputs, then pass it to prompt_for_payment.
    # The object assigned to input here is a StringIO object that simulates the keyboard by acting like the user type the number 30, then pressed the Return key (\n). 
    # input.gets works just like the normal gets, but gets information from the object specified by input (instead of $stdin).
    input = StringIO.new("30\n")
    # This method calls the setter amount_paid method in the Transaction object
    @transaction.prompt_for_payment(input: input)
    assert_equal(30, @transaction.amount_paid)
  end

  # 5) Clean up the output so that we don't get residual text from the previous test
  def test_prompt_for_payment_clean
    input = StringIO.new("30\n")
    # StringIO objects can consume text output as well. We don't have to provide a string for a StringIO object
    output = StringIO.new
    # Note that we had to alter the method in order for this solution to work
    @transaction.prompt_for_payment(input: input, output: output)
    assert_equal(30, @transaction.amount_paid)
  end
end
