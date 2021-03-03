# Custom Method Implementations

## Table of Contents
- [The `times` method](#the-`times`-method)
- [The `each` method](#the-`each`-method)
- [The `select` method](#the-`select`-method)
- [The `reduce` method](#the-`reduce`-method)

### The `times` method
Let's write our own `times` method that mimics the behavior of the `Integer#times` method.
```ruby
5.times do |num|
  puts num
end

# 0
# 1
# 2
# 3
# 4
# => 5
```
Notice that the `Integer#times` method's first block argument is `0`, and the last block argument is 1 less than the calling object. Finally, the method _returns the calling object_, `5`. 

Our `times` method will exhibit the same behavior, yielding to the block starting with `0` and going up to 1 less than the method argument. We don't have a calling object, but we do have a method argument, so we'll return that. In other words, we should be able to write the following code and get identical output as `Integer#times`:
```ruby
# method implementation
def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end

  # return the original method argument to match behavior of `Integer#times`
  number
end

# method invocation
times(5) do |num|
  puts num
end

# Output:
# 0
# 1
# 2
# 3
# 4
# => 5
```
Tracing the code execution flow of the above code:
1. Method invocation starts at line 13, when the `times` method is called with an argument, `5`, and a block of code.
2. Execution enters the first line of the method implementation at line 3, where the method local variable `counter` is initialized.
3. Execution continues to line 4. The `while` conditional is evaluated. The first time through, the condition is `true`.
4. Execution continues to line 5, which yields to the block. This is the same as executing the block of code, and this time, we are executing the block of code with an argument. The argument to the block is the counter, which is `0` the first time through.
5. Execution jumps to the block on line 13, setting the block local variable `num` to `counter`.
6. Execution continues in the block to line 14, which outputs the block local variable `num`.
7. Reaching the end of the block, execution continues back to the `times` method implementation on line 6, where `counter` is incremented.
8. Reaching the end of the `while` loop, execution continues on line 4, essentially repeating steps 3 through 7.
9. At some point, the `while` conditional should return `false` (otherwise, you have an infinite loop), allowing execution to flow to line 9.
10. Reaching the end of the method at line 10, execution will return the last expression in this method, which is the `number` method local variable.

Again, there are two separate roles here: the `times` method implementer and the user of the `times` method. We want to write a generic `times` method, and we don't know if users of the method will be outputting values, or adding them together, or whatever. 

As the implementer, all we want to do is write a generic method that iterates up to a certain number. Using a block is a perfect use case; we can allow users of the method to use blocks to perform some action. But we don't know what that action is, so all we are responsible for is to `yield` to the block and pass to the block the current number. This is the inspiration for our implementation of our `times` method.

### The `each` method
What happens is that the `Array#each` method iterates through the array, yielding each element to the block, where the block can do whatever it needs to do to each element. Then, the method _returns the calling object_. This is so developers can chain methods on afterwards.
```ruby
[1, 2, 3].each { |num| "do nothing" }
# still returns [1, 2, 3]
```
Here's our own implementation of the `each` method:
```ruby
def each(array)
  counter = 0

  while counter < array.size
    # yield to the block, passing in the current element to the block
    yield(array[counter])
    counter += 1
  end

  # returns the `array` parameter, similar in spirit to how `Array#each` returns the caller
  array
end

each([1, 2, 3, 4, 5]) do |num|
  puts num
end

# 1
# 2
# 3
# 4
# 5
# => [1, 2, 3, 4, 5]
```
The entire magic of our each method relies on the fact that our method __does not implement what action to perform__ when iterating through the array. Our `each` method is __solely focused on iterating__ and not on anything beyond that. 

Writing a generic iterating method allows method callers to add additional implementation details at method invocation time by passing in a block. This is why when we implemented the method, we `yield` to the block. 

Note that the trick here is to pass the current element we're working with to the block. At each iteration within the `while` loop, execution then goes to the block (with the current element as the block argument), and will return execution back to the `while` loop after executing the block. Then, `counter` is incremented and the while `loop` continues and the next element is yielded to the block.

### The `select` method
The `Array#select` method takes a block, then yields each element to the block. If the block evaluates to `true`, the current element will be included in the returned array. If the block evaluates to `false`, the current element will not be included in the returned array.
```ruby
array = [1, 2, 3, 4, 5]

array.select { |num| num.odd? }
# => [1, 3, 5]

array.select { |num| puts num }
# => [], because "puts num" returns nil and evaluates to false

array.select { |num| num + 1 }
# => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
```
Our custom implementation might look something like this:
```ruby
def select(array)
  new_arr = []

  for element in array
    # could skip this step, and use if yield(element)
    return_value = yield(element)
    new_arr << element if return_value
  end

  new_arr
end

array = [1, 2, 3, 4, 5]

select(array) { |num| num.odd? }
# => [1, 3, 5]

select(array) { |num| puts num }
# => [], because "puts num" returns nil and evaluates to false

select(array) { |num| num + 1 }
# => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
```
### The `reduce` method
`reduce` is another name for the `inject` method, and its main goal is to "fold" or "accumulate" a collection into 1 object. What the specific folding or accumulation mechanism is depends on the code passed in to the block. Let's take the typical example and sum up an array of integers.
```ruby
[1, 2, 3].reduce do |acc, num|
  acc + num
end

# => 6
```
The return value of the block is then assigned to the accumulator object. Therefore, the below code is __incorrect__.
```ruby
[1, 2, 3].reduce do |acc, num|
  acc + num if num.odd?
end

# => NoMethodError: undefined method `+' for nil:NilClass
```
You might have expected the answer to be `4`, thinking that the code will add up `1` and `3` together, skipping `2`. However, remember what the `reduce` method does: it __sets the accumulator to the return value of the block__, and then __passes the accumulator to the block on the next `yield`__. When it got to `2`, the line `acc + num if num.odd?` returned `nil`. 

The accumulator is now set to `nil`, and the next time reduce yielded to the block, this accumulator (which is now `nil`) was passed to the block. That's why we get the `NoMethodError`. Note that if our array is `[1, 2]`, the above code will return `nil`, because after iterating through the array, it returns the accumulator (which is `nil` since it's not odd).

Another interesting behavior for the `Enumerable#reduce` method is that you can initialize the accumulator to a default value. For example, let's say we wanted to add up all the elements of an array, but we wanted to start the accumulator from `10`. We can do this:
```ruby
[1, 2, 3].reduce(10) do |acc, num|
  acc + num
end

# => 16
```
Our implementation might look something like this:
```ruby
def reduce(array, default_value = 0)
  accumulator = default_value
  for element in array
    accumulator = yield(accumulator, element)
  end

  accumulator
end

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }
# => 15

reduce(array, 10) { |acc, num| acc + num }
# => 25

reduce(array) { |acc, num| acc + num if num.odd? }
# => NoMethodError: undefined method `+' for nil:NilClass
```
#### Comparison with `Enumerable#reduce`
If you take a close look at the real `reduce` method in the `Enumerable` module, you'll see that the real `reduce` is far more flexible and powerful. It contains many features our `reduce` method that we wrote above doesn't consider. While we could think about adding some of those features, it will stretch our code beyond the core concepts in this lesson, which is learning to work with blocks.

One other thing you may notice is that we use a number (`0`) as the default initial value for the accumulator, which limits us: we can't use our version with a default value if the data is non-numeric. Compare this to `Enumerable#reduce` where the default initial value is the first element of the collection.

For an extra challenge, how would you implement this improved default behavior? Try it on your own.
```ruby
def reduce(array, start_val = omitted = true)
  accumulator = omitted ? array.first : start_val
  counter = omitted ? 1 : 0

  while counter < array.size
      accumulator = yield(accumulator, array[counter])
      counter += 1
  end

  accumulator
end

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }
# => 15
reduce(array, 10) { |acc, num| acc + num }
# => 25
reduce(array, 1) { |acc, num| acc + num }
# => 16
reduce(['a', 'b', 'c']) { |acc, value| acc += value }
# => 'abc'
reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }
# => [1, 2, 'a', 'b']
```
The omitted flag is required to handle the edge case where the first element of the array is the same as the optional accumulator argument passed in by the user. If this occurs, the counter would otherwise skip the first element, and undercount the total (see 3rd example, which would equal `15` in that case).

We could also have implemented it as such:
```ruby
def reduce(array, start_val = nil)
  accumulator = start_val.nil? ? array.first : start_val
  counter = start_val.nil? ? 1 : 0

  while counter < array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end

  accumulator
end
```
