require 'minitest/autorun'
# This adds the colour
# require "minitest/reporters"
require_relative '1_car'

# Tell Ruby to use the Reporters module method to add color
# Minitest::Reporters.use!

class CarTest < MiniTest::Test
  # Use this if you need to run your tests in order (lol). We also need to ensure that our tests are ordered alphabetically.
  # i_suck_and_my_tests_are_order_dependent!()

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    skip "Test for bad wheels is skipped."
    car = Car.new
    assert_equal(3, car.wheels)
  end
end
