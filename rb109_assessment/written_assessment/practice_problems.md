*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​‘Hello’ 
b = a
a = '​Goodbye​'
```
On `line 1`, the local variable `a` is initialised and assigned to the string object `'Hello'`. On `line 2`, the `b` variable is initialised, and assigned to the same string object that the local variable `a` is pointing towards (`'Hello'`). On `line 3`, the local variable `a` is reassigned to the string object `'Goodbye'`. 

When executed, `a` will return the string object `'Goodbye'`, while `b` will return the string object `'Hello'`.  This is because variables are pointers to objects, and are not themselves, values. On `line 2`, the local variable `b` is referencing the string object `'Goodbye'`, not the local variable `a`. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
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
`line 8` will output the integer `5` and return `nil`, while `line 9` will return a `NameError`. 

The local variable `a` is initialised on `line 1` and assigned to the integer object `4`. A `loop` method is invoked on `line 2` with a block (denoted by the `do..end` reserved words immediately after a method call). Variables within a block scope are able to access local variables initialised outside of the block scope - this is why the local variable `a` is reassigned to the integer object `5` within the block on `line 3`. 

Variables initialised within a block scope cannot be accessed outside of the block scope. On `line 4`, the variable `b` is initialised in the block scope, but not accessible outside of the block. This is why `line 9` will return a `NameError`. 

After each of the `a` and `b` variables are assigned a reference to an integer object, the `break` keyword exits the loop. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
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
On `line 1`, the local variable `a` is initialised and assigned to the integer object `4`. On `line 2`, the local variable `b` is initialised and assigned to the integer object `2`. On `line 4`, the `loop` method is invoked with a block (denoted by the `do..end` reserved words immediately after a method call) passed in as an argument.  

Within the block scope, the local variable `c` is initialised and assigned to the integer object `3` on `line 5`. On `line 6`, the local variable `a`, which is initialised outside of the block, but accessible from within the block scope, is reassigned to the same integer object `3` that the block variable `c` points to, since variables are pointers to objects. On `line 7`, the `break` keyword exits the `loop` method. 

The local variable `a` (which is a reference to the integer object `3`) is passed as an argument to the `puts` method on `line 10`, which will output the integer object `3` and return `nil`, while `puts` method call on `line 11` will output the integer object `2` (as referenced by the local variable `b`) and return `nil`, since the local variable `b` was not reassigned to a different object within the loop. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
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

On `line 2`, within the method definition, we initialise a local variable `i` and assign it to the integer object `3`. On `line 3`, a `loop` method is invoked with a block (denoted by the `do..end` reserved words immediately after a method call) passed in as an argument. 

On `line 4`, we call the `puts` method, passing in the local variable `str` (which is a reference to the `'hello'` string object) as an argument. This `puts` call outputs the argument passed to the `example` method (`'hello'`), and returns `nil`. On `line 5`, the variable `i` is reassigned to the return value of a method call `Integer#-` on a local variable `i` with integer `1` passed to it as an argument.

The `i -= 1` line makes use of syntactical sugar (equivalent to `i = i - 1`), while the `-` method is also syntactical sugar for `.-()`. `line 6` checks to see if the object referenced by the variable `i` is equal to `0`. If this conditional evaluates to `true`, the `break` keyword will exit the loop. 

The code on `line 10` will print `'Hello'` three times, and return `nil`. The reason `nil` is returned is that Ruby has an implicit return on the last line of code within a method. This is the `break if i == 0` expression, which returns `nil`. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​greetings​(str) 
  puts str
  puts ​"Goodbye"
end

