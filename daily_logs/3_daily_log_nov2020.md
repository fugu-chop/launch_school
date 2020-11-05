# November 2020
- [1st, Sun](#011120-sun)
- [2nd, Mon](#021120-mon)
- [3rd, Tue](#031120-tue)
- [4th, Wed](#041120-wed)
- [5th, Thu](#051120-thu)

##### 01/11/20 (Sun)
__*Concepts covered*__<br/>
- RB100 Revision
  - Debugging exercises
- RB101 Revision
  - Lesson 1 - 2
- Blog Post reading
  - Advice for Ruby Programming Foundations Written Assessment (Part 4)
  - Pass by Reference v Value blog posts
- RB101-109 Small Problems
  - Easy 7

__*Time spent*__<br/>
239 minutes

__*Thoughts*__<br/>
Today was an absolute slog. Reading and revising content isn't as enjoyable as solving problems, even though I know that knowing these principles will help me solve problems more effectively. 

Re-reading the blog posts on pass by reference versus value was a good use of time however, as I picked up a few things I didn't fully grasp on my first reading of them, like how pass by reference is effectively passing copies of references. 

Also, I've confirmed that the RB109 written assessment is purely explaining code. I shall focus my efforts on this over the next few days, with a view to taking the assessment next weekend. 

##### 02/11/20 (Mon)
__*Concepts covered*__<br/>
- RB100 Revision
  - Variables, Methods
- RB101 Revision
  - Lesson 2 - 4
  - Quiz 2, 4

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
The quizzes are good revision, and still tricky to get 100% on. The wording is __very__ specific, and easy to skip over if I'm trying to parse the question quickly. This is something I'll have to keep in mind for in the written assessment. 

##### 03/11/20 (Tue)
__*Concepts covered*__<br/>
- RB101 Revision
  - Lesson 4, 5
  - Lesson 4 Practice Problems
  - Quiz 4

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I attended another study session, where I did a lot more exam style explaining of code. Overall. I did better than I was expecting to, especially given I was deliriously tired (I was breaking down code explanations with extreme precision at 02:30).

There's still a few concepts I had trouble explaining, like how `select` and `map` evaluate their blocks and what they return, as well as what happens to objects when they are not assigned to variables (the objects simply get lost if they're not returned). Nonetheless, I feel decent about my performance, and the TA seemed reasonably happy with my explanations. 

I'm almost finished looking over my notes. In the coming days, I'll be seeking to practice my explanations of code. I am not sure whether I'll be ready to take the written assessment by this weekend - I'll just play it by ear and not cause myself undue pressure. 

##### 04/11/20 (Wed)
__*Concepts covered*__<br/>
- RB100 Revision
  - Variables, Methods
- RB101 Revision
  - Lesson 2, 5, 6
  - Lesson 5 Practice Problems
  - Quiz 5

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I still have some way to go in properly interpret `sort`. I have to remember that a `-1` return value means the first object is __smaller__ than the second one, and will appear __after__ the second item in the returned collection. 

Also, I found I had some confusion with *variables as pointers*. Again, we __don't__ pass variables into methods - we pass the __objects__ they are referencing. If we pass a variable as an argument to a method, we are really passing a reference to the object, not the variable itself. 

Therefore, in the context of a collection, if we pass in a variable *as an argument* and mutate the underlying object within the context of the array, the object referenced will be mutated, but the object the __variable__ is referencing most likely won't change. 
```
a = 'hi'
english_greetings = ['hello', a, 'good morning']

greetings = {
  french: ['bonjour', 'salut', 'allo'],
  english: english_greetings,
  italian: ['buongiorno', 'buonasera', 'ciao']
}

greetings[:english][1] = 'hey'

# We reassign the object in the array and mutate the array, but never explicitly modify the variable through reassignment.
puts a # prints 'hi', returns nil. 
```
I feel like I am ready to make a start on actual practice problems (i.e. explaining code) tomorrow. 

##### 05/11/20 (Thu)
__*Concepts covered*__<br/>
- RB100 Revision
  - Arrays
- RB101 Revision
  - Lesson 5

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
Writing these code summaries is honestly exhausting. I have to be so precise in the language I use, without trying to go berserk explaining absolutely every possible detail (unfortunate tendency of mine). I think I am honestly fine for time, it's just being precise with my language. 