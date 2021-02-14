# Assignment - Object Oriented Rock Paper Scissors

## Table of Contents
- [Approach to Object Oriented Programming](#approach-to-object-oriented-programming)
- [Textual Description](#textual-description)
- [Extracting Nouns to Classes](#extracting-nouns-to-classes)
- [Organising Verbs with Nouns](#organising-verbs-with-nouns)
- [Orchestration Engine](#orchestration-engine)
- [General tips](#general-tips)

### Approach to Object Oriented Programming
The classical approach to object oriented programming is:
- Write a textual description of the problem or exercise.
- Extract the major nouns and verbs from the description.
- Organize and associate the verbs with the nouns.
- The nouns are the classes and the verbs are the behaviors or methods.

Notice that in OO, we don't think about the game flow logic at all. It's all about __organizing and modularizing the code__ into a cohesive structure - __classes__. 

After we come up with the initial class definitions, the final step is to orchestrate the flow of the program using objects instantiated from the classes.

When it comes to object oriented design, we're always juggling a tradeoff between more _flexible_ code and _indirection_. Put another way, the more flexible your code, the more indirection you'll introduce by way of _more classes_ (e.g. through more collaborator objects), such that we have to piece together the actual logic behind the code from more places in our code.

On one hand, we can have all the code in one place, but then we lose flexibility. On the other hand, we can refactor the code for increased flexibility and maintainability. However, the tradeoff is increased indirection, which means that you have to dig deeper throughout our program to fully understand what is happening.

In traditional functional programming, we could abstract/encapsulate logic in methods of the same class. With OO, we can add another layer of __abstraction through classes__. The same process can be done but rather than have the method exist within the same class, the method exists in *another class*. The added layer of abstraction is that we’re now thinking in terms of *objects that collaborate with each other*.

There's likely an optimal tradeoff on that spectrum for your application somewhere, but that place likely changes as your application matures. This is the source of never-ending debate and discussion in the software development field, but it really comes down to that tradeoff. This is where the "art" of programming comes in.

### Textual Description
```
Rock, Paper, Scissors is a two-player game where each player chooses one of three possible moves: rock, paper, or scissors. The chosen moves will then be compared to see who wins, according to the following rules:
- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.
```
### Extracting Nouns to Classes
In a way, Rock, Paper, Scissors is a difficult game to code in OO style, because there aren't many obvious _nouns_. 

The problem domain is easier to model and extract to classes when there are real world nouns that match the problem description. However, in RPS, the nouns are more subtle. 
```
Nouns: player, move, rule
Verbs: choose, compare
```
Note that we decided to ignore "rock", "paper" or "scissors", since they are all variations on a move -- almost like different states of a move. Therefore, we capture the major noun: move.

### Organising Verbs with Nouns
Here's a list of the nouns and their verbs. This is the step where we create methods (verbs) for nouns (classes).
```
Player
 - choose
Move
Rule

- compare
```
Notice that a "Player" can "choose", but "Move" and "Rule" don't have any verbs at all, and we aren't sure where to put "compare". This is an awkward first attempt, but it's all we are comfortable assuming at this point. We'll have to take a stab at defining our classes with this.

Let's code up some classes and methods. While we do this, we can also think about what "states" the objects of these classes should have.
```ruby
class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end
```
### Orchestration Engine
After we're done organizing nouns and verbs into classes, we need an "engine" of some sort to orchestrate the objects. 

This is where the procedural program flow should be. Let's call the "engine" class `RPSGame`. We want an easy interface to kick things off, so perhaps to play the game, we just instantiate an object and call a method called `play`.
```ruby
RPSGame.new.play

class RPSGame
  def initialize

  end

  def play

  end
end
```
Starting from that skeleton, we can start to think about what objects are required in the `play` method to facilitate the game.
```ruby
def play
  display_welcome_message
  human_choose_move
  computer_choose_move
  display_winner
  display_goodbye_message
end
```
Lines 3 and 4 look similar, and it also looks like there's a redundant "choose_move" part. This ties into our `Player` class, which has a `choose` method. What if "human" and "computer" were both objects of the `Player` class? They'd both immediately have the `Player#choose` method. 
```ruby
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end
```
### General tips
#### Explore the problem before design
It can be very difficult to come up with the "right" classes and methods when you first approach a problem. Take time to explore the problem domain with a __spike__ - exploratory code to play around with the problem. Spikes can help validate initial hunches and hypotheses. 

You don't have to worry about code quality, because the idea of a spike is to throw away the code. If you were writing an essay, the spike would be the initial braindump of ideas. As you start to understand the problem better and get a feel for possible solutions, start to organize your code into coherent classes and methods.

#### Repetitive nouns in method names is a sign that you're missing a class
In our Rock, Paper, Scissors game for example, if we find ourselves constantly referring to a "move", it may be a sign that we should encapsulate the logic into a `Move` class (which is what we did). Suppose we had the following code and `move` is a string or integer (ie, not a custom object):
```ruby
human.make_move
computer.make_move

puts "Human move was #{format_move(human.move)}."
puts "Computer move was #{format_move(computer.move)}."

if compare_moves(human.move, computer.move) > 1
  puts "Human won!"
elsif compare_moves(human.move, computer.move) < 1
  puts "Computer won!"
else
  puts "It's a tie!"
end
```
The above code is fabricated, but it's not as far fetched as it seems. The `format_move` helper method formats the move in our output, because we don't have an object that we can tell to "format yourself for output". We also need a `compare_moves` helper method because the moves don't know how to compare themselves with each other. 

All these references to "move" gives us a hint that we should be *encapsulating the move into a custom move object*, so that we can tell the object to "format yourself" or "compare yourself against another". Look at how the code could be possibly improved:
```ruby
human.move!
computer.move!

puts "Human move was #{human.move.display}."
puts "Computer move was #{computer.move.display}."

if human.move > computer.move
  puts "Human won!"
elsif human.move < computer.move
  puts "Computer won!"
else
  puts "It's a tie!"
end
```
The logic that used to be in straggling helper methods are now in the appropriate class: `Move#display` and the comparison methods `Move#<` and `Move#>`.

#### When naming methods, don't include the class name
A lot of beginners will write methods like this:
```ruby
class Player
  def player_info
    # returns player's name, move and other data
  end
end
```
But the `player_info` method is poorly named, because in actual usage, we could end up with code like this:
```ruby
player1 = Player.new
player2 = Player.new

puts player1.player_info
puts player2.player_info
```
The code would read much more fluently if the method was just named info, so we can use it like this:
```ruby
puts player1.info
puts player2.info
```
It's not always the case, but most of the time, you can leave off the class name in method definitions. Remember to always think about the method's usage or interface when you define methods. Pick naming conventions that are consistent, easy to remember, give an idea of what the method does, and *reads well at invocation* time.

#### Avoid long method invocation chains
When working with object oriented code, it's tempting to keep calling methods on collaborator objects. Take the following code.
```ruby
human.move.display.size
```
This is a 3 chain method invocation, and is very fragile. For example, if `human.move` returns `nil`, then the *entire method invocation chain blows up*, and it's very hard to debug the error. There are many solutions for this type of problem, and many strategies are beyond what we want to talk about right now. 

For now, develop the initial instinct to smell out code that contains long method invocation chains, and *try to think about the possibility of `nil` or other unexpected return values in the middle of the chain*. If you've identified that `human.move` could possibly return `nil`, for example, then you can put in some guard expressions like this:
```ruby
move = human.move
puts move.display.size if move
```
#### Avoid design patterns for now.

One of the biggest mistakes beginner programmers make is mis-application of "best practices" or "design patterns" to improve performance or flexibility. This is such a common phenomenon that experienced programmers have a quote: "premature optimization is the root of all evil".

Don't worry about optimization at this point. Don't write overly clever code. Granted, you won't know what's considered "clever" vs "normal" without reading a lot of code, but over time, you will start to hone your senses.

You'll spend the rest of your career mastering design patterns and best practices. Most importantly, you should spend time understanding when to use those things.
