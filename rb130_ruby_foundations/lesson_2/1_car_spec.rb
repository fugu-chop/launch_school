require 'minitest/autorun'

require_relative '1_car'

describe 'Car#wheels' do
  it 'has 4 wheels' do
    car = Car.new
    # this is the expectation
    car.wheels.must_equal(4)
  end
end