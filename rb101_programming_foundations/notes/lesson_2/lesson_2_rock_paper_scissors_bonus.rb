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
score_tally = { player: 0,
                computer: 0 }

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

def display_welcome
  prompt('Welcome to Rock, Paper, Scissors, Spock, Lizard!')
  prompt('The goal of this game is to select a choice that beats the computer.')
  prompt('First to 5, wins!')
  Kernel.puts("\n")
end

def choice_prompt
  Kernel.puts("\n")
  prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
  prompt('You can also use the first letter of your choice, unless
you\'re picking Spock or Scissors, in which case, use the first two letters!')
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

def winner_check(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'draw'
  end
end

def display_results(player, computer)
  if winner_check(player, computer) == 'draw'
    prompt('It\'s a draw!')
  else
    prompt("The #{winner_check(player, computer).capitalize} wins!")
  end
end

def score_incrementer(player, computer, score_tally)
  if winner_check(player, computer) != 'draw'
    score_tally[winner_check(player, computer).to_sym] += 1
  end
end

def score_printer(score_tally)
  Kernel.puts("\n")
  prompt("Your total score is #{score_tally[:player]}.")
  prompt("The total computer's score is #{score_tally[:computer]}.")
end

def score_check(score_tally)
  if score_tally.value?(5)
    Kernel.puts("\n")
    prompt("The #{score_tally.key(5)} has reached a total score of 5.")
    prompt("The #{score_tally.key(5)} wins the game!")
    prompt("Scores will be reset.")
  end
end

def score_reset(score_tally)
  if score_tally.value?(5)
    score_tally.each { |key, _value| score_tally[key] = 0 }
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

clear_screen
display_welcome

loop do
  player = player_selection
  computer = VALID_CHOICES.sample()
  display_selection(player, computer)
  display_results(player, computer)
  score_incrementer(player, computer, score_tally)
  score_printer(score_tally)
  score_check(score_tally)
  score_reset(score_tally)
  break unless play_again?
  clear_screen
end

display_farewell
