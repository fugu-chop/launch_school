require 'minitest/autorun'
# This adds the colour
# require "minitest/reporters"
require_relative '1_car'

# Tell Ruby to use the Reporters module method to add color
# Minitest::Reporters.use!

class CarTest < MiniTest::Test
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
