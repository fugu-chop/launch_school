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
    squares.collect(&:marker).count_by(human.marker)
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
  attr_accessor :score, :marker, :name

  def initialize
    @score = 0
  end
end

class Computer < Player
  MARKER = 'O'
  def initialize
    super()
    @marker = MARKER
    set_name
  end

  def move(board, human_marker)
    board[computer_selection(board, human_marker)] = marker
  end

  private

  def set_name
    self.name = ['Bender', 'R2D2', 'T-800', 'Optimus Prime', 'Sonny'].sample
  end

  def computer_defense(board, human_marker)
    Board::WINNING_LINES.each do |line|
      combo = board.squares.values_at(*line)
      if imminent_win?(combo, human_marker)
        return board.squares.select do |key, value|
          line.include?(key) && value.marker == Square::INITIAL_MARKER
        end.keys.first
      end
    end
    nil
  end

  def computer_offense(board)
    Board::WINNING_LINES.each do |line|
      combo = board.squares.values_at(*line)
      if imminent_win?(combo, marker)
        return board.squares.select do |key, value|
          line.include?(key) && value.marker == Square::INITIAL_MARKER
        end.keys.first
      end
    end
    nil
  end

  def imminent_win?(combo, marker)
    combo.collect(&:marker).count(marker) == 2 &&
      combo.collect(&:marker).count(Square::INITIAL_MARKER) == 1
  end

  def computer_selection(board, human_marker)
    if computer_offense(board)
      computer_offense(board)
    elsif computer_defense(board, human_marker)
      computer_defense(board, human_marker)
    elsif board.unmarked_keys.include?(5)
      5
    else
      board.unmarked_keys.sample
    end
  end
end

class Human < Player
  def initialize
    super()
    set_name
    choose_marker
  end

  def move(board, joinor)
    square = nil
    puts "Please select a square: #{joinor}."
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts
      puts "Sorry, that's not a valid choice. Please try again!"
    end

    board[square] = marker
  end

  private

  def choose_marker
    answer = nil
    loop do
      puts
      puts "Please choose a marker - you can select a character aside from 'O'."
      answer = gets.chomp
      break if answer_validation(answer)
      puts "Invalid marker. Please try again!"
      puts
    end
    self.marker = answer
  end

  def answer_validation(answer)
    !answer.empty? &&
      answer.upcase != Computer::MARKER &&
      answer != ' ' &&
      answer.length == 1
  end

  def set_name
    answer = nil
    loop do
      puts "Please enter your name!"
      answer = gets.chomp
      break if !answer.empty?
      puts "Empty input detected. Please try again"
      puts
    end
    self.name = answer
  end
end

class TTTGame
  FIRST_MOVER = 'choose'
  WIN_TOTAL = 3

  attr_reader :board, :human, :computer

  def initialize
    clear
    display_welcome_message
    display_rules
    @board = Board.new
    @computer = Computer.new
    display_opponent
    @human = Human.new
    @current_turn = who_moves_first
    @first_turn = @current_turn
  end

  def play
    clear
    main_game
    display_goodbye_message
  end

  private

  def clear
    system 'clear'
  end

  def display_opponent
    puts "You'll be playing #{computer.name} today."
    puts
  end

  def display_welcome_message
    puts "Welcome to Tictactoe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tictactoe!"
  end

  def joinor(general_delimiter = ', ', last_delimiter = ' or ')
    arr = board.unmarked_keys
    if arr.length > 2
      arr[0...-1].join(general_delimiter) +
        last_delimiter + arr[-1].to_s
    elsif arr.length == 2
      arr.join(last_delimiter)
    else
      arr[-1]
    end
  end

  def human_turn?
    @current_turn == human.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_round_end
    display_result
    increment_score
    display_score
  end

  def main_game
    loop do
      display_board
      player_move
      display_round_end
      display_game_end
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def current_player_moves
    if human_turn?
      human.move(board, joinor)
      @current_turn = computer.marker
    else
      computer.move(board, human.marker)
      @current_turn = human.marker
    end
  end

  def display_rules
    puts <<~MSG
    The goal is to mark 3 squares, either vertically, horizontally, or diagonally, consecutively.
    The first player to win #{WIN_TOTAL} rounds, wins the game.
    Good luck!
    MSG
    puts
  end

  def display_board
    puts "You're '#{human.marker}', #{computer.name} is '#{computer.marker}'."
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
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def increment_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def overall_winner?
    human.score == WIN_TOTAL || computer.score == WIN_TOTAL
  end

  def overall_winner
    return unless overall_winner?
    human.score > computer.score ? (human.name).to_s : (computer.name).to_s
  end

  def display_overall_winner
    return unless overall_winner?
    puts "The #{overall_winner} wins the game with #{WIN_TOTAL} total wins!"
  end

  def display_score
    puts "Total wins:"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
    puts
  end

  def display_score_reset
    return unless overall_winner?
    puts "Scores will be reset!"
    puts
  end

  def display_game_end
    display_overall_winner
    display_score_reset
  end

  def reset_scores
    return unless overall_winner?
    human.score = 0
    computer.score = 0
  end

  def reset
    board.reset
    @current_turn = @first_turn
    reset_scores
    clear
  end

  def display_play_again_message
    puts "Starting another round!"
    puts
  end

  def who_moves_first
    case FIRST_MOVER.downcase
    when 'computer' then computer.marker
    when 'player' then human.marker
    else
      choose_first_to_move
    end
  end

  def choose_first_to_move
    answer = nil
    loop do
      puts
      puts "Who should go first? Please answer [p]layer or [c]omputer."
      answer = gets.chomp.downcase
      break if ['p', 'c', 'computer', 'player'].include?(answer)
      puts "That's not a valid answer - please try again!"
      puts
    end

    ['p', 'player'].include?(answer) ? human.marker : computer.marker
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
