require 'minitest/autorun'

class Car
  attr_reader :name, :mileage, :prev_owners, :encumbrances

  def initialize(name = 'xyz', mileage = 51, prev_owners = [], encumbrances = nil, list = ['xyz', 'abc'])
    @name = name
    @mileage = mileage
    @prev_owners = prev_owners
    @encumbrances = encumbrances
    @list = list
  end

  def hire
    raise NoExperienceError, "You can't hire this car!" unless name == 'Yolo'
    "You've hired this car!"
  end

  def list
    @list
  end
  alias_method :process, :list
  
end

class NoExperienceError < StandardError
end

class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end
  # 1) Write a minitest assertion that will fail if the value.odd? is not true.
  def test_odd
    # The default message for assert lacks context, so it is common to specify the failure message when using assert.
    assert(@car.mileage.odd?, "Value is not odd")
  end

  # 2) Write a minitest assertion that will fail if value.downcase does not return 'xyz'
  def test_downcase
    assert_equal('xyz', @car.name.downcase, "Value is not lowercase")
  end

  # 3) Write a minitest assertion that will fail if value is not nil.
  def test_nil 
    assert_nil(@car.encumbrances)
  end

  # 4) Write a minitest assertion that will fail if the Array list is not empty.
  def test_empty
    assert_empty(@car.prev_owners, "Array is not empty")
  end

  # 5) Write a minitest assertion that will fail if the 'xyz' is not in the Array list.
  def test_list
    assert_includes(@car.list, 'xyz', "List array does not include 'xyz'")
  end

  # 6) Write a minitest assertion that will fail unless employee.hire raises a NoExperienceError exception.
  def test_error
    assert_raises(NoExperienceError) { @car.hire }
  end

  # 7) Write a minitest assertion that will fail if value is not an instance of the Numeric class exactly. value may not be an instance of one of Numeric's superclasses.
  def test_instance
    assert_instance_of(Numeric, @car.mileage)
  end

  # 8) Write a minitest assertion that will fail if the class of value is not Numeric or one of Numeric's subclasses (e.g., Integer, Float, etc).
  def test_instances
    assert_kind_of(Numeric, @car.mileage)
  end

  # 9) Write a test that will fail if list and the return value of list.process are different objects.
  def test_equality
    assert_same(@car.process, @car.list)
  end

  # 10) Write a test that will fail if 'xyz' is one of the elements in the Array list:
  def test_array_contain
    refute_includes(@car.list, 'xyz')
  end
end