word = ​"Hello" 
greetings(word)
```
On `lines 1-4`, we define the `greetings` method, with a `str` parameter. On `line 6`, we assign the string object with a value of `'Hello'` to the local variable `word`. On `line 7`, we call the `greetings` method, passing in the `word` local variable (which references the string object `'Hello'`) as an argument. 

On `line 2`, when the `greetings` method is invoked, the `str` local variable is initialised when an argument is passed to the `str` parameter. In our case, this is the string object `'Hello'`. We then call the `puts` method, passing in the `str` local variable as an argument. This outputs `'Hello'` and returns `nil`. On `line 3`, the string object `'Goodbye'` is passed as an argument to the `puts` method, which outputs `'Goodbye'` and returns `nil`. 

The end result of calling the `greetings` method with the string object `'Hello'` as an argument on `line 7` is that both `'Hello'` and `'Goodbye'` are outputted, and `nil` is returned. `nil` is returned because without an explicit `return` reserved word, the last line of the expression evaluated in a method will be returned. In this case, `puts` returns `nil`. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
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

On `line 6`, we call the `loop` method with a block (denoted by the `do..end` reserved words immediately following the method call) passed in as an argument. 
On `line 7`, the local variable `sum` is reassigned to the value of the array element referenced by the `arr`, where the array index is set to the integer object referenced by the `counter` local variable. The inner scope of the block is able to access the `arr`, `counter` and `sum` local variables, even though they are initialised outside of the block scope. 

Also note in our case, the `+=` code is syntactical sugar for `sum = sum + arr[counter]`. The `+` method is also making use of syntactical sugar, since this is a method call, such that without using syntactical sugar, we could rewrite `line 7` as `sum = sum.+(arr[counter])`.

On `line 8`, we reassign the local variable `counter` to the value of the integer object `counter` is referencing plus `1`. On `line 9` We break from the loop, if the value of the object `counter` is referencing is equal to the return value of the `size` method called on the object the local variable `arr` is referencing. 

Finally, on `line 10`, we pass the `sum` variable (which references the integer object `10`) as an argument to the string object `"Your total is #{sum}"` via string interpolation. This string object is then passed to the `puts` method, which will output `"Your total is 10"` and return `nil`, since `puts` always returns `nil`. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
a = ​'Bob'
5​.times ​do​ |x| 
  a = ​'Bill'
end

p a
```
On `line 1`, we initialize a local variable `a` and assign it to the string object `'Bob'`. On `line 2`, we invoke the `times` method on the object integer `5`, and pass a block to the `times` method (denoted by the `do..end` reserved words immediately after the method invocation). The block takes a single parameter, `x`. 

On `line 3`, the local variable `a` initialised in the outer scope is reassigned to the string object `'Bill'`. This occurs `5` times, on account of the `times` method executing the block 5 times. After the 5th iteration, the `times` methods returns the object it was called on - in this case, the integer object `5`. 

On `line 6`, we pass the local variable `a` as an argument to the `p` method. This will output and return the string object `'Bill'`. This is because local variables initialised outside of a block are accessible within the block, allowing the reassignment of local variable `a` within the block. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
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
On `line 1`, we initialise a local variable `animal` and assign it to the string object `'dog'`. On `line 2`, we call the `loop` method, passing in a block as an argument (the block is denoted by the `do...end` reserved words immediately following the method call). 

On `line 3`, the local variable `animal` initialised outside of the block is reassigned to the string object `'cat'`. This is possible because the block scope can access variables initialised outside of it. On `line 4`, a local variable `var` is initialised within the block, and assigned to the string object `'ball'`. 

On `line 5`, we break out of the loop using the `break` reserved word. 

On `line 8`, we pass the local variable `animal` as an argument to the `puts` method, which outputs `'dog'` and returns `nil`. On `line 9`, as we attempt to pass the `var` variable as an argument to the `puts` method, we will get a `NameError`, as variables initialised within a block scope cannot be accessed outside of that block. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
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

On `line 4`, we call the `times` method on the integer object `2`, passing in a block as an argument (denoted by the `do...end` reserved words immediately following the method invocation). On `line 5`, the local variable `a` passed by the block parameter `a` is assigned to the integer object `5`. The local variable `a` referencing the integer `4` cannot be accessed by the block, as variable shadowing occurs. 

Variable shadowing prevents an inner scope from accessing variables initialised outside of it when the block parameter is given the same name as the local variable that is being passed to it as an argument. On `line 5`, passing the local variable `a` initialised in the block scope to the `puts` method will output `5` and return `nil`. `Lines 5-6` will be executed twice, since the integer object `2` on which `times` was called on determines how many times the block will be executed. 

Once the second execution finishes, the `times` method will return the object it was called on (the integer object `2`). 

