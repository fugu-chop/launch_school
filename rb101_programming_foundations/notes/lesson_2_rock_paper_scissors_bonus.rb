=begin
PSEUDOCODE

PART 3
Keep score of the player's and computer's wins.
When either the player or computer reaches five wins, the match is over,
and the winning player becomes the grand winner.
Don't add your incrementing logic to display_results.
Keep your methods simple; they should perform one logical task.

BEGIN
SET two variables, one for computer, one for player
IF someone wins, increment one to the tally
WHEN tally = 5
PRINT "You are the grand winner!"
END

computer_score = 0
player_score = 0

def score_incrementer(player, computer)
  if win?(player1, player2)
    player_score += 1
  end
end
=end

VALID_CHOICES = %w(rock paper scissors spock lizard)
WIN_STATES = { rock: %w(scissors lizard),
               scissors: %w(paper lizard),
               paper: %w(rock spock),
               lizard: %w(paper spock),
               spock: %w(rock scissors) }
CHOICE_ACRONYMS = { sp: 'spock',
                    r: 'rock',
                    p: 'paper',
                    sc: 'scissors',
                    l: 'lizard' }

def win?(player1, player2)
  WIN_STATES.fetch(player1.to_sym()).include?(player2)
end

def clear_screen
  system('clear') || system('clr')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def get_choice_first_letter(player)
  if player.length == 1 && CHOICE_ACRONYMS.key?(player[0].to_sym)
    CHOICE_ACRONYMS.fetch(player[0].to_sym)
  elsif player.length == 2 && CHOICE_ACRONYMS.key?(player[0..1].to_sym)
    CHOICE_ACRONYMS.fetch(player[0..1].to_sym)
  else
    false
  end
end

def choice_prompt
  Kernel.puts("\n")
  prompt("Choose one: #{VALID_CHOICES.join(', ')}.
You can also use the first letter of your choice, unless you're picking
Spock or Scissors, in which case, use the first two letters!")
  puts "\n"
end

def incorrect_selection_prompt
  Kernel.puts("\n")
  prompt('That\'s not a valid choice! Please try again.')
end

def player_selection
  loop do
    choice_prompt
    player = Kernel.gets().chomp().downcase()
    if VALID_CHOICES.include?(player)
      return player
    elsif get_choice_first_letter(player)
      return get_choice_first_letter(player)
    else
      incorrect_selection_prompt
    end
  end
end

def display_selection(player, computer)
  Kernel.puts("\n")
  prompt("You chose #{player}, the computer chose #{computer}.")
  Kernel.puts("\n")
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You win!')
  elsif win?(computer, player)
    prompt('You lose!')
  else
    prompt('It\'s a draw!')
  end
end

def play_again?
  Kernel.puts("\n")
  prompt('Do you want to play again? Please press y if so!')
  Kernel.gets().chomp().downcase() == 'y'
end

def display_farewell
  Kernel.puts("\n")
  prompt('Thanks for playing! We hope to see you again.')
end

loop do
  player = player_selection
  computer = VALID_CHOICES.sample()
  display_selection(player, computer)
  display_results(player, computer)
  break unless play_again?
end

display_farewell
