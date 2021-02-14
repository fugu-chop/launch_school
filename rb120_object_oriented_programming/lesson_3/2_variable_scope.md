# Variable Scope

## Table of Contents
- [Instance Variable Scope](#instance-variable-scope)
- [Class Variable Scope](#class-variable-scope)
- [Constant Variable Scope](#constant-variable-scope)
- [Lexical Scope](#lexical-scope)

### Instance variable scope
Instance variables are variables that start with `@` and are _scoped at the object level_. They are used to track individual object state, and __do not cross over between objects__. 
```ruby
class Person
  def initialize(n)
    @name = n
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect
# => #<Person:0x007f9c830e5f70 @name="bob">

puts joe.inspect
# => #<Person:0x007f9c830e5f20 @name="joe">
```
Because the scope of instance variables is at the _object level_, this means that the instance variable is accessible in an object's instance methods, even if it's initialized __outside of that instance method__.
```ruby
class Person
  def initialize(n)
    @name = n
  end

  def get_name
    # is the @name instance variable accessible here?
    @name
  end
end

bob = Person.new('bob')
bob.get_name
# => "bob"
```
If we try to access an instance variable that is not yet initialised anywhere, we will get a `nil` - contrast this with an uninitialised _local_ variable (which would result in a `NameError`).
```ruby
class Person
  def get_name
    # the @name instance variable is not initialized anywhere
    @name
  end
end

bob = Person.new
bob.get_name
# => nil
```
This also occurs if we accidentally put an instance variable at the _class_ level. Don't do this, because instance variables initialised at the class level are an entirely different thing called __class instance variables__.
```ruby
class Person
  # class level initialization
  @name = "bob"

  def get_name
    @name
  end
end

bob = Person.new
bob.get_name
# => nil
```
With a *class instance variable* (__not__ on an instance of that class) you can store something common to that class __without having sub-classes automatically also get them__ (and vice-versa). With *class variables*, you have the convenience of not having to write `self.class` from an instance object, and (when desirable) you also get automatic sharing throughout the class hierarchy.
```ruby
# Class Instance Variable
class Parent
  @things = []
  def self.things
    @things
  end
  def things
    self.class.things
  end
end

class Child < Parent
  @things = []
end

Parent.things << :car
Child.things  << :doll
mom = Parent.new
dad = Parent.new

p Parent.things
#=> [:car]
p Child.things
#=> [:doll]
p mom.things
#=> [:car]
p dad.things
#=> [:car]


# Class Variable
class Parent
  @@things = []
  def self.things
    @@things
  end
  def things
    @@things
  end
end

class Child < Parent
end

Parent.things << :car
Child.things  << :doll

p Parent.things
#=> [:car,:doll]
p Child.things
#=> [:car,:doll]

mom = Parent.new
dad = Parent.new
son1 = Child.new
son2 = Child.new
daughter = Child.new

[ mom, dad, son1, son2, daughter ].each{ |person| p person.things }
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
```
### Class Variable Scope
Class variables start with `@@` and are scoped at the __class level__. They exhibit two main behaviors:
  1. All objects _share 1 copy of the class variable_. This also implies objects can access __class__ variables by way of __instance__ methods.
  2. Class methods can access class variables, regardless of where it's initialized.
```ruby
class Person
  @@total_people = 0            # initialized at the class level

  def self.total_people
    @@total_people              # accessible from class method
  end

  def initialize
    @@total_people += 1         # mutable from instance method
  end

  def total_people
    @@total_people              # accessible from instance method
  end
end

Person.total_people             # => 0
Person.new
Person.new
Person.total_people             # => 2

bob = Person.new
bob.total_people                # => 3

joe = Person.new
joe.total_people                # => 4

Person.total_people             # => 4
```
Even when we have two different Person objects in `bob` and `joe`, we're effectively __accessing and modifying one copy__ of the `@@total_people` class variable. We can't do this with instance variables or local variables; only class variables can *share state between objects* (ignoring globals for now). 

### Constant Variable Scope
Constant variables are usually just called __constants__, because you're not supposed to re-assign them to a different value. If you do re-assign a constant, Ruby will warn you (but won't generate an error). Constants begin with a _capital letter and have lexical scope_.
```ruby
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  attr_reader :name

  def self.titles
    TITLES.join(', ')
  end

  def initialize(n)
    @name = "#{TITLES.sample} #{n}"
  end
end

Person.titles                   # => "Mr, Mrs, Ms, Dr"

bob = Person.new('bob')
bob.name                        # => "Ms bob"  (output may vary)
```
Within one class, the rules for accessing constants is pretty easy: it's __available in class methods or instance methods__ (which implies it's accessible from objects). 

Where constant resolution gets really tricky is when *inheritance* is involved, and that's when we need to remember that unlike other variables, constants have lexical scope.

### Lexical Scope
_Lexical scope_ means that the scope of the object remains __limited to where it's defined in the code__.
```ruby
class Car
  WHEELS = 4

  def wheels
    WHEELS
  end
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts civic.wheels # => 4

bullet = Motorcycle.new
puts bullet.wheels # => 4, when you expect the output to be 2
```
When inheriting the `Car::wheels` method, `Motorcycle` class also seems to inherit the value of the constant. This is because for the `Car::wheels` method, the lexical scope of the `WHEELS` constant remains limited to the Car class, despite the inheritance.
```ruby
class Car
  WHEELS = 4

  def wheels
    WHEELS
  end
end

class Motorcycle < Car
  WHEELS = 2

  def wheels
    WHEELS
  end
end

civic = Car.new
puts civic.wheels # => 4

bullet = Motorcycle.new
puts bullet.wheels # => 2
```
Now that we've _explicitly defined_ the `Motorcycle#wheels` method, we get the expected return value because the `Motorcycle::WHEELS` constant is __in lexical scope__.

We can bring the behaviour of constants in line with how we expect other variables by __explicitly specifying the scope of the constant__ in the instance method, by using `self.class::WHEELS`.
```ruby
class Car
  WHEELS = 4

  def wheels
    self.class::WHEELS
  end
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts civic.wheels # => 4

bullet = Motorcycle.new
puts bullet.wheels # => 2
```
