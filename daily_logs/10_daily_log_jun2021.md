# June 2021 (Total minutes: 4,090)
- [1st, Tue](#010621-tue)
- [2nd, Wed](#020621-wed)
- [3rd, Thu](#030621-thu)
- [4th, Fri](#040621-fri)
- [5th, Sat](#050621-sat)
- [6th, Sun](#060621-sun)
- [7th, Mon](#070621-mon)
- [8th, Tue](#080621-tue)
- [9th, Wed](#090621-wed)
- [10th, Thu](#100621-thu)
- [11th, Fri](#110621-fri)
- [12th, Sat](#120621-sat)
- [13th, Sun](#130621-sun)
- [14th, Mon](#140621-mon)
- [15th, Tue](#150621-tue)
- [16th, Wed](#160621-wed)
- [17th, Thu](#170621-thu)
- [18th, Fri](#180621-fri)
- [19th, Sat](#190621-sat)
- [20th, Sun](#200621-sun)
- [21st, Mon](#210621-mon)
- [22nd, Tue](#220621-tue)
- [23rd, Wed](#230621-wed)
- [24th, Thu](#240621-thu)
- [25th, Fri](#250621-fri)
- [26th, Sat](#260621-sat)
- [27th, Sun](#270621-sun)
- [28th, Mon](#280621-mon)
- [29th, Tue](#290621-tue)
- [30th, Wed](#300621-wed)

##### 01/06/21 (Tue)
__*Concepts covered*__<br/>
- LS175 - Networked Applications
  - Revision

__*Time spent*__<br/>
133 minutes

__*Thoughts*__<br/>
I spent the majority of today revising a lot of the concepts behind networked applications. Through this CMS project, I got a little bit away from the fundamentals, especially since we're using Sinatra, which abstracts a lot of this detail away from us, so it's always helpful to remind myself of the underlying principles and structures behind the application.

##### 02/06/21 (Wed)
__*Concepts covered*__<br/>
- LS175 - Networked Applications
  - CMS Project
    - Authentication to functionality
    - Storing additional auth details
    - Writing tests
  - Auth articles
    - [How to store passwords](https://web.archive.org/web/20190416200849/http://dustwell.com/how-to-handle-passwords-bcrypt.html)
    - [Auth methods in Rails](https://launchschool.com/blog/authentication-methods-in-rails)

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I built some more authentication functionality within the CMS app, which now limits the number of pages that can be visited without logging in. I was also able to store additional logins in a `.yaml` file outside of the app, which caused a lot of broken tests since I had to write another method to help calculate the correct path based on which environment the application was running in.

##### 03/06/21 (Thu)
__*Concepts covered*__<br/>
- LS175 - Networked Applications
  - CMS Project
    - Forum posts
    - Hashing stored passwords
  - Auth articles
    - [How bcrypt works](https://www.rubyguides.com/2017/06/there-is-no-magic-in-ruby/)

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Working with `bcrypt` was slightly annoying, but I was able to debug my errors by stepping through the code and slowing down. The application is finally finished; the quiz awaits.

##### 04/06/21 (Fri)
__*Concepts covered*__<br/>
- LS175 - Networked Applications
  - Quiz
  - Readme updates for all projects
- Regex Book
  - Basic matching

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Polished off LS175 in the morning. A really enjoyable course where we actually get to build user-facing applications end to end based on non-technical requirements. It did highlight that my current knowledge of HTML and CSS is painfully limited. That's the next course (LS202) I'm going to tackle - I'll then go back to LS175 and build up an optional project, before I go onto LS180 (Database Foundations). For now though, I've been meaning to do the Regex book, which I've never set aside time to do. The evening session was going through some basic matching in regex. It's good to go through regex in a 'for dummies' manner - all the resources I've used so far have an assuemd baseline of knowledge, or those cheetsheets that accompany regex testers, which aren't ever enough to really understand it.

##### 05/06/21 (Sat)
__*Concepts covered*__<br/>
- Regex Book
  - Basic matching
  - Character classes
  - Character class shortcuts

__*Time spent*__<br/>
181 minutes

__*Thoughts*__<br/>
Regex is pretty fun, though reading and writing regex can get pretty intense, especially when trying to remember all the nuances of the shortcuts and how those actually look.

##### 06/06/21 (Sun)
__*Concepts covered*__<br/>
- Regex Book
  - Anchors
  - Quantifiers
  - [Article on Greediness](https://d186loudes4jlv.cloudfront.net/regex/files/greedy-vs-lazy.pdf)
  - Regex in Ruby
- LS180 - Database Foundations
  - Introductory Material

__*Time spent*__<br/>
182 minutes

__*Thoughts*__<br/>
Finished off the Regex module. It didn't really take that long, and I'm glad I did it. I now have a basic background of regex, and can actually reason through some regex related problems. I've started the Database Foundations course for now, but I think I'll actually pivot and do the HTML course, as I'm thinking about the potential projects to build on using knowledge from LS175, before I go onto the standard course material to assessment preparation cycle.

##### 07/06/21 (Mon)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Introductory Material

__*Time spent*__<br/>
132 minutes

__*Thoughts*__<br/>
After some more thinking, I've come to the conclusion that I'm better off just doing 2 optional projects from LS175 while continuing LS180. I don't think it's fully worth going through HTML/CSS - it would simply add complexity, when what I'm really trying to do is just better understand the backend components - I can always come back and add polish to them later.

Designing an application is quite hard, especially from an application logic front - what classes should exist, how they should interact are all strange to me. More practice is both good and fun at this stage.

##### 08/06/21 (Tue)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Creating and Viewing Tables and Databases

__*Time spent*__<br/>
126 minutes

__*Thoughts*__<br/>
The app design is quite tricky. I'm not in a position where I'm clear about how the app looks as a finished product, and thus not sure whether certain methods will be useful, and whether they should be handled within the routing or application code.

##### 09/06/21 (Wed)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Revision
  - Creating and Viewing Tables and Databases

__*Time spent*__<br/>
130 minutes

__*Thoughts*__<br/>
Did some revision of the Database Foundations material. It's not too bad - I have the underlying knowledge of SQL, it's more to do with conceptual terms, like DDL, DML, etc, as well as the syntax for `psql` and commands from the console. My app development continues - I think I have a decent implementation for displaying contacts (it ended up just being a getter method that returns a hash), but filtering a nested hash whilst retaining the ids from the top level is a little tricky.

##### 10/06/21 (Thu)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Altering Tables

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
Making good progress on my application. I've solved most of the hairy problems in the application logic, now it's just tidying it up and writing tests. There's a fair bit of duplication between the updating contact methods, but I can't seem to find any sort of solution of converting a string input and converting this to a variable name. 

##### 11/06/21 (Fri)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Inserting Data

__*Time spent*__<br/>
133 minutes

__*Thoughts*__<br/>
On my project, I finished off the first part of routing - the login page. However, I'm finding it nearly impossible to work with the `rack/test` gem when the application files and test files are in a different subdirectory on the same level. It's incredibly infuriating, since the error messages are not useful at all, and only indicate that Ruby should be able to find the correct file, since the directory that the error is appear for definitely exists.

##### 12/06/21 (Sat)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Select queries
  - Updating & deleting data
  - Table relationships

__*Time spent*__<br/>
178 minutes

__*Thoughts*__<br/>
Study today was a real struggle. I'm not finding the database foundations course that interesting, it's kind of tedious, but starting to cover the database design is pretty interesting and something I think is more applicable to the real world. On the LS175 project, I finally managed to write up some tests for authenticating user credentials that actually work - I had to migrate the `.env` file back to the project root directory, since that's where the `dotenv` gem looks for it by default.

##### 13/06/21 (Sun)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Table relationships

__*Time spent*__<br/>
179 minutes

__*Thoughts*__<br/>
Again, database design is not my favourite topic - studying this was a struggle. The material feels a little dry, and I think it's just something that's part of being a developer. I am seeing some connections with the database design that I encounter at work, so it does provide some helpful context in that respect.

##### 14/06/21 (Mon)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
121 minutes

__*Thoughts*__<br/>
I spent most of today revising the LS180 content. Nothing too new, but it was a welcome change from the monotony of grinding through new content that I've been feeling. I made a bit of progress in writing some validations for contact creation, and tests for the contact list application. It's very time consuming, but I'm enjoying the overall experience thus far. 

##### 15/06/21 (Tue)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - SQL Fundamentals Exercises - Easy 1
  - Lesson 1 Quiz

__*Time spent*__<br/>
119 minutes

__*Thoughts*__<br/>
Polished off Lesson 1. It got a bit boring, and I still didn't do all that well in the quiz. It will be a struggle to complete this module; it's really not my favourite aspect of the course.

##### 16/06/21 (Wed)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Lesson 2: Schema, Data & SQL
    - DDL, DML, DCL Fundamentals
    - Data Types

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
Not much to note on the LS180 front. The material so far seems to be broadly a revision of the SQL book. The Contact List project continues - I was able to figure out a bug that's been annoying me - when setting a `value=` field in an `input` element, you have to wrap the returned value in quotation marks; otherwise if your string has spaces, the `input` will cut off anything after the first space.

##### 17/06/21 (Thu)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Lesson 2: Schema, Data & SQL
    - DDL, DML, DCL Fundamentals
    - Data Types

__*Time spent*__<br/>
124 minutes

__*Thoughts*__<br/>
I spent an inordinate amount of time debugging a `params` issue in Sinatra - I forgot that anything taken from the URL is a string, which is why I couldn't access hash values.

##### 18/06/21 (Fri)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Lesson 2: Schema, Data & SQL
    - Constraints
    - `NULL`
    - Keys

__*Time spent*__<br/>
100 minutes

__*Thoughts*__<br/>
Today was a bit of a write off. I didn't get much of a chance to study in the afternoon. Still, covered some good ground in Constraints, and getting used to the syntax of DDL, which I don't encounter much in my day to day work.

##### 19/06/21 (Sat)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Lesson 2: Schema, Data & SQL
    - Keys
    - Group By & Aggregations
    - Quiz
  - Lesson 3: Relational Data and Joins
    - Relational Data
    - Cardinality and Modality

__*Time spent*__<br/>
182 minutes

__*Thoughts*__<br/>
It feels good to take a break from the Contact Book app. I've been grinding away at it for a while and it's starting to get tiresome. Today was focused on just revision and drilling syntax as part of exercises. The ERD/cardinality/modality concept is interesting, contrary to my prior reservations about database design. Thinking about these things up front before applicaiton design seems pretty involved, and a difficult skill to master.

##### 20/06/21 (Sun)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Lesson 3: Relational Data and Joins
    - Foreign Keys
  - Exercises
    - SQL Fundamentals - DDL (Data Definition Language)
    - SQL Fundamentals - DML (Data Manipulation Language)

__*Time spent*__<br/>
182 minutes

__*Thoughts*__<br/>
Another reasonably successful study day. I focused mainly on SQL exercises, which is a little dull, but there's a good sense of progression I'm getting. Not too bad.

##### 21/06/21 (Mon)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Lesson 3: Relational Data and Joins
    - One-to-Many
    - Many-to-Many
  - Exercises
    - SQL Fundamentals - DML (Data Manipulation Language)
    - SQL FUndamentals - Many to Many

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Another day of drilling exercises. I'm becoming slightly more familiar with the syntax now - it's getting easier.

##### 22/06/21 (Tue)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Lesson 3: Relational Data and Joins
    - Quiz
  - Lesson 4: Query Optimisation
    - Indexes
    - `EXPLAIN`, `EXPLAIN ANALYZE`
    - Subqueries
  - Exercises
    - SQL Fundamentals - Many to Many

__*Time spent*__<br/>
119 minutes

__*Thoughts*__<br/>
Some new content, finally. The query optimisation stuff is pretty interesting, as I think it's directly applicable to my current job. Learning about indexes is also interesting, as well as some less well known SQL commands is helpful. There's always something you don't know, even if you work with it all day.

##### 23/06/21 (Wed)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Lesson 4: Query Optimisation
    - Quiz
  - Exercises
    - SQL Fundamentals - Subqueries

__*Time spent*__<br/>
128 minutes

__*Thoughts*__<br/>
The subqueries exercises are a bit strange - they're covering a whole lot of techniques that weren't covered in the main course and seem like they make an extreme efforts to make contrived examples to make your life harder. The morning session was not great - I was exhausted from lack of sleep and couldn't really get into deep focus. There's an obvious difference in the speed of thought, and the ability to deconstruct concepts. Otherwise, I finished the LS180 course today. Onto the assessment preparation.

##### 24/06/21 (Thu)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
118 minutes

__*Thoughts*__<br/>
A distracted day. I felt tired waking up, and I struggled to focus all day. Study was a bit of a grind - hopefully tomorrow is a bit more productive.

##### 25/06/21 (Fri)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
55 minutes

__*Thoughts*__<br/>
The morning session was slow going and distracted. I think I just find this course a little bland and uninteresting, without having an application sit on top of it. I'm going to make up the difference over the next two days. I just don't feel all that motivated currently to study, and a light day might help me recharge.

##### 26/06/21 (Sat)
__*Concepts covered*__<br/>
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
189 minutes

__*Thoughts*__<br/>
I filled in my sample theory answers today and refined them slightly. I'll continue this, and then move onto the practical exercises to brush up on my syntax. 

##### 27/06/21 (Sun)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
180 minutes

__*Thoughts*__<br/>
Spent today's revision session revising my theory answers and quizzes. It felt good to jump back into the contact book application. I feel like that sense of burnout has gone away a little.

##### 28/06/21 (Mon)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
117 minutes

__*Thoughts*__<br/>
I felt like I was able to focus significantly better during this morning's revision session. I'm not sure what to put this down to, perhaps better sleep over the weekend. I did a review of all the DDL syntax that I'm not that familiar with.

I feel pretty good about how much functionality and testing I was able to cram into an hour of study. Some quick refactoring made my field validation methods tidier, and I was able to extend the functionality of an existing template based on the URL. I feel happy with my work.

##### 29/06/21 (Tue)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Today was mostly spent drilling exercises. I'm still a little unfamiliar with the various syntax for DML v DDL SQL. I finally finished my contact list application - that felt like a massive undertaking. I'll deploy it to Heroku tomorrow.

##### 30/06/21 (Wed)
__*Concepts covered*__<br/>
- LS175 - Optional Projects
  - Contact List
- LS180 - Database Foundations
  - Revision

__*Time spent*__<br/>
133 minutes

__*Thoughts*__<br/>
I finally deployed my contact book application to Heroku. I had some issues with the `.env` variables not being picked up because the `.env` file wasn't checked into git (which is where Heroku pulls all of the files from). I had to manually set these in the UI, which took a bit of StackOverflow searching to figure out.
