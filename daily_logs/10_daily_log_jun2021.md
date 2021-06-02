# June 2021 (Total minutes: 253)
- [1st, Tue](#010621-tue)
- [2nd, Wed](#020621-wed)

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
