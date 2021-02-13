# From Quiz 2 #

* Running the following code will _not_ produce the output shown on the last line. Why not? What would you need to change?
  ```ruby
  class Student
    attr_accessor :grade

    def initialize(name, grade=nil)
      @name = name
      #initialise the instance variable here
      @grade = grade
    end 
  end

  ade = Student.new('Adewale')
  ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">
  ```
  The above code will not output the displayed output, as the `@grade` instance variable is never initialised when the `ade` object is instantiated from the `Student` class. As such, the `@grade` instance variable never becomes part of `ade`'s state. 
  
  The `initialize` method is responsible for initialising instance variables and assigning them values after the object is instantiated - however in our implementation, we don't define `@grade` - the argument `grade = nil` is simply ignored by the `initialize` method.

* What is a collaborator object? Give an example in code as part of your explanation.

  A collaborator object is anything that is assigned to an instance variable when an object is instantiated and instance variables initialised. It is part of an object's state and useful for modelling associative relationships between objects (i.e. "has-a" relationships).

  In our example below, we instantiate a `ted` object from the `Dog` class, passing in the string object "Ted" as an argument. When the object is instantiated, the `initialize` method is called, which initialises the `@name` instance variable and assigns the "Ted" string to `@name`. At this point, the string object "Ted" is a collaborator object (`ted` "has a" name), since it is assigned to the `@name` instance variable and is thus now part of `ted`'s state. 
  ```ruby
  class Dog
    def initialize(name)
      @name = name
    end
  end

  ted = Pet.new("Ted")
  ```
* What are the differences between classes and modules? (give at least 3)
  - Classes can only directly inherit from a single class. Modules can be mixed into any number of classes
  - Objects cannot be instantiated from modules, while any number of objects can be instantiated from a class
  - Modules can be used for namespacing (organising classes), while classes are their own entity.

* When would you want to use class inheritance vs. a mixin? Give an example in code.

  We may want to use class inheritance when there is a logical hierarchical relationship between two classes, and we want the subclass to inherit the methods available in the superclass. We want to use a mixin when we have classes that don't fit into a logical hierarchical relationship (i.e. are unrelated by class hierarchy).
  ```ruby
  module Flyable
    def fly
      puts "I can fly!"
    end
  end

  class Animal
    def speak
      puts "I am a #{self.class}!"
    end
  end

  class Dog < Animal
  end

  class Bird < Animal
    include Flyable
  end

  class Plane
    include Flyable
  end
  ```
  In our example above, the `Bird` class is a subclass of `Animal` (i.e. a `Bird` is an `Animal`), and so it makes sense that we want `Bird` to inherit the instance method defined in the `Animal` class. 

  The `Plane` class isn't related to the `Animal` class in a hierarchical fashion (a `Plane` isn't an `Animal`), and it doesn't make sense to define a `fly` instance method (since other classes that subclass `Animal` don't necessarily have the ability to `fly`, like the `Dog` class). As such, in order for objects instantiated from both the `Plane` and `Bird` class to have a `fly` method, we need to mix in the `Flyable` module to both `Bird` and `Plane` classes. This preserves the hierarchical relationship of `Dog` and `Bird` classes subclassing from `Animal`, while only allowing entities (i.e. objects from the `Bird` and `Plane` class) that can fly to do so.

* You're designing a Recipe Book application.
    - You've identified some classes that you need:
        * RecipeBook
        * Recipe
        * StarterRecipe
        * MainCourseRecipe
        * DessertRecipe
        * Ingredient
    - Each Recipe Book has one or more recipes.
    - Starter recipes, main course recipes, and dessert recipes are all recipe types and share some
    characteristics but not others.
    - Recipes have one or more ingredients.
    - You decide that the application also needs a Conversion module that contains some temperature and measurement conversion methods required by Recipe and Ingredient objects. 
    - Describe the relationships between the classes you've identified (are they sub/super classes?, 
      are they modules?, are they collaborators?)
      
      The `Recipe` class should likely be a collaborator object with the `RecipeBook` class, since this appears to be an associative relationship (i.e. a `RecipeBook` should have a `Recipe`, rather than "is a" recipe). The `StarterRecipe`, `MainCourseRecipe` and `DessertRecipe` should all inherit from the `Recipe` class, since these appear to have a logical hierarchy (they are all more granular expressions of a `Recipe`). `Ingredient` is likely a collaborator object of `StarterRecipe`, `MainCourseRecipe` and `DessertRecipe`, since it would appear that all of these classes "have" `Ingredients`, and that ingredients would vary according to the type of recipe.

    - Write a skeleton of the class structure in code.
    ```ruby
    module Conversion
    end

    class RecipeBook
      def initialize(recipes)
        @recipes = [recipes]
      end
    end

    class Recipe
      include Conversion

      def initialize(ingredients)
        @ingredients = [ingredients]
      end
    end

    class StarterRecipe < Recipe
    end
    
    class MainCourseRecipe < Recipe
    end
    
    class DessertRecipe < Recipe
    end

    class Ingredient
      include Conversion
    end
    ```
