class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  attr_reader :squares

  def initialize
    @squares = Hash.new
    reset
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def count_marker(squares)
    squares.collect(&:marker).count_by(TTTGame::HUMAN_MARKER)
  end

  def winning_marker
    WINNING_LINES.each do |line|
      combo = @squares.values_at(*line)
      return combo.first.marker if three_identical_markers?(combo)
    end
    nil
  end

  def reset
    (1..9).each { |integer| @squares[integer] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
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
  FIRST_TO_MOVE = HUMAN_MARKER
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_turn = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def clear
    system 'clear'
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
    puts "Please select a square: #{board.unmarked_keys.join(', ')}."
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts
      puts "Sorry, that's not a valid choice. Please try again!"
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def human_turn?
    @current_turn == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_turn = COMPUTER_MARKER
    else
      computer_moves
      @current_turn = HUMAN_MARKER
    end
  end

  def display_board
    puts "You're #{human.marker}, the computer is #{computer.marker}."
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when HUMAN_MARKER
      puts "You won!"
    when COMPUTER_MARKER
      puts "The computer won!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def reset
    board.reset
    @current_turn = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Starting another round!"
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? Please answer [y]es or [n]o."
      answer = gets.chomp.downcase
      break if ['y', 'n', 'yes', 'no'].include?(answer)
      puts "That's not a valid answer - please try again!"
      puts
    end
    ['y', 'yes'].include?(answer)
  end
end

game = TTTGame.new
game.play
