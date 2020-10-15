require 'pry'
require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                 [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                 [[1, 5, 9], [3, 5, 7]]
score = { player: 0,
          computer: 0 }

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
def display_board(board, score)
  system 'clear'
  puts "You're marking #{PLAYER_MARKER}'s. The computer is #{COMPUTER_MARKER}."
  score_display(score)
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

def joiner(board, separator = ',', keyword = 'or')
  full = board
  if board.size > 1
    last_element = " #{keyword} " + full.pop.to_s
  else 
    last_element = full.pop.to_s
  end
  full.join("#{separator} ") + last_element
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt("Choose a square: #{joiner(empty_squares(board))}")
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    puts
    prompt('Sorry, that\'s not a value choice. Try again.')
    puts
  end
  board[square] = PLAYER_MARKER
end

def defense_choice(board)
  player_choices = board.select do |keys, value|
    value == PLAYER_MARKER
  end.keys

  computer_choice = []
  WINNING_COMBOS.select do |element|
    (element - player_choices).each do |option|
      if (element - player_choices).size == 1
        computer_choice << option
      end
    end
  end

  # Check if the computer_choice is empty or not!
  if true
    # Need to 
    computer_choice.first
  else
    computer_choice.first
  end 
  binding.pry
end

def computer_places_piece!(board)
  if defense_choice(board) != nil
    square = defense_choice(board)
  else
    square = empty_squares(board).sample
  end
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
    if board.values_at(*combo).count(PLAYER_MARKER) == 3
      return 'You'
    elsif board.values_at(*combo)
               .count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def score_incrementer(winner, score)
  if winner == 'You'
    score[:player] += 1
  elsif winner == 'Computer'
    score[:computer] += 1
  end
end

def score_display(score)
  prompt("The player has won #{score[:player]} rounds.")
  prompt("Computer has won #{score[:computer]} rounds.")
  puts
end

def winner?(score)
  score.key(5).to_s if score.key(5) != nil
end

def winner_display(winner)
  if winner
    prompt("The #{winner.capitalize} has won the game with 5 wins!")
  end
end

def score_reset(condition, score)
  if condition
    score[:player] = 0
    score[:computer] = 0
  end
end

loop do
  board = initialise_board

  loop do
    display_board(board, score)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
    
    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board, score)

  if someone_won?(board)
    puts
    prompt("#{detect_winner(board)} won this round!")
  else
    puts
    prompt('It\'s a tie!')
  end

  score_incrementer(detect_winner(board), score)
  score_display(score)

  winner_display(winner?(score))
  score_reset(winner?(score), score)

  prompt('Do you want to play again? (Please press y or n)')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thanks for playing Tictactoe! Have a great day.')
