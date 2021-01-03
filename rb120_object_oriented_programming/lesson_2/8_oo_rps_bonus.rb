class Player
  attr_reader :move, :name
  attr_accessor :score

  def initialize
    set_name
    @score = 0
  end

  protected

  attr_writer :move, :name
end

class Human < Player
  def set_name
    player_name = ''
    loop do
      puts "Please enter your name."
      player_name = gets.chomp
      break unless player_name.empty?
      puts "Please enter a name."
    end
    self.name = player_name
  end

  def class_choice(choice)
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
      puts "Please select a move: Rock, Paper, Lizard, Spock or Scissors."
      choice = gets.chomp.capitalize
      break if Move::VALUES.include?(choice)
      puts "That's not a valid move - please try again."
    end
    self.move = class_choice(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Bender', 'R2D2', 'T-800', 'Optmius Prime', 'Sonny'].sample
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
  WINNING_SCORE = 3
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts
    "Welcome to Rock Paper Scissors Lizard Spock!"
  end

  def display_goodbye_message
    "Thanks for playing Rock Paper Scissors Lizard Spock!"
  end

  def display_moves
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

    win_verb = winning_move.win_condition[losing_move.to_s]
    puts "#{winning_move} #{win_verb} #{losing_move}!" if display_verb?
  end

  def round_winner_check
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
      break if ['Y', 'N'].include?(answer.upcase)
      puts "That's not a valid answer - please answer y or n!"
    end
    puts

    answer.upcase == 'Y'
  end

  def play
    puts display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_verb
      display_winner
      round_winner_check
      display_scores
      display_game_winner if game_winner
      score_reset if game_winner
      break unless play_again?
    end
    puts display_goodbye_message
  end
end

RPSGame.new.play
