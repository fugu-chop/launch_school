*1) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​‘Hello’ 
b = a
a = '​Goodbye​'
```
On `line 1`, the local variable `a` is initialised and assigned to the string object `'Hello'`. On `line 2`, the `b` variable is initialised, and assigned to the same string object that the local variable `a` is pointing towards (`'Hello'`). On `line 3`, the local variable `a` is reassigned to the string object `'Goodbye'`. 

When executed, `a` will return the string object `'Goodbye'`, while `b` will return the string object `'Hello'`.  This is because variables are pointers to objects, and are not themselves, values. On `line 2`, the local variable `b` is referencing the string object `'Goodbye'`, not the local variable `a`. 

*2) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​4
loop ​do 
  a = ​5
  b = ​3
  break
end

puts a
puts b
```
The local variable `a` is initialised on `line 1` and assigned to the integer object `4`. A `loop` method is invoked on `line 2` with a block (denoted by the `do..end` reserved words immediately after a method call) passed in as an argument. Variables within a block scope are able to access local variables initialised outside of the block scope - this is why the local variable `a` is reassigned to the integer object `5` within the block on `line 3`. 

Variables initialised within a block scope cannot be accessed outside of the block scope. On `line 4`, the variable `b` is initialised in the block scope, but not accessible outside of the block. This is why `line 9` will return a `NameError`. 

After each of the `a` and `b` variables are assigned a reference to an integer object, the `break` keyword exits the loop. 

On `line 8`, we call the `puts` method, passing in the local variable `a` as an argument, which will output the integer `5` and return `nil`. On `line 9`, we call the `puts` method, passing in the local variable `b` as an argument, which will raise a `NameError` exception. 

*3) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​4 
b = ​2

loop ​do 
  c = ​3
  a = c
  ​break
end

puts a
puts b
```
On `line 1`, the local variable `a` is initialised and assigned to the integer object `4`. On `line 2`, the local variable `b` is initialised and assigned to the integer object `2`. On `line 4`, the `loop` method is invoked with a block (denoted by the `do..end` reserved words immediately after the `loop` method call) passed in as an argument.  

Within the block scope, the local variable `c` is initialised and assigned to the integer object `3` on `line 5`. On `line 6`, the local variable `a`, which is initialised outside of the block, but accessible from within the block scope, is reassigned to the same integer object `3` that the block variable `c` points to, since variables are pointers to objects. On `line 7`, the `break` keyword exits the `loop` method. 

The local variable `a` (which is a reference to the integer object `3`) is passed as an argument to the `puts` method on `line 10`, which will output the integer object `3` and return `nil`, while `puts` method call on `line 11` will output the integer object `2` (as referenced by the local variable `b`) and return `nil`, since the local variable `b` was not reassigned to a different object within the loop. 

*4) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​example​(str)
  i = ​3
  loop ​do
    puts str
    i -= ​1
    ​break​ ​if​ i == ​0
  ​end
end

example(​'hello'​)
```
On `line 1 - 8`, we define the `example` method, which takes a `str` parameter. On `line 10`, we invoke the `example` method, passing the string object `'hello'` as an argument.

On `line 2`, within the method definition, we initialise a local variable `i` and assign it to the integer object `3`. On `line 3`, a `loop` method is invoked with a block (denoted by the `do..end` reserved words immediately after the `loop` method call) passed in as an argument. 

On `line 4`, we call the `puts` method, passing in the `'hello'` string object from the block parameter `str` as an argument. This `puts` call outputs the string object `'hello'`, and returns `nil`. On `line 5`, the local block variable `i` is reassigned to the return value of the method call `Integer#-` on the local block variable `i` with integer `1` passed to it as an argument.

The `i -= 1` line makes use of syntactical sugar (equivalent to `i = i - 1`), while the `Integer#-` method is also syntactical sugar for `.-()`. `line 6` checks to see if the object referenced by the variable `i` is equal to `0`. If this conditional evaluates to `true`, the `break` keyword will exit the loop. 

The code on `line 10` will print `'Hello'` three times, and return `nil`. The reason `nil` is returned is that Ruby has an implicit return on the last line of code within a method (and there is no explicit `return` in the block). This is the `break if i == 0` expression, which returns `nil`. 

*5) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​greetings​(str) 
  puts str
  puts ​"Goodbye"
end

word = ​"Hello" 
greetings(word)
```
On `lines 1-4`, we define the `greetings` method, which takes a `str` parameter. On `line 6`, we assign the string object `'Hello'` to the local variable `word`. On `line 7`, we call the `greetings` method, passing in the `word` local variable (which references the string object `'Hello'`) as an argument. 

On `line 2`, when the `greetings` method is invoked, the `str` local variable is initialised when an argument is passed to the `str` parameter. In our case, this is the string object `'Hello'`. We then call the `puts` method, passing in the object referenced by the `str` block parameter as an argument. This outputs `'Hello'` and returns `nil`. On `line 3`, we call the `puts` method, passing in the string object `'Goodbye'` as an argument, which outputs `'Goodbye'` and returns `nil`. 

The end result of calling the `greetings` method with the string object `'Hello'` as an argument on `line 7` is that both `'Hello'` and `'Goodbye'` are output, and `nil` is returned. `nil` is returned because without an explicit `return` reserved word, the last line of the expression evaluated in a method will be returned implicitly. `puts` always returns `nil`. 

*6) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​] 

counter = ​0
sum = ​0

loop ​do
  sum += arr[counter]
  counter += ​1
  break ​if​ counter == arr.size
end

puts ​"Your total is ​#{sum}​"
```
On `line 1`, we initialise the local variable `arr` and assign it to an array object, containing the integer objects `1, 2, 3, 4`.
On `line 3`, we initialise the local variable `counter` and assign it to the integer object `0`. 
On `line 4`, we initialise the local variable `sum` and assign it to the integer object `0`. 

On `line 6`, we call the `loop` method with a block (denoted by the `do..end` reserved words immediately following the `loop` method call) passed in as an argument. 
On `line 7`, the local variable `sum` is reassigned to the value of the array element referenced by the local variable `arr`, where the array index is set to the value referenced by the `counter` local variable. The inner scope of the block is able to access the `arr`, `counter` and `sum` local variables, even though they are initialised outside of the block scope. This occurs for each element in the array object. 

The `+=` code is syntactical sugar for `sum = sum + arr[counter]`. The `Integer#+` method on `line 7` is also making use of syntactical sugar, which we could rewrite as `sum = sum.+(arr[counter])`.

On `line 8`, we reassign the local variable `counter` to the value of the integer object `counter` is referencing plus `1`. On `line 9` We break from the loop, if the value of the object `counter` is referencing is equal to the return value of the `size` method called on the object the local variable `arr` is referencing. 

On `line 10`, we pass the `sum` variable (which references the integer object `10`) as an argument to the string object `"Your total is #{sum}"` via string interpolation. This string object is then passed to the `puts` method, which will output `"Your total is 10"` and return `nil`, since `puts` always returns `nil`. 

*7) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​'Bob'
5​.times ​do​ |x| 
  a = ​'Bill'
end

