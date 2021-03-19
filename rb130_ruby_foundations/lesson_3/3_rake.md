# Rake

## Table of Contents
- [What is `rake`](#what-is-rake)
- [How to use `rake`](#how-to-use-rake)
- [Why do I need `rake`](#why-do-i-need-rake)

### What is `rake`
Rake is a Rubygem that automates many common functions required to build, test, package, and install programs; it is part of every modern Ruby installation, so you don't need to install it yourself.

Here are some common Rake tasks that you may encounter:
- Set up required environment by creating directories and files
- Set up and initialize databases
- Run tests
- Package your application and all of its files for distribution
- Install the application
- Perform common Git tasks
- Rebuild certain files and directories (assets) based on changes to other files and directories

In short, you can write Rake tasks to automate anything you may want to do with your application during the development, testing, and release cycles.

### How to use `rake`
Rake uses a file named `Rakefile` that lives in your project directory; this file describes the tasks that Rake can perform for your project, and how to perform those tasks.
```ruby
desc 'Say hello'
task :hello do
  puts "Hello there. This is the `hello` task."
end

desc 'Say goodbye'
task :bye do
  puts 'Bye now!'
end

desc 'Do everything'
task :default => [:hello, :bye]
```
This `Rakefile` contains three tasks: two that simply display a single message, and one task that has the other tasks as prerequisites or dependencies. The first two tasks are named `:hello` and `:bye`, while the final task is the `default` task; Rake runs the `default` task if you __do not provide a specific task name__ when you invoke Rake.

Each of the above tasks calls two Rake methods: `desc` and `task`. The `desc` method provides a short description that Rake displays when you run `rake -T`, and the `task` method associates a name with either a block of Ruby code (lines 2-4 and 7-9) or a list of dependencies (line 12). Here, the `:default` task depends on the `:hello` and `:bye` tasks: when you run the `:default` task, Rake will run the `:hello` and `:bye` tasks first.

The first thing you should do with any Rakefile is find out what tasks it can run. You do this with the `rake -T` command:
```
$ bundle exec rake -T
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello
```
This shows that there are three tasks defined by the Rakefile: `bye`, `default`, and `hello`. The output shows a short description of each task on the right: this information comes from the `desc` method calls in `Rakefile`.

Often, `rake -T` will work just fine, but many prefer to use `bundle exec` with `rake` when possible (i.e. when your project uses Bundler); if you don't, you may see unusual messages like this:
```
$ rake -T

rake aborted!
Gem::LoadError: You have already activated rake 12.0.0, but your Gemfile requires rake 10.4.2. Prepending `bundle exec` to your command may solve this.
```
If you see the below error when using `bundle exec rake`, it means that the project is not using `bundler`. In this case, we should omit `bundle exec` and just run `rake` instead.
```
Could not locate Gemfile or .bundle/ directory
```
One very important thing to notice is that `Rakefile` is actually a Ruby program. You can put __any Ruby code__ you want in a Rakefile and run it as part of a task. Commands like `desc` and `task` are just method calls to parts of Rake; these method calls comprise a Domain Specific Language (DSL) for writing automated Rake tasks.
```
$ bundle exec rake bye
Bye now!

$ bundle exec rake hello
Hello there. This is the `hello` task.

$ bundle exec rake default
Hello there. This is the `hello` task.
Bye now!

$ bundle exec rake                     # we don't need to specify 'default'
Hello there. This is the `hello` task.
Bye now!
```
### Why do I need `rake`
One reason why you need Rake is that nearly every Ruby project you can find has a `Rakefile`, and the presence of that file means you need to use Rake if you want to work on that project.

While you can always opt-out of using Rake in your projects, there is little point to doing so. Every project that aims to produce a finished project that either you or other people intend to use in the future has repetitive tasks the developer needs. For instance, to release a new version of an existing program, you may want to:
- Run all tests associated with the program.
- Increment the version number.
- Create your release notes.
- Make a complete backup of your local repo.

Each step is easy enough to do manually, but you want to make sure you __execute them in the proper order__ (for instance, you want to set the new version number before you commit your changes). You also don't want to be at the mercy of arbitrary typos that may do the wrong thing. It's far better to have a way to perform these tasks automatically with just one command, which is where Rake becomes extremely useful.

Your `Rakefile` likely has each of these as a separate task, as well as a single overall task (call it release, for instance) that steps through the tasks one at a time. The release task would stop __only when it completes all the tasks or one task fails__.
