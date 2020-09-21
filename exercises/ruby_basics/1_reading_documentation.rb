# 1) Where can you find the most complete Ruby documentation?
puts "https://docs.ruby-lang.org/en/ is where we find the most complete Ruby documentation."

# 2) Locate the description of the while loop in the ruby documentation.
puts "Documentation on while loops can be found here, under the 'Control Expressions' section: https://docs.ruby-lang.org/en/master/doc/syntax/control_expressions_rdoc.html#label-while+Loop"

# 3) Using the ruby documentation, determine what value a while loop returns.
puts "Per this, https://docs.ruby-lang.org/en/master/doc/syntax/control_expressions_rdoc.html#label-while+Loop, a while loop will print out a specified expression, but will return nil unless break is used to supply a value."

# 4) In the previous exercise, you learned that the while loop returns nil unless break is used. Locate the documentation for break, and determine what value break sets the return value to for the while loop.
puts "The break statement stops an expression from completing fully. If an expression is terminated by break, it will return the most recent value supplied to it in the while loop (provided a value is supplied to it, otherwise a simple break will still return a nil). Documentation for break statements can be found here: https://docs.ruby-lang.org/en/master/doc/syntax/control_expressions_rdoc.html#label-break+Statement"

# 5) Using the Ruby documentation, determine how you can write large numbers in a way that makes them easier to read.
puts "Ruby has a concept of integer literals, which allow us to insert underscores in large numbers that create commas, making them easier to read. Documentation can be found here: https://docs.ruby-lang.org/en/master/doc/syntax/literals_rdoc.html"

# 6) Using the ruby documentation, determine how you would write a Symbol that represents your name. We aren't looking for a String; we want a Symbol, which is one of ruby's datatypes.
puts "We could append :to_sym to a string to convert it to a symbol. We could also write :name. Per here: https://docs.ruby-lang.org/en/master/Symbol.html#method-i-to_sym"

# 7) Let's move on now to the documentation you will use most often; the core API section on Classes and Modules. All of these are listed under Classes on the Core API page. Locate and open the class documentation for the String class. 
puts "The documentation for strings can be found here: https://docs.ruby-lang.org/en/master/String.html"

# 8) Use the ruby documentation for the String class to determine which method can be used to right justify a String object.
puts "We can use rjust to right-justify a string. The documentation is here: https://docs.ruby-lang.org/en/master/String.html#method-i-rjust"

# 9) 