p a
```
On `line 1`, we initialize a local variable `a` and assign it to the string object `'Bob'`. On `line 2`, we invoke the `times` method on the object integer `5`, and pass a block to the `times` method (denoted by the `do..end` reserved words immediately after the `times` method invocation) as an argument. The block takes a single parameter, `x`. 

On `line 3`, the local variable `a` initialised in the outer scope is reassigned to the string object `'Bill'`. This occurs `5` times, on account of the `times` method executing the block 5 times. After the 5th iteration, the `times` methods returns the object it was called on - in this case, the integer object `5`. 

On `line 6`, we call the `p` method and pass the local variable `a` as an argument. This will output and return the string object `'Bill'`. This is because local variables initialised outside of a block are accessible within the block, allowing the reassignment of local variable `a` within the block. 

*8) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
animal = ​"dog"
loop ​do​ |_| 
  animal = ​"cat" 
  var = ​"ball" 
  ​break
end

puts animal
puts var
```
On `line 1`, we initialise a local variable `animal` and assign it to the string object `'dog'`. On `line 2`, we call the `loop` method, passing in a block (the block is denoted by the `do...end` reserved words immediately following the `loop` method call). The block, while taking a parameter (`_`), never uses this parameter when executing the rest of the code. 

On `line 3`, the local variable `animal` initialised outside of the block is reassigned to the string object `'cat'`. This is possible because the block scope can access variables initialised outside of it. On `line 4`, a local variable `var` is initialised within the block, and assigned to the string object `'ball'`. 

On `line 5`, we break out of the loop using the `break` reserved word. 

On `line 8`, we call the `puts` method and pass the local variable `animal` as an argument, which outputs `'dog'` and returns `nil` (`puts` always returns `nil`). On `line 9`, as we attempt to pass the `var` local variable as an argument to the `puts` method, Ruby will raise a `NameError` exception, as variables initialised within a block scope cannot be accessed outside of that block. 

*9) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​4
b = ​2

2​.times ​do​ |a| 
  a = ​5
  puts a
end

puts a
puts b
```
On `line 1`, we initialise a local variable `a`, and assign it to the integer object `4`. We initialise a local variable `b` on `line 2`, assigning it to the integer object `2`. 

On `line 4`, we call the `times` method on the integer object `2`, passing in a block (denoted by the `do...end` reserved words immediately following the `times` method invocation). This has the effect of executing the block `2` times. On `line 5`, the local variable `a` is initialised and assigned to the integer object `5`. The local variable `a` initialised outside of the block referencing the integer `4` cannot be accessed by the block, as variable shadowing occurs (which prevents variable reassignment here). 

Variable shadowing prevents an inner scope from accessing variables initialised outside of it when the block parameter is given the same name as the local variable that is being passed to the block. On `line 5`, passing the local variable `a` initialised in the block scope to the `puts` method will output `5` and return `nil`. `Lines 5-6` will be executed twice, since the integer object `2` on which `times` was called on determines how many times the block will be executed. 

Once the second execution finishes, the `times` method will return the object it was called on (the integer object `2`). 

On `line 9`, we pass in the local variable `a` to the `puts` method, which will output the string object `'5'` and return `nil`, due to variable shadowing interfering with the attempted variable reassignment in the block. 

On `line 10`, we pass in the local variable `b` to the `puts` method, which will output a string object `'2'` and return `nil` (since `puts` always returns `nil`). 

*10) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
n = ​10 

1​.times ​do​ |n|
  n = ​11
end

puts n
```
On `line 1`, we initialise a local variable `n` and assign it to the integer object `10`. On `line 2`, we call the `times` method on the integer object `1`, and pass in a block to the `times` method. The `do...end` reserved words immediately following the `times` method invocation indicate that this is a block. 

On `line 4`, a local variable `n` is initialised and assigned to the integer object `11` passed to it by the block parameter `n`. The local variable `n` in the outer scope is __not__ reassigned, as variable shadowing occurs. Variable shadowing stops the inner scope of the block accessing local variables initialised outside of the block scope when the block parameter has the same name as the local variable initialised outside of the inner scope. 

The `times` method executes once, since the number of times the method will execute the block depends on the integer object on which it is called. After `line 4` is executed, the `times` method will return `1`, the integer object on which the method was called. 

Finally, on `line 7`, we pass the local variable `n` as an argument to the `puts` method, which will output the string object `'10'` (no reassignment occurs in the block scope due to variable shadowing) and return `nil` (the `puts` method always returns `nil`). 

*11) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
animal = ​"dog"

loop ​do​ |animal| 
  animal = ​"cat" 
  ​break
end

puts animal
```
On `line 1`, we initialise a local variable `animal` and assign a string object, `'dog'` to it. On `line 3`, we call the `loop` method and pass a block that takes a parameter as an argument. On `line 4`, we initialise a local variable `animal` and assign it to the string object `'cat'` passed by the block parameter `animal`. The local variable `animal` initialised outside of the block is __not__ reassigned due to variable shadowing. 

Variable shadowing stops the inner scope from accessing local variables initialised outside of the block when the block parameter has the same name as the local variable initialised outside of the block (thus preventing variable reassignment from occuring on `line 4`). On `line 5`, the `break` reserved word exits the loop. Once the loop is finished executing, it returns `nil`, since there is no explicit `return` in this loop, the last line of the expression is returned. In this case, it's the `break` reserved word, which returns `nil`. 

On `line 8`, we pass the local variable `animal` (which still references the string object `'dog'`) to the `puts` method, which will output the string object `'dog'` and return `nil` (since `puts` always returns `nil`). 

*12) What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a` and `b`?*
```
a = ​"hi there"
b = a
a = ​"not here"
```
On `line 1`, we initialise a local variable `a` and assign a string object `'hi there'` to it. This will also return the string object `'hi there'`. On `line 2`, we initialise a local variable `b`, and assign it to the same object that the local variable `a` is referencing (the string object `'hi there'`). This will also return `'hi there'`. 

On `line 3`, we reassign the local variable `a` to reference a different string object (`'not here'`). The local variable `b` will return `'hi there'`, as variables are references to objects. 

*13) What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a` and `b`?*
```
a = ​"hi there" 
b = a
a << ​", Bob"
```
On `line 1`, we initialise a local variable `a`, and assign the string object `'hi there'` to it. On `line 2`, we initialise the local variable `b`, and since variables are pointers to objects, we assign the same string object that the local variable `a` was pointing to to `b` (`'hi there'`). 

On `line 3`, we use the shovel operator to append the string object `', Bob'` to the string object that local variable `a` was pointing to (`'hi there'`). The shovel operator is destructive (mutating the original string object, rather than creating a new one), and so local variable `a` will return `'hi there, Bob'`. Local variable `b` will also return `'hi there, Bob'`, since the shovel operator is a destructive method, and does not result in reassignment of the local variable `a` to a different object. 

*14) What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a`,`b` and `c`? What happens if the last line was `c = a.uniq!`?*
```
a = [​1​, ​2​, ​3​, ​3​]
b = a
c = a.uniq
```
On `line 1`, we initialise the local variable `a`, and assign the array object `[​1​, ​2​, ​3​, ​3​]` to it. On `line 2`, we initialise the local variable `b` and since variables are references to objects, `b` is assigned to the same array object that the local variable `a` is pointing towards. 

