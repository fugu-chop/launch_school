VALID_CHOICES = %w(rock paper scissors)

def clear_screen
  system('clear') || system('clr')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(player1, player2)
  (player1 == 'rock' && player2 == 'scissors') ||
    (player1 == 'paper' && player2 == 'rock') ||
    (player1 == 'scissors' && player2 == 'paper')
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

def player_selection
  loop do
    Kernel.puts("\n")
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    player = Kernel.gets().chomp().downcase()
    if VALID_CHOICES.include?(player)
      return player
    else
      prompt('That\'s not a valid choice! Please try again.')
    end
  end
end

def display_selection(player, computer)
  Kernel.puts("\n")
  Kernel.puts("You chose #{player}, the computer chose #{computer}.")
  Kernel.puts("\n")
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
