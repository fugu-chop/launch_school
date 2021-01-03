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

  def choose
    choice = nil
    loop do
      puts "Please select a move: Rock, Paper, Lizard, Spock or Scissors."
      choice = gets.chomp.capitalize
      break if Move::VALUES.include?(choice)
      puts "That's not a valid move - please try again."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Sonny', 'R2D2', 'T-800', 'Baymax', 'Chappie'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = %w(Rock Paper Lizard Scissors Spock)
  VERBS = {
    'Rock' => {'Scissors' => 'crushes',
               'Lizard' => 'crushes'},
    'Scissors' => {'Paper' => 'cuts',
               'Lizard' => 'decapitates'},
    'Paper' => {'Rock' => 'covers',
               'Spock' => 'disproves'},
    'Lizard' => {'Paper' => 'eats',
               'Spock' => 'poisons'},
    'Spock' => {'Scissors' => 'smashes',
               'Rock' => 'vapourises'}                                           
  }

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'Scissors'
  end

  def spock?
    @value == 'Spock'
  end

  def lizard?
    @value == 'Lizard'
  end

  def paper?
    @value == 'Paper'
  end

  def rock?
    @value == 'Rock'
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (spock? && (other_move.rock? || other_move.scissors?)) ||
      (lizard? && (other_move.paper? || other_move.spock?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.lizard? || other_move.paper?))
  end

  def to_s
    @value
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

  def display_verb
    display = false
    if human.move > computer.move
      winning_move, losing_move = human.move, computer.move
      display = true
    elsif human.move < computer.move
      winning_move, losing_move = computer.move, human.move
      display = true
    end

    puts "#{winning_move.to_s} #{Move::VERBS[winning_move.to_s][losing_move.to_s]} #{losing_move.to_s}!" if display
  end

  def round_winner_check
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} wins!"
    elsif human.move < computer.move
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
