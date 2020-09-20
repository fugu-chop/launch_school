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