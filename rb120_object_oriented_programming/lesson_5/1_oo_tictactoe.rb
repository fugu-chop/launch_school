require 'pry'

class Board
  INITIAL_MARKER = " "

  def initialize
    @squares = Hash.new
    (1..9).each { |integer| @squares[integer] = Square.new(INITIAL_MARKER) }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end
end

class Square
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def unmarked?
    marker == Board::INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tictactoe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tictactoe!"
  end

  def human_moves
    square = nil
    puts "Please select a square (#{board.unmarked_keys.join(', ')})."
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts
      puts "Sorry, that's not a valid choice. Please try again!"
    end

    binding.pry
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_board
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}  "
    puts "     |     |"
    puts
  end

  def play
    display_welcome_message
    display_board
    loop do
      human_moves
      # break if someone_won? || board_full?
      computer_moves
      display_board
      # break if someone_won? || board_full?
    end
    display_board
    #display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
