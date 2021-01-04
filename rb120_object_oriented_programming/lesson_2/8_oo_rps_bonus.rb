module Clearable
  def clear_screen
    system 'clear'
  end
end

class Player
  include Clearable

  attr_reader :move, :name
  attr_accessor :score

  def initialize
    set_name
    @score = 0
  end

  private

  attr_writer :move, :name
end

class Human < Player
  def set_name
    player_name = ''
    loop do
      puts "Please enter your name."
      player_name = gets.chomp
      break unless player_name.empty?
      puts "No name detected. Please enter a name."
      puts
    end
    self.name = player_name
    puts
  end

  def player_class_choice(choice)
    case choice
    when 'Rock' then Rock.new
    when 'Paper' then Paper.new
    when 'Lizard' then Lizard.new
    when 'Scissors' then Scissors.new
    when 'Spock' then Spock.new
    end
  end

  def choose
    choice = nil
    loop do
      clear_screen
      puts "Please select a move: Rock, Paper, Lizard, Spock or Scissors."
      choice = gets.chomp.capitalize
      break if Move::VALUES.include?(choice)
      puts "That's not a valid move - please try again."
      puts
    end
    self.move = player_class_choice(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Bender', 'R2D2', 'T-800', 'Optimus Prime', 'Sonny'].sample
  end

  def choose
    choice = Move::VALUES.sample
    self.move = case choice
                when 'Rock' then Rock.new
                when 'Paper' then Paper.new
                when 'Lizard' then Lizard.new
                when 'Scissors' then Scissors.new
                when 'Spock' then Spock.new
                end
  end
end

class Move
  attr_reader :win_condition, :value, :loss_condition

  VALUES = %w(Rock Paper Lizard Scissors Spock)

  def >(other_move)
    win_condition.keys.include?(other_move.value)
  end

  def <(other_move)
    other_move.win_condition.keys.include?(@value)
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'Rock'
    @win_condition = { 'Scissors' => 'crushes',
                       'Lizard' => 'crushes' }
    @loss_condition = %w(Paper Spock)
  end
end

class Paper < Move
  def initialize
    @value = 'Paper'
    @win_condition = { 'Rock' => 'covers',
                       'Spock' => 'disproves' }
    @loss_condition = %w(Scissors Lizard)
  end
end

class Scissors < Move
  def initialize
    @value = 'Scissors'
    @win_condition = { 'Paper' => 'cuts',
                       'Lizard' => 'decapitates' }
    @loss_condition = %w(Rock Spock)
  end
end

class Spock < Move
  def initialize
    @value = 'Spock'
    @win_condition = { 'Scissors' => 'smashes',
                       'Rock' => 'vapourises' }
    @loss_condition = %w(Paper Lizard)
  end
end

class Lizard < Move
  def initialize
    @value = 'Lizard'
    @win_condition = { 'Paper' => 'eats',
                       'Spock' => 'poisons' }
    @loss_condition = %w(Rock Scissors)
  end
end

class RPSGame
  include Clearable

  WINNING_SCORE = 3
  attr_accessor :human, :computer

  def initialize
    clear_screen
    display_welcome_message
    display_rules
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts
    puts <<~MSG
    Welcome to Rock Paper Scissors Lizard Spock! 
    Rock, Paper, Scissors, Spock, Lizard is an interesting wrinkle on the traditional Rock Paper Scissors game.
    MSG
    puts
  end

  def display_rules
    puts <<~MSG
    Here's the win conditions:
    > Rock crushes Scissors and Lizard
    > Paper covers Rock and disproves Spock
    > Scissors cuts Paper and decapitates Lizard
    > Lizard poisons Spock and eats Paper
    > Spock vapourises Rock and smashes Scissors

    The player will make their selection, followed by the computer. The first to reach #{RPSGame::WINNING_SCORE} wins, wins the game!
    MSG
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Rock Paper Scissors Lizard Spock!"
  end

  def display_moves
    puts
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts
  end

  def human_win?
    human.move > computer.move
  end

  def computer_win?
    computer.move > human.move
  end

  def display_verb?
    human_win? || computer_win?
  end

  def display_verb
    if human_win?
      winning_move = human.move
      losing_move = computer.move
    elsif computer_win?
      winning_move = computer.move
      losing_move = human.move
    end

    win_verb = winning_move.win_condition[losing_move.to_s] if display_verb?
    puts "#{winning_move} #{win_verb} #{losing_move}!" if display_verb?
  end

  def score_incrementer
    if human_win?
      human.score += 1
    elsif computer_win?
      computer.score += 1
    end
  end

  def display_winner
    if human_win?
      puts "#{human.name} wins!"
    elsif computer_win?
      puts "#{computer.name} wins!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def game_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def game_winner
    if human.score == WINNING_SCORE
      (human.name).to_s
    elsif computer.score == WINNING_SCORE
      (computer.name).to_s
    end
  end

  def display_game_winner
    puts "#{game_winner} wins with #{WINNING_SCORE} total wins!" if game_winner
    puts "Scores will be reset."
    puts
  end

  def score_reset
    human.score = 0
    computer.score = 0
  end

  def display_scores
    puts "#{human.name} has won #{human.score} rounds."
    puts "#{computer.name} has won #{computer.score} rounds."
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp
      break if ['Y', 'N', 'YES', 'NO'].include?(answer.upcase)
      puts "That's not a valid answer - please answer [y]es or [n]o!"
    end
    puts

    ['Y', 'YES'].include?(answer.upcase)
  end

  def game_loop
    human.choose
    computer.choose
    display_moves
    display_verb
    display_winner
    score_incrementer
    display_scores
  end

  def play
    loop do
      game_loop
      if game_winner?
        display_game_winner
        score_reset
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