On `line 3`, the local variable `c` is initialised, and assigned to the return value of calling the `uniq` method on the array object referenced by local variable `a`. The `.uniq` method removes duplicate elements and returns a new array of unique elements - `[1, 2, 3]`. Therefore, the local variables `a` and `b` will return `[1, 2, 3, 3]`, while `c` will return `[1, 2, 3]`, as the `uniq` method is non-destructive, and the object returned by `a.uniq` is different to the object `a` is referencing. 

If the last line was `c = a.uniq!`, then local variables `a`, `b` and `c` would all return `[1, 2, 3]`. This is because `uniq!` is a destructive method, mutating the original array object, rather than creating a new object. This means that `a`, `b` and `c` are all pointing towards the same object. 

*15) What does the following code return? What does it output? Why? What concept does it demonstrate? What is `a`? What if we called `map!` instead of `map`?*
```
def​ ​test​(b)
  b.map { |letter| ​"I like the letter: ​#{letter}​"​ }
end

a = [​'a'​, ​'b'​, ​'c'​] 
test(a)
```
On `lines 1-3`, we are defining the `test` method, which takes a single parameter (`b`). On `line 5`, we initialise the local variable `a` and assign it to an array object `[​'a'​, ​'b'​, ​'c'​]`. On `line 6`, we pass in the local variable `a` as an argument to the `test` method. 

On `line 2`, the `map` method is called on the array object referenced by the local variable `a`. The `map` method is invoked with a block (signified by the `{}` immediately following the method invocation). On `line 6`, we pass the local variable `a` as an argument to the `test` method, which passes the array object referenced by the local variable `a` to the method parameter `b`, upon which we invoke the `map` method. 

The `map` method will return a new array object whose contents depend on the return value of the block on each iteration. On each iteration, each element of the array object is passed to the block parameter `letter`. This element is then passed (through string interpolation) to the string `"I like the letter: #{letter}"`.

As there is no explicit `return` in this method definition, Ruby will return the last expression evaluated. In this case, the `map` method is the last expression, which will return `['I like the letter: a', 'I like the letter: b', 'I like the letter: c']`. This is the returned object from the `test(a)` method call on `line 6`. The local variable `a` is still the array object `['a', 'b', 'c']`, as the `map` method returns a new object. 

If we had used the `map!` instead of `map`, `test(a)` and `a` would both return `['I like the letter: a', 'I like the letter: b', 'I like the letter: c']`. This is because `map!` is a mutating method. Instead of creating a new array object, `map!` will reassign the elements within the original `['a', 'b', 'c']` array to the values returned by the block. 

*16) What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a` and `b`? Why?*
```
a = ​5.2 
b = ​7.3

a = b

b += ​1.1
```
On `line 1`, we initialise local variable `a` and assign it to the float object `5.2`. On `line 2`, we initialise the local variable `b` and assign it to the float object `7.3`. On `line 4`, we reassign the local variable `a` to reference the same float object that local variable `b` is pointing to, `7.3` as variables are pointers to objects.  

On `line 6`, we reassign the local variable `b` to the value of the float object referenced by `b` plus `1`. This is an example of Ruby syntactic sugar, where `b += 1.1` can be rewritten as `b = b + 1.1`, and `b + 1.1` is also syntactic sugar for `b.+(1.1)`. 

After this code executes, local variable `a` will return the float object `7.3`, while local variable `b` will return the float object `8.4`. Local variable `a` is not the same as local variable `b`, as reassignment is not destructive (float objects are also immutable). So when we reassign the local variable `b`, a new float object is being referenced. 

*17) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​test​(str) 
  str += ​'!' 
  str.downcase!
end

test_str = ​"Written Assessment" 

test(test_str)
puts test_str
```
On `line 6`, we are initialising a local variable `test_str` and assigning it to a string object with the value `'Written Assessment'`. We then pass this `test_str` variable as an argument to the `test` method. On `lines 1-4`, we are defining the `test` method, which takes a single parameter (`str`). 

On `line 2`, the `str` local variable is initialised and passed the `'Written Assessment'` string object by the `str` parameter, and reassigned to a new string object, which is an additional `'!'` string object added to the value of the string object the local variable `str` is referencing. 

On `line 3`, the `downcase!` method is invoked on the local variable `str`, which destructively downcases the string object referenced by `str`. As there is no explicit `return` in this expression, the last evaluated line of code (`str.downcase!`) will be returned from the `test` method call, which is a string object `'written assessment!'` (`line 8`).

On `line 9`, we call the `puts` method and pass the `test_str` local variable as an argument. This will output `'Written Assessment'` and return `nil` (`puts` always returns `nil`). The reason why `test_str` was not mutated is that while variables are pointers to objects, there was a variable reassignment on `line 2`, such that the destructive method on `line 3` was called on a different string object to the string object that `test_str` is referencing. 

*18) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​plus​(x, y) 
  x = x + y
end

a = ​3
b = plus(a, ​2​)

puts a
puts b
```
On `line 5`, we initialise the local variable `a`, and assign it to the integer object `3`. On `line 4`, we initialise the local variable `b`, and assign it to the return value of calling the `plus` method, with the local variable `a` and the integer object `2` passed in as arguments. On `line 1-3`, we define the `plus` method which takes two parameters (`x` and `y`). 

Within the `plus` method (`line 2`), we initialise a local variable `x`, and assign it to the return value of applying the `Integer#+` method with the integer object `2` as an argument to the integer object `3` (these objects were passed via the method parameters `x` and `y` respectively). This is an example of syntactic sugar, and `line 2` could be rewritten as `x = x =.+(y)`. 

As there is no explicit return statement in the method, the last line evaluated of the expression is `line 2`, which returns the integer object `5` in our case. 

On `line 8`, we pass the local variable `a` as an argument to the `puts` method call, which will output `3` and return `nil` (`puts` always returns `nil`). On `line 9`, we pass the local variable `b` to the `puts` method call, which will output `5` and return `nil`. 

*19) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​increment​(x) 
  x << ​'b'
end

y = ​'a' 

increment(y)
puts y
```
On `line 5`, we initialise a local variable `y` and assign it to the string object `'a'`. On `line 7`, we call the `increment` method, passing in the local variable `y` as an argument. 

On `line 1-3`, we define a method `increment` which takes one parameter (`x`). On `line 2`, we initialise local variable `x` and pass a reference to an object from the `x` parameter, This object has a string object with the value `'b'` destructively added through the shovel operator (i.e. the original string object is modified, instead of creating a new string object). As there is no explicit return statement, the last line of the expression evaluated will be returned. 

This method will return the string object `'ab'`, as the shovel operator permanently mutates the object it is applied to. This also means that the string object that `y` is referencing has been mutated from `'a'` to `'ab'` (it is __not__ referencing a different string object). 

On `line 8`, we pass the local variable `y` as an argument to the `puts` method call, which outputs `'ab'` and returns `nil` (`puts` always returns `nil`). 

*20) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​change_name​(name)
  name = ​'bob'​
end

name = ​'jim'
change_name(name)
puts name
```
On `line 5`, we initialise the local variable `name`, and assign it to a string object `'jim'`. We then pass this `name` local variable as an argument to the `change_name` method. 

