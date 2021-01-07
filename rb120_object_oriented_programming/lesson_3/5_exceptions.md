# Exceptions

## Table of Contents
- [Exceptions](#exceptions)
- [Exception Class Hierarchy](#exception-class-hierarchy)
- [When to Handle Exceptions](#when-to-handle-exceptions)
- [Handling Exceptions](#handling-exceptions)
- [Exception Objects and Built-In Methods](#exception-objects-and-built-in-methods)
- [Ensure](#ensure)
- [Retry](#retry)
- [Raising Exceptions Manually](#raising-exceptions-manually)
- [Raising Custom Exceptions](#raising-custom-exceptions)

### Exceptions
An exception is simply an exceptional state in your code. It is not necessarily a bad thing, but it is Ruby’s way of letting you know that your code is behaving unexpectedly. 

If an exception is raised and your code does not handle the exception, your program will crash and Ruby will provide a message telling you what type of error was encountered.
```
3 + "z"
# Program execution stops
#=> String can't be coerced into Integer (TypeError)
```
Ruby provides a hierarchy of _built-in classes_ to simplify exception handling. In fact, the exception names that you see when your program crashes, such as `TypeError`, are actually class names. 

The class at the very top of the hierarchy is the `Exception` class. `Exception` has several subclasses, many of which have descendents of their own.

### Exception Class Hierarchy
Here is a complete hierarchy of `Exception` classes:
```
Exception
  NoMemoryError
  ScriptError
    LoadError
    NotImplementedError
    SyntaxError
  SecurityError
  SignalException
    Interrupt
  StandardError
    ArgumentError
      UncaughtThrowError
    EncodingError
    FiberError
    IOError
      EOFError
    IndexError
      KeyError
      StopIteration
    LocalJumpError
    NameError
      NoMethodError
    RangeError
      FloatDomainError
    RegexpError
    RuntimeError
    SystemCallError
      Errno::*
    ThreadError
    TypeError
    ZeroDivisionError
  SystemExit
  SystemStackError
  fatal
```
### When to Handle Exceptions
Most often, the errors you want to handle are descendents of the `StandardError` class that was introduced above. These exceptions may be caused by a wide variety of circumstances including unexpected user input, faulty type conversions, or dividing by zero. Generally, it is relatively safe to handle these exceptions and continue running the program.

Why not just handle all exceptions? Doing so can be very dangerous. Some exceptions are more serious than others; there are some errors that we should allow to crash our program. Important errors such as `NoMemoryError`, `SyntaxError`, and `LoadError` must be addressed in order for our program to operate appropriately. Handling all exceptions may result in masking critical errors and can make debugging a very difficult task.

In order to avoid causing unwanted behaviors yourself, it is important to be intentional and very specific about which exceptions you want to handle and what action you want to take when you handle them.

### Handling Exceptions
Using a `begin/rescue` block to handle errors can keep your program from crashing if the exception you have specified is raised. 
```
begin
  # put code at risk of failing here
rescue TypeError, ZeroDivisionError
  # take action
end
```
The above example will execute the code in the `rescue` clause rather than exiting the program if the code on line 2 raises a `TypeError` or `ZeroDevisionError`. If no exception is raised, the `rescue` clause will not be executed at all and the program will continue to run normally. 

You can see that on line 3 we specified what type of exception to rescue. If no exception type is specified, all `StandardError` exceptions will be rescued and handled. __Remember not to tell Ruby to rescue `Exception` class exceptions__. Doing so will rescue all exceptions down the `Exception` class hierarchy and is very dangerous.

It is possible to include multiple rescue clauses to handle different types of exceptions that may occur.
```
begin
  # some code at risk of failing
rescue TypeError
  # take action
rescue ArgumentError
  # take a different action
end
```
### Exception Objects and Built-In Methods
Exception objects are just normal Ruby objects that we can gain useful information from. Ruby provides built-in behaviors for these objects that you may want to use while handling the exception or debugging. 
```
rescue TypeError => e
```
The syntax in the above code rescues any `TypeError`, and stores the exception object in `e`. Some useful instance methods that Ruby provides are `Exception#message` and `Exception#backtrace`, which return an error message and a backtrace associated with the exception, respectively. 
```
begin
  # code at risk of failing here
rescue StandardError => e   # storing the exception object in e
  puts e.message            # output error message
end
```
The code above will rescue any type of `StandardError` exception (including all of its descendents) and output the message associated with the exception object. Code like this can be useful when you are debugging and need to narrow down the type or cause of the error. You may always choose to be more specific about which type of exception to handle, but remember to never `rescue` the `Exception` class.

Recall that exception objects are just normal Ruby objects and the different exception types, such as `ArgumentError` and `NoMethodError`, are actually _class names_. Therefore, we can even call `Object#class` on an exception object to return its class name.
```
e.class
#=> TypeError
```
### Ensure
You may also choose to include an `ensure` clause in your `begin/rescue` block after the __last__ `rescue` clause. This branch will __always execute__, whether an exception was raised or not. 

A simple example is resource management; the code below demonstrates working with a file. Whether or not an exception was raised when working with the file, this code ensures that it will always be closed.
```
file = open(file_name, 'w')

begin
  # do something with file
rescue
  # handle exception
rescue
  # handle a different exception
ensure
  file.close
  # executes every time
end
```
If there are multiple `rescue` clauses in the `begin/rescue` block, the `ensure` clause serves as a __single exit point__ for the block and allows you to put all of your cleanup code in one place.

One important thing to remember about `ensure` is that it is critical that the code in the `ensure` clause __does not raise an exception itself__. If the code within the `ensure` clause raises an exception, any exception raised earlier in the execution of the `begin/rescue` block will be _masked_ and debugging can become very difficult.

### Retry
Using `retry` in your `begin/rescue` block redirects your program back to the `begin` statement. This allows your program to make another attempt to execute the code that raised an exception. You may find retry useful when connecting to a remote server, for example. 

Beware that if your code continually fails, you risk ending up in an infinite loop. In order to avoid this, it’s a good idea to __set a limit on the number of times you want `retry` to execute__. `retry` must be called within the `rescue` block. Using `retry` elsewhere will raise a `SyntaxError`.
```
RETRY_LIMIT = 5

begin
  attempts = attempts || 0
  # do something
rescue
  attempts += 1
  retry if attempts < RETRY_LIMIT
end
```
### Raising Exceptions Manually
Ruby actually gives you the power to manually raise exceptions yourself by calling `Kernel#raise`. This allows you to choose what type of exception to raise and even set your own error message. 

If you do not specify what type of exception to raise, Ruby will default to `RuntimeError` (a subclass of `StandardError`). There are a few different syntax options you may use when working with `raise`:
```
raise TypeError.new("Something went wrong!")
raise TypeError, "Something went wrong!"
```
In the following example, the exception type will default to a `RuntimeError`, because no type of exception is specified. The error message specified is `"invalid age"`.
```
def validate_age(age)
  raise("invalid age") unless (0..105).include?(age)
end
```
Exceptions you raise manually in your program can be handled in the same manner as exceptions Ruby raises automatically.
```
begin
  validate_age(age)
rescue RuntimeError => e
  puts e.message              #=> "invalid age"
end
```
Above, we placed the `validate_age` method in a `begin/rescue` block. If an invalid age is passed in to the method, a `RuntimeError` with the error message `"invalid age"` will be raised and the `rescue` clause of our `begin/rescue` block will be executed.

### Raising Custom Exceptions
Ruby allows us the flexibility to create our own custom exception classes.
```
class ValidateAgeError < StandardError
end
```
Our custom exception class `ValidateAgeError` is a subclass of an existing exception. This means that `ValidateAgeError` has access to all of the built-in exception object behaviors Ruby provides, including `Exception#message` and `Exception#backtrace`. 

When using a custom exception class, you can be specific about the error your program encountered by giving the class a very descriptive name. Doing so may aid in debugging. 
```
def validate_age(age)
  raise ValidateAgeError, "invalid age" unless (0..105).include?(age)
end

begin
  validate_age(age)
rescue ValidateAgeError => e
  # take action
end
```
