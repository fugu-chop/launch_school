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
- [11th, Sun](#111020-sun)
- [12th, Mon](#121020-mon)
- [13th, Tue](#131020-tue)
- [14th, Wed](#141020-wed)
- [15th, Thu](#151020-thu)
- [16th, Fri](#161020-fri)
- [17th, Sat](#171020-sat)
- [18th, Sun](#181020-sun)
- [19th, Mon](#191020-mon)
- [20th, Tue](#201020-tue)
- [21st, Wed](#211020-wed)
- [22nd, Thu](#221020-thu)

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

##### 12/10/20 (Mon)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Debugging with pry
  - Tictactoe implementation

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I spent a decent amount of time playing around with `pry` and `pry-byebug`, which is a super helpful tool - being able to access variable values mid-execution is a gamechanger. 

I also spent some time debugging a block of code I wasn't sure about - I *think* my conclusion is that the `Array#select` method is equivalent to `any?`, in that it will return the whole nested subarray if __any__ of the nested elements return `true`. 

The tictactoe game is interesting to code in Ruby. As there's no visual element like there is HTML for Javascript, this makes for some incredibly ugly ASCII art, which I am getting a good laugh out of. 

##### 13/10/20 (Tue)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Tictactoe implementation
- Revision
  - `select` method

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
A cool tip I learned is the ability to turn an object into a boolean, via the `!!` method. This can be a quick method of determining whether something exists (`true`) or not (`false`).

After some further investigation, my conclusion yesterday about the `select` method was incorrect. The key to understanding was that `select` will __always__ return a collection, even if that collection is empty (e.g. if no true conditions are evaluated). This has implications for nested `select` calls, since `select` only cares about the truthiness of what is passed to it, and __empty arrays are still truthy__.

##### 14/10/20 (Wed)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Tictactoe code review (splat operator)
  - Tictactoe rubocop & refactor
  - Tictactoe enhancements (joiner method, incrementing scores)

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
Recently, I've been having some concern about the pace at which I'm going. I feel like I'm moving too quickly to fully absorb everything I'm learning, but too slowly to achieve my goals. I realise this is the sort of thinking that is the opposite of mastery based learning. 

I spent a decent amount of time just unpicking code and reading about the splat operator, trying to understand what it does. I found this to be very useful, as well as reduce some concerns about whether the pace at which I'm going is "right". 

> It does not matter how slowly you go, as long as you do not stop. 

I spent time doing the enhancements to the Tictactoe project, making sure to write out the steps required before I started coding, just to get some rudimentary PEDAC practice. It's definitely helpful, and getting me to think through the problem. 

##### 15/10/20 (Thu)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Tictactoe enhancements (victory condition, AI defense)
  - Tictactoe debugging (`score` not updated on last move, `joiner` punctuating a single element)

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
I worked on the AI defense portion of the Tictactoe problem. After some major struggling at finding appropriate syntax to return an array (`.select` really annoys me), I was able to come up with a method that can give a single choice for the computer. 

I also encountered a bug - `pry-byebug` was incredibly helpful in actually stepping through the code - my method doesn't exclude already chosen squares, so it basically does nothing. I need to fix this tomorrow. It's very satisfying being able to bug fix, after all the initial frustration. I feel like I'm in a good spot to solve this tomorrow.

##### 16/10/20 (Fri)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Tictactoe enhancements 
    - AI offense
    - AI enhancements
    - Player order
    - Refactor game loop logic

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
Really fun session again. It's super rewarding to get a working piece of code that's reasonably complex. 

I also learned to take advantage of how `||` is evaluated - if you're going to set a reference for a particular variable, and one of those conditions could be falsy, but the other one will always return a truthy value, you don't need an `if/else` statement - just use `var = condition_falsy || condition_truthy` instead.

Also, the `&` operator is super handy to get common elements of two arrays, in a new array. 

##### 17/10/20 (Sat)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Tictactoe enhancements 
    - Refactor game loop logic
  - Twenty-One
    - Setting up the deck and shoe
    - Player turn (inc. inputs)
    - Dealer turn

__*Time spent*__<br/>
245 minutes

__*Thoughts*__<br/>
I started on the Twenty-One assignment, which is a simplified blackjack. Again, I really enjoy this type of work where I can build sequences of logic that rely on other bits of logic, like a scaffold. 

Once again, I failed to read the assignment fully, and went off on a tangent, trying to code sequential player and dealer turns. Thankfully most of the code I wrote was still usable as is, but I did lose a fair bit of my win condition code, which needs to be re-written. 

It's another reminder to slow down, and fully read the requirements.

##### 18/10/20 (Sun)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Twenty-One
    - Win conditions
    - Win display messages
    - Refactor display methods
    - Review the Launch School solution
    - Bonus Features (score tally, arbitrary values, caching hand totals as variables)
  - Tictactoe refactor

__*Time spent*__<br/>
244 minutes

__*Thoughts*__<br/>
Working through the Twenty-one assignment - the bonus features suggested didn't really apply that much to my program, as there isn't too much repetition of methods. I think one thing I could do better is not make methods take other methods as arguments, as this increases the complexity of reading code. 

Another important factor I remember reading about (and encountered again in this assignment) was the `while` loop - the `while` keyword can restrict the entire loop from executing at least once. 

I'm really glad for the code reviews Launch School provides. Ordinarily I would just be smashing logic into the one place, but having an experienced eye suggest specific things to clean up code is very helpful. I'll need to continue to keep an eye on the length of my methods, but I find refactoring to be a useful exercise. 

##### 19/10/20 (Mon)
__*Concepts covered*__<br/>
- RB101 - Lesson 6: Slightly Larger Problems
  - Twenty-One
    - Refactor
  - Tictactoe
    - Refactor
  - Quiz & Feedback
- RB109 - Assessment
  - Reading about assessments, some blog posts, study guides

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I spent some time aggressively refactoring my Twenty-One script according to the feedback I got from Tictactoe. Hopefully it should pass muster. 

I finally finished the RB101 coursework. It was a journey, that's for sure. I'm quite proud of myself in how far I've come in being able to decompose problems, as well as create somewhat production ready code (smaller methods, shorter logic) as opposed to my old, massive scripts with lots of repetition. 

I'll start the Launch School problems tomorrow for RB109 preparation. I'm looking forward to seeing how my comprehension of the materials has been so far, on the first pass of the course materials. 

Codewar Katas are also on my list of to-dos. Apparently being able to solve difficult 6 kyu and easier 5 kyu problems is a good benchmark to be ready for the interview. 

##### 20/10/20 (Tue)
__*Concepts covered*__<br/>
- RB101 - Slightly Larger Problems
  - Twenty-One Refactor

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
The refactor of logic into methods was absolutely hellish, due to:
1. Method scoping rules - I wasn't able to replace local variables initiated outside of methods, without resorting to hashes or arrays with mutating methods. 
2. Methods only really being able to return a single object, whereas in a loop in the local scope, you can reassign variables as and when needed. 

Ultimately, I'm not sure how beneficial the refactor was. The main loop is about 50% shorter, but the overall code length is about 20% longer - I'm not sure which one has a more severe impact on performance here. 

This took way longer than expected, but was good experience in extensive debugging and general programming pain. 

##### 21/10/20 (Wed)
__*Concepts covered*__<br/>
Problem solving videos

__*Time spent*__<br/>
131 minutes

__*Thoughts*__<br/>
Today was mostly focused on watching problem solving videos, which were examples of PEDAC. It was a nice change of pace from refactoring and being deep in lower levels of abstraction in code. There's some more videos to watch, so that will probably take up tomorrow's time, before I jump into the exercises.

##### 22/10/20 (Thu)
__*Concepts covered*__<br/>
- Beginning Ruby videos
  - Syntactical sugar, where code comes from, and variable scope
  - Pass by reference/value, variables as pointers, method side-effects vs return value

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
The videos I watched, despite aimed at beginners and covering topics I've learned already, still surfaced new concepts. I'm still at a stage in my learning that I'm always finding new and interesting things. It did make me realise that despite the content being great and useful, Launch School isn't the best at surfacing this stuff - it's sometimes tucked away and quite hard to find.

##### 23/10/20 (Fri)
__*Concepts covered*__<br/>
- Beginning Ruby videos
  - Collections
- RB101-109 Small Problems
  - Documentation Again
  - Easy 1

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
I'm still having a bit of trouble finding and interpreting documentation. I need to make sure to reference what class a particular method is being invoked on, and then look within the list of methods in that class to make sure I'm looking at the right thing. 

Easy 1 problems are reasonably straightforward so far. I just need to become a bit more familiar with some of the syntactic sugar available in Ruby. 

##### 24/10/20 (Sat)
__*Concepts covered*__<br/>
- RB101
  - Shallow copy revision
  - Pass by reference versus value
- RB101-109 Small Problems
  - Easy 1
  - Easy 2
  - Easy 3
  - Easy 4

__*Time spent*__<br/>
242 minutes

__*Thoughts*__<br/>
Happily, all of the exercises in the Easy collections have been pretty easy so far, though they have been useful in uncovering some areas I need to revise - particularly in explaining pass by reference and pass by value, especially in the context of mutating methods. 