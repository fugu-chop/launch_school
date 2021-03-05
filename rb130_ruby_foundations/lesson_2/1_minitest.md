# Minitest

## Table of Contents
- [Why minitest?](#why-minitest)
- [Test Driven Development](#test-driven-development)
- [Vocabulary](#vocabulary)
- [Breaking down the test](#breaking-down-the-test)
- [Breaking down the output](#breaking-down-the-output)
- [Failures](#failures)
- [Skipping Tests](#skipping-tests)
- [Expectation Syntax](#expectation-syntax)
- [Setup and Teardown](#setup-and-teardown)

### Why minitest?
One of the biggest keys to producing quality software is properly testing your program under a wide variety of conditions. Doing this manually is tedious and error-prone, and frequently doesn’t get done at all. This leads to buggy software, and sometimes software that doesn’t work at all.

For beginners, we write tests to __prevent regression__ - that's what we'll focus on for now. We want to write tests so that when *we make changes in our code, we don't have to manually verify everything still works*. You can write tests first if you like, or you can write your tests after implementation. Most likely, you'll need to take some mixture of both, jumping back and forth between implementation and testing code.

Though many people use RSpec, Minitest is the default testing library that comes with Ruby. From a pure functionality standpoint, Minitest can do everything RSpec can, except Minitest uses a more straight forward syntax. RSpec bends over backwards to allow developers to write code that reads like natural English, but at the cost of simplicity. RSpec is what we call a __Domain Specific Language__; it's a DSL for writing tests.

We install Minitest through the gem package manager:
```
# To install Minitest:
gem install minitest

# Verify minitest has installed:
gem list minitest

# To add color:
gem install minitest-reporters
```
Typically, test suites are stored in in a special tests directory beneath your main application’s development directory. For example, if you are working on a to-do application that is stored in `/Users/me/todo`, then you will place your test suite files in `/Users/me/todo/tests`. This isn’t a requirement, but is good practice for source organization, particularly when working with large projects.

### Test Driven Development
While we won’t be doing any actual development in this post, it’s important to understand how testing fits into the software development cycle. Ideally, your test cases should be run before writing any code. This is frequently called Test-Driven Development (TDD), and follows a simple pattern:

1. Create a test that fails.
2. Write just enough code to implement the change or new feature.
3. Refactor and improve things, then repeat tests.

This is often called Red-Green-Refactor. Red describes the failure step; green describes the getting things working; and, of course, refactor covers refactoring and improving things.

Once you’ve been through these steps, you can move on the next feature and repeat all of the above steps.
### Vocabulary
In the world of testing, a whole new vocabulary is necessary to talk about the new concepts. There is a lot of jargon when working with tests, but for now, we'll just focus on a few terms below.

A _testing framework_ is software that provides a way to test each of the components of an application. These can be methods or entire programs; the framework should be able to provide appropriate inputs, check return values, examine outputs, and even determine if errors occur when they should.

Testing frameworks provide 3 basic features:
- a way to describe the tests you want to run,
- a way to execute those tests,
- a way to report the results of those tests.

There is a hierarchy to tests. Since there isn’t any formal agreement on exactly which terms are used to describe this hierarchy, we will use the following definitions:
- __Assertion__: this is the actual verification step to confirm that the data returned by your program or application is indeed what is expected. You make one or more assertions within a test.
- __Test__: this describes a *situation or context* in which tests are run. For example, this test is about making sure you get an error message after trying to log in with the wrong password. A test can contain multiple assertions.
- __Test Suite__: this is the entire set of tests that accompanies your program or application. You can think of this as __all the tests__ for a project.

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

Within our test class, `CarTest`, we can write tests by creating an instance method that starts with `test_`. Through this naming convention, Minitest will know that these methods are individual tests that need to be run. Within each test (or every instance method that starts with "`test_`"), we will need to make some __assertions__. 

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

If we want to reference a particular seed, we append it as a flag when we run our file:
`ruby test/tests.rb --seed 51859`

The next important thing to notice is the `.`. There's only 1 here, so it looks like an inconsequential period, but it's very important. That means the __test was run and nothing went wrong__. If you skip a test with the "`skip`" keyword, it'll say "`S`". If you have a failure, it'll say "`F`". Pay attention to that to see if you have a failing test. If we see an "`E`", we know that one or more test cases were broken. 

### Failures
If we specifically add a test to ensure a failure:
```ruby
require 'minitest/autorun'

require_relative '1_car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    car = Car.new
    assert_equal(3, car.wheels)
  end
end
```
We will get this output.
```
$ ruby 1_car_test.rb

Run options: --seed 8732

# Running:

CarTest F.

Finished in 0.001222s, 1636.7965 runs/s, 1636.7965 assertions/s.

  1) Failure:
CarTest#test_bad_wheels [1_car_test.rb:13]:
Expected: 3
  Actual: 4

2 runs, 2 assertions, 1 failures, 0 errors, 0 skips
```
The last line gives us a quick summary, and we can see that there are now 2 assertions and 1 failure. Minitest further gives us the exact failing test, and also tells us the expected value vs the actual value. Also notice at the top, there's a "`F.`", which means there were 2 tests, one of which failed (that's the "`F`") and one of which passed (that's the "`.`").

### Skipping Tests
Minitest allows us to skip tests via the `skip` keyword. All you have to do is put `skip` at the beginning of the test, and Minitest will skip it. It will also report that you have skipped tests in your suite, and output an "`S`" instead of a dot. You could also pass a string into `skip` if you want a more custom display message (displays by default in Minitest Reporters, need to run the script with the `--verbose` flag for default).
```ruby
require 'minitest/autorun'
# require "minitest/reporters"
require_relative '1_car'

# Minitest::Reporters.use!

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    skip
    car = Car.new
    assert_equal(3, car.wheels)
  end
end
```
The default output:
```
Run options: --seed 32489

# Running:

S.

Finished in 0.001072s, 1865.6716 runs/s, 932.8358 assertions/s.

2 runs, 1 assertions, 0 failures, 0 errors, 1 skips

You have skipped tests. Run with --verbose for details.
```
With Minitest Reporters, the skipped test is represented in yellow and is highlighted showing that you should go back and take care of it.
```
Started with run options --seed 23047

 SKIP CarTest#test_bad_wheels (0.00s)
        Skipped, no message given
        1_car_test.rb:16:in `test_bad_wheels'

  2/2: [==================================================================================================] 100% Time: 00:00:00, Time: 00:00:00

Finished in 0.00115s
2 tests, 1 assertions, 0 failures, 0 errors, 1 skips
```
### Expectation Syntax
Thus far, we've been using the assertion or assert-style syntax. Minitest also has a completely different syntax called _expectation_ or _spec-style_ syntax.

In expectation style, tests are grouped into `describe` blocks, and individual tests are written with the `it` method. We no longer use assertions, and instead use expectation matchers.
```ruby
require 'minitest/autorun'

require_relative '1_car'

describe 'Car#wheels' do
  it 'has 4 wheels' do
    car = Car.new
    car.wheels.must_equal 4           # this is the expectation
  end
end
```
The above test gives us the following output.
```
Run options: --seed 51670

# Running:

Car#wheels .

Finished in 0.001067s, 937.0051 runs/s, 937.0051 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```
### Setup and Teardown
Many test suites have some code that needs to be run either before or after each test. For example, a test suite that validates a database query may need to establish the database connection prior to each test, and then shut down the connection after each test. 

This can be easily accomplished with helper methods inside your test suite classes; however, you would need to remember to call both methods in every test case. Minitest provides a better way: each class that defines a test suite can have a `#setup` and/or a `#teardown` method to automatically perform any preprocessing or postprocessing required.

The `#setup` method is called __prior to each test case__ in the class, and is used to perform any setup required for each test. Likewise, `#teardown` is called __after each test case__ to perform any cleanup required. It is common to set instance variables in `#setup` that can be used in the actual test case methods. 
```ruby
require 'minitest/autorun'
require 'pg'

class MyApp
  def initialize
    @db = PG.connect 'mydb'
  end

  def cleanup
    @db.finish
  end

  def count
    # Do something
  end

  def create(value)
    # Do something
  end
end

class DatabaseTest < Minitest::Test
  def setup
    @myapp = MyApp.new
  end

  def test_that_query_on_empty_database_returns_nothing
    assert_equal 0, @myapp.count
  end

  def test_that_query_on_non_empty_database_returns_right_count
    @myapp.create('Abc')
    @myapp.create('Def')
    @myapp.create('Ghi')
    assert_equal 3, @myapp.count
  end

  def teardown
    @myapp.cleanup
  end
end
```
This test suite runs two test cases. Prior to each test case, `#setup` creates a `@myapp` instance variable that references a `MyApp` object. After each test case, `#teardown` calls `@myapp.cleanup` to perform any shutdown cleanup required by the `MyApp` class. In this example, set up and tear down consist of code that establishes and then drops a database connection. Elsewhere in the test suite, we can reference `@myapp` freely to access the object.

Note that both `#setup` and `#teardown` are __independent and optional__; you can have both, neither, or either one in any test suite.