On `line 9`, we pass in the local variable `a` to the `puts` method, which will output the string object `'5'` and return `nil`, due to variable shadowing interfering with the attempted variable reassignment in the block. 

On `line 10`, we pass in the local variable `b` to the `puts` method, which will output a string object `'2'` and return `nil` (since `puts` always returns `nil`). 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
n = ​10 

1​.times ​do​ |n|
  n = ​11
end

puts n
```
On `line 1`, we initialise a local variable `n` and assign it to the integer object `10`. On `line 2`, we call the `times` method on the integer object `1`, and pass in a block as an argument to the `times` method. The `do...end` reserved words immediately following the `times` method invocation indicate that this is a block. 

On `line 4`, a local variable `n` is passed by the block parameter `n` assigned to the integer object `11`. The local variable `n` in the outer scope is __not__ reassigned, as variable shadowing occurs. Variable shadowing stops the inner scope of the block accessing local variables initialised outside of the block scope when the block parameter has the same name as the local variable outside of the inner scope. 

The `times` method executes once, since the number of times the method will execute the block depends on the integer object on which it is called. After `line 4` is executed, the `times` method will return `1`, the integer object on which it was called. 

Finally, on `line 7`, we pass the local variable `n` as an argument to the `puts` method, which will output the string object `'10'` (no reassignment occurs in the block scope due to variable shadowing) and return `nil` (the `puts` method always returns `nil`). 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
animal = ​"dog"

loop ​do​ |animal| 
  animal = ​"cat" 
  ​break
end

puts animal
```
On `line 1`, we initialise a local variable `animal` and assign a string object, `'dog'` to it. On `line 3`, we call the `loop` method and pass a block that takes a parameter as an argument. On `line 4`, the local variable `animal` is passed by the block parameter `animal` and assigned to the string object `'cat'`. The local variable `animal` initialised outside of the block is __not__ reassigned due to variable shadowing. 

Variable shadowing stops the inner scope from accessing local variables initialised outside of the block when the block parameter has the same name as the local variable initialised outside of the block. On `line 5`, the `break` reserved word exits the loop. Once the loop is finished executing, it returns `nil`, since there is no explicit `return` in this loop, the last line of the expression is returned. In this case, it's the `break` reserved word, which returns `nil`. 

On `line 8`, we pass the local variable `animal` (which still references the string object `'dog'`) to the `puts` method, which will output the string object `'dog'` and return `nil` (since `puts` always returns `nil`). 

*What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a` and `b`?*
```
a = ​"hi there"
b = a
a = ​"not here"
```
On `line 1`, we initialise a local variable `a` and assign a string object `'hi there'` to it. This will also return the string object `'hi there'`. On `line 2`, we initialise a local variable `b`, and assign it to the same object that the local variable `a` is referencing (the string object `'hi there'`). This will also return `'hi there'`. 

On `line 3`, we reassign the local variable `a` to reference a different string object (`'not here'`). The local variable `b` will return `'hi there'`, as variables are references to objects, and not references to variables. 

*What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a` and `b`?*
```
a = ​"hi there" 
b = a
a << ​", Bob"
```
On `line 1`, we initialise a local variable `a`, and assign the string object `'hi there'` to it. On `line 2`, we initialise the local variable `b`, and since variables are pointers to objects, we assign the same string object that the local variable `a` was pointing to to `b` (`'hi there'`). 

On `line 3`, we use the shovel operator to append the string object `', Bob'` to the string object that local variable `a` was pointing to (`'hi there'`). The shovel operator is destructive, and so local variable `a` will return `'hi there, Bob'`. Local variable `b` will also return `'hi there, Bob'`, since the shovel operator is a destructive method, and does not result in reassignment of the local variable `a` to a different object. 

