# November 2020
- [1st, Sun](#011120-sun)
- [2nd, Mon](#021120-mon)
- [3rd, Tue](#031120-tue)
- [4th, Wed](#041120-wed)
- [5th, Thu](#051120-thu)
- [6th, Fri](#061120-fri)
- [7th, Sat](#071120-sat)
- [8th, Sun](#081120-sun)
- [9th, Mon](#091120-mon)
- [10th, Tue](#101120-tue)
- [11th, Wed](#111120-wed)
- [12th, Thu](#121120-thu)
- [13th, Fri](#131120-fri)
- [14th, Sat](#141120-sat)
- [15th, Sun](#151120-sun)
- [16th, Mon](#161120-mon)
- [17th, Tue](#171120-tue)
- [18th, Wed](#181120-wed)
- [19th, Thu](#191120-thu)
- [20th, Fri](#201120-fri)
- [21st, Sat](#211120-sat)
- [22nd, Sun](#221120-sun)
- [23rd, Mon](#231120-mon)
- [24th, Tue](#241120-tue)

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
- RB109 Preparation
  - Practice Problems

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
Writing these code summaries is honestly exhausting. I have to be so precise in the language I use, without trying to go berserk explaining absolutely every possible detail (unfortunate tendency of mine). I think I am honestly fine for time, it's just being precise with my language. 

##### 06/11/20 (Fri)
__*Concepts covered*__<br/>
- Blog Post reading
  - Advice for Ruby Programming Foundations Written Assessment (Part 1-4)
- RB109 Preparation
  - Practice Problems

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
Reading the blog posts helps me reduce some of my self-doubt about the language I'm using in my answers. I'll walk back my previous assertion that I should be fine for time. I think there are time savings I can achieve by just being more familiar with specific phrases. 

Writing about code is certainly less fun that writing code. I find myself currently unable to do more than 30 minutes at a time - it is just so boring. I can see why the developers at work aren't a big fan of writing documentation. I'm kind of dreading tomorrow - 4 hours of writing about code and being super precise sounds incredibly draining. 

##### 07/11/20 (Sat)
__*Concepts covered*__<br/>
- RB109 Preparation
  - Answer review
  - Practice Problems

__*Time spent*__<br/>
241 minutes

__*Thoughts*__<br/>
With an assessment where precision of language is so important, I'm a bit concerned about the blog post I've been using as a guide to the language I should use. They're written by a non-native English speaker, so sometimes I'm not sure if the guidance written is a result of grammatical mistakes, or acceptable precision. I guess if they've been there for several years and no amendments have been made, it should be ok? 

I've found that doing these exercises is quite draining, as it takes considerable focus to get the precision of the language right. I'm just a little apprehensive whether I will be able to maintain a strong level of focus for three hours(!) of explaining code. 

##### 08/11/20 (Sun)
__*Concepts covered*__<br/>
- RB109 Preparation
  - Answer review
  - Practice Problems

__*Time spent*__<br/>
239 minutes

__*Thoughts*__<br/>
I've been reviewing some of my earlier answers to the practice problems, and there's a few examples where I could have tidied up the language. Still, it's encouraging that my latter answers have required less amendments. There's still a few exam questions I'd like to go through before I attempt the test, but I feel like I'm in a good place to attempt the test during the week. 

I can't wait to do this written test. I am kind of sick of doing the same thing repetitively - I've been doing this almost exclusively for the past 3 days. I just hope I pass. 

##### 09/11/20 (Mon)
__*Concepts covered*__<br/>
- RB109 Preparation
  - Answer review
  - Practice Problems

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I think have been describing how iterators pass collection elements to the block incorrectly. I'm still not 100% sure I am describing it correctly, but my new explanation seems consistent with the `Introduction to Ruby` book that I read in the earlier courses. 

I *believe* that what happens is that iterators pass elements to the block parameter, this initialises a local block variable and assigns that element to the local block variable (and can be referred to as such, based on Srdjan's blog post), before any of the rest of the block is executed. 

What I previously had said was that a new local variable was initialised with the same name as the block parameter *after* the object had already been passed to the parameter (which doesn't seem to make sense in retrospect, as you would lose any previously referenced objects if you reassigned a variable). I'll make an effort to rewrite my previous incorrect answers. 

##### 10/11/20 (Tue)
__*Concepts covered*__<br/>
- RB109 Preparation
  - Answer review
  - Practice Problems

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I need to dedicate at least one or two lines at the end of my code descriptions to explain the general principle being demonstrated (e.g. variable shadowing, variables acting as pointers, variable scope). 

I feel pretty good about taking the test tomorrow. I left two small examples as a warm up in the morning tomorrow. I don't feel like I'd make any measurable improvements by continuing to practice or putting the test off any longer. In any case, I should get some good feedback. 

##### 11/11/20 (Wed)
__*Concepts covered*__<br/>
- RB109 Written assessment

__*Time spent*__<br/>
174 minutes

__*Thoughts*__<br/>
I feel like I completed the written assessment reasonably quickly - timing wasn't really an issue. Generally speaking, I feel like I prepared well enough that I was able to explain the relevant concepts quickly. The only question in my mind is whether the language I used was specifically what the assessors wanted. I really don't have a good sense, since so much of what I read and wrote seemed to differ. I used my best judgement - I'll see what the feedback is. The practice I did felt a little more difficult than what was on the actual assessment. I also like how the assessment questions were significantly more targetted than just 'explain this code please' and pointed you towards specifics they wanted you to answer. 

##### 12/11/20 (Thu)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Blog post reading
  - Videos of others live coding

__*Time spent*__<br/>
62 minutes

__*Thoughts*__<br/>
Got the results of the written assessment back and somehow I got 100%. There wasn't much feedback returned. Looks like all the preparation I did paid off. 

Today was pretty light. Just reading some articles on other students' past experiences with the RB109 written assessment, and seeing the approach expected within an interview setting. I did one less hour to make up for the extra hour I did yesterday. 

The video was a good pointer into the level of explanation I should go into (basically explain everything in my mind). It also highlighted to me that I have some level to go before I can confidently solve assessment-level difficulty problems.

I'll probably start off the problems again tomorrow. I think I'll also do a re-run of all the problems I've solved previously, explaining myself and seeing if I take as long as I used to. 

##### 13/11/20 (Fri)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems 
    - Easy 8, 9

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
It feels good to get back to coding again. Easy 8 has proven not too bad, but the time taken is still a little long for my taste (general problems take around 10 minutes, while the additional exploration can take 10 minutes as well). 

##### 14/11/20 (Sat)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Easy 9
    - Medium 1

__*Time spent*__<br/>
243 minutes

__*Thoughts*__<br/>
I'm not sure if this is skill progression, but Easy 9 exercises felt significantly easier than Easy 8 (and even those weren't that bad). The Medium 1 problems feel like a noticable jump up in difficulty. I can solve them, but it takes a long time to actually understand the problem. 

I spent an ungodly amount of time on Medium 1, Question 4, but solved it with my own implementation that's slightly shorter than the suggested answer. Feels good man. The silly thing was, it probably took me 15% longer than necessary because I kept getting confused with my block parameter names - specifically the difference between indices and objects within the array. 

The suggested solution feels super complicated. I spent quite a while trying to digest what was happening across four different methods. 

Medium 1 is pretty challenging. I can solve the problems, it just takes quite a while to do so. 

##### 15/11/20 (Sun)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Medium 1
    - Medium 2

__*Time spent*__<br/>
240 minutes

__*Thoughts*__<br/>
Did some more struggling with Medium 1 problems. I think it's better just to get a working solution built on something that you know is working (even if it's very inefficient or long), rather than trying to rebuild logic, which is incredibly time consuming. 

A few of the middle Medium 1 problems annoyed me. Some of them because the problem logic is long and tedious to understand, without being exceptionally difficult, or covers concepts that we are specifically instructed  won't be covered in this assessment (recursion, regex). The difficulty feels either feels contrived or unnecessary to the actual assessment. 

Medium 2 is much more 'fun'. It's pretty challenging, but I'm able to solve the problems (if a little slowly).

##### 16/11/20 (Mon)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Medium 2
    - Codewars (8 kyus)
  - Blog post 
    - Interview for internal processors
    - PEDAC revision

__*Time spent*__<br/>
122 minutes

__*Thoughts*__<br/>
I've noticed myself getting into some bad habits, going back to hack and slash when I'm really struggling with a problem. I need to make an effort to
- Slow down 
- Plan first
- then code 
- Think about *why* I'm doing what I'm doing
- Explain *what* the expected output is, at each step
- Reread the algorithm while solving (prevents edge cases from creeping in)

I should also make more of an effort to test as I'm writing code, to reduce the amount of review I have to do. 

Up to now, I haven't really been verbalising my thoughts. I've been practicing just getting the PEDAC process right, and documenting my thought process. This has definitely been helpful, and I feel like I've gotten a decent grasp on this, enough to add one more layer of complexity - talking about my thought process. I'll particularly need to do this for errors I encounter.

There's quite a bit of variation in the Codewars quality. It's pretty good, because it makes me actively think about edge cases and understanding what the problem is trying to convey.

##### 17/11/20 (Tue)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (7 & 8 kyu)

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
There are quite a few debugging style questions, which aren't applicable to the interview assessment (I haven't noted them in the exercises files), but are useful in developing the ability to quickly scan and interpret other people's code. 

Level 7 is probably the right level of difficulty for me currently. I'm definitely seeing the difference in quality of Codewars problems compared to those in Launch School. Some of the problems are very difficult to understand, especially when the person who wrote it doesn't have English as their first language. This compounds the difficulty of the problems.

##### 18/11/20 (Wed)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (7 kyu)

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
A deeply humbling experience today. I spent almost an hour trying to solve a single problem, which was 19 lines of code and still didn't pass all the test cases. The suggested solution was five lines of code and didn't involve any obscure methods. I've got a long way to go in developing 'programmer' logic.

One positive aspect - I'm able to solve these problems without the fancy methods that a lot of the shorter solutions go into. I think this will stand me in good stead when I'm not able to look up methods in the actual interview. 

After doing a few more examples, I feel a lot better about Kyu 7. I think I was just unlucky for the one problem I got first up being pretty challenging. 

##### 19/11/20 (Thu)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (7 kyu)
    - Revising previous suggested solutions

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
After doing a few more examples, I feel ok with Kyu 7. I'm basically able to solve most of the ones I come across (avoiding anything that looks like it needs Regex).

I am slowly picking up a few tricks, like `each_cons` for iterating through multiple items in a collection at a time, passing arguments to methods like `max` (which I never seem to do).

I definitely need some more practice around iterators, what they return, and how they interact with each other, like `each`, `select` and `map`, as they cut down on the amount of variables I need to define and code I need to write. 

##### 20/11/20 (Fri)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (7 kyu)

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
There's some additional work that can be done around decomposing problem logic. I find myself going for the most obvious solution. This works, but can take more time than writing a more elegant solution. 

On the other hand, there are some problems which just require brute forcing with some obscure methods (like `product`), which just can't be done with simple looping methods. 

##### 21/11/20 (Sat)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (7 kyu)

__*Time spent*__<br/>
242 minutes

__*Thoughts*__<br/>
More practice. I'm feeling ready to move to 6 kyu problems. There's still the occassional problem which is tricky at 7 kyu, but these generally rely on some more obscure methods. 

##### 22/11/20 (Sun)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (6 & 7 kyu)

__*Time spent*__<br/>
250 minutes

__*Thoughts*__<br/>
I spent an inordinate amount of time trying to debug a simple loop. I was putting the increment for the tracking variable in the wrong place. How embarrassing. 

Every time I move up a kyu, it's like uncovering a whole new world of complexity. It's an eye-opening experience. If I had to describe the difference, it's that there is generally an additional layer of logic required in this level compared to the previous stage, or that the immediately obvious solution generally will not work for the problems due to some constraint or edge cases. 

Anyway, I solved my first 6 kyu problem. It took basically an hour to do so, with 30 lines of code. I couldn't help but laugh when the solution was three lines. Mine took significantly longer because I wasn't familiar with the `sort_by` notation - i.e. that you could use a `-` sign to reverse sort sublements within the block.

##### 23/11/20 (Mon)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (6 kyu)

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I definitely need to get better at chaining iterators. It takes me a long time to figure out the correct inputs and outputs at each stage of the iterators. Otherwise, I am starting to be able to solve 6 kyu problems. It takes me a while, and a lot of code, but it's already a significant improvement on 2 days ago, where I couldn't even digest the problems correctly. 

##### 24/11/20 (Tue)
__*Concepts covered*__<br/>
- RB109 Interview assessment
  - Practice Problems
    - Codewars (6 kyu)

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Really happy with pretty complex problem of calculating hamming distance and correcting issues. I worked through it relatively well. I also managed to solve a 6 kyu problem in less than a minute with some careful reading. 

I also gave a Regex problem a fair swing, but didn't end up succeeding - I'm just not sure how to concatenate multiple characters in a string, in a group and then replace that group. I also ran into a few problems that required extra modules, like `date` and `datetime` from the standard library. I'm going to avoid these style of problems for now. 

I need to remember to slow down and apply the PEDAC method. I find myself kind of overwhelmed by the amount of steps required to solve a problem, and while I do break up the problem into bits, I immediately start jumping into those bits without piecing together the whole solution. I also spent a significant amount of time working on a problem, only to find I had got the requirements wrong.
