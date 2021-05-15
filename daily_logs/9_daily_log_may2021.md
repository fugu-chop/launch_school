# May 2021 (Total minutes: 1,770)
- [1st, Sat](#010521-sat)
- [2nd, Sun](#020521-sun)
- [3rd, Mon](#030521-mon)
- [4th, Tue](#040521-tue)
- [5th, Wed](#050521-wed)
- [6th, Thu](#060521-thu)
- [7th, Fri](#070521-fri)
- [8th, Sat](#080521-sat)
- [9th, Sun](#090521-sun)
- [10th, Mon](#100521-mon)
- [11th, Tue](#110521-tue)
- [12th, Wed](#120521-wed)
- [13th, Thu](#130521-thu)
- [14th, Fri](#140521-fri)
- [15th, Sat](#150521-sat)

##### 01/05/21 (Sat)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
185 minutes

__*Thoughts*__<br/>
I'm starting to write out my answers for potential questions to the written assessment. This is going to be time consuming, but is valuable in forcing me to revise the concepts and distil them down. Writing questions and answers for the Transport layer was pretty hard - I had to parse all my notes, which are pretty scattered and hard to piece together. 

##### 02/05/21 (Sun)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
182 minutes

__*Thoughts*__<br/>
Revision continues. It's slow going, and I'm not entirely sure if I'm retaining all the knowledge in this first pass. Positively, I'm almost done with the topics on the study guide - the breadth of the actual assessment isn't nearly as intimidating as the coursework itself.

##### 03/05/21 (Mon)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
119 minutes

__*Thoughts*__<br/>
I accidentally slept in today and ended up having to do the two hours of study during the evening. As per my previous experience, this doesn't work particularly well after a long day at work. The second hour of study isn't nearly as productive as the first, as fatigue starts to creep in. I finished off my templated answers and tidied them up.

##### 04/05/21 (Tue)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I'm retaining the earlier concepts reasonably well, and able to communicate them more succinctly. It's good progress, which is helpful because generally, I'm starting to feel a little burned out.

##### 05/05/21 (Wed)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
More revision. The earlier topics I'm able to recall somewhat clearly, though basically anything from URLs onwards I'm struggling to recall the details of. More practice needed, but I should be ready to take the test reasonably soon.

##### 06/05/21 (Thu)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
I'm still having some trouble with TLS authentication and explaining it clearly, particularly how the chain of trust operates. I'll continue to practice this. 

##### 07/05/21 (Fri)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
More practice today. My recall is improving slightly, and my answers continue to get more succinct.

##### 08/05/21 (Sat)
__*Concepts covered*__<br/>
- LS170 - Networking Foundations
  - Revision

__*Time spent*__<br/>
178 minutes

__*Thoughts*__<br/>
I went through the quizzes today, and was able to get all of the answers right. I think I'm basically at the point where I can feel confident to take the test. 

##### 09/05/21 (Sun)
__*Concepts covered*__<br/>
- LS171 Assessment

__*Time spent*__<br/>
138 minutes

__*Thoughts*__<br/>
The test went by relatively quickly. The use of templated answers was very handy, as I don't think I could have written out answers and still finished in time. This is honestly the test I'm least confident about, since so much of it is theory and dependent on interpretation of the question. Let's see how I do.

##### 10/05/21 (Mon)
__*Concepts covered*__<br/>
- RB130 Revision
  - Closures, Blocks and Procs
- LS175 Networked Applications
  - Creating a simple echo server

__*Time spent*__<br/>
123 minutes

__*Thoughts*__<br/>
Revision this morning was a bit distracted - I couldn't get into the zone for studying. I aced the LS175 assessment, which was nice. I started up on LS175 - it's fun to get back to the implementation side, rather than pure theory.

##### 11/05/21 (Tue)
__*Concepts covered*__<br/>
- LS175 Networked Applications
  - Creating a simple echo server
  - Working with Sinatra
    - [Overview of Ruby application servers](https://medium.com/launch-school/demystifying-ruby-applications-ruby-application-servers-and-web-servers-c3d0fd415cb3)
    - [What is Rack](http://blog.gauravchande.com/what-is-rack-in-ruby-rails)

__*Time spent*__<br/>
125 minutes

__*Thoughts*__<br/>
I spent the morning doing further optimisations to the simple echo server. I had some compatibility issues with Firefox in rendering the response - there were some additional `puts` statements and response headers I had to throw in before the response showed up correctly.

Tracking state in the URL query strings is something covered in LS170, though it's cool to see it in action.

##### 12/05/21 (Wed)
__*Concepts covered*__<br/>
- LS175 Networked Applications
  - Working with Sinatra
    - [Overview of Ruby application servers](https://medium.com/launch-school/demystifying-ruby-applications-ruby-application-servers-and-web-servers-c3d0fd415cb3)

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
Spent the morning doing some reading of the Ruby application server architecture. I found it pretty hard to digest, but once I got to the architectural diagram, everything made sense. The afternoon session was looking at Rack, and deploying a simply Rack application using templates (ERB).

##### 13/05/21 (Thu)
__*Concepts covered*__<br/>
- LS175 Networked Applications
  - Working with Sinatra
    - Building a simple Rack app
    - Sinatra

__*Time spent*__<br/>
120 minutes

__*Thoughts*__<br/>
I finished up the very basic Rack app. It wasn't too hard to follow, and tied in some useful concepts previously learned, like bindings of closures, mixin modules versus class inheritance, and some refactoring of code. I also learned that if a method is expecting a positional argument at the end, any name: value pairs that aren't treated as keyword arguments get gathered up into a single hash.

I moved onto the next part of the coursework, which looking at Sinatra. Using Ruby 3.0.0 keeps tripping me up, as I need to remember that the `webrick` gem is not installed by default.

##### 14/05/21 (Fri)
__*Concepts covered*__<br/>
- LS175 Networked Applications
  - Working with Sinatra
    - Building a simple Rack app
    - Sinatra
    - Code Directory Challenge

__*Time spent*__<br/>
127 minutes

__*Thoughts*__<br/>
Had a mini-heart attack when I thought my bundler wasn't working correctly. After wasting significant amounts of time trying to troubleshoot, I found out I was using the wrong command to execute my Ruby files. How embarrassing. In the afternoon, I tried the Dynamic Directory Index challenge. The solution relied on a `params` variable that Sinatra automatically provides as part of each request. I'm still wrapping my head around variables being passed between different files - I need to remember that a page refresh (e.g. triggered by clicking on a link that adds a query string) triggers another HTTP request, which executes the block in the `get` method in the Ruby file.

##### 15/05/21 (Sat)
__*Concepts covered*__<br/>
- LS175 Networked Applications
  - Working with Sinatra
    - Book Reader App

__*Time spent*__<br/>
185 minutes

__*Thoughts*__<br/>
Today's session was really difficult. Working through the Sinatra search enhancements in particular was difficult - I built a solution that met the needs of the assignment, but didn't leave much room for enhancements on top for the next assignment, as I basically railroaded myself into an approach that didn't allow for extraction of nested hash values in an intelligent way. The solution required use of blocks, which I understand, but still don't have a strong background with.
