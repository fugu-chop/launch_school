# Ruby Version Managers

## Table of Contents
- [Ruby on a Mac](#ruby-on-a-mac)
- [What gets installed with Ruby?](#what-gets-installed-with-ruby)
- [Gems](#gems)
- [Interacting with Gems](#interacting-with-gems)
- [Working with Gems in the local library](#working-with-gems-in-the-local-library)
- [Gem versions](#gem-versions)
- [Ruby version managers](#ruby-version-managers)
- [RVM](#RVM)
- [Installing Rubies](#installing-rubies)
- [Troubleshooting RVM](#troubleshooting-rvm)
- [Uninstalling RVM](#uninstalling-rvm)
- [Rbenv](#rbenv)
- [Installing rubies through Rbenv](#installing-rubies-through-rbenv)
- [Troubleshooting Rbenv](#troubleshooting-rbenv)
- [Rbenv plugins](#rbenv-plugins)
- [Summary](#summary)

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
RubyGems, often just called Gems, are packages of code that you can download, install, and use in your Ruby programs or from the command line. The `gem` command manages your Gems; all versions of Ruby since version 1.9 supply gem as part of the standard installation. 

The basics of Gems are pretty simple: you can search the RubyGems website to find a Gem you want to install, and then run `gem install` to install the Gem on your system. Once installed, you can start using most Gems immediately, though you may have to read the [documentation first](http://guides.rubygems.org/).

The [RubyGems Basics](http://guides.rubygems.org/rubygems-basics/) page provides a nice synopsis of the commands you will use most often, and there's a useful [command reference](http://guides.rubygems.org/command-reference/) for the `gem` command.

### Interacting with Gems
Since your Ruby installation already includes the `gem` program (provided you're using version 1.9 or higher of Ruby), all you need to do is find the Gems you want, and install them.

When you first start using Ruby, someone will usually tell you to install certain Gems. Eventually, though, you will need to search through a remote Gem library. The one you will use most often is the main [RubyGems Library](https://rubygems.org/gems). You may also need to search a specialized remote library provided by your employer.

Note that Gem descriptions at the RubyGems library are often extremely minimal. You will find some additional links on the right hand side of the Gem's main page; the "Homepage" and "Documentation" pages often contain more detailed information. In some cases, you may actually have to read the source code to figure out how to use a Gem. 

Once you've found a Gem that you want to install, you run `gem install GEM_NAME` to install the Gem. The `gem` command connects to the remote library, downloads the appropriate Gems, and installs them. If you specify additional remote libraries, `gem` also connects to those libraries to find the Gems you want.

When `gem` installs a Gem, it places the files that comprise the Gem on your local file system in a location where Ruby and your system can find the files and commands it needs. This location is the __local library__.

Precisely where gem creates the local library depends on several factors, including whether you are using a system Ruby that needs root access, a user maintainable Ruby, the specific Ruby version number, and whether you use a Ruby version manager (e.g. `rbenv` or `RVM`).

### Working with Gems in the local library
When working with Gems, you may want to look at the source code. To find *where* the gem is located, we can run
```
gem env
```
This prints a long list of information about your RubyGems installation. Useful information is usually found on these lines:
```
RubyGems Environment:
  - RUBYGEMS VERSION: 2.4.8
  - RUBY VERSION: 2.2.2 (2015-12-16 patchlevel 230) [x86_64-linux]
  - INSTALLATION DIRECTORY: /usr/local/rvm/gems/ruby-2.2.2
  - RUBY EXECUTABLE: /usr/local/rvm/rubies/ruby-2.2.2/bin/ruby
  - EXECUTABLE DIRECTORY: /usr/local/rvm/gems/ruby-2.2.2/bin
    ...
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /home/ubuntu/.nvm/versions/node/v4.5.0/bin
     - /usr/local/rvm/gems/ruby-2.2.2/bin
     - /usr/local/rvm/gems/ruby-2.2.2@global/bin
     ...
```
__What do these mean?__<br/>

__RUBY VERSION__<br/>
This is the version number of the Ruby associated with the `gem` command you just ran. Each version of Ruby on your system has its own `gem` command; if you have multiple versions of Ruby installed, then you have multiple versions of gem installed. Checking the `RUBY VERSION` is a helpful diagnostic: if you see an unexpected version, you are likely using the wrong version of `gem` or ruby.

__RUBY EXECUTABLE__<br/>
This is the location of the ruby command that you should use with the Gems managed by this `gem` command. This information is often useful when `RUBY VERSION` reveals a gem/ruby mismatch.

__INSTALLATION DIRECTORY__<br/>
This directory is where `gem` installs Gems by default. Note that the location varies based on the Ruby version number (`2.2.2` here). Under `rbenv`, you may see two different versions in this name: the first is the major version, the second is the actual version. You can usually ignore the major version.

__USER INSTALLATION DIRECTORY__<br/>
Depending on your installation of Ruby and the options you pass to `gem`, `gem` may install Gems somewhere in your home directory instead of a system-level directory. This is the location in your home directory that `gem` uses in such cases.

The structure of the USER INSTALLATION DIRECTORY is the same as the INSTALLATION DIRECTORY.

__EXECUTABLE INSTALLATION DIRECTORY__<br/>
Some Gems provide commands that you can use __directly from a terminal prompt__; `gem` places those commands in this directory. In the above example, we show the `bundler` and `rubocop` executables for Ruby `2.2.2` in the `bin` subdirectory.

Note that you need to include this directory in your shell `PATH` variable so that the shell can find these commands. Your Ruby version manager (`rbenv` or `RVM`) usually handles this, but it's useful to know where to look if you have problems. (See also `SHELL PATH` below.)

__REMOTE SOURCES__<br/>
This is the remote library used by this gem installation.

__SHELL PATH__<br/>
The value of your shell's `PATH` variable; this variable tells your shell _which directories it should search_ to find executable program files. If you have problem with `command not found` messages or running the wrong versions of programs, this listing may provide valuable clues about where the system looks for your programs.

Note in particular that the list of directories includes `/usr/local/rvm/rubies/ruby-2.2.2/bin`. We can see from the above example that this directory contains the `ruby`, `irb`, and `gem` commands (it contains other commands as well).

Note that the following shows the directory structure under `RVM`; the structure will be different but similar with `rbenv` or a system ruby. The below diagram shows a RVM-managed Ruby version `2.2.2`, with the `bundler`, `freewill`, `pry`, and `rubocop` gems installed.
```
$ tree /usr/local/rvm     # the following is partial output
/usr/local/rvm
├── gems
│   └── ruby-2.2.2        # This is the INSTALLATION DIRECTORY for Gems
│       ├── bin
│       │   ├── bundle
│       │   └── rubocop
│       └── gems
│           ├── bundler-1.12.5
│           ├── freewill-1.0.0
│           │   └── lib
│           │       └── freewill.rb
│           ├── pry-0.10.4
│           └── rubocop-0.43.1
└── rubies
    └── ruby-2.2.2
        └── bin
            ├── gem
            ├── irb
            └── ruby
```
This structure shows Ruby `2.2.2` and some associated Gems installed under RVM. In particular, note the locations of the `gems` directory in this structure. All Gems for Ruby 2.2.2 are installed here. The files are in *subdirectories named with the name and version number of the installed Gems*. For instance, `pry` version `0.10.4` is in `INSTALLATION DIRECTORY/gems/pry-0.10.4`.

Inside each Gem-specific directory, you will find additional subdirectories and files. For example, we show a bit of detail for the `freewill 1.0.0` Gem. The `lib` subdirectory is the most important: this is where your Ruby finds the require files for the Gem. 

For instance, when you write `require 'freewill'` in a program, Ruby loads `freewill.rb` from this `lib` subdirectory. Note that the Gems are __installed within a specific Ruby version__; in this way, it's possible to install the same Gem for multiple Rubies because they are installed under the Ruby version-specific directory.

### Gem versions
Suppose your program needs a specific feature from version `1.1.1` of a Gem named `freewill`, but when you try to run the program, you get an error that tells you the feature doesn't exist. How can you find out which version of the Gem your program really loaded?

To determine the Gem version, you need to know the full path name of the file that your program loaded. The easiest way to do this is to insert some debugging code (or a call to `binding.pry`) in your program shortly after the point where you require the Gem:
```ruby
puts $LOADED_FEATURES.grep(/freewill\.rb/)
```
This will print something like this:
```
/usr/local/rvm/gems/ruby-2.2.2/gems/freewill-1.0.0/lib/freewill.rb
```
That command searches for any entries in the `$LOADED_FEATURES` Array that include `freewill.rb` in the name, and prints all matching entries. With luck, there is just one entry, though sometimes you may have several from which to choose. 

The resulting name is the _path of the file_ that your program required; by looking at that name, you can see that your program loaded the file from `freewill-1.0.0`. This tells you that your program loaded version `1.0.0` of the Gem, not version `1.1.1` as needed.

Once you've confirmed that you're using the wrong version of the Gem, you may find that you need to install the desired version, or that you're using the wrong version of Ruby. As we'll see later, this can also be an issue with `Bundler`.

#### Multiple gem versions
Suppose our system looks like this:
```
$ tree /usr/local/rvm     # the following is partial output
/usr/local/rvm
└── gems
    └── ruby-2.2.2        # This is the INSTALLATION DIRECTORY for Gems
        ├── bin
        │   ├── bundle
        │   └── rubocop
        └── gems
            ├── bundler-1.12.5
            ├── freewill-1.0.0
            │   └── lib
            │       └── freewill.rb
            ├── freewill-1.1.1
            │   └── lib
            │       └── freewill.rb
            ├── pry-0.10.4
            └── rubocop-0.43.1
```
We now have two versions of `freewill` installed. Let's say that version `1.1.1` is not fully compatible with the older `1.0.0` version. Suppose further that we have another Ruby program that requires the version `1.0.0` of `freewill`. What happens when this program tries to `require 'freewill'`?

In this situation, Ruby loads the __installed version of the Gem with the most recent version number__, namely version `1.1.1`. This means trouble for our hypothetical program that needs the older version. This can be addressed in several ways:
- Provide an absolute path name to require.
- Add an appropriate -I option to the Ruby invocation.
- Modify $LOAD_PATH prior to requiring somegem.
- Modify the RUBYLIB environment variable.

These fixes are all hacks though; they will quickly become unmanageable and an enormous mess and source of bugs. You definitely do not want to go down this road except in the extremely short-term. The right choice is to use `Bundler`.

### Ruby version managers
Ruby version managers are programs that let you install, manage, and use multiple versions of Ruby. Ruby is an evolving language with features added, modified, and deleted with every new version. Eventually, you're going to write or use a Ruby program that needs a different version of Ruby, and that's when you will find that you need a Ruby version manager.

There are two major ruby version managers in common use: `RVM` and `rbenv`. (There are others as well, like `chruby`, but their use is much less widespread.) They take different approaches to the problem of using multiple versions of Ruby, but the result is the same: you can easily use multiple versions of Ruby on the same system.

Which version manager should you use, though? This partly depends on your own preferences and needs, but most people can just pick one and start using it. Functionally, the two systems perform all the tasks most developers need. In most cases, there is little in the way of features to recommend one over the other.

There are some problems with RVM on a Mac, however, mostly having to do with using older versions of Ruby, which we ask to you to do later. For that reason, you may want to use `Rbenv` on a Mac. If you have Homebrew installed, the easiest way to install Rbenv is with the `brew install rbenv` command.

### RVM
The following example shows a typical installation of two different Ruby versions under RVM. This output assumes that `rvm` stores its files in `/usr/local/rvm`; depending on your system and installation, the directory may be elsewhere. For instance, a common location is `~/.rvm` (`~/` means your home directory).
```
$ tree /usr/local/rvm        # the following is partial output
/usr/local/rvm               # RVM path directory
├── gems
│   ├── ruby-2.2.2
│   │   ├── bin
│   │   │   ├── bundle
│   │   │   └── rubocop
│   │   └── gems
│   │       ├── bundler-1.12.5
│   │       ├── freewill-1.0.0
│   │       │   └── lib
│   │       │       └── freewill.rb
│   │       ├── pry-0.10.4
│   │       └── rubocop-0.43.1
│   └── ruby-2.3.1
│       ├── bin
│       │   ├── bundle
│       │   └── rubocop
│       └── gems
│           ├── bundler-1.12.5
│           ├── freewill-1.0.0
│           │   └── lib
│           │       └── freewill.rb
│           ├── pry-0.10.4
│           └── rubocop-0.45.0
└── rubies
    ├── ruby-2.2.2
    │   └── bin
    │       ├── gem
    │       ├── irb
    │       └── ruby
    └── ruby-2.3.1
        └── bin
            ├── gem
            ├── irb
            └── ruby
```
#### How RVM works
At RVM's core is a set of directories in which RVM stores all your Ruby versions, its associated tools (such as `gem` and `irb`), and its Gems. Each directory is specific to a given Ruby version. If you need Ruby `2.3.1`, RVM uses the files in the `ruby-2.3.1` directory; if you need Ruby `2.2.2`, it gets the files from the `ruby-2.2.2` directory. 

Note that the standard Ruby __executables__ are found in the `rubies` subdirectory of RVM's main directory, while __Gems__ are found in the `gems` subdirectory. Note also that the Gem version numbers can differ between Rubies: in this case, Ruby `2.2.2` uses Rubocop `0.43.1`, while Ruby `2.3.1` uses Rubocop `0.45.0`.

RVM defines a *shell function* (see your shell's documentation for information on functions) named `rvm`. Your shell uses this function _in preference to executing the disk-based `rvm` command_. There are complex reasons behind using shell functions, but the main reason is that _a function can modify your environment_, while a *disk-based* command cannot.

When you run `rvm use VERSION` to change the Ruby version you want to use, you actually invoke the `rvm` function. It modifies your environment so that the various ruby commands invoke the correct version. For instance, `rvm use 2.2.2` modifies your PATH variable so that the `ruby` command uses the Ruby installed in the `ruby-2.2.2` directory. It makes other changes as well, but the `PATH` change is the most noticeable.

If you want to run, say, `rubocop` from the `Ruby 2.2.2` directory, you tell RVM to use Ruby `2.2.2`, then run the `rubocop` command. The system searches for a `rubocop` command in your `PATH`, and runs the _first one it finds_. Since the RVM directories usually occur early in your `PATH`, the system finds the desired `rubocop` command that pertains to Ruby `2.2.2`. In our above example, we can see that the `rubocop` command lives in `/usr/local/rvm/gems/ruby-2.2.2/bin`.

### Installing Rubies
Let's say you're about to start work on a project that requires Ruby `2.2.2`. The first thing you should do is to check whether you already have Ruby `2.2.2` installed.
```
$ rvm list rubies

rvm rubies

   ruby-2.1.5 [ x86_64 ]
=* ruby-2.3.1 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```
This command shows that you currently have Ruby versions `2.1.5` and `2.3.1` installed, and that version `2.3.1` is both the current version and the default version. Since the listing does not show version `2.2.2`, we need to install it:
```
$ rvm install 2.2.2
```
Once we've installed version `2.2.2`, we can use it through:
```
$ rvm use 2.2.2
```
This command modifies your environment to ensure that the first ruby your system finds is version `2.2.2`. This same change also works for related commands such as `gem`, `irb` and `rubocop`.

Once we are using a version, we can quickly see some condensed information about our current version using:
```
rvm info rvm
```
This will output
```
ruby-3.0.0:
  rvm:
    version:      "1.29.12 (latest)"
    updated:      "11 hours 9 minutes 50 seconds ago"
    path:         "/Users/dean/.rvm"
    autolibs:     "[4] Allow RVM to use package manager if found, install missing dependencies, install package manager (only OS X)."
```
#### Set a default version
Usually, you won't use this command. Instead, you will define a default version, and then override the default on a directory-by-directory basis. To define the default version -- the Ruby version that RVM uses automatically in a new terminal session or shell -- just run:
```
$ rvm use 2.3.1 --default
```
If you later set a different version as the current Ruby, you can restore the default with:
```
$ rvm use default
```
#### Set a project specific version
There are [a number of ways to do this](https://rvm.io/workflow/projects), but the easiest is to create a `.ruby-version` file in your project's root directory; the content of this file is just the version number of ruby that you want to use when using programs from that directory.

Suppose we want to use Ruby `2.2.2` for the project in our `~/src/magic` directory.
```
$ cd ~/src/magic
$ rvm --ruby-version use 2.2.2
```
This creates a `.ruby-version` file in the directory. Once set, you don't need to worry about setting the version for this project. For good measure, you should set your __default version in your home directory__:
```
$ cd ~
$ rvm --ruby-version default
```
To make use of the `.ruby-version` file, RVM replaces the `cd` command from your shell with a shell __function__. This function invokes the real `cd` command, then checks for the `.ruby-version` file (it also checks for some other files we won't discuss). 

If it finds one of these files, it retrieves the version number from the file, and then modifies your environment in the same way the `rvm` function does. Thus, every time you change directories with the `cd` command, RVM modifies your environment to run the proper Ruby version.

RVM also uses the Gemfile for ruby projects that use Bundler. If the Gemfile contains a ruby directive, RVM uses that version of ruby to run the program. Note, however, that the `.ruby-version` file takes precedence.

### Troubleshooting RVM
The most likely issue with RVM is that you get confused about which version of Ruby you are running, or you install or update Gems with the wrong gem command. When trying to diagnose an RVM problem, first make sure that you are using the correct Ruby version, then check for Gem versioning issues.

Some additional tips include:

__Directory Names__<br/>
Make sure your directory name __does not include any spaces__, and none of its ancestors (parents, grandparents, etc) do either. RVM does not currently support directory names with spaces.

__Shell Functions__<br/>
Verify that you are using the `cd` and `rvm` functions, not the built-in `cd` command nor the executable file `rvm`. We can verify this with the below command. If it fails to print out the below output, the `cd` and `rvm` functions aren't defined properly and RVM fails to work.
```
type cd | head -1 ; type rvm | head -1
cd is a function
rvm is a function
```
To load `cd` and `rvm` as functions, confirm that your shell startup file (`.profile`, `.bash_profile`, etc) includes a command that looks like something like this:
```
$ source "{RVM PATH}"/scripts/rvm"
```
Where `"{RVM PATH}"` is the name of our RVM path. This command should be near the __end__ of the file, __after__ any commands that set or modify your `PATH` variable or replace built-in commands with functions. If you must change the file, start a new terminal session after making the changes, then close any previously open terminal sessions.

__Verify Gem and Rubies `PATH` precedence__<br/>
We can use `echo $PATH` to confirm that the `{RVM PATH}/rubies-{VERSION}/bin` and `{RVM PATH}/gem/rubies-{VERSION}/bin` directories are present in your PATH, and listed before any other directories that may contain programs with the same name.

If, for example, `/usr/bin` occurs before `{RVM_PATH}/rubies-{VERSION}/bin` in your `PATH`, your system may load the system version of Ruby instead of one managed by RVM.

__RVM Info__<br/>
We can display information about the __current__ RVM environment using `rvm info`, similar to `gem env`.

__Verify current version__<br/>
We can use `rvm current` to display the current, active version of Ruby.

__Repair permissions__<br/>
We can fix permissions on RVM files using `rvm fix-permissions`. This may be useful if you accidentally use `sudo` to install, modify or update RVM, or any of its rubies or Gems. If you see "permission denied" messages on any of these files, try running this command.

__Repair everything__<br/>
We can repair files that help RVM manage the different rubies using `rvm repair all`. This may be useful if RVM seems completely broken in areas.

__Update RVM__<br/>
We can download and install the latest version of RVM using `rvm get latest`. This is most useful when you are using a new or unfamiliar feature that may not be available or working correctly in your current version of RVM.

### Uninstalling RVM
`rvm implode` will remove the `rvm/` directory and all the rubies built within it. In order to remove the final trace of RVM, you need to remove the `rvm` gem, through `gem uninstall rvm`. We will also need to check that our shell startup file (`.profile`, `.bash_profile`, etc) has the relevant `PATH` removed. You also need to restart your CLI.
### Rbenv
At `rbenv`'s heart is a set of directories very similar to the directories at RVM's core. It stores and uses the rubies, associated tools, and Gems from these directories. There are subdirectories for each version of Ruby located in the versions directory. If you need Ruby `2.3.1`, `rbenv` uses the files in the `2.3.1` directory; if you need Ruby `2.2.2` it gets the files from the `2.2.2` directory.
```
$ tree /usr/local/rbenv   # the following is partial output
/usr/local/rbenv          # rbenv root directory
├── shims
│   ├── bundle
│   ├── irb
│   ├── rubocop
│   └── ruby
└── versions
    ├── 2.2.2
    │   ├── bin
    │   │   ├── bundle
    │   │   ├── irb
    │   │   ├── rubocop
    │   │   └── ruby
    │   └── lib
    │       └── ruby
    │           └── gems
    │               └── 2.2.0
    │                   └── gems
    │                       ├── bundler-1.12.5
    │                       ├── freewill-1.0.0
    │                       │   └── lib
    │                       │       └── freewill.rb
    │                       ├── pry-0.10.4
    │                       └── rubocop-0.43.1
    └── 2.3.1
        ├── bin
        │   ├── bundle
        │   ├── irb
        │   ├── rubocop
        │   └── ruby
        └── lib
            └── ruby
                └── gems
                    └── 2.2.0
                        └── gems
                            ├── bundler-1.12.5
                            ├── freewill-1.0.0
                            │   └── lib
                            │       └── freewill.rb
                            ├── pry-0.10.4
                            └── rubocop-0.45.0
```
Under the hood, how `rbenv` manages Rubies is a significant departure from how RVM does it. `rbenv` uses a set of small scripts called __shims__. The scripts have the same names as the various ruby and Gem programs. They live in the `shims` sub-directory of the main `rbenv` installation directory. 

Valid `rbenv` installations include the `shims` directory in the `PATH`; `rbenv` places it before any other directories that contain ruby or any related programs; this ensures that the __system searches the shims directory first__. 

Shims are lightweight executables that simply pass your command along to `rbenv`. So with `rbenv` installed, when you run, say, `rake`, your operating system will do the following:
1. Search your `PATH` for an executable file named `rake`
2. Find the `rbenv` shim named `rake` at the beginning of your `PATH`
3. Run the shim named `rake`, which in turn passes the command along to `rbenv`

An Rbenv shim intercepts a ruby related command and calls `rbenv exec` which takes care of running the right executable.

When you execute a shim, `rbenv` determines which Ruby version to use by reading it from the following sources, in this order:
1. The `RBENV_VERSION` environment variable, if specified. You can use the `rbenv shell` command to set this environment variable in your current shell session.
2. The first `.ruby-version` file found by searching the __directory of the script you are executing__ and each of its parent directories until reaching the root of your filesystem.
3. The first `.ruby-version` file found by searching the __current working directory__ and each of its parent directories until reaching the root of your filesystem. You can modify the `.ruby-version` file in the current working directory with the `rbenv local` command.
4. The global `~/.rbenv/version` file. You can modify this file using the `rbenv global` command. If the global version file is not present, `rbenv` assumes you want to use the "system" Ruby — i.e. whatever version would be run if `rbenv` weren't in your path.

This way, when you run one of the ruby commands or Gems, the system executes the proper shim script. The shim script, in turn, executes `rbenv exec PROGRAM`; this command determines what version of Ruby it should use, and executes the appropriate program from the Ruby version-specific directories, e.g. `/usr/local/rbenv/versions/2.3.1/bin`.

The `shims` directory contains all the shims used by `rbenv`, while versions contains all the different Rubies. Inside the `versions` directory, you will find one directory for each Ruby version you have installed; inside each of these directories, you will find the specific version of Ruby, all its companion programs, and your Gems for that version.

When installing on a Mac, we need to add some code to the end of the `.bash_profile`, `.bashrc`, or `.zshrc` file:
```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```
### Installing rubies through Rbenv
Let's say you're about to start work on a project that requires Ruby 2.2.2. You first need to check whether you already have Ruby `2.2.2` installed. To do this, run:
```
$ rbenv versions

system
2.1.5
* 2.3.1 (set by /Users/.../project/.ruby-version)
```
This command shows that you currently have Ruby versions `2.1.5` and `2.3.1` installed, and that version `2.3.1` is the currently selected Ruby version. Since the listing does not show version 2.2.2, we need to install it. 

However, unlike RVM, `rbenv` __does not provide a way to install new Rubies by default__. Fortunately, there's an easy fix: just install the `ruby-build` `rbenv` plugin. If you're on a Mac with a Homebrew version of Ruby, just run
```
$ brew install ruby-build
```
Once you've installed the `ruby-build` plugin, you can install Ruby `2.2.2` with:
```
$ rbenv install 2.2.2
```
### Setting local rubies
There are several ways to use a particular version of Ruby in `rbenv`, which can be found in the [Github readme](https://github.com/rbenv/rbenv).

One way is to set it __globally__, which means everything you do in Ruby will be set using the specified version:
```
$ rbenv global 2.3.1
```
Another way is to set it __locally__, meaning the version of Ruby is specific to that directory:
```
$ cd ~/src/magic
$ rbenv local 2.0.0
```
This creates a `.ruby-version` file in the `~/src/magic` directory; when you run any Ruby-based programs stored in this directory, `rbenv` checks the `.ruby-version` file, and uses that version of Ruby for the program. If there is no `.ruby-version` file, `rbenv` launches a search for an alternative `.ruby-version` file, and, if it still can't find one, it uses the __global version__ of Ruby.

Note that this `.ruby-version` file is identical to the `.ruby-version` file used by RVM: same name, same content, same function, and the same search sequence.

#### Where are the files?
Rbenv creates a directory at installation known as the `rbenv` `root` directory; it also installs all `rbenv` related files, including all the Rubies and Gems that it manages, in this directory. To determine the location of the `rbenv` `root` directory, run:
```
$ rbenv root

/Users/dean/.rbenv
```
### Troubleshooting Rbenv
Compared to RVM, `rbenv` uses a conservative approach to perform its tasks: it doesn't rely on making dynamic changes to your environment or system commands. Instead, it makes __a small, one-time change to your `PATH`__, and leaves your system to run exactly as designed (it relies on shims to do things, rather than changing directories in the `PATH`). 

This is the real strength of `rbenv`, and the main reason many developers prefer it over RVM; it's less likely to go wrong. There's just not that many moving parts to worry about. The most likely issue with `rbenv` is that you get confused about which version of Ruby you are running, or you use the wrong gem command to install or update some Gems.

The troubleshooting steps are broadly the same:

__Correct version__<br/>
We can check we're using the right version of Ruby by using `rbenv version`.

__Confirm directory__<br/>
By using `echo $PATH`, We can confirm that the `local/bin` directory is occuring before the `Library/Apple/usr/bin`, such that our system is loading the Rbenv directory in preference to the system directory.

__Confirm command location__<br/>
By using `rbenv which COMMAND`, we can display the disk location of the command named by `COMMAND` (e.g. `ruby`, `irb`, `rubocop`)

__Rebuild shims directory__<br/>
By using `rbenv rehash`, we can rebuild the `shims` directory. If you can't execute some commands or rbenv doesn't appear to be running the correct commands, try this command.

__Make sure the correct shim is installed__<br/>
We can display a list of all current shims by using `rbenv shims`.

### Rbenv plugins
Rbenv has a number of [plugins](https://github.com/rbenv/rbenv/wiki/Plugins) that extend the capabilities provided by Rbenv. 

### Summary
By default, RVM has more features, but `rbenv` plugins provide much of the functionality not provided by the base install of `rbenv`. RVM works by __dynamically managing your environment__, mostly by modifying your `PATH` variable and replacing the built-in `cd` command with an RVM-aware shell function; `rbenv` works by just modifying your PATH once and some other environment variables, relying on shims to execute commands.
