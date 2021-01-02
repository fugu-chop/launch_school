# September 2020 (Total minutes: 3,321)
- [10th, Thu](#100920-thu)
- [11th, Fri](#110920-fri)
- [12th, Sat](#120920-sat)
- [13th, Sun](#130920-sun)
- [14th, Mon](#140920-mon)
- [15th, Tue](#150920-tue)
- [16th, Wed](#160920-wed)
- [17th, Thu](#170920-thu)
- [18th, Fri](#180920-fri)
- [19th, Sat](#190920-sat)
- [20th, Sun](#200920-sun)
- [21st, Mon](#210920-mon)
- [22nd, Tue](#220920-tue)
- [23rd, Wed](#230920-wed)
- [24th, Thu](#240920-thu)
- [25th, Fri](#250920-fri)
- [26th, Sat](#260920-sat)
- [27th, Sun](#270920-sun)
- [28th, Mon](#280920-mon)
- [29th, Tue](#290920-tue)
- [30th, Wed](#300920-wed)

##### 10/09/20 (Thu)
__*Concepts covered*__<br/>
- CLI commands and navigation
- CLI environmental variables
- Permissions
- Reading on oral and written assessments (applicable to future modules)

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
Nothing too heavy so far. I've used the CLI pretty frequently through my 6 months or so of tutorials. I'm relatively familiar with navigation, so that didn't take too long. Practice was the most time consuming aspect of this. 

The environmental variable section was interesting - it's pretty similar to setting variables in other languages, and it gives me an idea of how to play around with my zsh settings. I'd previously just downloaded `.zshrc` files without really understanding what it was, or how it worked.

The idea of the `PATH` environmental variable is pretty cool. It's a shortcut for CLI to reference commands without the user having to specify the exact location where those commands are saved. 

Permissions is the newish content for me. Taking a little longer to wrap my head around it. 

##### 11/09/20 (Fri)
__*Concepts covered*__<br/>
- Permissions, sudo (CLI)
- Changing context (CLI)
- Using irb versus CLI (Ruby)
- Styling in Ruby
- Codecademy - Introduction to Ruby
  - Data types
  - Variable assignment
  - General math operations
  - Some useful methods
- Codecademy - Control flow in Ruby
  - `if` statements
  - Comparison operators (including `&&`, `||`, `!`)

__*Time spent*__<br/>
130 minutes

__*Thoughts*__<br/>
Finished off the book on the CLI. Permissions was a lot of stuff, but explained quite well and intuitively with examples in the book. Definitely helpful. 

I like how the Codecademy syntax seems to match the Rubocop style guidelines. Executing `.rb` files in the CLI is pretty slow.

Comparison operators are pretty similar to JS, which I am somewhat familiar with. String interpolation uses a different character to template strings in JS (`#` versus a `$`).

##### 12/09/20 (Sat)
__*Concepts covered*__<br/>
- Codecademy - Control flow in Ruby
  - Comparison operators practice
- Codecademy - Loops and iterators
  - `while`, `until`, `for` loops
  - `next` keyword
  - Iterators (`loop do end`, `.each`, `x.times`)
  - `.split()`
- Codecademy - Arrays and hashes
  - How to create hashes
  - How to iterate through an array and hash
- Codecademy - Methods, Blocks & Sorting
  - What is a method?
  - Method syntax & terminology
  - Blocks (anonymous functions)
  - Sorting

__*Time spent*__<br/>
242 minutes

__*Thoughts*__<br/>
Ruby is interesting, in that there appear to be multiple obvious ways of doing the exact same thing - e.g. `while` versus `until` loops and `loop do end` all seem to achieve the exact same thing, I'm not really sure why so many options exist, unless there is some performance variation.

Loops and ~~functions~~ methods are generally where the power of programming starts to be observed, so this is probably where things start to get interesting and useful. 

The face that what I regard as a `function` in other languages is called a `method` in Ruby is a bit disconcerting - I've always regarded methods as those `.action()` things you see appended to objects. Ruby treats calls these `.action()` methods `blocks`, which are equivalent to lambda functions in Python. 

Getting up early in the morning is pretty handy - it's really the only extended period of time that I can work without interruptions. Timing myself while working also keeps me accountable. 

##### 13/09/20 (Sun)
__*Concepts covered*__<br/>
- Codecademy - Hashes and Symbols
  - Revision on hash notation
  - Symbols
  - Syntax for symbols as keys
  - Converting symbols to strings
  - `Case when` statements
- Codecademy - The Zen of Ruby
  - One line `if`, `unless` statements
  - Folded `case when`
  - Conditional assignment
- Codecademy - Blocks, Procs & Lambdas
  - `.collect` method
  - The `yield` keyword
  - Procs
  - Converting to procs
  - Starting lambdas

__*Time spent*__<br/>
244 minutes

__*Thoughts*__<br/>
I've learned some useful hacks for shortening statements in Ruby. Codecademy is starting to increase the complexity of the exercise, like building multiple layers of conditional logic, which I like. However I have noticed that the UI doesn't seem to play nicely with Firefox with uOriginBlock on it, since the code doesn't seem to update between exercises.

The `yield` keyword was kind of tricky to understand. Hopping out of a method and back in is pretty trippy and could allow for some logic shenanigans, especially when we pass in arguments.

I still don't really understand why we would use `yield` to execute logic outside of a method, especially when start saving blocks to Procs. Surely it's easier just to write a method that can do the same thing, with less code? I've just started covering `lambdas` too - why are there so many ways to do the same thing? 

Lambdas v procs is an interesting topic. I'm curious to see how useful procs are, given the extra level of validation on lambdas, though returning a function immediately is a useful property.

##### 14/09/20 (Mon)
__*Concepts covered*__<br/>
- Codecademy - Blocks, Procs and Lambdas
  - Finished up the module with some exercises
- Introduction to Programming with Ruby (Launch School book)
  - How to interpret documentation
  - Class and module names
  - Class and instance methods
- Revision of notes

__*Time spent*__<br/>
118 minutes

__*Thoughts*__<br/>
I definitely think spaced repetition is going to be necessary for me to retain anything. I cover a lot of ground very quickly, and being able to remember the syntax is a bit of a challenge currently. 

> "Reading about programming and the act of programming are very different things. If you read this entire book without ever writing one piece of code, it is very likely that you will "understand" intellectually how to code, without being able to actually DO IT. Then, the next time you are in front of your editor with a blank screen and someone asks you to solve a problem with a computer program, you won't be able to complete the task." 

This is a quote that *really* sticks with me - I have definitely experienced this. 

##### 15/09/20 (Tue)
__*Concepts covered*__<br/>
- Converting handwritten notes to typed notes
- Introduction to Programming with Ruby (Launch School book)
  - Types, Data Structures (hashes & arrays)
  - Variables (including scope)

__*Time spent*__<br/>
127 minutes

__*Thoughts*__<br/>
A lack of spaced repetition has come back to bite me. I don't recall a lot of the syntax I learned in the Codecademy preparation material and I find it hard to read through my written notes - there's just so much stuff all over the place. I typed notes up as revision, as well as to allow for indexing and better organisation.

I also have given up using vim for now. It was just adding to the complexity and time without really providing much benefit outside of novelty. 

##### 16/09/20 (Wed)
__*Concepts covered*__<br/>
- Converting handwritten notes to typed notes
- Introduction to Programming with Ruby (Launch School book)
  - Variables
  - Methods
  - Scope

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
Today was mostly revision again, though there was more detail in the book about different variable types and returning from methods. I didn't put it together previously, but methods automatically returning a value makes chaining methods possible. 

I also found it weird (for some reason) that a method will always return it's last line until explicitly told to return something earlier, such that defining a variable inside a method as the last line (without an explicit return) will return that variable. 

Hopefully I don't get tripped up by using `puts` as the final step in a method.

The discussion about scope were really interesting and completely skipped over in the Codecademy course. This sounds like a pretty easy area to get tripped up by, so I'll be cognisant about what methods can access, and what/where other variables can access. 

As part of this, mutating the caller was also weird, since what goes in (purely intuitively) shouldn't be changed by what comes out. 

##### 17/09/20 (Thu)
__*Concepts covered*__<br/>
- Introduction to Programming with Ruby (Launch School book)
  - Methods exercises
  - Flow control (inc. exercises)
  - Loops (`loop`, `break`, `next`, `for`, `while`, `until`) inc. exercises
  - Iterators
  - Recursion

__*Time spent*__<br/>
133 minutes

__*Thoughts*__<br/>
Not much new so far, though it surprises me how things just seem unexpected if the syntax changes slightly, or if an expression is structured slightly differently to what I'm used it. 

Recursion is confusing for me. I still don't really get the flow of code when a method is called within itself. In the provided example, I don't understand how the `start` variable is being incremented, since there's no actual change to the variable itself in the code. One for tomorrow, I think.

##### 18/09/20 (Fri)
__*Concepts covered*__<br/>
- Introduction to Programming with Ruby (Launch School book)
  - Recursion
  - Iterators exercises
  - Arrays and array methods
  - Bang operator
  - Many array methods
  - Array exercises
  - Hashes

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
I ended up getting a basic understanding of recursion. It's basically running a function over and over within the same function until a condition is met. 

This intro program is actually more detailed than any other online course that I've undertaken. I appreciate the level of explanation and focus on details, like returned value versus printed value, or whether or not the original object is mutated or not. 

While working in the morning is positive, I'm finding the lack of sleep is actually affecting me in my day job. I am just tired all the time and find myself a little slower than normal. 

##### 19/09/20 (Sat)
__*Concepts covered*__<br/>
- Introduction to Programming with Ruby (Launch School book)
  - Revising what is returned versus printed in flow control, loops and methods notes
  - Hashes (inc. exercises)

__*Time spent*__<br/>
254 minutes

__*Thoughts*__<br/>
I spent some time going through the old notes, making sure that I was careful to specify what was returned versus what was printed from a particular program. 

I spent (potentially way too much) time on the challenge exercise for the hashes section. I was pretty disappointed to not get the actual output, but I think this is because I am just not as comfortable with how to use loops in a way that synergises (?) with other code. 

I am slightly encouraged because I was able to break down what was required within the problem and actually get code for those intermediate steps, I just couldn't put the final steps together to get the output in the correct format. Also, I learned to use `p` instead of `puts`, since `puts` messes up arrays and hashes when trying to debug the output of a method. 

##### 20/09/20 (Sun)
__*Concepts covered*__<br/>
- Introduction to Programming with Ruby (Launch School book)
  - Regex
  - Variables as pointers
  - Blocks & Procs
  - Exception handling
  - Exercises
- Revising CLI Notes
- Ruby Basics exercises
  - Reading documentation

__*Time spent*__<br/>
243 minutes

__*Thoughts*__<br/>
Blocks and procs (though I covered them previously in Codecademy) are interesting. I can tell they'd be very useful, but still don't really have a strong idea of *how* they'd be useful. The Launch School book introduces it as a concept to be covered in detail later. I'm going to learn from my previous mistakes, and not dive into a hole and completely lose myself in details. 

Positive news - I was actually able to solve the challenge problems, though I spent a long time and my solution is like 5x longer than the suggested solution. I am very pleased with this. 

I also learned that there's a whole bunch of other methods that can be applied to arrays and hashes, which are located on the __*Enumerables*__ section of the ruby-doc website. More power!

I also initially thought it was kind of goofy to have an exercise section dedicated just to reading documentation, but some of it is actually quite challenging - figuring out where to look and actually interpreting documentation is a core skill (and something I'm quite bad at)!

##### 21/09/20 (Mon)
__*Concepts covered*__<br/>
- Ruby Basics exercises
  - Reading documentation
  - Reading documentation 2
  - Variable scope
  - Loops 1

__*Time spent*__<br/>
124 minutes

__*Thoughts*__<br/>
I've never had a course actually go into *how* to read documentation, as well as provide exercises and guidance on interpretation. Most courses just say "read the documentation". This is super useful and I'm really appreciating it. 

The variable scope exercises were a little confusing at first, but there's basically three rules that can help determine what value a variable will take:
- Is there a method definition (i.e. `def...end`)? If so, variables within the local scope of the method have no context of variables outside of it's scope. Variables outside of the method definition also have no context of what is inside the method. 
- Is there a mutating method? Variables from outside of a method definition can be passed in as an argument. If the expression within the method definition is a mutating one (e.g. "string"[2] = "-"), then it will mutate the variable in the outer scope. 
- Is there a method invocation on a block (e.g. `.each { }`, or `.each do...end`)? If so, then there is no method definition, and no creation of a local scope. Expressions that reassign values to variables will mutate variables outside the local block scope. 

I still need to get more familiar with loop syntax and how to use them. 

##### 22/09/20 (Tue)
__*Concepts covered*__<br/>
- Ruby Basics exercises
  - Loops 1
  - Loops 2 
    - `.between?`, `.size`, `.empty?`, `next` methods
  - User Input

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
The User Input exercises have been helpful in training to use loops. I am enjoying these bite-size exercises, as they are gradually building up in complexity, but still short enough to churn through them quickly. I feel like this is a good way to consolidate my thinking on this. 

##### 23/09/20 (Wed)
__*Concepts covered*__<br/>
- Ruby Basics exercises
  - User Input
  - Methods 
    - `.sample` method for arrays.
  - Return keyword
  - Conditionals

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
The key to the `return` exercises, is to remember that `puts` always returns `nil`, and that unless `return` is explicitly called, a method will always return the last line of the code that's inside of it. If `return` doesn't have a value associated with it, the value is `nil`.

The exercises continue to challenge my understanding of concepts. I somewhere along the line got confused about how variable assignment within a method definition worked, and somehow thought you couldn't assign variables within a method. 

I also learned that `if/else` logical statements by themselves don't create their own scope, but are able to create variables and assign values to them, even if they didn't exist before. These aren't method invocations with a block, nor are they creating their own scope. 

I also previously thought you couldn't assign `if/else` statements to variables. This is possible, so long as you don't `return` anything at each evaluation stage (technically this works with `puts`, but you'll end up with either `nil` or blank lines, depending on the print method used).

##### 24/09/20 (Thu)
__*Concepts covered*__<br/>
- Ruby Basics exercises
  - Conditionals
  - Strings
  - Arrays
- Revision of scope and return

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I'm still a little confused by what is returned and printed in methods. The revision was helpful, but I'll need to go through it again to be sure. The arrays exercises were reasonably straightforward. The hashes were a little trickier, since my recollection of the methods and what they return is a little hazy. The end of the prep course beckons!

##### 25/09/20 (Fri)
__*Concepts covered*__<br/>
- Ruby Basics exercises
  - Hashes
  - Debugging
- RB101 - Lesson 1: Preparation
  - PEDAC Method
  - Quiz 1
- RB101 - Lesson 2: Small Programs
  - Truthiness

__*Time spent*__<br/>
120 minutes 

__*Thoughts*__<br/>
Debugging is actually really fun. It's like a puzzle, tracing through the logs and figuring out logic fixes. Hopefully that bodes well for my career as a developer, since I hear a lot of time is spent debugging.

I also made a start on RB101, up to 'truthiness'. I'm officially enrolled into Launch School proper. This is going to be good. 

##### 26/09/20 (Sat)
__*Concepts covered*__<br/>
- RB101 - Lesson 2: Small Programs
  - Calculator (inc. Refactor)
    - Heredocs
    - `%w()` as way to convert strings into a comma separated array
  - Pseudo-code (formal and casual)
  - Rubocop
  - Debugging
  - Precedence
    - `tap` method

__*Time spent*__<br/>
242 minutes

__*Thoughts*__<br/>
I like the frameworks for pseudo-code. I definitely have a bad habit of just jumping straight into the code, only to find out mid-way during the solution that my initial code isn't ideal or doesn't cover the necessary use cases. I will need to make sure I try to put this into practice to get good and fast at it. 

Some of the precedence material is pretty crazy, like how `{}` and `do/end` actually have different priorities to each other, and that depending on which one you use, you could be returning a completely different value to what you expected. Sounds like a really easy way to get bugs in your program. 

The `.tap` method looks really useful to me for debugging. I'll be able to just insert it between chained methods to see what exactly gets returned at each step. It feels like a really good timesaver. 

##### 27/09/20 (Sun)
__*Concepts covered*__<br/>
- RB101 - Lesson 2: Small Programs
  - Porting messages to an external YAML file
  - Home loan calculator
  - Best practices with methods
  - Revision on variable scope
  - Method invocation versus definition
  - Methods accessing local variables through block interactions

__*Time spent*__<br/>
241 minutes

__*Thoughts*__<br/>
The concept of having your messages live in an external file is pretty cool. I'm not sure what the performance implications are, but it seems like you could have improved security by not having everything live in the same script. 

I'm getting some good practice with loops, and pseudocode with the home loan calculator. The loan calculator was a fun exercise, even if it did take me a while. The Rubocop alerts for style guide failures are kind of annoying, but necessary I guess. I find the truncated lines even harder to read, especially when there's lots of indenting involved. 

Methods accessing local variables through blocks is weird. I think I only superficially understand it, and I'm not entirely sure what use cases there are to do so (our old friend `yield`).

##### 28/09/20 (Mon)
__*Concepts covered*__<br/>
- RB101 - Lesson 2: Small Programs
  - Home loan calculator refactor
  - Pass by Reference
- References and mutability in Ruby article

__*Time spent*__<br/>
119 minutes

__*Thoughts*__<br/>
Refactoring according to Rubocop creates some interesting challenges, like shortening all of your logic in methods to ensure compliance, or abstracting out logic to smaller methods. I have a bad habit of not using methods enough and just creating a whole bunch of code. 

Reading back on the pass by value and reference stuff is good revision. It seems like a useful concept to preemptively avoid bugs. 

##### 29/09/20 (Tue)
__*Concepts covered*__<br/>
- Mutating and Non-Mutating Methods in Ruby article
- Object Passing in Ruby - Pass by Reference or Pass by Value Article
- Revision
  - The basics
  - Variables
  - Methods
  - Precedence

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
The pass by value versus reference material is interesting. It's nice to be able to interpret a more complex concept like this that is intuitively what I have learned through previous exercises. 

I feel like it's time for some review of the material covered, as I'm starting to read material and not fully remember what the concepts covered are. I will address this before the confusion compounds and makes it too difficult to follow the material. 

Revision is helpful, as I've uncovered random little bits of logic I didn't put together previously:
- If you can access a variable from the outer scope (e.g. a method invocation with a block accessing a main scoped variable), you can change what it's referencing (e.g. variable reassignment). 
- `main` is an instance of `Object`, which loads modules, like `Kernel`, that enable us to call methods outside of classes (e.g. `puts`, `gets`)
- In an arithmetic expression, Ruby first goes through an expression left-to-right and evaluates everything it can without calling any operators. Ruby needs to know what the values are in an arithmetic expression before it can execute the expression, meaning that Ruby may have to call certain methods left to right to ascertain values, before it executes the expression. 
- Short-circuiting expressions, like `&&`, `||` and `?:`, can get around need to evaluate all values, since they only rely on one value before they can execute.  

##### 30/09/20 (Wed)
__*Concepts covered*__<br/>
- Revision
  - Precedence
  - Variable scoping
  - Pass by value and reference
  - Flow control
  - Loops and iterators

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
Precedence was really confusing. I think I spent about 20 minutes just going over my notes and writing out different examples to properly understand it. I think I have a decent mental model of it now.
- Since the precedence of `do/end` as a block is so low, when we pass a method invocation with a block to `p`, `p`, perceives two arguments being passed to it, rather than a single argument, since the method invocation is bound to `p` before the block is bound to the method invocation. 
- Technically speaking, any method invocation can accept a block, but whether or not the method will do execute that block when called, depends on how the method is defined (requiring the `yield` keyword). 
- Again, variables __aren't objects__ - they are references to objects. Therefore variable reassignment  changes which object is bound to a particular variable.
- Indexed assignment is mutating. The underlying object (collection) is mutated (and hence it's `object_id` remains the same). The collection *element* references a new object (and hence has a different `object_id`). The same thing happens with setter methods. 
