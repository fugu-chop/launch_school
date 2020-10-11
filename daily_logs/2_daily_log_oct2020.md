# October 2020
- [1st, Thu](#011020-thu)
- [2nd, Fri](#021020-fri)
- [3rd, Sat](#031020-sat)
- [4th, Sun](#041020-sun)
- [5th, Mon](#051020-mon)
- [6th, Tue](#061020-tue)
- [7th, Wed](#071020-wed)
- [8th, Thu](#081020-thu)
- [9th, Fri](#091020-fri)
- [10th, Sat](#101020-sat)

##### 01/10/20 (Thu)
__*Concepts covered*__<br/>
- Revision
  - Arrays
  - Hashes
  - Other stuff
- RB101 - Lesson 2: Small Programs
  - Rock Paper Scissors game

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
I really enjoy writing logic. Abstracting out bits of logic into methods isn't something I've done a lot of in the past, but I'm really enjoying it for it's troubleshooting benefits, even if it does introduce a bit of complexity around variables' local scope. 

Other little pointers and things to remember from my revision:
- Methods with a `?` in the name should return a boolean as good practice.
- Mutating methods can be expressed as "changing the address space in memory", while non-mutating methods as "changing the variable to point to a different address space".

##### 02/10/20 (Fri)
__*Concepts covered*__<br/>
- RB101 - Lesson 2: Small Programs
  - Coding Tips
  - Rock Paper Scissors Additional Features

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
I encountered some trickiness around methods when building the additional features for Rock Paper Scissors, again determining what a method should return. It's cool being able to use truthiness as a way to shortcut a lot of code and conditional testing. 

##### 03/10/20 (Sat)
__*Concepts covered*__<br/>
- RB101 - Lesson 2: Small Programs
  - Rock Paper Scissors Additional Features
  - Quiz
- RB101 - Lesson 3: Practice Problems
  - Easy 1
  - Easy 2
  - Medium 1
  - Medium 2

__*Time spent*__<br/>
240 minutes

__*Thoughts*__<br/>
I'm getting a better grasp of breaking apart logic into methods, and after having to debug some strangeness, am confident it's definitely the right way to go about programming. 

The only thing I'm concerned about is speed. I heard that the RB109 assignment is only three hours with multiple questions - it took me about 45 minutes to build and troubleshoot one additional feature. I'm hoping with significant practice, I can speed this up. 

The quiz was hard. I have a reasonable intuitive understanding of concepts, but have a hard time verbalising those concepts into writing. This is one criticism I have about the content so far - sometimes the quiz questions are a little vague, while the answers are incredibly pedantic in their semantics. 

I am finding the medium problems quite difficult. It's being able to logically unpack what is required in the question, finding an appropriate method where possible and if not, writing something custom. Where I'm struggling is writing correct syntax to apply logic, as well as applying all of the rules in a sequential manner to figure out what the correct output should be.

A lot of these exercises about `object_ids` changing are honestly really annoying (they're not proactive exercises, just time-consuming reading very verbose methods), and I really question the necessity of learning such specific terminology, so long as we are able to implement them in our code. I will spend tomorrow revising the three blog posts regarding object_ids and how/what things get reassigned when variables are reassigned. 

##### 04/10/20 (Sun)
__*Concepts covered*__<br/>
- Revision
  - Variables, pass by reference/value

__*Time spent*__<br/>
242 minutes

__*Thoughts*__<br/>
The revision was helpful. I don't think I fully absorbed the concepts about variables and pass by reference/value when first going through it. The exercises in Medium 2 (which I'm still not entirely a huge fan of), have helped expose those knowledge gaps. 

I still need to sit down and work them out step by step to understand what each exercise is trying to show me, probably by simplifying the excessively long methods in the exercise. 

After some serious mental crunching, I think I now have a better (although still not 100% solid) understanding of pass by reference versus value in Ruby. 

With some help from the TA's, I've clarified some terminology confusion about *mutating the caller* and *mutating an argument* in a method - a method definition does not have an explicit caller - it takes in an argument, which can be mutated. By contrast, an object calls a method (e.g. `"string".upcase!`).

##### 05/10/20 (Mon)
__*Concepts covered*__<br/>
- PEDAC Group Walkthrough
- Rock Paper Scissors Refactor
- Revision
  - Medium 2 Exercises

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
The PEDAC session was helpful in breaking down a problem I ordinarily would have no idea how to solve. I think now it's just being able to efficiently recall Ruby syntax to actually complete these problems. 

After drastically cutting down on the amount of verbiage in the Medium 2, Question 2 exercise, I think I finally grasp the concept. When we pass arguments to methods, we are passing *values*, __not variables__.

##### 06/10/20 (Tue)
__*Concepts covered*__<br/>
- RB101 - Lesson 3: Practice Problems
  - Medium 2
  - Hard 1
- RB101 - Lesson 4: Ruby Collections
  - Collection Basics
  - Looping

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
After the strangeness of Medium 2 exercises, Hard 1 problems seemed easier. Maybe that's just because the concepts are cumulative, and grasping the concepts initially is the hard bit. Lesson 4 seems relatively straightforward - we've covered this implicitly through all the other lessons so far. 

##### 07/10/20 (Wed)
__*Concepts covered*__<br/>
- RB101 - Lesson 4: Ruby Collections
  - Looping
  - PEDAC Walkthrough

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Today was mainly revision. There was a huge amount of time dedicated to PEDAC on a fairly complex problem. I liked the fact there was a lot of detail, but the presenter on the videos was really...boring. He was clearly very knowledgable, just not a great presenter. 

##### 08/10/20 (Thu)
__*Concepts covered*__<br/>
- RB101 - Lesson 4: Ruby Collections
  - Transformations and Selection
  - Methods (inc. the `Enumerable` module)
  - Practice problems

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
There were a few exercises today where I really enjoyed having to manually write loops instead of relying on library methods. It gives me an opportunity to think about what I'm writing and writing code with intent, rather than classic hack and slash. 

Practice problems are again, very enjoyable. They encourage sequentially thinking through logic, as well as distinguishing what gets returned and how an expression is evaluated.

Multiple assignment still trips me out - it just feels very weird to see two variables, separated by commas without parenthesis being assigned references to objects. 

##### 09/10/20 (Fri)
__*Concepts covered*__<br/>
- RB101 - Lesson 4: Ruby Collections
  - Practice problems
  - Additional practice problems
  - Quiz

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
Once again, the quizzes prove to be exercises in interpretation of what the answers actually mean, rather than what the code actually returns. I'm still finding them vague and hard to answer, even if I know exactly what the code returns. 

Still, they're valuable in making me __very__ carefully consider what code returns. 

##### 10/10/20 (Sat)
__*Concepts covered*__<br/>
- RB101 - Lesson 4: Ruby Collections
  - Quiz
- RB101 - Lesson 5: Advanced Ruby Collections
  - Sorting
  - Nested collections
  - Working with blocks

__*Time spent*__<br/>
242 minutes

__*Thoughts*__<br/>
Spent some time finishing off the quiz. I am still not really happy with how the quiz answers are expressed, since I find the questions vague, but the answers very specific. 

Nested collections and shallow copies was interesting. It feels like a logical extension of how indexed assignment in arrays is mutating - shallow copies mean that the objects in nested collections are now arrays themselves, rather than individual elements like before. 

Using nested blocks for comparison/sorting operations is pretty crazy. It seems pretty logical in hindsight, since it's the same principle as a nested `if` statement, but seeing it in action with `each`, `map` and `select` methods is eye-opening, and seems quite complex, since you have to account for what is returned and what is evaluated.

##### 11/10/20 (Sun)
__*Concepts covered*__<br/>
- RB101 - Lesson 4: Ruby Collections
  - Revision of Methods
- RB101 - Lesson 5: Advanced Ruby Collections
  - Working with blocks revision
  - Working with blocks practice problems
  - Quiz
- RB101 - Lesson 6: Slightly Larger Problems
  - Debugging with pry

__*Time spent*__<br/>
241 minutes

__*Thoughts*__<br/>
Revision was helpful. One of the things that tripped me up was directly invoking a method with a block on the object that's being iterated on. Just a comfort thing, I think. 

For some reason, I really have a hard time reading hashes nested in other collections. I can't seem to process that a hash can have multiple keys and multiple values per key when it's nested. 

The quiz was really challenging. I had to interpret some pretty detailed nested loops without running them. It's very taxing mentally to keep a track of everything that's being returned and how it's being returned. I'm having a bit of difficulty understanding `select` and how it interacts with other methods and sub-blocks. 