*What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a`,`b` and `c`? What happens if the last line was `c = a.uniq!`?*
```
a = [​1​, ​2​, ​3​, ​3​]
b = a
c = a.uniq
```
On `line 1`, we initialise the local variable `a`, and assign an array object to it, containing 4 elements. On `line 2`, we initialise the local variable `b` and since variables are references to objects, `b` is assigned to the same array object that the local variable `a` is pointing towards. 

On `line 3`, the local variable `c` is initialised, and assigned to the return value of calling the `uniq` method on `a`, which will be `[1, 2, 3]`. Therefore, the local variables `a` and `b` will return `[1, 2, 3, 3]`, while `c` will return `[1, 2, 3]`, as the `uniq` method is non-destructive, and the object returned by `a.uniq` is different to the object `a` is referencing. 

If the last line was `c = a.uniq!`, then local variables `a`, `b` and `c` would all return `[1, 2, 3]`. This is because `uniq!` is a destructive method, altering the object, rather than creating a new object. This means that `a`, `b` and `c` are all pointing towards the same object. 

*What does the following code return? What does it output? Why? What concept does it demonstrate? What is `a`? What if we called `map!` instead of `map`?*
```
def​ ​test​(b)
  b.map! { |letter| ​"I like the letter: ​#{letter}​"​ }
end

a = [​'a'​, ​'b'​, ​'c'​] 
test(a)
```
On `lines 1-3`, we are defining the `test` method, with a single parameter (`b`). On `line 5`, we initialise the local variable `a` and assign it to an array object, containing three string object elements. On `line 6`, we pass in the local variable `a` (which serves as a reference to an array object) as an argument to the `test method`. 

On `line 2`, the `map` method is called on the array object referenced by the local variable `a`, which has been passed through the method parameter `b`. The `map` method is invoked with a block (signified by the `{}` immediately following the method invocation). The `map` method will return a new array object whose contents depend on the return value of the block. 

As there is no explicit `return` in this method definition, Ruby will return the last expression evaluated. In this case, the `map` method is the last expression, which will return `['I like the letter: a', 'I like the letter: b', 'I like the letter: c']`. This is the returned object from the `test(a)` method call on `line 6`. The local variable `a` is still the array object `['a', 'b', 'c']`, as the `map` method returns a new object. 

If we had used the `map!` instead of `map`, `test(a)` and `a` would both return `['I like the letter: a', 'I like the letter: b', 'I like the letter: c']`. This is because `map!` is a mutating method. Instead of creating a new array object with the returned values of the block like the `map` method would, it will reassign the values within the original `['a', 'b', 'c']` array to the values returned by the block. 

*What does the following code return? What does it output? Why? What concept does it demonstrate? What are `a` and `b`? Why?*
```
a = ​5.2 
b = ​7.3

a = b

b += ​1.1
```
On `line 1`, we initialise local variable `a` and assign it to the float object `5.2`. On `line 2`, we initialise the local variable `b` and assign it to the float object `7.3`. On `line 4`, we reassign the local variable `a` to reference the same float object that local variable `b` is pointing to, `7.3`. 

On `line 6`, we reassign the local variable `b` to the value of `b` plus `1`. This is an example of Ruby syntactic sugar, where `b += 1.1` is equivalent to `b = b + 1.1`, and `b + 1.1` is also syntactic sugar for `b.+(1.1)`. 

After this code executes, local variable `a` will return the float object `7.3`, while local variable `b` will return the float object `8.4`. Local variable `a` is not the same as local variable `b`, as reassignment is not destructive (float objects are also immutable). So when we reassign the local variable `b`, a new float object is being referenced. Variables act as pointers to objects, and are not linked to other variables. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​test​(str) 
  str += ​'!' 
  str.downcase!
end

test_str = ​"Written Assessment" 

test(test_str)
puts test_str
```
On `lines 1-4`, we are defining a method, `test` with a single parameter (`str`). On `line 6`, we are initialising a local variable `test_str` and assigning it to a string object with the value `'Written Assessment'`. We then pass this `test_str` variable as an argument to the `test` method. 

On `line 2`, the `str` local variable (which is referencing the `'Written Assessment'` string object) is passed by the `str` parameter, and reassigned to a new string object, which is an additional `'!'` string object added to the value of the string object `test_str` is referencing. 

On `line 3`, the `downcase!` method is invoked on the local variable `str`, which destructively downcases the string object referenced by `str`. As there is no explicit `return` in this expression, the last line (`str.downcase!`) will be returned from the `test` method call, which is a string object `'written assessment!'` (which occurs on `line 8`).

