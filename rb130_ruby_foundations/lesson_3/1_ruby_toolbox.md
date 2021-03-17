# Managing Ruby

## Table of Contents
- [Ruby on a Mac](#ruby-on-a-mac)
- [What gets installed with Ruby?](#what-gets-installed-with-ruby)
- [Gems](#gems)

### Ruby on a Mac
On Macs, Ruby is part of the standard OS X/macOS installation. We can find out where it is installed by running the following in the CLI.
```
$ which ruby
```
We can find out what version of "system Ruby" we have installed by running this in the CLI.
```
/usr/bin/ruby -v
```
The "system Ruby" is a complete installation of Ruby and its standard components. However, the installation is usually an older version of Ruby. 

The Mac system Ruby has a characteristic that makes it undesirable for developers: it needs __root access__ to install and manipulate other Ruby components. Root access is a privileged user level that isn't always available to the developer, so the developer lacks the permissions needed to easily install these components.

The system Ruby also stores some additional commands (like `irb` and `rake`) in the `/usr/bin directory`. `/usr/lib/ruby` contains other Ruby components such as the libraries and Gems. On a Mac, `/usr/lib/ruby` provides access to the Ruby components, but this is just an alias for the real directory that is nested deeply in `/System/Library/Frameworks` (you should never modify or delete files in this directory directly).

Generally speaking, we should install a Ruby version manager and use it to install the versions of Ruby you need (you'll see people say "Rubies" to just mean "different versions of Ruby"). 

We can find out which version of Ruby is currently being used through the CLI:
```
ruby -v
```
### What gets installed with Ruby?
Besides the `ruby` command, a Ruby installation contains a host of other files and tools, including:
- The `core` library
- The `standard` Library
- The `irb` REPL (Read Evaluate Print Loop)
- The `rake` utility: a tool to automate Ruby development tasks
- The `gem` command: a tool to manage RubyGems
- Documentation tools (`rdoc` and `ri`)

### Gems
RubyGems, often just called Gems, are packages of code that you can download, install, and use in your Ruby programs or from the command line. The gem command manages your Gems; all versions of Ruby since version 1.9 supply gem as part of the standard installation. 
