# September 2020
- [10th, Thu](#100920-thu)
- [11th, Fri](#110920-fri)
- [12th, Sat](#120920-sat)
- [13th, Sun](#130920-sun)
- [14th, Mon](#140920-mon)
- [15th, Tue](#150920-tue)

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