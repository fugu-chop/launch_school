# Inheritance and Variable Scope

## Table of Contents
- [Instance Variables](#instance-variables)
- [Class Variables](#class-variables)
- [Constants](#constants)
- [Module and Constant Interaction](#module-and-constant-interaction)

### Instance Variables
Instance variables defined in the superclass are accessible in the subclass, so long as the relevant instance variables are initialised through instance methods. Remember that this __is not inheritance__, but only only __access__ (scope), which is resolved by looking *up the inheritance chain*.

Instance variables are __not defined by the object's class__ - they are simply __created when a value is assigned to them__. Because instance variables are not defined by a class, they are _unrelated_ to subclassing and the inheritance mechanism.
```
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! Teddy bark! bark!
```
When we instantiated `teddy`, we called `Dog.new`. Since the `Dog` class doesn't have an `initialize` instance method, the method lookup path went to the superclass, `Animal`, and executed `Animal#initialize` (i.e. `Dog` inherits the `initialize` method from `Animal`). That's when the `@name` instance variable was initialized, and that's why we can access it from `teddy.dog_name`.

This is __not true__ if the methods in which instance variables are defined are overwritten, or never called. Again, this is because instance variables themselves __cannot be inherited__; only the methods in which they are defined.
```
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! bark! bark!
```
`@name` is `nil`, because it was __never initialised__. The `Animal#initialize` method was never executed (the `name` argument passed to the method is ignored by `initialize`). Remember that __uninitialised instance variables__ return `nil` (calling `.to_s` on `nil` returns a blank string).

Another example:
```
module Speedy
  def run_fast
    @speed = 70
  end
end

class Animal
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Dog < Animal
  DOG_YEARS = 7

  def initialize(name, age)
    @dog_age = age * DOG_YEARS
  end
end

class Greyhound < Dog
  include Speedy
end

grey = Greyhound.new('Grey', 3)
```
Here, the only instance variable initialized when `grey` is instantiated is `@dog_age`, since we override the `initialize` method in the `Animal` class. Also, while we have mixed in the `Speedy` module into the `Greyhound` class, we never actually call the `run_fast` method, such that the `@speed` instance variable is never initialised. 

The same behaviour can be observed with mixins:
```
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.swim                                  
# => nil
```
Since we didn't call the `Swim#enable_swimming` method, the `@can_swim` instance variable was __never initialised__. Assuming the same module and class from above, we need to do the following:
```
teddy = Dog.new
teddy.enable_swimming
teddy.swim                                  
# => swimming!
```
### Class Variables
Class variables are accessible to sub-classes.
```
class Animal
  @@total_animals = 0

  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animals
  end
end

spike = Dog.new
spike.total_animals                           # => 1
```
Note that since this class variable is initialized in the `Animal` class, there is no method to explicitly invoke to initialise it. *The class variable is loaded when the class is evaluated by Ruby*.

It can be dangerous when working with class variables within the context of inheritance, because there is __only one copy of the class variable across all sub-classes__.
```
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels                              # => 4
```
If we add in a sub-class that *overrides* this class variable:
```
class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels                           # => 2
Vehicle.wheels                              # => 2  Yikes!
```
The class variable in the sub-class affected the class variable in the super class. This change **will affect all other sub-classes** of `Vehicle`.
```
class Car < Vehicle
end

Car.wheels                                  # => 2  Not what we expected!
```
For this reason, _avoid using class variables when working with inheritance_. Some Rubyists would go as far as recommending avoiding class variables altogether.

Take this as a further example:
```
class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end
```
`Triangle.sides` returns a value of `nil` when called __before instantiating__ a `Triangle` or `Quadrilateral` object. It returns `4` when called directly after instantiating a `Quadrilateral` object.

`Triangle.new.sides` always returns a value of `3` since upon initialising a `Triangle` object, the `initialize` method overwrites anything else `@@sides` might have been set to, ensuring that the return value is `3`. If we call `Quadrilateral.sides` at this stage, this will return `3` as well. 

Otherwise, `Triangle.sides` can sometimes return a value of `4`, as if we instantiate a `Quadrilateral` object without instantiating a `Triangle` object, that object will overwrite the class variable `@@sides`, which the `Triangle` class would be referencing. 

### Constants
Constants can be accessed from instance or class methods when defined within a class. However, they _cannot_ be referenced if defined in a __different__ class, unless we use the *namespace resolution operator*, `::`. The namespace resolution operator enables us to look in a different scope (i.e. outside of the immediate class scope where the constant is referenced).
```
class Dog
  LEGS = 4
end

class Cat
  def legs
    LEGS
  end
end

kitty = Cat.new
kitty.legs                                  # => NameError: uninitialized constant Cat::LEGS
```
The error occurs here because Ruby is looking for `LEGS` within the `Cat` class. This is expected, since this is the same behavior as class or instance variables (except, referencing an uninitialised instance variable will return `nil`).

But unlike class or instance variables, we can actually reach into the `Dog` class and reference the `LEGS` constant. In order to do so, we have to tell Ruby where the LEGS constant is using `::`, which is the namespace resolution operator.
```
class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS                               # added the :: namespace resolution operator
  end
end

kitty = Cat.new
kitty.legs                                  # => 4
```
Sidenote: you can use `::` on classes, modules or constants. 

### Module and Constant Interaction
Unlike instance methods or instance variables, constants are __not evaluated at runtime__, so their lexical scope - or, where they are defined in the code - is very important.
```
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires                          # => NameError: uninitialized constant Maintenance::WHEELS
```
The line `"Changing #{WHEELS} tires."` is in the `Maintenance` module, which is where Ruby will look for the `WHEELS` constant. Even though we call the `change_tires` method from the `a_car` object, Ruby is not able to find the constant.

Constant resolution will look at the __lexical scope first__, and then look at the inheritance hierarchy. It can get very tricky when there are nested modules, each setting the same constants to different values. 

We can fix the above code with either of:
```
module Maintenance
  def change_tires
    "Changing #{Vehicle::WHEELS} tires."    # this fix works
  end
end

module Maintenance
  def change_tires
    "Changing #{Car::WHEELS} tires."        # surprisingly, this also works
  end
end
```
The reason `Car::WHEELS` works is because we're telling Ruby to look for `WHEELS` in the `Car` class, which can access `Vehicle::WHEELS` through inheritance.

See this example:
```
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

Square.sides # => 4
Square.new.sides # => 4
Square.new.describe_shape # => "I am a Square and have 4 sides."
```
In order to achieve the desired outputs, we need to:
- Add `def sides; SIDES; end` to the `Quadrilateral` class, as there is no `#sides` instance method,  `Square.new.sides` would return a `NoMethodError` without it. 
- Change the method body of `#describe_shape` method to `"I am a #{self.class} and have #{self.class::SIDES} sides."`, as without `self.class`, Ruby will look to the module to define `SIDES` (i.e. will return `NameError: uninitialized constant Describable::SIDES`), per _lexical scope_ rules for constants.
- Change the method body of `Shape::sides` method (i.e. class method) to `self::SIDES`, as `SIDES` is not defined in `Shape`, it is defined in `Quadrilateral`. By using `self::`, it will start at the current class (`Square`, as `self` within a class method refers to the class itself) and go up the inheritance chain (the `self::` operator enables access to the `Shape` superclass through inheritance). Again, constants have lexical scope - without `self::SIDES`, despite defining a constant within `Quadrilateral`, Ruby will only look at the `Shape` class to find the definition of `SIDES`, which does not exist. 
