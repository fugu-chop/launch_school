# Blocks and Variable Scope

## Table of Contents
- [Closure and Binding](#closure-and-binding)

### Closure and Binding
A block is how Ruby implements the idea of a __closure__, which is a general computing concept of a "chunk of code" that you can pass around and execute at some later time. In order for this "chunk of code" to be executed later, it must understand the surrounding context from when it was initialized. 

In Ruby, this "chunk of code" or closure is represented by a `Proc` object, a lambda, or a block. Remember that __blocks are a form of `Proc`__.
```ruby
name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" }
```
If you try to run that code, nothing will happen. That's because we've created a `Proc` and saved it to `chunk_of_code`, but haven't executed it yet. We can now pass around this local variable, `chunk_of_code` and execute it at any time later. Suppose we have a completely different method, and we pass in this `chunk_of_code` into that method, then the method executes that `chunk_of_code`. 
```ruby
def call_me(some_code)
  # call will execute the "chunk of code" that gets passed in
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" }

call_me(chunk_of_code)

# hi Robert
# => nil
```
Note that the `chunk_of_code` knew how to handle `puts #{name}`, and specifically that it knew how to process the `name` variable. How did it do that? The `name` variable was initialized outside the method definition, and we know that in Ruby local variables initialized outside the method aren't accessible inside the method, unless it's explicitly passed in as an argument.
