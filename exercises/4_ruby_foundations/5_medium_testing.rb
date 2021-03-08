require 'minitest/autorun'
# Two require_relative are necessary to gain access to both classes
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(10)
  end

  # 1) Write a test for the #accept_money method
  def test_accept_money
    # We have to set this instance variable using the setter method
    @transaction.amount_paid = 25
    assert_equal(125, @register.accept_money(@transaction))
  end

  # 2) Write a test for the method, CashRegister#change
  def test_change
    @transaction.amount_paid = 30
    assert_equal(20, @register.change(@transaction))
  end

  # 3) Write a test for method CashRegister#give_receipt that ensures it displays a valid receipt
  def test_give_receipt
    # Test text output - the output of puts is a side effect, so we need to use an assertion that tests side effects.
    assert_output("You've paid $10.\n") do
      @register.give_receipt(@transaction)
    end
    # Test return value
    assert_nil(@register.give_receipt(@transaction))
  end
end
