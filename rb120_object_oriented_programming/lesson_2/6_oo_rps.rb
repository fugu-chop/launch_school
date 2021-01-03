class Player
  attr_reader :move
  attr_accessor :name

  def initialize
    set_name
  end

  protected

  attr_writer :move
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
      puts "Please select a move: Rock, Paper or Scissors."
      choice = gets.chomp.capitalize
      break if Move::VALUES.include?(choice)
      puts "That's not a valid move - please try again."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Computer', 'R2D2', 'Hal', 'Baymax', 'Chappie'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['Rock', 'Paper', 'Scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'Scissors'
  end

  def paper?
    @value == 'Paper'
  end

  def rock?
    @value == 'Rock'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    "Welcome to Rock Paper Scissors!"
  end

  def display_goodbye_message
    "Thanks for playing Rock Paper Scissors!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} wins!"
    elsif human.move < computer.move
      puts "#{computer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp
      break if ['Y', 'N'].include?(answer.upcase)
      puts "That's not a valid answer - please answer y or n!"
    end

    answer.upcase == 'Y'
  end

  def play
    puts display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    puts display_goodbye_message
  end
end

RPSGame.new.play
