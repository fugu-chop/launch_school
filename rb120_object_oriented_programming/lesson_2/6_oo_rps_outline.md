# Assignment - Object Oriented Rock Paper Scissors

## Table of Contents
- [Approach to Object Oriented Programming](#approach-to-object-oriented-programming)
- [Textual Description](#textual-description)
- [Extracting Nouns to Classes](#extracting-nouns-to-classes)
- [Organising Verbs with Nouns](#organising-verbs-with-nouns)
- [Orchestration Engine](#orchestration-engine)

### Approach to Object Oriented Programming
The classical approach to object oriented programming is:
- Write a textual description of the problem or exercise.
- Extract the major nouns and verbs from the description.
- Organize and associate the verbs with the nouns.
- The nouns are the classes and the verbs are the behaviors or methods.

Notice that in OO, we don't think about the game flow logic at all. It's all about __organizing and modularizing the code__ into a cohesive structure - __classes__. 

After we come up with the initial class definitions, the final step is to orchestrate the flow of the program using objects instantiated from the classes.

When it comes to object oriented design, we're always juggling a tradeoff between more _flexible_ code and _indirection_. Put another way, the more flexible your code, the more indirection you'll introduce by way of more classes. 

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
```
class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
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
```
RPSGame.new.play

class RPSGame
  def initialize

  end

  def play

  end
end
```
Starting from that skeleton, we can start to think about what objects are required in the `play` method to facilitate the game.
```
def play
  display_welcome_message
  human_choose_move
  computer_choose_move
  display_winner
  display_goodbye_message
end
```
Lines 3 and 4 look similar, and it also looks like there's a redundant "choose_move" part. This ties into our `Player` class, which has a `choose` method. What if "human" and "computer" were both objects of the `Player` class? They'd both immediately have the `Player#choose` method. 
```
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