On `line 1-3`, we define a method, `change_name`, which takes a `name` parameter. On `line 2`, a local variable `name` is initialised, and assigned a string object with the value `'bob'`. The `name` parameter is unused in this method. Since there is no explicit return, this method will return the last evaluated expression in the method. Therefore, the `change_name` method will always return `'bob'`, regardless of what object is passed in as an argument. 

On `line 7`, we pass the `name` local variable as an argument to the `puts` method call. This will output `'jim'` and return `nil` (`puts` always returns `nil`). There is no change to the `'jim'` string object that the local variable `name` is referencing, since there was no mutation within the `change_name` method. 

Also, method definitions have their own scope, and cannot directly access local variables initialised outside of the method definition scope (this is also why this particular code is __not__ an example of variable shadowing).  

*21) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​cap​(str) 
  str.capitalize!
end

name = ​"jim" 
cap(name) 
puts name
```
On `line 4`, we initialise a local variable `name`, and assign it to the string object `'jim'`. We then pass this local variable `name` as an argument to the `cap` method on `line 6`.

On `line 1-3`, we define a method, `cap`, which takes a single `str` parameter. On `line 2`, the `capitalize!` method is invoked on the object passed in as an argument to the `cap` method, which destructively capitalises the first character of the string object it's called on and returns the mutated object. As there is no explicit return statement in this method, the last evaluated expression will be returned, which will be the returned value of the `capitalize!` method call on `line 2`. This method call will return `'Jim'`. 

When we pass the local variable `name` as an argument to the `puts` method on `line 7`, this will output `'Jim'` and return `nil`. The string object that the local variable `name` was referencing was mutated as a result of calling the `capitalize!` method on the `'jim'` string object. 

*22) What is `arr`? Why? What concept does it demonstrate?*
```
a = [​1​, ​3​] 
b = [​2​]
arr = [a, b] 
arr

a[​1​] = ​5 
arr
```
On `line 1`, we initialise a local variable `a` and assign an array object to it `[​1​, ​3​] `. On `line 2`, we initialise the local variable `b`, and assign an array object to it `[​2​]`. 

On `line 3`, we initialise the local variable `arr`, and assign it to an array object, which references the array object `[1, 3]` that local variable `a` is pointing to as the first element, and `[2]`, the array object that local variable `b` is pointing to as the second element. On `line 4`, `arr` will return `[[1, 3], [2]]` since variables are pointers to objects. 

On `line 6`, we are reassigning the element at index `1` of the array object local variable `a` is referencing, to the integer object `5`. This is known as indexed assignment and while the object at `a[1]` is reassigned, indexed assignment has the effect of mutating the *original* array object referenced by the local variable `a`. As such, on `line 7`, `arr` will return `[[1, 5], [2]]`.

*23) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr1 = [​"a"​, ​"b"​, ​"c"​] 
arr2 = arr1.dup 

arr2.map! ​do​ |char|
  char.upcase
end

puts arr1
puts arr2
```
On `line 1`, we initialise a local variable `arr1`, and assign it to an array object `[​"a"​, ​"b"​, ​"c"​] `. On `line 2`, we initialise the local variable `arr2` and assign it to the return value of calling the `.dup` method on `arr1`. The `.dup` method returns a shallow copy of the array object `arr1`  is referencing, which is a new array object. 

On `line 4`, we call the `map!` method on the array object `arr2` is referencing (again, this is __not__ the same array object that `arr1` is referencing), passing in a block (denoted by the `do..end` reserved words immediately following the `map!` method call) as an argument. The `map!` method is a destructive method, returning the object it was called on, where the elements are determined by the return value of the block on each iteration. In this case (`line 5`), the `.upcase` method is called on each element in the array object referenced by `arr2`. This has the effect of reassigning the elements within the `[​"a"​, ​"b"​, ​"c"​]` object, mutating it. 

On `line 8`, we call the `puts` method, passing the local variable `arr1` as an argument. This will output `'a', 'b', 'c'` on separate lines (i.e. converting each element of the array into a string object) and return `nil` (`puts` always returns `nil`). 

On `line 9`, we call the `puts` method, passing the local variable `arr2` as an argument. This will output `'A', 'B', 'C'` on separate lines and return `nil`. This is due to the `map!` method being destructive, replacing each element of the original array referenced by `arr2` with the return value of the block. 

*24) What values do `s` and `t` have? Why?*
```
def​ ​fix​(value) 
  value.upcase! 
  value.concat(​'!'​) 
  value
end

s = ​'hello' 
t = fix(s)
```
On `line 7`, we initialise a local variable `s` and assign it to a string object `'hello'`. On `line 8`, we initialise a local variable `t` and assign it to the return value of calling the `fix` method, passing in `s` as an argument. 

On `line 1-5`, we define the `fix` method which takes a single parameter (`value`). On `line 2`, we initialise a local variable `value` and pass it the string object from the `value` method parameter, and call the `.upcase!` method. This is a destructive method, permanently modifying the string object (instead of referencing a different string object). On `line 3`, we call the `.concat` method, passing in `'!'` as an argument. This is also a destructive method, with the effect of appending the `'!'` to the original string object referenced by `value`. 

As there is no explicit `return` in this method definition, when this method is called, it will return the last evaluated expression, which is the `value` local variable on `line 4`, which is `'HELLO!'` in this example. 

After the `fix` method call, the local variable `s` is pointing to same string object as when the variable was initialised, however, it has been mutated to `'HELLO!'`, while the local variable `t` is also pointing to that same string object (since variables are pointers to objects), with a value of `'HELLO!'`, due to the destructive method calls within the `fix` method. 

*25) What values do `s` and `t` have? Why?*
```
def​ ​fix​(value)
  value = value.upcase 
  value.concat(​'!'​)
end

s = ​'hello' 
t = fix(s)
```
On `line 6`, we initialise a local variable `s`, and assign it to the string object `'hello'`. On `line 7`, we initialise a local variable `t`, and assign it to the return value of the `fix` method, where the local variable `s` is passed as an argument. 

On `lines 1-4`, we define the `fix` method which takes a single parameter `value`. On `line 2`, we initialise a local variable `value`, which is assigned to the return value of calling the `upcase` method on the object which is passed by reference by the `value` method parameter. As the `.upcase` method is not mutating, this has the effect of initialising the local variable `value` on a new string object, `'HELLO'` per the returned value of calling `upcase` on the `'hello'` string object. 

On `line 3`, we mutate this `value` object by calling the destructive `.concat` method on it, with the `'!'` string object passed as an argument. This has the ffect of appending a `'!'` character to the `'HELLO'` string object. As there is no explicit `return` in this method, the return value of this `.concat` method call is what the `fix` method call will return (with the local variable `s` as an argument). 

`s` will return `'hello'`, and `t` will return `'HELLO!'`. `s` is not mutated since on `line 2` , we initialised the local variable `value` to reference a __new__ string object, since `.upcase` is not a destructive method and returns a new string object. 

