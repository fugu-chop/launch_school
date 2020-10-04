# October 2020
- [1st, Thu](#011020-thu)
- [2nd, Fri](#021020-fri)
- [3rd, Sat](#031020-sat)
- [4th, Sun](#041020-sun)
- [5th, Mon](#051020-mon)

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