On `line 9`, we pass the `test_str` local variable to the `puts` method. This will output `'Written Assessment'` and return `nil` (`puts` always returns `nil`). The reason why `test_str` was not mutated is that while variables are pointers to objects, there was a variable reassignment on `line 2`, such that the destructive method on `line 3` was called on a different string object to the string object that `test_str` is referencing. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​plus​(x, y) 
  x = x + y
end

a = ​3
b = plus(a, ​2​)

puts a
puts b
```
On `line 1-3`, we define a method `plus`, with two parameters (`x` and `y`). On `line 5`, we initialise the local variable `a`, and assign it to the integer object `3`. On `line 4`, we initialise the local variable `b`, and assign it to the return value of calling the `plus` method, with the local variable `a` and the integer object `2` passed in as arguments.

Within the `plus` method (`line 2`), we initialise a local variable `x`, and assign it to the return value of applying the `+` method with the integer object `2` as an argument to the integer object `3`. This is an example of syntactic sugar, and `line 2` could be rewritten as `x = x =.+(y)`.

In this case, `line 2` represents variable initialisation, since the integer objects that were passed in as arguments through the `x` and `y` parameters, are immutable. The local variable `x` initialised on `line 2` is different to integer object `3` passed in as an argument to the `plus` method (which was represented as the `x` parameter). 

As there is no explicit return statement, the last line evaluated of the expression is `line 2`, which returns the integer object `5` in our case. 

On `line 8`, we pass the local variable `a` as an argument to the `puts` method, which will output `3` and return `nil` (`puts` always returns `nil`). On `line 9`, we pass the local variable `b` to the `puts` method, which will output `5` and return `nil`. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​increment​(x) 
  x << ​'b'
end

y = ​'a' 

increment(y)
puts y
```
On `line 1-3`, we define a method `increment`, with one parameter (`x`). On `line 2`, the local variable `x` is passed a reference to an object from the `x` parameter, and has a string object with the value `'b'` destructively added to that referenced object through the shovel operator. As there is no explicit return statement, the last line of the expression evaluated will be returned. 

On `line 5`, we initialise a local variable `y` and assign it to the string object `'a'`. On `line 7`, we call the `increment` method, passing in the local variable `y` as an argument. Using the above explanation, this method will return the string object `'ab'`, as the shovel operator permanently mutates the object it is applied to. This also means that the string object that `y` is referencing has been mutated from `'a'` to `'ab'` (it is __not__ referencing a different string object). 

On `line 8`, we pass the local variable `y` to the `puts` method, which outputs `'ab'` and returns `nil` (`puts` always returns `nil`). 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​change_name​(name)
  name = ​'bob'​
end

name = ​'jim'
change_name(name)
puts name
```
On `line 1-3`, we define a method, `change_name`, with a `name` parameter. On `line 2`, a local variable `name` is initialised, and assigned a string object with the value `'bob'`. The `name` parameter is unused in this method. Since there is no explicit return, this method will return the last evaluated expression in the method. Therefore, the `change_name` method will always return `'bob'`, regardless of what value is passed in as an argument. 

On `line 5`, we initialise the local variable `name`, and assign it to a string object `'jim'`. We then pass this `name` local variable as an argument to the `change_name` method. As discussed above, this will return `'bob'`, since the `change_name` method does nothingwith the argument passed to it. 

On `line 7`, we pass the `name` local variable to the `puts` method. This will output `'jim'` and return `nil` (`puts` always returns `nil`). There is no change to the `'jim'` string object that the local variable `name` is referencing, since there is no mutating method called on it when passed to the `change_name` method as an argument. 

Also, method definitions have their own scope, and cannot directly access local variables initialised outside of the method definition scope (this is also why this particular code is __not__ an example of variable shadowing). Therefore, `line 2` represents variable initialisation, rather than variable reassignment. 

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
def​ ​cap​(str) 
  str.capitalize!
end

name = ​"jim" 
cap(name) 
puts name
```
On `line 1-3`, we define a method, `cap`, with a single `str` parameter. On `line 2`, the `capitalize!` method is invoked on the object passed in as an argument to the `cap` method, which destructively capitalises the first character of the string object. As there is no explicit return statement in this method, the last evaluated expression will be returned, which will be the returned value of the `.capitalize!` method call on `line 2`. 

