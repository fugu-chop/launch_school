# Classes and Objects I

## Table of Contents
- [States and Behaviours](#states-and-behaviours)
- [Attributes versus State](#attributes-versus-state)
- [Initialising a new object](#initialising-a-new-object)
- [Instance Variables](#instance-variables)
- [Instance Methods](#instance-methods)
- [Accessor Methods](#accessor-methods)
- [Calling Methods with self](#calling-methods-with-self)

### States and Behaviours
We use classes to create objects. When defining a class, we typically focus on two things: __states__ and __behaviors__. 
- *States* track attributes for individual objects (e.g. think of attributes as the collaborator objects assigned to instance variables). 
- *Behaviors* are what objects are capable of doing.

Using our `GoodDog` class from earlier, we may want to create two `GoodDog` objects: one named `"Fido"` and one named `"Sparky"`. They are both `GoodDog` objects, but may contain different information, such as name, weight, and height. 

We would use _instance variables_ to track this information. This should tell you that instance variables are scoped at the _object (or instance) level_, and are how objects keep track of their _states_.

Even though they're two different objects, both `"Fido"` and `"Sparky"` are still objects (or instances) of class `GoodDog` and contain identical behaviors. For example, both `GoodDog` objects should be able to `bark`, `run`, `fetch`, and perform other common behaviors of good dogs. We define these behaviors as __instance methods in a class__. Instance methods defined in a class are available to objects (or instances) of that class.

In summary, instance *variables* keep track of __state__, and instance *methods* expose __behavior__ for objects. State *sets or determines the attributes* of an object. We can think of the _instance variables themselves_ as the __attributes__ (which are shared by __all objects__ of that class) and the *actual objects* referenced by those instance variables as the _state_ (which is specific to each object). 

The __attributes__ (i.e. remember that these need to be accessible by getter/setter methods) of the objects of a class are shared by all objects of the class, and are defined by the instance variables defined by the class. Instance variable __values__ for each individual object keep track of the unique __state__ of each object of a class and are unique to each individual object. 

### Attributes versus State
Another useful mental model is that classes don't define instance variables, they _define attributes_ (since attributes are getter/setter methods that can be inherited). Note that the instance name and variable __behind__ the attribute are not inherited - these are defined when an object is instantiated from the class and are unique to each object.

An *instance variable* is __named by the class__, but each object created from the class __creates its own copy of the instance variable__, and its _value_ contributes to the overall *state* of the object. 

All Ruby objects have a set of instance variables. These are __not defined by the object's class__ - they are simply __created when a value is assigned to them__ (i.e. on object instantiation). Because instance variables are not defined by a class, they are _unrelated_ to subclassing and the inheritance mechanism.

With this definition, note that __the instance variable is actually not part of the class__; therefore, it can't be inherited. The class does know about the name (we can say instance variables are *named* by the class), but the class is merely using that name as a handle for the value it contains.

Ruby's instance variables are __not inherited__ and have nothing to do with the inheritance mechanism. The reason that they sometimes appear to be inherited is that instance variables are _created by the methods that first assign values to them_, and __those methods are often inherited__ or chained (i.e. getter and setter methods).

An *attribute* is an instance variable __name and value__. More specifically, an attribute __must be accessible outside the methods defined by the class__; this means you need either a getter or setter method, or both. You can't access variables (local or instance) outside of a class, but you can access the attributes by using the getter and/or setter. 

If you don't have a getter or setter method, you only have an instance variable and a value (and __not an attribute__), which still contributes to state. An attribute's getter and setter methods will be inherited by a superclass, but the __instance variable name and value behind the attribute do not participate in inheritance__.

Every object has state. State is the *collection of all initialised instance variables and their values defined for an object*. Since state is part of the *object*, not the class, state is __not inherited__.

In summary: 
- A subclass inherits the methods of the superclass.
- Instance variables and their values are not inheritable.
- Attribute getters and setters are methods, so they are inheritable.
- Attribute names and their values are just instance variables and values, so they are not inheritable.
- State is __tied directly to individual objects__, so is not inheritable.

### Initialising a new object
In our code below, we've created the `initialize` method, which gets called every time you create a new object. Calling the `new` class method eventually leads us to the `initialize` instance method. 
```
class GoodDog
  def initialize
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new
=> "This object was initialized!"
```
In the above example, instantiating a new `GoodDog` object triggered the `initialize` method and resulted in the string being outputted. The `initialize` method is a method that automatically/internally gets called when a new instance of the class is created using `Class::new` (contrast it with all other methods you define within a class, which aren't automatically called). Technically it's possible to instantiate an object without `initialize` being invoked (e.g. by calling `allocate` instead of `new`), though this is beyond the scope of the course.

We can see this in action as we can instantiate an object of a class that __doesn't__ have an `initialize` method defined.
```
class MyClass; end
my_obj = MyClass.new
# => #<MyClass:0x000000036ae728>
```
When we think about the `initialize` method, its job is just this: to __initialize variables__ (although it doesn't have to). This is different from a _constructor_, whose job is to __instantiate objects__. Variables __are not objects__ (although they can be assigned to objects), since they are not instantiated from a class.

### Instance Variables
The `@name` variable below is called an __instance variable__. It is a variable that exists as long as the object instance exists and it is one of the ways we tie data to objects. It does not "die" after the `initialize` method is run. It "lives on", to be referenced, until the object instance is destroyed.
```
class GoodDog
  def initialize(name)
    @name = name
  end
end
```
In the above example, our `initialize` method takes a parameter called `name`. You can pass arguments into the `initialize` method through the `new` method.
```
sparky = GoodDog.new("Sparky")
```
The string `"Sparky"` is being passed from the `new` method through to the `initialize` method, and is assigned to the local variable `name`. Within the `initialize` method, we then set the instance variable `@name` to `name`, which results in assigning the string `"Sparky"` to the `@name` instance variable.

We can see that instance variables are responsible for *keeping track of information about the state* of an object. In the above line of code, the name of the `sparky` object is the string `"Sparky"`. This state for the object is tracked in the instance variable, `@name`.

If we created another `GoodDog` object, for example, with `fido = GoodDog.new('Fido')`, then the `@name` instance variable for the `fido` object would contain the string `"Fido"`. Every object's state is _unique_, and instance variables are how we keep track.

__Once initialised__, instance variables are available to instance methods *throughout the class* - this is how instance methods are able to return values without needing to take them as arguments (see below example of string interpolation with the `fido` object).

The instance variables become properties of objects __once objects are created__ using the class. Every object's attributes are assigned *individually* and share *no value with other objects*. 

Instance variables __do not exist prior to an object being created and a value being assigned to them__ (i.e. no inheritance is possible). Consider the following code:
```
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end
end

ade = Student.new('Adewale')
ade 
# => #<Student:0x00000002a88ef8 @name="Adewale">
```
Although we have a `grade` accessor method within our `Student` class, the `@grade` instance variable is __never initialized__ within our code (since it's not initialized as an instance variable within the `initialize` method) and so __can't be considered part of state__ of the `Student` object represented by `ade`. 

Calling `ade.grade` would return `nil` because `@grade` is an uninitialized instance variable and __not__ because we have set its value to `nil` (the `initialize` method ignores the `grade` parameter).

We can also access the instance variables of an object by calling `Object#instance_variables` on the object, or a specific instance variable using `.instance_variable_get("instance_var")`.

### Instance Methods
Instance methods are how we attach functionality to our objects. 
```
class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
sparky.speak
```
When you run this program, nothing happens. This is because the `speak` method returned the string `"Arf!"`, but we now need to print it out, using the `puts` method.
```
fido = GoodDog.new("Fido")
puts fido.speak
=> Arf!
```
Our second `fido` object can also perform `GoodDog` behaviors. Again, all objects of the same class have the same behaviors, though they contain different states; here, the differing state is the *name*.

We can use string interpolation and change our speak method to this (other code omitted):
```
def speak
  "#{@name} says arf!"
end
```
### Accessor Methods
What if we wanted to print out only `sparky`'s name? We could try the code below:
```
puts sparky.name
NoMethodError: undefined method `name' for #<GoodDog:0x007f91821239d0 @name="Sparky">
```
A `NoMethodError` means that we called a method that doesn't exist or is unavailable to the object. If we want to access the object's name, which is __stored in the `@name` instance variable__, we have to *create a method that will return the name*. We can call it `get_name`, and its only job is to return the value in the `@name` instance variable.
```
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name

=> "Sparky says arf!"
=> "Sparky"
```
We now have a __getter__ method. But what if we wanted to change `sparky`'s name? That's when we reach for a __setter__ method. It looks a lot like a __getter__ method but with one small difference.
```
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def set_name=(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.get_name
=> "Sparky says arf!"
=> "Sparky"

sparky.set_name = "Spartacus"
puts sparky.get_name
=> "Spartacus"
```
Note that in Ruby, setter methods always return the _argument that was passed in_, even when you add an explicit return statement, or mutate the argument within the method body.

The first thing you should notice about the setter method `set_name=` is that Ruby gives us a special syntax to use it. 

To use the `set_name=` method normally, we would expect to do this: `sparky.set_name=("Spartacus")`, where the entire `set_name=` is the method name, and the string `"Spartacus"` is the argument being passed in to the method. 

Ruby recognizes that this is a setter method and allows us to use the more natural assignment syntax: `sparky.set_name = "Spartacus"`. When you see this code, just realize there's a method called `set_name=` working behind the scenes, and we're just seeing some Ruby *syntactical sugar*.

Accessor methods allow us to interact with instance variables __outside of the class__ (i.e. after the object has been created).

As to whether we __should__ have getters or setters (or work directly with the instance variable), consider the following:
- Should users of my class be able to directly access the state represented by an instance variable? If so, then I have to use a getter. Otherwise, no getters (use an instance variable) unless I make them private (we can still handle getting state through other instance methods in the class).
- Should users of my class be able to directly change the state represented by an instance variable? If so, then I have to use a setter. Otherwise, no setters (use an instance variable) unless I make them private (again, private does not stop other instance methods from changing state).

Also consider: having all your state accessed by an instance variable (i.e. __not__ through a getter/setter method) makes it really easy to see where your state is being set and used. 

#### Naming convention
Finally, as a convention, Rubyists typically want to name those getter and setter methods using the same name as the instance variable they are exposing and setting.
```
class GoodDog
  def initialize(name)
    @name = name
  end

  def name                  # This was renamed from "get_name"
    @name
  end

  def name=(n)              # This was renamed from "set_name="
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.name
=> "Sparky"

sparky.name = "Spartacus"
puts sparky.name
=> "Spartacus"
```
Writing those getter and setter methods took up a lot of room in our program for such a simple feature. And if we had other states we wanted to track, like height or weight, the class would be even longer. 

#### Attribute accessors
Because these methods are so commonplace, Ruby has a built-in way to automatically create these getter and setter methods for us, using the `attr_accessor` method. Remember, that these represent __instance methods that retrieve/create instance variables__ and enable us to __read and/or write__ those instance variables.
```
class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name
=> "Sparky"

sparky.name = "Spartacus"
puts sparky.name
=> "Spartacus"
```
The `attr_accessor` method takes a *symbol as an argument*, which it uses to create the method name for the getter and setter methods. That one line replaced two method definitions.

But what if we only want the getter method without the setter method? Then we would want to use the `attr_reader` method. It works the same way but only allows you to __retrieve__ the instance variable. 

If you only want the setter method, you can use the `attr_writer` method. All of the `attr_*` methods take a _symbol as parameters_. If there are more states you're tracking, you can use this syntax:
```
attr_accessor :name, :height, :weight
```
#### Examples of Accessor methods
With getter and setter methods, we have a way to expose and change an object's state. We can also use these methods from within the class as well. In the previous section, the `speak` method referenced the `@name` instance variable, like below:
```
def speak
  "#{@name} says arf!"
end
```
Instead of referencing the instance variable directly, we want to use the `name` getter method that we created earlier, and that is given to us now by `attr_accessor`. Remember, `attr_accessor` __creates instance methods that reference instance variables__ - our change from the instance variable to the instance method is effectively the same thing, just a different method of getting the instance variable.
```
def speak
  "#{name} says arf!"
end
```
By removing the `@` symbol, we're now calling the instance *method* (and using it's return value), rather than the instance *variable*. Why not just reference the `@name` instance variable, like we did before? 

Technically, you could just reference the instance variable, but it's generally a good idea to call the getter method instead. It's much easier to just reference a getter method, and make the change in that one method, especially if your getter method does something more than just return the instance variable (e.g. unit conversions, or applying formatting/arithmetic).

Suppose we added two more states to track to the GoodDog class called "height" and "weight":
```
attr_accessor :name, :height, :weight
```
This one line of code gives us six getter/setter instance methods: `name`, `name=`, `height`, `height=`, `weight`, `weight=`. It also gives us three instance variables: `@name`, `@height`, `@weight`. 

Now suppose we want to create a new method that allows us to change several states at once, called `change_info(n, h, w)`. The three arguments to the method correspond to the new name, height, and weight, respectively. We could implement it like this:
```
def change_info(n, h, w)
  @name = n
  @height = h
  @weight = w
end
```
Our code now looks like this:
```
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end
```
Note the change to the `initialize` method and also the new method `change_info`. Finally, we created another method called `info` that displays all the states of the object, just for convenience.

We first use the `initialize` method to create our objects with instances variables, and print out the info using the `info` method.
```
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info
=> "Sparky weighs 10 lbs and is 12 inches tall."

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info
=> "Spartacus weighs 45 lbs and is 24 inches tall."
```
### Calling methods with self
Just like when we replaced accessing the instance variable directly with getter methods, we'd also like to do the same with our setter methods. Let's change the implementation of the `change_info` method to this:
```
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end
```
However, with this change, when we call the `change_info` method, nothing changes.
```
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info
=> "Sparky weighs 10 lbs and is 12 inches tall."
```
The reason our setter methods didn't work is because Ruby thought we were initializing *local* variables. Recall that to initialize or create new local variables, all we have to do is `x = 1` or `str = "hello world"`. 

It turns out that instead of calling the `name=`, `height=` and `weight=` setter methods, what we did was create three new local variables called `name`, `height` and `weight`. 

To disambiguate from creating a local variable, we need to use `self.name=` to let Ruby know that we're calling a method. So our `change_info` code should be updated to this:
```
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```
This tells Ruby that we're __calling a setter method__, not creating a local variable. To be consistent, we could also adopt this syntax for the getter methods as well, though it is not required. In fact, it appears to be generally accepted convention that getter methods do not have `self` prepended to them.
```
def info
  "#{self.name} weighs #{self.weight} and is #{self.height} tall."
end
```
Now, the returned result is as expected:
```
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info
=> Spartacus weighs 45 lbs and is 24 inches tall.
```
Prefixing `self.` is not restricted to just the accessor methods; you can use it with any instance method. For example, the `info` method is not a method given to us by `attr_accessor`, but we can still call it using `self.info`:
```
class GoodDog
  # ... rest of code omitted for brevity
  def some_method
    self.info
  end
end
```
It's generally safer to use an explicit `self.` caller when you have a setter method unless you have a good reason to use the instance variable directly. We say that calling the setter method, if available, is safer since using the instance variable _bypasses any checks or operations performed by the setter_:
```
def mileage=(miles)
  @mileage = miles.to_i
end
```
Here, when you use the setter method elsewhere in your class, you're guaranteed that it will try to apply `#to_i` to the value. If you don't use the setter, you may set the `mileage` to a string value.
