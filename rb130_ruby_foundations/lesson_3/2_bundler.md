# Bundler

## Table of Contents
- [What is Bundler](#what-is-bundler)
- [Gemfile](#Gemfile)
- [Running files with Bundler](#running-files-with-bundler)
- [File locations](#file-locations)
- [`bundle-exec`](#bundle-exec)
- [`binstubs`](#binstubs)

### What is Bundler?
Dealing with dependencies -- multiple versions of Ruby and multiple versions of Gems -- is a significant issue in Ruby. A project may need a Ruby version that differs from your default Ruby. Even if it requires the same version of Ruby, it may need a different version of a RubyGem.

In Ruby, most developers use a Ruby version manager such as RVM or rbenv to manage multiple Ruby versions. You can also use your version manager to manage Gem dependencies, but the favored approach is to use a dependency manager.

The most widely used dependency manager in the Ruby community is the Bundler Gem. This Gem lets you configure which Ruby and which Gems each of your projects need.

### Gemfile
Bundler relies on a file named `Gemfile` to tell it which version of Ruby and its Gems it should use. This file is a simple Ruby program that uses a Domain Specific Language (DSL) to provide details about the Ruby and Gem versions. It's the configuration or instruction file for Bundler. We need to create this file in our application directory.

A Gemfile typically needs four main pieces of information:
- Where should Bundler look for Rubygems it needs to install?
- Do you need a `.gemspec` file?
- What version of Ruby does your program need? (Recommended, not required)
- What Rubygems does your program use?

1. The first part is typically easy: most projects find Rubygems at the [official Rubygems site](https://rubygems.org). Your company or school or project group may have a private repository, but for now, you can use the official site.
2. We usually want a `project_name.gemspec` file (which is basically a description of the Gem) - Bundler checks for a `.gemspec` file when the Gemfile contains a gemspec statement. If you decide to release a program or library as a Gem, you must include a `.gemspec` file. 
3. The Ruby version is a bit harder. You must decide whether you want to support an older version of Ruby or a more recent version. Ideally, you should support the newest versions, but this isn't always possible: some users may need to use older versions. If we don't include this, Bundler will use whatever version of Ruby it finds by default (usually in the `.ruby-version` file).
4. The easiest way to find the Rubygems needed is to examine the `require` statements in your code: in all your code, even code that you run only during development, such as tests. One difficulty, though, is that it isn't always evident what Gem a particular require file loads. You may need to search your Gem directories to determine which Gem you use.

After you create a Gemfile, the `bundle install` command scans it, downloads and installs all the dependencies listed (including those not already installed), and produces a `Gemfile.lock` file. `Gemfile.lock` shows all the dependencies for your program; this includes the Gems listed in Gemfile, as well as the Gems they depend on (the dependencies), which may not be explicitly listed in the Gemfile. 

By recursively scanning the Gemfiles for each Gem, Bundler builds a complete dependency list that identifies all the Gems your application needs, even those you don't know you need. Once Bundler has the dependency list, it installs any Gems that are not yet part of your Ruby installation.

It's very common for __RubyGems you install for use in your project to rely on many other gems__, creating a large dependency tree.

It's easy to see the names `Gemfile` and `Gemfile.lock` and think that these files must be part of Rubygems. Bundler uses both files; it depends on `Gemfile` to provide information on the Gems your project uses, and it creates `Gemfile.lock` based on that. If you ever create your own Rubygem, you will probably use Bundler, but you don't have to. Hence, you don't need `Gemfile` or `Gemfile.lock` to create a Rubygem.

Suppose you are writing a program that requires Ruby `2.3.1` and the `sinatra`, `erubis`, and `rack` Gems. Our Gemfile incorporates these dependencies, and looks like this:
```ruby
source 'https://rubygems.org'

ruby '2.3.1'
gem 'sinatra'
gem 'erubis'
gem 'rack'
gem 'rake', '~>10.4.0'
```
Let's also assume our Ruby installation looks like the below:
```
$ tree /usr/local/rvm # the following is partial output
/usr/local/rvm        # RVM path directory
└── gems
    ├── ruby-2.2.2
    └── ruby-2.3.1
        ├── bin
        │   ├── bundle
        │   └── rubocop
        └── gems
            ├── erubis-2.7.0
            ├── rack-1.6.4
            ├── rack-protection-1.5.3
            ├── rake-10.4.2
            ├── rake-11.3.0
            ├── sinatra-1.4.6
            ├── sinatra-1.4.7
            └── tilt-2.0.5
```
When we run `bundle install`, Bundler will install the specified Gems (if needed) and create a `Gemfile.lock`, which looks like this:
```
GEM
  remote: https://RubyGems.org/
  specs:
    erubis (2.7.0)
    rack (1.6.4)
    rack-protection (1.5.3)
      rack
    rake (10.4.2)
    sinatra (1.4.7)
      rack (~> 1.5)
      rack-protection (~> 1.4)
      tilt (>= 1.3, < 3)
    tilt (2.0.5)

PLATFORMS
  ruby

DEPENDENCIES
  erubis
  rack
  rake (~> 10.4.0)
  sinatra

RUBY VERSION
  ruby 2.3.1p112

BUNDLED WITH
  1.13.6
```
The `specs` section under the GEM heading provides a list of the Gems (and their versions) that your app will load. Beneath each listed Gem is a list of the Gem's dependencies; that is, the Gems and versions it needs to work. Here, we can see that:
- We have `sinatra` version 1.4.7. Note that we chose 1.4.7 over 1.4.6. Bundler won't always choose the latest version like this. It will choose a version that __works in conjunction with the other dependencies__.
- `sinatra` requires `rack` (version >= 1.5.0 and < 2.0.0); we have version 1.6.4.
- `sinatra` requires `rack-protection` (version >= 1.4.0 and < 2.0.0); we have version 1.5.3.
- `sinatra` requires `tilt` (versions >= 1.3.0 and < 3.0.0); we have version 2.0.5

We didn't have to provide any information about `rack-protection` and `tilt` in our Gemfile; Bundler found this information on its own by examining the Gemfiles for those Gems -- that is, not our application's Gemfile, but the Gemfile that came with the Gems specified in our Gemfile. It then added the information to our `Gemfile.lock`.

### Running files with Bundler
Once we've a `Gemfile.lock`, we can add `require 'bundler/setup'` to the top of our Ruby file, __before any other gem__ (this isn't required if our app is a Rails app).

`bundler/setup` first removes all Gem directories from Ruby's `$LOAD_PATH` global array. Ruby normally uses `$LOAD_PATH` to list the directories that it searches when it needs to locate a required file. When `bundler/setup` removes those directories from `$LOAD_PATH`, Ruby can no longer find Gems.

To fix this, `bundler/setup` reads `Gemfile.lock`; for each Gem listed, it adds the directory that contains that Gem back to `$LOAD_PATH`. When finished, `require` only finds the proper versions of each Gem. This ensures that the specific Gem and version your app depends on is loaded, and not a conflicting version of that Gem.

Now, all you need to do is run your app and the correct Gem will be loaded when you require files.

### File locations
Bundler does not interfere with your Rubies nor their Gems. They remain where they were before you installed Bundler, and will continue to use the same setup in the future. This means that you can still use `gem env`, `rvm info`, and `rbenv` version and other informational commands to find information you may need.

However, Bundler provides a feature called `binstubs`; if you use this feature, you may have to add some directories to your `PATH`. The `gem env` and `rvm info` commands will reflect this.

### `bundle-exec`
Unfortunately, you will surely encounter situations where you can't just add require `'bundler/setup'` to the code, or the program itself may run code that has conflicting needs. When this happens, we may need use of `bundle-exec`.

The `bundle exec` command ensures that *executable programs installed by Gems don't interfere with your app's requirements*. For instance, if your app needs a specific version of `rake` but the default version of `rake` differs, `bundle exec` ensures that you can still run the specific `rake` version compatible with your app.

You can use `bundle exec` to run most any command in an environment that conforms to the `Gemfile.lock` versioning information (i.e. you need a `Gemfile.lock` in the directory where you're running the command). We can use this feature to see how `bundle exec` modifies your environment:
```
# This command compares the output of 'bundle exec env' with the output of 'env'
# Partial output only

$ diff <(bundle exec env) <(env)
< PATH=/usr/local/rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/bin:/usr/local/rbenv/versions/2.3.1/bin:/usr/local/Cellar/rbenv/1.0.0/libexec:/usr/local/rbenv/shims:...
---
> PATH=/usr/local/rbenv/shims:...
< RBENV_HOOK_PATH=/usr/local/rbenv/rbenv.d:/usr/local/Cellar/rbenv/1.0.0/rbenv.d:/usr/local/etc/rbenv.d:/etc/rbenv.d:/usr/lib/rbenv/hooks:/usr/local/rbenv/plugins/rbenv-default-gems/etc/rbenv.d
< RBENV_DIR=/Users/wolfy/my_app
< RUBYLIB=/usr/local/rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/bundler-1.13.6/lib:/usr/local/Cellar/rbenv/1.0.0/rbenv.d/exec/gem-rehash
< RBENV_VERSION=2.3.1
< BUNDLE_BIN_PATH=/usr/local/rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/bundler-1.13.6/exe/bundle
< BUNDLE_GEMFILE=/Users/wolfy/my_app/Gemfile
< RUBYOPT=-rbundler/setup
```
As you can see, the two commands produce different results; this output shows the modifications and additions that bundle exec makes to your environment.

Of special importance is the `RUBYOPT` value: this tells Ruby to `require 'bundler/setup'` (recall that `'bundle'` and `'bundler'` are aliases) before it starts running your code. This lets Bundler gain control in time to configure things so that the app loads the proper Gems, and only those Gems.

#### When to use `bundle-exec`? 
Using `bundle exec` with a non-Ruby command is rare, though. You usually use `bundle exec` with commands written in Ruby and installed as Gems, e.g., Rake, Pry, and Rackup. 

We use it to resolve __dependency conflicts when issuing shell commands__. From time to time, you may encounter an error message that looks like this:
```
Gem::LoadError: You have already activated rake 11.3.0, but your Gemfile requires rake 10.4.2. Prepending `bundle exec` to your command may solve this.
```
This error usually appears when you use a Gem command whose version differs from the Gem version in your Gemfile. For example, let's say your default version of `rake` is version 11.3.0, but you're in a directory where the Gemfile wants version 10.4.2.

When you run `rake` from the command line, your system will find and execute `rake` version 11.3.0; your shell doesn't know about Gemfiles, so it just invokes the version of `rake` it finds in the `PATH`.

However, `rake` sometimes runs code that Bundler manages but isn't part of `rake`, and that's where things get ugly. When that code runs, it checks your `Gemfile.lock`, and sees that it needs rake 10.4.2, so it tries to load and run it. Unfortunately, `rake` is already running, but it is version 11.3.0. Since you can't run two versions of `rake` in the same process, the `require` fails with a `LoadError`.

Fortunately, the solution is easy: the error message tells you what to do. All you have to do is run the command with `bundle exec`:
```
$ bundle exec rake
```
This changes the environment so that `rake` 10.4.2 runs instead of your system default, 11.3.0; now, when `rake` runs the external code, Bundler sees that you are already running 10.4.2, so everything is okay, and execution continues.

Discrepancies with `rake` and other executables are the main reason to use `bundle exec`. However, this problem can happen with other commands as well. Any Gem command that requires other Gems may load a Gem that conflicts with your app's requirements - `bundle exec` is the easiest way to fix this issue.

### `binstubs`
`binstubs` is an alternative to using `bundle exec`. It sets up a *directory of short Ruby scripts (wrappers) with the same names as executables installed by your Gems*. By default, `binstubs` names this directory as `bin`, but you should override that if your app also needs a `bin` directory of its own.

The scripts in the `binstubs`-provided directory *effectively replace `bundle exec`*; if you include the directory in your `PATH`, you can avoid using `bundle exec`.

The `binstubs` feature only installs wrappers for the Gems listed by `Gemfile.lock`. It __skips executables for unlisted Gems__. This can be an issue with Gems that you don't require in your apps, but use externally. For example, Rubocop and Pry. 

It's recommended to stick with `bundle exec` and not worrying about `binstubs`; it's mostly mentioned here in case you're debugging a tricky issue and that's one place to double check.

### Troubleshooting with Bundler
We already talked about the following issue, which we can resolve with `bundle exec Gem`
```
Gem::LoadError: You have already activated ...
```
We might also get the following error:
```
in `require': cannot load such file -- colorize (LoadError)
```
This message means that bundler/setup can't find the named Gem (`colorize` here). However, you've confirmed that the Gem is installed, has the proper permissions, and you're using the proper version of Ruby and the `gem` command. 

The problem here is that the `Gemfile.lock` file doesn't list the `colorize` Gem; `bundler/setup` insists that your `Gemfile.lock` __contains all needed Gems__. To add this Gem to yours, add it to your Gemfile, then run `bundle install` again to generate a __new__ `Gemfile.lock` file.

__Correct version of Bundler__<br/>
Another potential issue is that you may use the *wrong version of the `bundle`* command. Remember that Bundler is a RubyGem, and __every Ruby version on your system has its own Gems__; this includes the `bundle` command. 

If you use `bundle` from version 2.2.2 of Ruby when you mean to use Ruby 2.3.1, you may end up with unexpected results. For instance, if your Gemfile lists a specific version of a Gem that only runs under Ruby 2.3.0 or higher, the `bundle` command will fail to find a Gem that meets that requirement. Make sure you use the correct version of `bundle`.

Other things to try include:
- Removing the `Gemfile.lock` file and running `bundle install` again, which should generate a new `Gemfile.lock` file.
- Remove the `.bundle` directory and its contents from your project directory and run `bundle install` again.
- If you're using the `binstubs` feature, remove the directory used by `binstubs` and run `bundle install --binstubs` again. __Don't do this if you aren't using `binstubs`__.
- Remove and reinstall `bundler`
- If `gem list` shows that either `rubygems-bundler` or `open_gem` are installed, __uninstall them__. These old Gems are _incompatible with Bundler_. Repeat the above items if you remove either Gem.
- Issue this command in the command line from your app's top-level directory: `rm Gemfile.lock ; DEBUG_RESOLVER=1 bundle install`

This command removes the `Gemfile.lock` file, then runs `bundle install` while producing debug information. You can use the debug information to see how Bundler resolves each Gem. This can be valuable when you aren't sure if your app is loading the correct Gems. 

Note that you must include the `rm Gemfile.lock` part; this mode __only produces useful output when `Gemfile.lock` doesn't exist__. More information on how this works can be found [here](http://patshaughnessy.net/2011/9/24/how-does-bundler-bundle).
