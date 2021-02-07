# From Quiz 2 #

* Running the following code will _not_ produce the output shown on the last
  line. Why not? What would you need to change?
    ```ruby
    class Student
      attr_accessor :grade

      def initialize(name, grade=nil)
        @name = name
      end 
    end

    ade = Student.new('Adewale')
    ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">
    ```
 
* What is a collaborator object? Give an example in code as part of your
  explanation.

* What are the differences between classes and modules? (give at least 3)

* When would you want to use class inheritance vs. a mixin? Give an example in
  code.

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
    - You decide that the application also needs a Conversion module that contains some temperature
        and measurement conversion methods required by Recipe and Ingredient objects. 
    - Describe the relationships between the classes you've identified (are they sub/super classes?, 
      are they modules?, are they collaborators?)
    - Write a skeleton of the class structure in code.
