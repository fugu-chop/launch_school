# Assertions

## Table of Contents
- [Assertions](#assertions)
- [Refutations](#refutations)
- [Testing Equality](#testing-equality)
- [Equality with a custom class](#equality-with-a-custom-class)
- [Code coverage](#code-coverage)

### Assertions
Besides equality, sometimes we want to assert that a specific error is raised, or that something is printed out to standard out, or an object must be an object of a specific class, or that something must be `nil`, or that it must not be `nil`, etc. 

Minitest can support virtually every kind of assertion you'd want to make. We'll only cover a few of the more popular assertions, but a full list can be found [here](http://docs.seattlerb.org/minitest/Minitest/Assertions.html).

| Assertion | Description |
|-|-|
| `assert(test)` | Fails unless test is truthy. |
| `assert_equal(exp, act)` |	Fails unless `exp == act`, depending on the objects being compared (can use custom `==`) |
| `assert_same(exp, act)` |	Fails unless `exp` is the same object as `act`. |
| `assert_nil(obj)` | Fails unless obj is `nil`. |
| `assert_raises(*exp) { ... }` |	Fails unless block raises one of `*exp`. |
| `assert_instance_of(cls, obj)` |	Fails unless obj is an instance of `cls`. |
| `assert_includes(collection, obj)` | Fails unless `collection` includes `obj`. |
| `assert_output(str) { ... }` | Fails unless `str` matches the side effect of executing the block. |
| `assert_same(obj1, obj2)` | Fails unless objects occupy the same space in memory. |

We'll use the following code for testing our assertions.
```ruby
class Vehicle
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end
end

class Car < Vehicle
end
```
`assert`
```ruby
def test_car_exists
  car = Car.new
  assert(car, "The car object is falsy")
end
```
Note that while `assert` can evaluate truthiness, `assert` can't distinguish between the expected and actual values when producing an output.
```ruby
# Assuming this test fails, minitest won't be able to tell what the output should be
assert(@kitty.name == 'Milo')
# Expected false to be truthy.

# If we want the below output (i.e. distinguish between an expected v actual result), we need to use assert_equal
=begin
1) Failure:
CatTest#test_name [minitest_test.rb:21]:
Expected: "Milo"
Actual: "Kitty"
=end
```
We also can't use it to evaluate exceptions (unless rescued, the exception will also terminate the rest of the tests).
```ruby
assert(Cat.new == ArgumentError)
# This will raise an Argument error, and terminate the rest of the tests since the exception is not rescued
```
`assert_equal`
```ruby
def test_wheels
  car = Car.new
  # This DOES NOT evaluate for truthiness like assert does
  assert_equal(4, car.wheels, "The car doesn't have 4 wheels")
end
```
`assert_nil`
```ruby
def test_name_is_nil
  car = Car.new
  assert_nil(car.name, "The name method doesn't return nil")
end
```
`assert_raises`
```ruby
def test_raise_initialize_with_arg
  assert_raises(ArgumentError) do
    # this code raises ArgumentError, so this assertion passes
    car = Car.new("Joey")
  end
end
```
`assert_instance_of`
```ruby
def test_instance_of_car
  car = Car.new
  assert_instance_of(Vehicle, car, "The car object isn't an instance of the Vehicle class")
end
```
This test is more useful when dealing with inheritance (i.e. testing which objects are direct instances of a class) and is analogous to the method `Object#instance_of?`.

`assert_includes`
```ruby
def test_includes_car
  car = Car.new
  arr = [1, 2, 3]
  arr << car

  assert_includes(arr, car, "The arr array doesn't include the car object")
end

# assert_includes calls assert_equal in its implementation, and Minitest counts that call as a separate assertion. For each assert_includes call, you will get 2 assertions, not 1.
```
In our assertions above, we've defined an optional argument, `msg`, which outputs the string object if the test fails. The `assert_mock`, `assert_raises`, `assert_silent` assertions __do not__ accept an optional message.

`assert_output`
```ruby
def test_output
  assert_output("You've paid $10.\n") do
    puts "You've paid $10."
  end
end
```
This test is useful particularly when we are testing the output of a `puts` method call - since `puts` returns `nil`, we need this assertion to test the side effect of the `puts` method - i.e. ensuring that the string output matches our expected string, which we pass as an argument to `assert_output`. Note that the `puts` method appends a newline to the end of a string output, so we need to account for that in our expected value by appending `"\n"`.

`assert_same`
```ruby
def test_same_object
  assert_same(3, 3)
end
```
This test is useful when we want to ensure that the two objects passed as arguments to the `assert_same` method are the same object - i.e. occupy the same physical space in memory.

### Refutations
Refutations are the opposite of assertions. That is, they refute rather than assert. __Every assertion has a corresponding refutation__. 

For example, `assert`'s opposite is `refute`. `refute` passes if the object you pass to it is falsey. Refutations all take the same arguments, except it's doing a refutation. They are generally expressed as `refute_equal`, `refute_nil`, `refute_includes`, etc.

They're not frequently used, unless they are a preferred style by someone in charge.

### SEAT Approach
Notice how in our previous tests, we had to instantiate a new `car` object every time we wanted to run a test. It would be more optimal to do some set up once outside of each test, then just run the assertions on it. This may seem like a minor and unnecessary performance savings, but the savings really add up if you have a lot of tests and if the set up process is expensive (say you're retrieving some data from a database).

In larger projects, there are usually 4 steps to writing a test:
1. Set up the necessary objects.
2. Execute the code against the object we're testing.
3. Assert the results of the execution.
4. Tear down and clean up any lingering artifacts.

This is the SEAT approach, and we can use it to clean our existing testing:
```ruby
require 'minitest/autorun'

require_relative '1_car'

class CarTest < MiniTest::Test

  def test_car_exists
    car = Car.new
    assert(car)
  end

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_name_is_nil
    car = Car.new
    assert_nil(car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end

  def test_instance_of_car
    car = Car.new
    assert_instance_of(Car, car)
  end

  def test_includes_car
    car = Car.new
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car)
  end
end
```
We can clean up the repeated instantiation of the `car` object by using the `setup` instance method, which is available in Minitest.
```ruby
require 'minitest/autorun'

require_relative '1_car'

class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end

  def test_car_exists
    assert(@car)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      Car.new(name: "Joey")
    end
  end

  def test_instance_of_car
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end
```
Note that in the `setup` method, we __must now use an instance variable__, `@car`. We can't use a local variable in `setup`, because the tests, which are just instance methods, __won't be able to access it__. But they can access an instance variable. Because we changed `car` to `@car`, we also have to make the same update in the actual tests. Finally, note that we __do not use `@car`__ in the `test_raise_initialize_with_arg` test, because we're using `Car.new` *with arguments* in this test.

The `setup` method will be called __before running every test__, and the `teardown` method (which we don't have) will be called after running every test. In our case, we don't have any tear down activity, so it's not necessary. In some cases, we will need a tear down for cleaning up files or logging some information, or closing database connections.

### Testing Equality
When we use `assert_equal`, we are testing for __value equality__. Specifically, we're invoking the `==` method on the object. If we're looking for more strict object equality, then we need to use the `assert_same` assertion.
```ruby
require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = "hi there"
    str2 = "hi there"

    assert_equal(str1, str2)
    assert_same(str1, str2)
  end
end
```
Which provides this output.
```
  1) Failure:
EqualityTest#test_value_equality [temp.rb:9]:
Expected "hi there" (oid=70321861410720) to be the same as "hi there" (oid=70321861410740).
```
Notice that the __object_ids for the two strings are not the same__. `assert_same` corresponds to __object equality__; they must be the same object.

### Equality with a custom class
What happens if we try to use `assert_equal` on our own custom classes? The answer is we have to tell Minitest how to compare those objects by _implementing our own `==` method_.

If we didn't have a custom `==` method, this is what happens:
```ruby
class Car
  attr_accessor :wheels, :name

  def initialize(name)
    @wheels = 4
    @name = name
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new("Kim")
    car2 = Car.new("Kim")

    assert_equal(car1, car2)
  end
end
```
Which produces this output:
```
# Running:

CarTest F

Finished in 0.021080s, 47.4375 runs/s, 47.4375 assertions/s.

  1) Failure:
CarTest#test_value_equality [car_test.rb:48]:
No visible difference in the Car#inspect output.
You should look at the implementation of #== on Car or its members.
#<Car:0xXXXXXX @wheels=4, @name="Kim">

1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```
As such, we should implement our own `==` instance method within the `Car` class.
```ruby
class Car
  attr_accessor :wheels, :name

  def initialize(name)
    @wheels = 4
    @name = name
  end

  # assert_equal would fail without this method
  def ==(other)
    other.is_a?(Car) && name == other.name
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new("Kim")
    car2 = Car.new("Kim")

    # this will pass
    assert_equal(car1, car2)
    # this will fail
    assert_same(car1, car2)
  end
end
```
### Code coverage
When writing tests, we want to get an idea of code coverage, or how much of our actual program code is tested by a test suite. Code coverage is based on all of your code, both public and private. Also, this doesn't mean every edge case is considered, or that even our program is working correctly. It only means that we have some tests in place for every method.

There are other ways to measure code coverage too besides looking at public methods. For example, more sophisticated tools can help with ensuring that all branching logic is tested. While not foolproof, code coverage is one metric that you can use to gauge *code quality*.

One tool we can use is the gem `simplecov`.
```
gem install simplecov
```
We can use it by inserting the following lines above the rest of our test file. 
```ruby
require 'simplecov'
SimpleCov.start
```
If your test file and original file are in different directories, `simplecov` will fail to pick up the code correctly. If however, you __navigate in the terminal to the directory with the original file__ (i.e. `pwd` in the terminal shows the location of the original file), then run the test file, the correct `/coverage/` directory is created and you get a meaningful code coverage percent.

Once we have this, when we run our tests, we'll get a new directory in our file system called `coverage`. Open up the `index.html` file in that directory, and you should see something like this:

![simplecov Diagram](https://d1b1wr57ag5rdp.cloudfront.net/images/simplecov_output_92.jpg)
