# Note we don't have to master the content for the purposes of an assessment

=begin
Thus far, we've been using methods like each and map, which are internal iterators - the process and implementation of that iteration is hidden from us, and the process that allows us to progress through a collection is part of that hidden implementation.

There's also "External Iteration". This is iteration that takes place at the behest of the user. Ruby gives us the option to use this type of iteration with the Enumerator class.
=end

# 1) Your task is to create a new Enumerator object. When creating a new Enumerator, you may define what values are iterated upon. We'll want to create an Enumerator that can iterate over an infinite list of factorials. Once you make this new Enumerator, test it out by printing out the first 7 factorial values, starting with zero factorial.

# More specifically, print the first 7 factorials by using an "External Iterator". Once you have done so, see what happens if you print 3 more factorials (the results won't be correct). Now, reset your Enumerator (use the rewind method). Finally, print 7 more factorials.

# Iteration is defined by the given block, in which a “yielder” object, given as block parameter, can be used to yield a value by calling the yield method (aliased as <<)
factorial = Enumerator.new do |yielder|
  # Remember, we don't need to take user input - we are just calculating all factorials, starting from zero
  accumulator = 1
  number = 0
  # We need to yield this accumulator to the yielder on each iteration
  loop do
    # No need to break the loop explicitly - we control each iteration with Enumerator methods
    
    yielder << accumulator
    number += 1
  end
end
