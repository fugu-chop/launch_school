# Minitest

## Table of Contents
- [Why minitest?](#why-minitest?)
- [Vocabulary](#vocabulary)
- [Breaking down the test](#breaking-down-the-test)
- [Breaking down the output](#breaking-down-the-output)

### Why minitest?
For beginners, we write tests to __prevent regression__ - that's what we'll focus on for now. We want to write tests so that when *we make changes in our code, we don't have to manually verify everything still works*. You can write tests first if you like, or you can write your tests after implementation. Most likely, you'll need to take some mixture of both, jumping back and forth between implementation and testing code.

Though many people use RSpec, Minitest is the default testing library that comes with Ruby. From a pure functionality standpoint, Minitest can do everything RSpec can, except Minitest uses a more straight forward syntax. RSpec bends over backwards to allow developers to write code that reads like natural English, but at the cost of simplicity. RSpec is what we call a __Domain Specific Language__; it's a DSL for writing tests.

### Vocabulary
In the world of testing, a whole new vocabulary is necessary to talk about the new concepts. There is a lot of jargon when working with tests, but for now, we'll just focus on a few terms below.

- __Test Suite__: this is the entire set of tests that accompanies your program or application. You can think of this as __all the tests__ for a project.
- __Test__: this describes a *situation or context* in which tests are run. For example, this test is about making sure you get an error message after trying to log in with the wrong password. A test can contain multiple assertions.
- __Assertion__: this is the actual verification step to confirm that the data returned by your program or application is indeed what is expected. You make one or more assertions within a test.

### Breaking down the test
We start with the following code, in `1_car.rb`.
```ruby
class Car
  attr_accessor :wheels

  def initialize
    @wheels = 4
  end
end
```
This is our test file, `1_car_test.rb`.
```ruby
require 'minitest/autorun'

require_relative '1_car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```
In our test, on line 1 is require `'minitest/autorun'`, which loads all the necessary files from the `minitest` gem. That's all we need to use Minitest. 

Next, on line 3, we require the file that we're testing, `1_car.rb`, which contains the `Car` class. We use `require_relative` to specify the *file name from the current file's directory*. Now when we make references to the `Car` class, Ruby knows where to look for it.

Finally, line 5 is where we create our test class. Note that this class must subclass `MiniTest::Test`. This will allow our test class to inherit all the necessary methods for writing tests.

Within our test class, `CarTest`, we can write tests by creating an instance method that starts with `test_`. Through this naming convention, Minitest will know that these methods are individual tests that need to be run. Within each test (or instance method that starts with "`test_`"), we will need to make some __assertions__. 

These assertions are what we are trying to verify. Before we make any assertions, however, we have to first *set up the appropriate data or objects to make assertions against*. For example, on line 7, we first instantiate a `Car` object. We then use this car object in our assertion to verify that newly created `Car` objects indeed have 4 wheels.

There are many types of assertions, but for now, just focus on `assert_equal`. Since we are inside an instance method, you can guess that `assert_equal` is an inherited instance method from somewhere up the hierarchy.

`assert_equal` takes two parameters: the first is the *expected* value, and the second is the *test or actual* value. If there's a discrepancy, `assert_equal` will save the error and Minitest will report that error to you at the end of the test run.

It's sometimes useful to have multiple assertions within one test (ie, instance method that starts with "`test_`"), but in the beginning, we'll only show one assertion within one test.

### Breaking down the output
Running the test file produces the following output.
```
$ ruby 1_car_test.rb

Run options: --seed 62238

# Running:

CarTest .

Finished in 0.001097s, 911.3428 runs/s, 911.3428 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```
This output means our test passed. The last line states: 1 assertions, 0 failures, 0 errors. That means the assertion was executed, and there weren't any problems.

The first "`seed`" tells Minitest _what order the tests were run in_. In our example, we only have 1 test, but most test suites have many tests that are run in random order. The "seed" is how you tell Minitest to run the entire test suite __in a particular order__. This is rarely used, but is sometimes helpful when you have an especially tricky bug that only comes up when certain specific situations come up.

The next important thing to notice is the `.`. There's only 1 here, so it looks like an inconsequential period, but it's very important. That means the __test was run and nothing went wrong__. If you skip a test with the "`skip`" keyword, it'll say "`S`". If you have a failure, it'll say "`F`". Pay attention to that to see if you have a failing test.
