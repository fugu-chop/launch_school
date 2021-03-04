# Assertions

## Table of Contents
- [Assertions](#assertions)
- [Refutations](#refutations)

### Assertions
Besides equality, sometimes we want to assert that a specific error is raised, or that something is printed out to standard out, or an object must be an object of a specific class, or that something must be `nil`, or that it must not be `nil`, etc. 

Minitest can support virtually every kind of assertion you'd want to make. We'll only cover a few of the more popular assertions, but a full list can be found [here](http://docs.seattlerb.org/minitest/Minitest/Assertions.html).

| Assertion | Description |
|-|-|
| `assert(test)` | Fails unless test is truthy. |
| `assert_equal(exp, act)` |	Fails unless `exp == act`. |
| `assert_nil(obj)` | Fails unless obj is `nil`. |
| `assert_raises(*exp) { ... }` |	Fails unless block raises one of `*exp`. |
| `assert_instance_of(cls, obj)` |	Fails unless obj is an instance of `cls`. |
| `assert_includes(collection, obj)` | Fails unless `collection` includes `obj`. |

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
  assert(car)
end
```
`assert_equal`
```ruby
def test_wheels
  car = Car.new
  assert_equal(4, car.wheels)
end
```
`assert_nil`
```ruby
def test_name_is_nil
  car = Car.new
  assert_nil(car.name)
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
`assert_instance_of`. This test is more useful when dealing with inheritance (i.e. testing which objects are direct instances of a class). This example is a little contrived.
```ruby
def test_instance_of_car
  car = Car.new
  assert_instance_of(Vehicle, car)
end
```
`assert_includes`
```ruby
def test_includes_car
  car = Car.new
  arr = [1, 2, 3]
  arr << car

  assert_includes(arr, car)
end

# assert_includes calls assert_equal in its implementation, and Minitest counts that call as a separate assertion. For each assert_includes call, you will get 2 assertions, not 1.
```
### Refutations
Refutations are the opposite of assertions. That is, they refute rather than assert. __Every assertion has a corresponding refutation__. 

For example, `assert`'s opposite is `refute`. `refute` passes if the object you pass to it is falsey. Refutations all take the same arguments, except it's doing a refutation. And yes, there is a `refute_equal`, `refute_nil`, `refute_includes`, etc.

They're not frequently used, unless they are a preferred style by someone in charge.
