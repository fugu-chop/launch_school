INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                 [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                 [[1, 5, 9], [3, 5, 7]]
PLAYER_ORDER = 'choose'
ROUNDS_TO_WIN = 5
COMBO_LENGTH = 3
score = { player: 0,
          computer: 0 }

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome
  prompt 'Welcome to Tictactoe!'
  prompt "The goal is to place #{COMBO_LENGTH} icons in a row."
  prompt "The first to #{ROUNDS_TO_WIN} wins, wins the game!"
end

def who_goes_first
  if PLAYER_ORDER == 'choose'
    loop do
      puts
      prompt('Who should go first? Computer or player?')
      answer = gets.chomp.downcase
      if ['player', 'computer'].include?(answer)
        return answer
      else
        prompt('Sorry, please choose computer or player.')
      end
    end
  else
    PLAYER_ORDER
  end
end

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
def display_board(board, score)
  system 'clear'
  puts "You're marking #{PLAYER_MARKER}. The computer is #{COMPUTER_MARKER}."
  display_score(score)
  puts
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

def initialise_board
  new_board = Hash.new
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def joinor(board, separator = ',', keyword = 'or')
  full = board
  last_element = if board.size > 1
                   " #{keyword} " + full.pop.to_s
                 else
                   full.pop.to_s
                 end
  full.join("#{separator} ") + last_element
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def place_piece!(board, current_player)
  if current_player == 'player'
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt("Choose a square: #{joinor(empty_squares(board))}")
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    puts
    prompt('Sorry, that\'s not a value choice. Try again.')
    puts
  end
  board[square] = PLAYER_MARKER
end

def computer_choice(board, marker)
  choices = board.select do |_keys, value|
    value == marker
  end.keys.uniq

  computer_choice = []
  WINNING_COMBOS.each do |element|
    (element - choices).each do |option|
      if (element - choices).size == 1
        computer_choice << option
      end
    end
  end
  (computer_choice & empty_squares(board)).first
end

def computer_places_piece!(board)
  square = computer_choice(board, COMPUTER_MARKER) ||
           computer_choice(board, PLAYER_MARKER) ||
           ([ROUNDS_TO_WIN] & empty_squares(board)).first ||
           empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_COMBOS.each do |combo|
    if board.values_at(*combo).count(PLAYER_MARKER) == COMBO_LENGTH
      return 'You'
    elsif board.values_at(*combo)
               .count(COMPUTER_MARKER) == COMBO_LENGTH
      return 'Computer'
    end
  end
  nil
end

def increment_score(winner, score)
  if winner == 'You'
    score[:player] += 1
  elsif winner == 'Computer'
    score[:computer] += 1
  end
end

def display_score(score)
  prompt "The player has won #{score[:player]} rounds."
  prompt "Computer has won #{score[:computer]} rounds."
  puts
end

def winner?(score)
  score.key(ROUNDS_TO_WIN).to_s if !score.key(ROUNDS_TO_WIN).nil?
end

def display_winner(winner)
  if winner
    prompt "The #{winner.capitalize} has won with #{ROUNDS_TO_WIN} wins!"
  end
end

def reset_score(condition, score)
  if condition
    score[:player] = 0
    score[:computer] = 0
  end
end

def display_farewell
  puts
  prompt 'Thanks for playing Tictactoe! Have a great day.'
end

system 'clear'
display_welcome

loop do
  current_player = who_goes_first
  board = initialise_board

  loop do
    display_board(board, score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board, score)

  puts
  if someone_won?(board)
    prompt "#{detect_winner(board)} won this round!"
  else
    prompt 'It\'s a tie!'
  end

  increment_score(detect_winner(board), score)
  display_score(score)

  display_winner(winner?(score))
  reset_score(winner?(score), score)

  prompt 'Do you want to play again? (Please press y or n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

display_farewell
