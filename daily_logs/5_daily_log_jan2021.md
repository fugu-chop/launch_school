# January 2021 (Total minutes: 1029)
- [1st, Fri](#010121-fri)
- [2nd, Sat](#020121-sat)
- [3rd, Sun](#030121-sun)
- [4th, Mon](#040121-mon)
- [5th, Tue](#050121-tue)
- [6th, Wed](#060121-wed)
- [7th, Thu](#070121-thu)

##### 01/01/21 (Fri)
__*Concepts covered*__<br/>
- OOP Revision
  - Zetcode
  - Codecademy
  - Inheritance Notes

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Starting the new year as I mean to finish it - with coding. Today was another revision session. I finished most of the Lesson 1 related content and moved onto Lesson 2. It's interesting to read different tutorials and the way they structure their content. It feels a little bit all over the place.

##### 02/01/21 (Sat)
__*Concepts covered*__<br/>
- Lesson 1 Revision
  - Inheritance Notes
- Lesson 2 Revision
  - Polymorphism & Encapsulation
  - Collaborator objects
  - Modules
- Lesson 2
  - OO Rock Paper Scissors Design

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I've decided to cut down my weekend revision to 6 hours over the two days. 8 hours was tough over the past several months, but not really doable since lockdown has been over, since I have too many other life obligations to study that much and still get everything else I need done. I'm going to try study a bit more during the week to make up for this (perhaps 2 additional hours during the week).

Today was full of life stuff that prevented me from properly studying. I basically drove about 70% of the day.

I had some confusion around some usage of `self` within duck-typing, but I was confusing classes with objects instantiated from objects. Duck-typing almost seems like a trial and error way of creating polymorphism.

##### 03/01/21 (Sun)
__*Concepts covered*__<br/>
- Lesson 2
  - OO Rock Paper Scissors Design
  - OO Rock Paper Scissors basic implementation
  - CRC cards
  - RPS bonus features

__*Time spent*__<br/>
216 minutes

__*Thoughts*__<br/>
The Object Oriented way of thinking is still a little unusual to me - extracting things to classes and objects isn't second nature and will require further practice, especially when thinking about how logic should operate and what values objects and methods should return and how objects should interact with each other.

##### 04/01/21 (Mon)
__*Concepts covered*__<br/>
- Lesson 2
  - RPS bonus features

__*Time spent*__<br/>
199 minutes

__*Thoughts*__<br/>
Rubocop is a handy aid. Refactoring code is pretty fun and challenging. I managed to make it through coding all additional features without any additional Rubocop alerts(?).

##### 05/01/21 (Tue)
__*Concepts covered*__<br/>
- Lesson 2
  - Quiz
  - Collaboration discussion reading
- Lesson 3
  - Equivalence

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Collaborator objects came up in the quiz, and my definition is still fuzzy. I think the key points to take away are:
1. A collaborative relationship exists when there is a direct __has-a__ relationship between the two objects (or, an __association__). Where the relationship is indirect (i.e. there is another class between the two objects), it's unlikely to have a collaborative relationship. 
2. Inheritance operates on an __is-a__ basis. This means that objects instantiated from subclasses __also create an instance of their parent classes__.
3. Since instance variables are only considered part of state when they are initialised, the collaborative relationship exists in *intention*, but not in actuality until that instance variable is initialised (e.g. through an `initialize` method, or through calling a method that assigns an object to an instance variable).

##### 06/01/21 (Wed)
__*Concepts covered*__<br/>
- Lesson 2
  - RPS Bonus Refactor
- Lesson 3
  - Equivalence
  - Variable Scope

__*Time spent*__<br/>
124 minutes

__*Thoughts*__<br/>
Refactoring code is a good way to refresh concepts, as well as revisit design choices. It's quite fun. Lexical scope was introduced as a concept, which is a little bit confusing - a variable retains it's value based on where it was defined, which creates confusion during inheritance. 

##### 07/01/21 (Thu)
__*Concepts covered*__<br/>
- Lesson 3
  - Variable Scope revision
  - Inheritance and Variable Scope
    - Revision
  - Fake Operators
  - Exceptions

__*Time spent*__<br/>
130 minutes

__*Thoughts*__<br/>
Not much to comment on here. Churning through material. Handling exceptions seems like a pretty useful thing to be able to do, but I need to remember to never rescue the `Exception` class, such that we can ensure our program actually does what we want it to do.

Revising lexical scope for constants is instructive. It acts so differently from class and instance variables, and throws a real spanner in code when trying to inherit, or mix in modules into a class. Definitely something to watch out for. 