*26) What values do `s` and `t` have? Why?*
```
def​ ​fix​(value)
  value << ​'xyz'
  value = value.upcase 
  value.concat(​'!'​)
end

s = ​'hello'
t = fix(s)
```
On `line 7`, we initialise a local variable `s`, which is assigned to the string object `'hello'`. On `line 8`, we initialise a local variable `t`, which is assigned to the return value of the `fix` method with the local variable `s` passed to it as an argument. 

On `lines 1-5`, we define a method, `fix` which takes a single parameter (`value`). On `line 2`, the local variable `value` is initialised, and passed the string object by the method parameter `value` (`'hello'`). We use the shovel operator (`<<`) to destructively append the string object `'xyz'` to the original string object referenced by the local variable `value`. This has the effect of mutating the original string object from `'hello'` to `'helloxyz'`.

On `line 3`, we reassign the local variable `value` to the return value of calling the `.upcase` method on the string object referenced by `value`. Since the `.upcase` method is non destructive, this creates a __new__ string object (`'HELLOXYZ!'`), which `value` is now referencing. On `line 4`, we call the `.concat` method on the local variable `value`, passing in a string object `'!'` as an argument. This has the effect of mutating the string object referenced by `value` (`'HELLOXYZ'`) to `'HELLOXYZ!'`. As there is no explicit `return` in this method, and `line 4` is the last evaluated expression, this method will return `'HELLOXYZ!'`. 

As such, `s` will return `'helloxyz`, and `t` will return `'HELLOXYZ!'`. This is because the shovel operator mutated the string object referenced by `s` when it was passed as an argument to `fix`, but the `value` local variable was reassigned within the `fix` method to a new string object, since `.upcase` is not a mutating method. This means that the `upcase` and `concat` methods were called on a different string object that `s` was referencing. 

*27) What values do `s` and `t` have? Why?*
```
def​ ​fix​(value)
  value = value.upcase! 
  value.concat(​'!'​)
end

s = ​'hello' 
t = fix(s)
```
We initialise a local variable `s` on `line 7` to a string object `'hello'`. On `line 8`, we initialise a local variable `t` to the returned value of the `fix` method call with the local variable `s` passed as an argument. 

On `lines 1-4`, we define the `fix` method with a single parameter (`value`). On `line 2`, the local variable `value` is initialised and passed a string object from the `value` method parameter and the `.upcase!` method is called on this string object. As `.upcase!` is a destructive method, this has the effect of mutating the string object that was passed as an argument to the `fix` method. While `line 2` also also reassigns the local variable `value` to the return value of this `.upcase!` method call, since the `.upcase!` method call is destructive (i.e. a new string object is __not__ created), the reassignment is rebinding the same string object to the `value` local variable. 

On `line 3`, the `concat` method is called on the string object referenced by the local variable `value`, with the string object `'!'` passed in as an argument. The `concat` method is destructive, meaning that the string object is mutated and now has a value of `'hello!'`. As this is the last evaluated expression in the method, and there is no explicit `return`, `'hello!'` is what will be returned by the `fix` method call. 

After calling `fix(s)` on `line 7`, `s` will return `'HELLO!'`, and `t` will also return `'HELLO!'`, as they are referencing the same string object (variables are pointers to objects) since `lines 2-3` of the `fix` method did not create a new string object, but mutated the original string object. 

*28) What values do `s` and `t` have? Why?*
```
def​ ​fix​(value) 
  value[​1​] = ​'x' 
  value
end

s = ​'abc' 
t = fix(s)
```
On `line 6`, we initialise the local variable `s` with a string object `'abc'`. On `line 7`, we initialise the local variable `t` and assign it to the return value of the `fix` method, with the local variable `s` passed as an argument. 

On `line 1-4`, we define the `fix` method which takes one parameter (`value`). We initialise the local variable `value`, passing in the string object from the `value` method parameter on `line 2`, and make use of indexed assignment, reassigning the string object at index `1` of `'abc'` to the string object `x`. This will mutate the string object referenced by the local variable `x`, such that the string object referenced by `value` is now `axc`. As indexed assignment is mutating, we do not create a new object, but mutate the original object on which the indexed assignment occurred. 

Since there is no explicit `return` in this method, the last expression evaluated will be returned by the `fix` method, which is the string object referenced by the local variable `value`, per `line 3`. 

The return value of `fix(s)` is `'axc'`, which is assigned to the local variable `t`. As a result of calling `fix(s)`, the local variable `s` now returns `'axc'`, as does the local variable `t`, since they are now referencing the same string object (variables being pointers to objects) due to the mutating effects of the indexed assignment on `line 2`. 

*29) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
num = ​3
num = ​2​ * num
```
On `line 1`, we initialise the local variable `num`, and assign it to the integer object `3`. On `line 2`, we reassign the `num` local variable to the value returned by multiplying the value of the object referenced by `num` by `2`, using the `*` method. 

`num` will return the integer object `6`. It should be noted that integer objects are immutable - `line 2` was a variable reassignment. The `num` variable will reference different objects on `line 1` versus `line 2`. We can verify this by calling the `object_id` method on the `num` variable after the variable initialisation on `line 1`, which will return a different `object_id` to calling the `object_id` method on `num` after `line 2`. 

*30) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​%w(abc) 
a[​1​] = ​'-'
p a
```
On `line 1`, we initialise the local variable `a` and assign it to an array object `['abc']`. On `line 2`, we reassign the object at index `1` of the array object referenced by local variable `a` to the string object `'-'`. Since there is no object at index `1` of the array object referenced by `a`, this will create a `'-'` string object as an element at index `1`. Note that indexed assignment is mutating, such that the original array object is now `['abc', '-']`. 

Therefore, when we pass the local variable `a` as an argument to the `p` method call, this will output and return `['abc', '-']`.

*31) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​add_name​(arr, name) 
  arr = arr + [name]
end

names = [​'bob'​, ​'kim'​] 
add_name(names, ​'jim'​) 
puts names
```
On `line 5`, we initialise a local variable `names` to an array object `[​'bob'​, ​'kim'​]`. On `line 6`, we call the `add_name` method, passing in the `name` local variable and string object `'jim'` as arguments. 

`Lines 1-3` is where we define the method with two parameters `arr` and `name`. On `line 2`, we initialise the `arr` local variable to the return value of calling the `+` method on the array object passed from the `arr` method parameter. The `Array#+` method is non-destructive, meaning that the `Array#+` method returns a __new__ array object (`['bob', 'kim', 'jim']`) and assigns this to the `arr` local variable. 

As this is is the last evaluated expression of the `add_name` method, and there is no explicit `return`, this is `['bob', 'kim', 'jim']` object is what will be returned by the method call on `line 6`.

On `line 7`, we call the `puts` method, passing in the local variable `name` as an argument. This will print `'bob', 'kim'` on new lines, and return `nil` (`puts` always returns `nil`). The array object referenced by `names` is not mutated, since `line 2` is variable reassignment, and no mutating methods are called. 

*32) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​add_name​(arr, name) 
  arr = arr << name
end

