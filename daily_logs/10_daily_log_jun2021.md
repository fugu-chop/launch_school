# June 2021 (Total minutes: 373)
- [1st, Tue](#010621-tue)
- [2nd, Wed](#020621-wed)
- [3rd, Thu](#030621-thu)
- [4th, Fri](#040621-fri)

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