On `line 4`, we initialise a local variable `name`, and assign it to the string object `'jim'`. We then pass this local variable `name` as an argument to the `cap` method on `line 6`. Per above discussion, this method call will return `'Jim'`. 

When we pass the local variable `name` as an argument to the `puts` method on `line 7`, this will output `'Jim'` and return `nil`. The string object that the local variable `name` was referencing was mutated as a result of passing the reference to the `'jim'` string object and calling the `.capitalize!` method on that object. 

*What is `arr`? Why? What concept does it demonstrate?*
```
a = [​1​, ​3​] 
b = [​2​]
arr = [a, b] 
arr

a[​1​] = ​5 
arr
```
On `line 1`, we initialise a local variable `a` and assign an array object to it, with two integer object elements within the array. On `line 2`, we initialise the local variable `b`, and assign an array object to it, with a single integer object as an element. 

On `line 3`, we initialise the local variable `arr`, and assign it to an array object, which references the array object `[1, 3]` that local variable `a` is pointing to, and `[2]`, the array object that local variable `b` is pointing to. On `line 4`, `arr` will return `[[1, 3], [2]]` since variables are pointers to objects per above. 

On `line 6`, we are reassigning the object at index `1` of the array object local variable `a` is referencing, to the integer object `5`. This is known as indexed assignment and while the object at `a[1]` is reassigned, indexed assignment has the effect of mutating the *original* array object referenced by the local variable `a`. As such, on `line 7`, `arr` will return `[[1, 5], [2]]`.

*What does the following code return? What does it output? Why? What concept does it demonstrate?*
```
arr1 = [​"a"​, ​"b"​, ​"c"​] 
arr2 = arr1.dup 

arr2.map! ​do​ |char|
  char.upcase
end

puts arr1
puts arr2
```
On `line 1`, we initialise a local variable `arr1`, and assign it to an array object, containing three string object elements. On `line 2`, we initialise the local variable `arr2` and assign it to the return value of calling the `.dup` method on `arr1`. The `.dup` method returns a shallow copy of the array object `arr1`  is referencing, which is a new array object. 

On `line 4`, we call the `.map!` method on the array object `arr2` is referencing (again, this is __not__ the same array object that `arr1` is referencing), passing in a block (denoted by the `do..end` reserved words immediately following the `.map!` method call) as an argument. The `.map!` method is a destructive method, returning the object it was called on, where the elements are determined by the return value of the block on each iteration. In this case (`line 5`), the `.upcase` method is called on each element in the array object referenced by `arr2`. 

On `line 8`, we call the `puts` method, passing the local variable `arr1` as an argument. This will output `'a', 'b', 'c'` on separate lines (i.e. converting each element of the array into a string object) and return `nil` (`puts` always returns `nil`). 

On `line 9`, we call the `puts` method, passing the local variable `arr2` as an argument. This will output `'A', 'B', 'C'` on separate lines and return `nil`. This is due to the `.map!` method being destructive, replacing each element of the original array referenced by `arr2` with the return value of the block. 

*What values do `s` and `t` have? Why?*
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

On `line 1-5`, we define the `fix` method with a single parameter (`value`). On `line 2`, we pass the local variable `value` from the `value` method parameter, and call the `.upcase!` method on the string object referenced by `value` (`'hello'`, in this example). This is a destructive method, permanently modifying the string object. On `line 3`, we call the `.concat` method, passing in `'!'` as an argument. This is also a destructive method, with the effect of appending the `'!'` to the string object referenced by `value`. 

As there is no explicit `return` in this method definition, when this method is called, it will return the last evaluated expression, which is the `value` local variable on `line 4`, which is `'HELLO!'` in this example. 

After the `fix` method call, the local variable `s` is now pointing to a string object `'HELLO'`, while the local variable `t` is also pointing to that same string object (since variables are pointers to objects), with a value of `'HELLO'`, due to the destructive method calls within the `fix` method call. 