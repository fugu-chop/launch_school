# June 2021 (Total minutes: 1,680)
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
