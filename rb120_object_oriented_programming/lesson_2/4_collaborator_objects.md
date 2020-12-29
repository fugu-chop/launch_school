# Collaborator Objects

## Table of Contents
- [What is collaboration?](#what-is-collaboration)
- [What is a collaborator object?](#what-is-a-collaborator-object)
- [Working with other objects](#working-with-other-objects)
- [When does collaboration occur?](#when-does-collaboration-occur)
- [Other notes](#other-notes)

### What is collaboration?
Collaboration is a way of modeling relationships between different objects. A collaborative relationship is a relationship of *association* — not of inheritance. 

Collaboration is a *has-a* relationship rather than a *is-a* relationship - for example, a library has books, so there is an __associative__ relationship between objects of class `Library` and objects of class `Book` (contrast this with _inheritance_ - e.g. a dictionary is a book).

### What is a collaborator object?
Objects that are stored as _state within another object_ are also called __collaborator objects__. By assigning a collaborator object to an instance variable in another class’ constructor method definition, you are _associating the two objects with one another_.

We call such objects collaborators because they work in conjunction (or in collaboration) with the class they are associated with. 

Here's an example of a string object acting as a collaborator object for the instance variable `@name`. Collaborator objects are not limited to just strings though, they can be basically anything (essentially, any object that you could assign to the instance variable `@name`, like arrays or hashes).
```
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

joe = Person.new("Joe")
joe.name
=> "Joe"
```
Here's another example of arrays and hashes as collaborator objects:
```
class Person
  def initialize
    @heroes = ['Superman', 'Spiderman', 'Batman']
    @cash = {'ones' => 12, 'fives' => 2, 'tens' => 0, 'twenties' => 2, 'hundreds' => 0}
  end

  def cash_on_hand
    # this method will use @cash to calculate total cash value
    # we'll skip the implementation
  end

  def heroes
    @heroes.join(', ')
  end
end

joe = Person.new
joe.cash_on_hand
=> "$62.00"
joe.heroes

=> "Superman, Spiderman, Batman"
```
Here's an example of using an object instantiated from a class as a collaborator object. 
```
class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
=> #<Person:0x00007fd2092007a0 @name="Robert">

bob.pet
=> nil

bud = Bulldog.new             # assume Bulldog class from previous assignment

bob.pet = bud

bob.pet
=> <Bulldog:0x007fd8399eb920>

bob.pet.class
=> Bulldog

bob.pet.speak
=> "bark!"

bob.pet.fetch
=> "fetching!"
```
For instance, `bob` has a collaborator object stored in the `@pet` variable. When we need that `BullDog` object to perform some action (i.e. we want to *access some behaviour* of `@pet`), then we can go through `bob` and call the method on the object stored in `@pet`, such as `speak` or `fetch` (and chain them together, where available). 

### Working with other objects
Depending on the collaborator object, we may need to modify methods, or how other parts of our program interact with that object.
```
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets
=> [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]

bob.pets.jump
NoMethodError: undefined method `jump' for [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]:Array

bob.pets.each do |pet|
  pet.jump
end
```
Because the `@pets` variable is referencing an array, we cannot simply call the `jump` method on the array. We need to iterate through the array, and call the `jump` method on each of the objects in the array.

### When does collaboration occur?
Here, the collaborator object does not become part of the primary object’s state _until the setter or instance method is invoked elsewhere_, outside of the class definition. Another helpful mental model is: the *collaborative relationship exists in the design (or intention) of our code*.

Collaboration occurs when one object is added to the state of another object (i.e., when a method is invoked on an object). In our example above, collaboration occurs when we define the `BullDog` class, and add it to the `@pets` instance variable.

### Other notes
When we work with collaborator objects, they are usually custom objects (e.g. defined by the programmer and not inherited from the Ruby core library); `@pet` is an example of a custom object. 

Yet, collaborator objects __aren't strictly custom objects__. Even the string object stored in `@name` within `bob` in the code above is _technically a collaborator object_.

Collaborator objects play an important role in object oriented design, since they also represent the _connections between various actors_ in your program. When working on an object oriented program be sure to consider what collaborators your classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem your program aims to solve.