names = [​'bob'​, ​'kim'​] 
add_name(names, ​'jim'​) 
puts names
```
On `line 4`, we initialise a local variable `names`, and assign an array object `[​'bob'​, ​'kim'​]` to it. On `line 5`, we call the `add_name` method, passing in the `names` local variable and string object `'jim'` as arguments. 

`Lines 1-3` is where we define the `add_name` methods with two parameters. On `line 2`, we initialise the local variables `arr` and `name` and assign them to the array object and string object respectively from the method parameters. 

We reassign the `arr` variable to the return value of using the shovel operator to destructively append the string object referenced by `name` to the array object referenced by `arr`. Since the shovel operator mutates the original array object, the variable reassignment rebinds the `arr` variable to the same (now mutated) array object. 

As `line 2` is the last expression evaluated in this method, and there is no explicit `return`, the array object `['bob', 'kim', 'jim']` is what will be returned from the method call on `line 5`. 

Finally, we call the `puts` method on `line 7`, passing in the `names` local variable as an argument. This will output `'bob', 'kim', 'jim'` on separate lines, and return `nil` (since `puts` always returns `nil`). The array object referenced by `names` was mutated by the shovel operator on `line 2`, and hence a new array object was __not__ created. 

*33) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
array = [​1​, ​2​, ​3​, ​4​, ​5​]

array.select ​do​ |num| 
  puts num ​if​ num.odd?
end
```
On `line 1`, we initialise a local variable `array` and assign it to an array object, containing five integer object elements. 

On `line 3`, we call the `select` method on the local variable `array` passing in a block (as denoted by the `do..end` reserved words immediately following the `select` method invocation). This block takes a single parameter, `num`. 

The `select` method iterates through the elements of the array object it's called on, and returns a new array object based on the truthiness of the returned value of the block. 

In this example on `line 2`, we call the `.odd?` method on each array element passed to the block. Based on whether the element is evaluated as true in the `if` conditional (i.e. whether the value of the integer object passed to the block through the block parameter `num` is odd), the element will be passed as an argument to the `puts` method call, which will output that element as a string and return `nil`. 

Within the block, the `puts` method call will output `1`, `3`, `5` as an array, each on a new line. Since the `select` method return a new array based on truthiness, a new empty array will be returned, as when the block evaluates to false, it is not passed to the `puts` method as an argument, and when block evaluates to true, `puts` always returns `nil` (which is __not__ truthy). 

*34) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​] 
arr.select { |n| n.odd? }
```
On `line 1`, the local variable `arr` is initialised and assigned to an array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`.
On `line 2`, we call the `select` method on the array object referenced by `arr`, with a block (as denoted by `{}` immediately following the `select` method call). This block is passed as an argument to the `select` method. The `select` method iterates through each element of the array object and returns a new array object that is populated based on the truthiness of the return value of the block. 

On each iteration, each element of the array object is passed to the block parameter `n`. The `.odd?` method is then called on value of the block parameter `n`, which evaluates whether the element passed to it is odd (returns `true` if odd). In this example, this will return a new array object `[1, 3, 5, 7, 9]`, since those are the integer elements for which the block will evaluate as `true`. 

*35) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]

new_array = arr.select ​do​ |n| 
  n + ​1
end

p new_array
```
On `line 1`, we initialise a local variable `arr` and assign it to the array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`. On `line 3`, we initialise a local variable `new_array`, which we assign to the return value of the `select` method call on the array object referenced by the `arr` local variable. 

The `select` method is called on the array object referenced by the local variable `arr`, with a block passed as an argument (the block is denoted by the `do..end` reserved words immediately following the `select` method call). The block takes a single parameter `n`. In this case, each element in the array object is passed to the block through the block parameter `n`, upon which the `Integer#+` method is called. 

The `select` method only evaluates the truthiness of the return value of the block (the actual value returned is ignored). Everything in Ruby is evaluated as truthy except for `false` and `nil`. Since there is no explicit `return` within the block, the last evaluated expression will be returned. 

Therefore, each element will be evaluated by the block as true, since all integers are truthy. The `select` method returns a new array of elements where those elements are truthy. Therefore, when we pass the local variable `new_array` as an argument to the `p` method call, this will output and return `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`.

*36) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]

new_array = arr.select ​do​ |n| 
  n + ​1
  puts n
end

p new_array
```
On `line 1`, we initialise a local variable `arr` and assign it to the array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`. 
On `line 3`, we initialise a local variable `new_array` and assign it to the return value of calling the `select` method with a block (as denoted by the `do...end` reserved words immediately following the `select` method call) passed as an argument, on the array object referenced by `arr`. 

The `select` method will return a new array with elements returned by the block that are truthy. In Ruby, everything except for `false` and `nil` are evaluated as truthy. In our case, each element of the array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]` is passed to the block parameter `n`.

The expression on `line 4` is executed, but ultimately ignored in the evaluation of the element's truthiness (the return value is not assigned to a variable at any stage or evaluated any further). 

On `line 5`, the value of the block parameter `n` is passed to the `puts` method as an argument, which outputs the element, and returns `nil`. Since there is no explicit `return` in the block, Ruby will return the value of the last evaluated expression in the block. In this case, that return value is `nil`. All of the elements that are passed into the block will be evaluated as `nil` due to the `puts` statement being the last evaluated expression in the block (the `puts` method call always returns `nil`). 

Since none of the values returned by the block are truthy, the `select` method will return an empty array and this is assigned to the local variable `new_array`. When we pass the local variable `new_array` as an argument to the `p` method call on `line 8`, this will both output and return an empty array. 

*37) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
words = ​%w(jump trip laugh run talk)

new_array = words.map ​do​ |word| 
  word.start_with?(​"t"​)
end

p new_array
```
On `line 1`, we initialise a local variable `words` and assign it to an array object, `['jump', 'trip', 'laugh', 'run', 'talk']`. The `w%` method converts any arguments passed to it into a string object, place it in an array, and return the array object. 

On `line 3`, we initialise a local variable `new_array`, and assign it to the return value of the `map` method call on the array object referenced by the `words` local variable. The `map` method takes a block (denoted by the `do...end` reserved words immediately following the `map` method call). 

The `map` method will iterate through each element of the array object and return a new array, populated with the return values of the block. In this case, as each element within the array object (referenced by the `words` local variable) is passed to the block parameter `words`, the `start_with?("t")` method is called on the value of the object passed by the block parameter `words`. 

This method returns a boolean based on whether the first character of the string object the method is called on, matches the character passed to the method as an argument. 

In our case, this will return a new array `[false, true, false, false, true]`, since these are the return values as evaluated by the expression in the block. As such, the local variable `new_array` is assigned to the returned `[false, true, false, false, true]` array object. 

When we pass the `new_array` variable as an argument to the `p` method call on `line 7`, this will output and return `[false, true, false, false, true]`.

*38) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​] 
arr.each { |n| puts n }
```
On `line 1`, the local variable `arr` is initialised and assigned to an array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`. On `line 2`, the `each` method is called on the array object referenced by the local variable `arr`. The `each` method is passed a block (as denoted by the `{}` immediately following the `each` method call) as an argument, which takes a parameter `n`. 

The `each` method returns the original object it was called on (here, the `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]` array object referenced by `arr`), ignoring the return value of the block. 

