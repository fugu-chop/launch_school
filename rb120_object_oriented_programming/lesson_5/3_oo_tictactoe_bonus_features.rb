require 'pry'

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

  # While these are duplicate methods, we need them to run independently
  # If we put player and computer win conditions together,
  # we run in to the edge case where
  # the order of iterating through WINNING_LINES begins to matter
  # since a player_imminent_win might be assessed earlier
  # than a computer_imminent win.
  def computer_defense(human_marker)
    WINNING_LINES.each do |line|
      combo = @squares.values_at(*line)
      if player_imminent_win?(combo, human_marker)
        return @squares.select do |key, value|
          line.include?(key) && value.marker == Square::INITIAL_MARKER
        end.keys.first
      end
    end
    nil
  end

  def computer_offense(computer_marker)
    WINNING_LINES.each do |line|
      combo = @squares.values_at(*line)
      if computer_imminent_win?(combo, computer_marker)
        return @squares.select do |key, value|
          line.include?(key) && value.marker == Square::INITIAL_MARKER
        end.keys.first
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  def player_imminent_win?(combo, human_marker)
    combo.collect(&:marker).count(human_marker) == 2 &&
      combo.collect(&:marker).count(Square::INITIAL_MARKER) == 1
  end

  def computer_imminent_win?(combo, computer_marker)
    combo.collect(&:marker).count(computer_marker) == 2 &&
      combo.collect(&:marker).count(Square::INITIAL_MARKER) == 1
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
  attr_accessor :score, :marker

  def initialize
    @score = 0
  end
end

class Computer < Player
  def initialize(marker)
    super()
    @marker = marker
  end
end

class Human < Player
  def initialize
    super()
    choose_marker
  end

  private

  def choose_marker
    answer = nil
    loop do
      puts "Please choose a marker - you can select any alphanumeric character."
      answer = gets.chomp
      break if !answer.empty?
      puts "That appears to be an empty input. Please try again!"
      puts
    end
    @marker = answer
  end
end

class TTTGame
  COMPUTER_MARKER = 'O'
  FIRST_MOVER = 'choose'
  WIN_TOTAL = 3

  attr_reader :board, :human, :computer

  def initialize
    clear
    display_welcome_message
    @board = Board.new
    @human = Human.new
    @computer = Computer.new(COMPUTER_MARKER)
    @current_turn = who_moves_first
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

  def human_moves
    square = nil
    puts "Please select a square: #{joinor}."
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts
      puts "Sorry, that's not a valid choice. Please try again!"
    end

    board[square] = human.marker
  end

  def computer_selection(human_marker = human.marker,
                         computer_marker = computer.marker)
    if board.computer_offense(computer_marker)
      board.computer_offense(computer_marker)
    elsif board.computer_defense(human_marker)
      board.computer_defense(human_marker)
    elsif board.unmarked_keys.include?(5)
      5
    else
      board.unmarked_keys.sample
    end
  end

  def computer_moves
    board[computer_selection] = computer.marker
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
      human_moves
      @current_turn = computer.marker
    else
      computer_moves
      @current_turn = human.marker
    end
  end

  def display_board
    puts "You're marking #{human.marker}, the computer is #{computer.marker}."
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
      puts "You won!"
    when computer.marker
      puts "The computer won!"
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
    human.score > computer.score ? "player" : "computer"
  end

  def display_overall_winner
    return unless overall_winner?
    puts "The #{overall_winner} wins the game with #{WIN_TOTAL} total wins!"
  end

  def display_score
    puts "Total wins:
    Player: #{human.score}
    Computer: #{computer.score}"
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
    # I've decided to give the player to choose on subsequent rounds
    # even if the constant is set to player/computer
    @current_turn = choose_first_to_move
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
