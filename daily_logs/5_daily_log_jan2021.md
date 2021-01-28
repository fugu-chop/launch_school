# January 2021 (Total minutes: 3,947)
- [1st, Fri](#010121-fri)
- [2nd, Sat](#020121-sat)
- [3rd, Sun](#030121-sun)
- [4th, Mon](#040121-mon)
- [5th, Tue](#050121-tue)
- [6th, Wed](#060121-wed)
- [7th, Thu](#070121-thu)
- [8th, Fri](#080121-fri)
- [9th, Sat](#090121-sat)
- [10th, Sun](#100121-sun)
- [11th, Mon](#110121-mon)
- [12th, Tue](#120121-tue)
- [13th, Wed](#130121-wed)
- [14th, Thu](#140121-thu)
- [15th, Fri](#150121-fri)
- [16th, Sat](#160121-sat)
- [17th, Sun](#170121-sun)
- [18th, Mon](#180121-mon)
- [19th, Tue](#190121-tue)
- [20th, Wed](#200121-wed)
- [21st, Thu](#210121-thu)
- [22nd, Fri](#220121-fri)
- [23rd, Sat](#230121-sat)
- [24th, Sun](#240121-sun)
- [25th, Mon](#250121-mon)
- [26th, Tue](#260121-tue)
- [27th, Wed](#270121-wed)

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

##### 08/01/21 (Fri)
__*Concepts covered*__<br/>
- Lesson 3
  - Quiz
  - Quiz Review
  - Inheritance and Variable Scope Revision
- Lesson 4
  - Practice Problems: Easy 1
  - Practice Problems: Easy 2
  - Practice Problems: Easy 3

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Something I'm still not 100% comfortable in is defining functionality within superclasses that doesn't work until you create an instance of the subclass - e.g. defining a method in the superclass to require an argument that doesn't get input until an instance method of the subclass is called. It's just very weird to me, coming from a functional programming perspective. 

My level of understanding of OOP principles feels pretty solid so far, based on the Easy problems.

##### 09/01/21 (Sat)
__*Concepts covered*__<br/>
- Lesson 4
  - Practice Problems: Easy 3
  - Practice Problems: Medium 1
  - Practice Problems: Hard 1
- Lesson 5
  - Tictactoe

__*Time spent*__<br/>
191 minutes

__*Thoughts*__<br/>
So far, the Medium problems are a little more engaging, requiring me to think one layer deeper about OOP principles. The Hard problems uncovered some gaps in understanding (e.g. `super` is applicable across all instance methods, not just `initialize`, creating custom functionality on a getter method instead of relying on `attr_reader` and that `self.method_name` is still applicable syntax where that method is defined in a mixed in module and calling those instance methods in another method), which is positive. 

The introduction in Lesson 5 warned us that some of the design elements would seem difficult. This is very much the case for me - if left alone, I don't think I could design an OO skeleton structure that would work (especially choices in respect of where objects and methods should live). I think that once given the skeleton, and an idea of where methods should live, I am able to implement a solution.

##### 10/01/21 (Sun)
__*Concepts covered*__<br/>
- Lesson 5
  - Tictactoe
  - Tictactoe Improvements
  - Tictactoe Discussion
  - Tictactoe Rubocop Fixes

__*Time spent*__<br/>
188 minutes

__*Thoughts*__<br/>
I struggled a bit with the Tictactoe improvements. I think I was relying on the given instructions in the walkthrough too much, so that my mind wasn't in the OO space. I found that when trying to solve problems, I was still reverting to the functional mindset, creating local variables instead of initialising instance variables. 

The idea of encapsulation and dependencies is interesting from a design perspective. What objects should collaborate, and what should be inherited? What interfaces are we interested in? Where should they live?

##### 11/01/21 (Mon)
__*Concepts covered*__<br/>
- Lesson 5
  - Tictactoe Rubocop Fixes
  - Tictactoe Bonus Features

__*Time spent*__<br/>
136 minutes

__*Thoughts*__<br/>
Spent most of today working through adding additional features into Tictactoe. With the current implementation, I'm not entirely sure the methods belong where they are currently. I guess when I get the code review, I can get some feedback.

##### 12/01/21 (Tue)
__*Concepts covered*__<br/>
- Lesson 5
  - Tictactoe Bonus Features

__*Time spent*__<br/>
134 minutes

__*Thoughts*__<br/>
Refactoring code can be somewhat challenging in the OO context, since it might involve creating new classes and shuffling methods around into different classes. It's fun to think about design like this!

##### 13/01/21 (Wed)
__*Concepts covered*__<br/>
- Lesson 5
  - Tictactoe Bonus Features
  - Study session

__*Time spent*__<br/>
146 minutes

__*Thoughts*__<br/>
The study session was very helpful. Being able to discuss concepts in a group environment where people are asking questions is good at uncovering knowledge blind spots. Highly recommended. 

##### 14/01/21 (Thu)
__*Concepts covered*__<br/>
- Lesson 5
  - Tictactoe Bonus Features
  - Revision
    - Encapsulation
    - Polymorphism
    - Inheritance
    - Self
  - Reading
    - [Encapsulation, Polymorphism and Abstraction](#https://vahid.blog/post/2020-11-04-encapsulation-polymorphism-and-abstraction-in-ruby/)
    - [Static v Dynamic Typing](#https://hackernoon.com/i-finally-understand-static-vs-dynamic-typing-and-you-will-too-ad0c2bd0acc7)
  - Twenty-One

__*Time spent*__<br/>
138 minutes

__*Thoughts*__<br/>
I finally finished off the Tictactoe bonus features. That one took a long time, it feels like. I'm still not 100% the design choices I made were optimal (though what is optimal?), as I introduced more dependencies between classes in order to have more conceptually neat classes.

The article on Encapsulation, Polymorphism and Abstraction was an eye-opener. It covered the concepts I was previously aware of, but really joined them together in a fashion I haven't tried to compile yet. It also led me to an interesting article about language typing, which I've continually seen pop up in material, but never really looked into with real detail. 

As far as I can tell, there are two important dimensions for a language when determining typing:
- Static v Dynamic
  - Static: Type of objects checked before running the script (i.e. before run-time/execution)
  - Dynamic: Types checked during execution (so certain `TypeErrors` may never be picked up if their code never executes - e.g. within an `else` clause).
- Compiled v Interpreted
  - Compiled: Code translated before run-time
  - Interpreted: Code translated during execution

##### 15/01/21 (Fri)
__*Concepts covered*__<br/>
- Lesson 5
  - Twenty-One

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
Continuing to work through the Twenty-One project. It's fun! Incrementally building blocks on your program and seeing it evolve in features is very rewarding. 

##### 16/01/21 (Sat)
__*Concepts covered*__<br/>
- Lesson 5
  - Tictactoe Refactor
  - Twenty-One

__*Time spent*__<br/>
128 minutes

__*Thoughts*__<br/>
More coding. I managed to add in some nice UI features. The challenging part is to clean up these ABC errors from Rubocop. These will likely involve some heavy refactoring. 

##### 17/01/21 (Sun)
__*Concepts covered*__<br/>
- Lesson 5
  - Twenty-One
- Exercises
  - Debugging

__*Time spent*__<br/>
189 minutes

__*Thoughts*__<br/>
Refactoring some of the longer methods with ABC alerts in Rubocop was challenging. Basically, the cheap way is simply to extract more logic to more methods. I'm not sure I entirely agree with this logic, since it just creates more sprawl for code without necessarily making it easier to read. It feels good to finally finish off this Twenty-One project as it felt it was dragging on a fair bit.

The Debugging exercises are very tricky for me. They brought up a lot of gaps in my knowledge - in particular determining where a particular method comes from in respect of the method lookup chain and writing custom methods for classes. I'll need to revisit these once I've done a proper revision sweep of concepts.

##### 18/01/21 (Mon)
__*Concepts covered*__<br/>
- Exercises
  - Debugging
  - Medium 1

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
The Medium 1 exercises aren't too bad, though there was one particular problem of a circular queue where it was just really hard to wrap my head around what the specific requirements of the problem were, and I struggled to figure out a way to keep track of two states and implement them in the solution. Still, we move onward.

##### 19/01/21 (Tue)
__*Concepts covered*__<br/>
- Exercises
  - Medium 1
- Revision
  - Pass by Reference v Value

__*Time spent*__<br/>
129 minutes

__*Thoughts*__<br/>
The problems aren't too bad. I just find that in the mornings, my mind is constantly in a fog because I'm exhausted. I'm not sure if this hour of study in the morning is too feasible with my current schedule - I'll need to find a way to sleep more, I think.

##### 20/01/21 (Wed)
__*Concepts covered*__<br/>
- Revision
  - Pass by Reference v Value
- RB120 Quiz

__*Time spent*__<br/>
60 minutes

__*Thoughts*__<br/>
A light day today. I used the opportunity to sleep in the morning. The quiz actually wasn't too hard in this particular instance. Just a bit of thinking about design choices, understanding the namespace resolution operator and understanding the various steps to expose methods to a class. We begin the RB129 preparation!

##### 21/01/21 (Thu)
__*Concepts covered*__<br/>
- Revision
  - Forum posts

__*Time spent*__<br/>
135 minutes

__*Thoughts*__<br/>
The forum is a pretty mixed bag of topics. One point of confusion is whether we should treat the `initialize` method as a constructor. The OO book designates the `initialize` method as a constructor, but a forum post by a TA, argues that a constructor instantiates an object (which would be the `new` method). Not sure what to use here.

I also need to make a note to practice reading OO code - i.e. "be able to read through and have a mental model of how various pieces of the program function and work together". I think I can do this by going through all of the longer applications in this course (including solutions by other students), as well as the examples, to describe what is happening.

##### 22/01/21 (Fri)
__*Concepts covered*__<br/>
- Revision
  - Forum posts
  - The `||=` operator
  - The object model

__*Time spent*__<br/>
124 minutes

__*Thoughts*__<br/>
I read an interesting forum post on singleton methods, the premise of which is that custom classes are really objects instantiated from the `Class` class. Therefore, class methods defined in a custom class are really just instance methods of the custom class object.

It then went onto an exploration about whether these class methods are duplicated or reused when inherited. Long story short, they are reused, and not duplicated. Class methods belong to a specific instance of that custom class (again, which is itself an object). These are called singleton methods. There's more detail, but it doesn't really seem too relevant to what I'm studying now (and I don't see how practically, this is a useful detail).

##### 23/01/21 (Sat)
__*Concepts covered*__<br/>
- Revision
  - Classes and objects
  - Attributes v State

__*Time spent*__<br/>
181 minutes

__*Thoughts*__<br/>
The early revision started off on a confusing note. Defining attributes versus state is still a little fuzzy in my mind, but here's what I take away:
- Distinguishing between attributes and state is useful in respect of inheritance - attribute methods are inheritable, but the attribute names and values (and by extension, state) are __not__ inheritable, since they are tied to objects. 
- An attribute exists if it captures an instance variable and value, and that value is accessible outside of the class through a getter and/or setter method. If an instance variable exists, but is not accessible outside of the class, then it is __not__ an attribute, but simply contributes to state in an object instantiated from the class.
- State represents all of the instance variables and values for a particular object. 

##### 24/01/21 (Sun)
__*Concepts covered*__<br/>
- Revision
  - Inheritance
  - Modules
  - Method Access Control
  - Collaborator objects

__*Time spent*__<br/>
182 minutes

__*Thoughts*__<br/>
I had some confusion around collaborator objects (yet again) - specifically, there was a forum post about some buggy code where it was stated that when an object was instantiated from a subclass, the superclass was also needed. Hence I'm not sure whether there needs to be an instance of the superclass created somewhere...

##### 25/01/21 (Mon)
__*Concepts covered*__<br/>
- Revision
  - OO Code Implementation
  - Equivalence
  - Variable Scope (inc. Constants & Lexical scope)

__*Time spent*__<br/>
127 minutes

__*Thoughts*__<br/>
An update on yesterday's question. The `new` method is the only way through which an object is instantiated (for our purposes). I misunderstood the explanation for an infinite loop of collaborator object creation, which threw me. It's all good now. 

##### 26/01/21 (Tue)
__*Concepts covered*__<br/>
- Revision
  - Variable Scope (Constants, Namespace Resolution Operator)
  - Fake Operators
  - Lesson 3 Quiz
  - Lesson 4 Practice Problems

__*Time spent*__<br/>
119 minutes

__*Thoughts*__<br/>
Today was a public holiday, which should have been easy to complete my study for the day. However, I just felt really low and didn't particularly feel like studying. I didn't do any in the morning, which meant I was cramming all of my study towards the last two hours of the day before I went to bed, which is not particularly enjoyable. I probably won't do this again. 

Again, I'm still a little bit confused about instance variable scope in the context of inheritance. From what I understand, instance variables __cannot be inherited__; they are not defined by classes but are simply created when objects of that class are instantiated. However, even though instance variables can be defined in the superclass, they are actually still available in subclasses, which kind of confused me. 

The proper explanation is that accessing instance variables in subclasses relies on methods being defined (and the instance variable being created) in the superclass - thus these methods are then inherited and accessible to the subclass (hence the instance variables created in the superclass are accessible). 

##### 27/01/21 (Wed)
__*Concepts covered*__<br/>
- Revision
  - Lesson 4 Practice Problems
  - OOP Exercises

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
I've finally covered off reading through the material for the written test component. After finishing off the last two exercise modules, I can start on the practice problems and start typing out my answers. There's a few things I know I'm still fuzzy on:
  - Core definitions
  - Method access control
  - Instance methods
  - super
  - Inheritance
  - Attributes and State
  - Lexical scope

##### 28/01/21 (Thu)
__*Concepts covered*__<br/>
- Revision
  - OOP Exercises

__*Time spent*__<br/>
124 minutes

__*Thoughts*__<br/>
I didn't get to do the second round of revisions of unclear topics. Some of the exercises were pretty hairy - especially some of the edge cases around method access control, exception handling and variable shadowing when there are two instances of the same local variable in a method. 