The `each` method iterates through each element of the array object, passing each element to the method parameter `n`. The object referenced by the block parameter `n` is then passed to the `puts` method call as an argument, which outputs each element of the array object, converted to a string object on a separate line, and returns `nil` (since there is no explicit `return`, the method will return the last evaluated expression in the method, which is the `puts` method call, which always returns `nil`).

*39) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]

incremented = arr.map ​do​ |n| 
  n + ​1
​end 

p incremented
```
On `line 1`, we initialise a local variable `arr` and assign it to the array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`. On `line 3`, we initialise a local variable `incremented`, and assign it to the return value of calling the `map` method on the array object referenced by `arr`. 

The `map` method has a block passed to it as an argument (as denoted by the `do...end` reserved words immediately following the `map` method call), and iterates through each element of the array object, passing it to the block parameter `n`. 

The `map` method returns a new array, based on the return value of the block. In this case, each integer element of the array object (the value of the block parameter `n` on each iteration) has the `Integer#+` method applied to it, so that each element has `1` added to it (`1` is the object passed as an argument to the `Integer#+` method). 

As there is no explicit `return` in the block, the last evaluated expression is returned - the value of `n + 1` in this case. As such, the `map` method will return a new array object (since the `map` method is non-destructive) of `[​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​, 11]`, and this is what is assigned to the local variable `incremented`.

On `line 7`, we call the `p` method and pass the local variable `incremented` as an argument. This will output and return `[​​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​, 11]`.

*40) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]

new_array = arr.map ​do​ |n| 
  n > ​1
end

p new_array
```
On `line 1`, we initialise the local variable `arr` and assign it to an array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`. This will return `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]`. On `line 3`, we initialise the local variable `new_array` and assign it to the return value of calling the `map` method on the array object referenced by the local variable `arr`. 

When we call the `map` method on the array object referenced by the local variable `arr`, we pass in a block (denoted by the `do...end` reserved words immediately following the `map` method call). The block takes a single parameter, `n`. The `map` method iterates through each element within the array object, and passes it to the block. The .`map` method returns a new array object, based on the return value of the block on each iteration. 

On `line 4`, we initialise the local variable `n`, which is passed each element of the array object from the block parameter `n`, and apply the integer method `Integer#>` to that element, with the integer object `1` passed as an argument. This returns a boolean if the value of that array element is greater than `1`. As this is the last evaluated expression in our block (there is no explicit `return`), the block will return this boolean on each iteration. 

After all the elements are iterated through, the `map` method will return a new array object `[false, true, true, true, true, true, true, true, true, true]`. This is what is assigned to the local variable `new_array`.

On `line 7`, we call the `p` method and pass the local variable `new_array` as an argument, which will output and return `[false, true, true, true, true, true, true, true, true, true]`.

*41) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr = [​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]

new_array = arr.map ​do​ |n| 
  n > ​1
  puts n
end

p new_array
```
On `line 1`, we initialise the local variable `arr` and assign the array object `[​1​, ​2​, ​3​, ​4​, ​5​, ​6​, ​7​, ​8​, ​9​, ​10​]` to it. 

On `line 3`, we initialise the local variable `new_array` and assign the return value of calling the `map` method on the array object referenced by `arr`. As part of the `map` method call, we pass in a block (denoted by the `do...end` reserved words immediately following the `map` method call). The block takes a single parameter, `n`. 

The `map` method iterates through each element of the array object it is called on and returns a new array, whose contents are the return value of the block passed to it. 

On `line 4`, we initialise a local variable `n`, and pass it an array element from the block parameter `n`. We call the `Integer#>` method on that array element, passing it an argument of `1`. This will evaluate whether the value of the array element is greater than `1`, and return a boolean on whether this condition is true or not. On `line 5`, we call the `puts` method and pass the local variable `n` to it (referencing value of the array element), which will output the array element, and return `nil` (the `puts` method always returns `nil`). 

After each element of the array has been iterated through by the .`map` method, it returns a new array object `[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]`. This is because there is no explicit `return` within the block, and so the last evaluated expression is returned - this is the `puts` method call, which always returns `nil`. The local variable `new_array` is assigned this `[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]` array object. 

We then call the `p` method on `line 8`, passing the local variable `new_array` as an argument. This outputs and returns `[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]`.

*42) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​"hello"
[​1​, ​2​, ​3​].map { |num| a }
```
On `line 1`, we initialise the local variable `a` and assign it to the string object `'hello'`. On `line 2`, we call the `map` method on the array object `[1, 2, 3]`. We pass a block to the `map` method (denoted by `{}` immediately following the `map` method call). The block takes a single parameter, `num`. 

The `map` method iterates through each element of the array object on which it's called, passing each element to the block parameter `num`. In our example, the array element passed to the block parameter `n` is not used. Instead, we return the local variable `a`, as the inner block scope is able to access local variables initialised outside of the block. On each iteration, as there's no explicit `return` in the block, the block will implicitly return the last evaluated expression in the block, which is the `a` local variable. 

The `map` method returns a new array object, containing the returned value of the block for each element of the array. In our case, this is a new array object `['hello', 'hello', 'hello']`. 

*43) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[​1​, ​2​, ​3​].any? ​do​ |num| 
  num > ​2
end
```
On `line 1`, we call the `.any?` method on the array object `[1, 2, 3]`. We pass a block to the `any?` method call (denoted by the `do...end` reserved words immediately following the `.any?` method call), which takes a single parameter `num`. The `.any?` method iterates through each of the elements in the array object passed, passing each element to the block parameter `num`. 

On `line 2`, we initialise a local variable `num` and pass it an array element from the block parameter `num`. We then call the `Integer#>` method on that array element, passing in the integer `2` as an argument. This evaluates whether the value of the array element is greater than `2` and returns a boolean. Only the third  array element passed to the local variable `num` will evaluate to `true`. As there is no explicit `return` in our block, the implicit return value of the block will be the boolean returned by the `Integer#>` method.

The `.any?` method will return `true` if any of returned values of the block return `true`, which does occur in our example. 

*44) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }.any? ​do​ |key, value| 
  value.size > ​4
end
```
On `line 1`, we call the `.any?` method on the hash object `{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }`, passing in a block to the `.any?` method as an argument (the block is denoted by the `do...end` reserved words immediately following the `.any?` method call). The block takes two parameters, `key` and `value`.

The `.any?` method passes each key and value pair of the hash object to the block parameters `key` and `value` respectively to be evaluated on `line 2`. On `line 2`, we initialise a local variable `value` and pass the value of key-value pair from the block parameter `value` and call the `.size` method on it. This will return an integer object representing the character length of the string object passed to it. 

We then call the `Integer#>` method on the returned integer object value from the `.size` method call, passing in `4` as an argument. This evaluates whether the value of the integer object is greater than `4` and return a boolean based on whether this condition is true. As there is no explicit return in our block, this boolean will be returned by the block (since it is the last evaluated expression in the block).

The code will return `false`, since none of the string object values in the hash have more than `4` characters (`line 2` will never return `true`). 

*45) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[​1​, ​2​, ​3​].all? ​do​ |num| 
  num > ​2
