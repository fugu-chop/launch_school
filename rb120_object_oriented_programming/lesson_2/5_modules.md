# Modules

## Table of Contents
- [Single inheritance](#single-inheritance)
- [Multiple inheritance](#multiple-inheritance)

### Single Inheritance
One of the limitations of class inheritance in Ruby is that a __class can only directly sub-class from one super class__. We call this single inheritance. In some situations, this limitation makes it very difficult to accurately model the problem domain. 

For example, suppose we have a new pet animal called `Fish`. These are pets that can swim, and have other characteristics like living in a small bowl, etc. They also can't run or jump, which are methods in our `Pet` class. Obviously, given this new information, some reorganizing of methods is required. 

![Multiple Class Inheritance Diagram](https://d1b1wr57ag5rdp.cloudfront.net/images/oop/lesson2/module_class_hierarchy.png)

This seems fine, except we have `swim` in both the `Dog` class as well as the `Fish` class (the `swim` in `Bulldog`, remember, is to override the one in `Dog`, and therefore performs a different functionality). 

We'd like to __not__ have the same `swim` method in two different classes, but where do we move it to? In Ruby, as in many other languages, you can only sub-class from one parent class.

### Multiple Inheritance
Some programming languages allow classes to directly inherit from multiple classes, a functionality known as multiple inheritance. Ruby's answer to multiple inheritance is by way of _mixing in behaviors_. A class can only sub-class from one parent, but it can mix in *as many modules as it likes*.

The solution is to create a module, called `Swim`, and mix in that module in the appropriate classes.
```
module Swim
  def swim
    "swimming!"
  end
end

class Dog
  include Swim
  # ... rest of class omitted
end

class Fish
  include Swim
  # ... rest of class omitted
end
```
The result is that all the instance methods defined in the `Swim` module are now ready for use in the `Dog` and `Fish` classes. It's as if we copied and pasted the methods right in. 

We can also mix in as many modules as we need to. Mixing in modules, though, does affect the method lookup path (we can look at the effect/order by using the `.ancestors` method).