end
```
On `line 1`, we call the `.all?` method on the array object `[1, 2, 3]`, passing in a block (denoted by the `do...end` reserved words immediately following the `.all?` method call). The block takes a single parameter, `num`. 

The `.all?` method iterates through each element of the array object, passing it to the block parameter `num`. On `line 2`, the local variable `num` is initialised and assigned to the array element passed by the block parameter `num`. We then call the `Integer#>` method on this value, passing in an integer object `2` as an argument. This will return a boolean based on whether the value of the array element is greater than `2`. As there is no explicit return in our block, the boolean returned by the `Integer#>` method call is what will be implicitly returned by the block. 

The `.all?` method will return `true` if all of the return values of the block evaluate to `true`. Not all array elements are greater than `2`, so the `.all?` method call will return `false`.

*46) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }.all? ​do​ |key, value| 
  value.length >= ​3
end
```
On `line 1`, we call the `.all?` method on the hash object `{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }`, passing in a block (denoted by the `do...end` reserved words immediatley following the `.all?` method call). The block takes two parameters, `key` and `value`. 

The `.all?` method interates through each key and value pair of the hash object, and passes them to the `key` and `value` block parameters respectively. On `line 2`, we initialise a local variable `value` and assign it to the string object passed by the `value` parameter (representing the value of the key-value pairs in the hash object). 

We then call the `.length` method on the string object, which returns an integer object representing how many characters are in that string object. We then call the `Integer#>=` method on the returned integer object, passing in the integer object `3` as an argument. This will return a boolean, depending on whether the length of the hash object value is greater than `3`. As there is no explicit `return` in our block, this boolean will be implicitly returned by the block (as it is the last evaluated expression in our block). 

The `.all?` method will return `true` only if all of the returned values of the block evaluate to `true`. In our case, the `.all?` method call will return `true`, since all of the lengths of the hash object values are greater than or equal to `3`. 

*47) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[​1​, ​2​, ​3​].each_with_index ​do​ |num, index| 
  puts ​"The index of ​#{num}​ is ​#{index}​."
end
```
On `line 1`, we call the `each_with_index` method on the array object `[1, 2, 3]`, passing in a block (denoted by the `do...end` reserved words immediately following the `each_with_index` method call). The block takes two parameters, `num` and `index`.

The `each_with_index` method interates through each element in the array object, passing the element to the `num` block parameter, and the index of that element to the `index` block parameter. 

On `line 2`, we call the `puts` method, passing in a string object as an argument. The string object in question uses string interpolation, allowing us to initialise local variables `num` and `index` and assign them to objects from the block parameter. This will output several string objects on new lines. 
`​"The index of 1​ is ​0."`
`​"The index of 2 is ​1."`
`​"The index of ​3 is 2."`
The `puts` method returns `nil` on each iteration. However, the `each_with_index` method does not do anything with the returned value of the block and returns the original array object on which it was called. 

*48) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }.each_with_object([]) ​do​ |pair, array| 
  array << pair.last
end
```
On `line 1`, we call the `each_with_object` method on the hash object `{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }`, passing in a block (denoted by the `do...end` reserved words immediately following the `each_with_object` method call). We also pass an empty array object as an argument to the `each_with_object` method.

The `each_with_object` method iterates through each key-value pair in our hash object, passing them to the block parameter `pair`. On `line 2`, we initialise a local variable `array`, passing it the empty array object from the `array` block parameter. We initialise the local variable `pair`, assigning it an array containing a key and value from the `pair` block parameter. 

We then call the `.last` method on this array object, returning the last item in the array (which is the value of the key value pair). We use the shovel operator (`<<`) to destructively append this item to the array object referenced by the `array` variable. This will return the item that was destructively added to the array object. As there is no explicit `return` in the block, this item will be implicitly returned by the block, as it is the last evaluated expression in our block. 

In our case, the `each_with_object` method returns a new array object populated by the returned values of the block `['ant', 'bear', 'cat']`. 

*49) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }.each_with_object({}) ​do​ |(key, value), hash|
  hash[value] = key
end
```
On `line 1`, we call the `each_with_object` method on the hash object `{ ​a:​ ​"ant"​, ​b:​ ​"bear"​, ​c:​ ​"cat"​ }`. We also pass in an empty hash object as an argument, as well as a block to the `each_with_object` method (denoted by the `do...end` reserved words immediately following the `each_with_object` method call). The block takes two parameters, `(key, value)` and `hash`. The `(key, value)` is technically a single parameter, but will take an array containing two values. 

The `each_with_object` iterates through each key-value pair in our hash object, and will pass these keys and values to the `(key, value)` parameter. We will use multiple assignment to assign these different values to different local block variables. 

On `line 2`, we initialise a local block variable, `hash` and pass in the empty hash object from the block parameter `hash`. We also initialise two local block variables, `key` and `value` and assign them the key and value objects from the block parameter `(key, value)`, using multiple assignment. 

We then populate the empty hash object with a new key value pair on each iteration, where the keys of the empty hash are the string object values from the calling hash object, and the values are the symbol objects. This is a destructive operation, which mutates our initial empty hash object.

In our example, the `each_with_object` returns the initial hash object, which is now mutated to `{"ant"=>:a, "bear"=>:b, "cat"=>:c}`. 

*50) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
odd, even = [​1​, ​2​, ​3​].partition ​do​ |num| 
  num.odd?
end

p odd
p even
```
On `line 1`, we initialise two local variables, `odd` and `even`, and assign them to the return values of the `.partition` method call on the array object `[1, 2, 3]` using multiple assignment. We pass a block to the `partition` method (denoted by the `do...end` reserved words immediately following the `partition` method call). The block takes a single parameter `num`. 

The `partition` method iterates through each element of the array object, passing it to the block. It will assign each element to two different variables depending on whether the block evaluates true or not for that array element. If the block evaluates to true, it will assign that element to the first variable. If the block evalutes to false, it will assign that element to the second variable. 

On `line 2`, we initialise a local block variable `num`, assigning it to the array object element from the block parameter `num`. We then call the `odd?` method on this array object element, which returns a boolean based on whether the value of this array object element is odd or not. 

In our case, the `partition` method call will return an array, with two subarrays based on whether the elements are evaluated as true or false from the block - `[[1, 3], [2]]`. The first array element will be assigned to the local variable `odd`, and the second array element is assigned to the local variable `even`. 

On `line 5`, we call the `p` method, passing in the local variable `odd` as an argument. This will output and return `[1, 3]`. On `line 6`, we call the `p` method, passing in the local variable `even` as an argument. This will output and return `[2]`.

*51) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​"Hello"
if​ a
  puts ​"Hello is truthy"
else
  puts ​"Hello is falsey" 
end
```

*52) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​test
  puts ​"written assessment"
end

var = test

if​ var
  puts ​"written assessment"
else
  puts ​"interview" 
end
```

*53) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[1, 2, 3].select do |num|
  num > 5
  'hi'
end
```

*54) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end
```

*55) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[1, 2, 3].reject do |num|
  puts num
end
```

*56) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end
```

*57) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
hash = { a: 'ant', b: 'bear' }
hash.shift
```

*58) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
['ant', 'bear', 'caterpillar'].pop.size
```

*59) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end
```

*60) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end
```

*61) What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end
```