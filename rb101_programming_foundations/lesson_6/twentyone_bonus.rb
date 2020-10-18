number_cards = (2..10).to_a.map(&:to_s)
face_cards = %w(King Queen Jack Ace)
cards = number_cards + face_cards
values = (2..10).to_a + [10, 10, 10, 11]
CARDS = Hash[cards.zip(values)]
DEALER_STAY = 17
BLACKJACK = 21
SUITS = 4
STARTING_HAND_SIZE = 2
ROUNDS_TO_WIN = 5
scores = { player: 0,
           dealer: 0 }

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome
  prompt "Welcome to Twenty-one!"
  puts
  prompt "The goal of this game is to draw to 21."
  prompt "If you go over 21, you bust."
  prompt "Dealer hits to 17 exclusive."
  prompt "No splitting or doubling down."
  puts
  prompt "First to #{ROUNDS_TO_WIN} wins, wins the game!"
  puts
end

def initial_hand!(shoe)
  shoe.shuffle!.pop(STARTING_HAND_SIZE)
end

def display_initial_hand(player_hand, dealer_hand)
  prompt "The dealer has a #{dealer_hand[0]} and unknown card in hand."
  prompt "You have a #{player_hand[0]} and #{player_hand[1]} in hand."
  puts
end

def player_choice
  loop do
    prompt 'Do you hit or stay?'
    answer = gets.chomp.downcase
    if ['hit', 'stay'].include?(answer)
      return answer
    end
    prompt 'Sorry, pick a valid choice - hit or stay.'
    puts
  end
end

def player_stay(player_hand, player, player_total)
  prompt 'You\'ve chosen to stay.'
  puts
  display_hand(player_hand, player, player_total)
  prompt 'It\'s the dealer\'s turn!'
  sleep(0.5)
end

def hit!(shoe)
  shoe.shuffle!.pop
end

def hand_value(hand)
  final_value = CARDS.values_at(*hand).reduce(:+)
  counter = 0
  if hand.count('Ace') > 0 && final_value > BLACKJACK
    while final_value > BLACKJACK && counter != hand.count('Ace')
      final_value -= 10
      counter += 1
    end
  end
  final_value
end

def dealer_hit?(dealer_total)
  dealer_total < DEALER_STAY
end

def dealer_turn(shoe, dealer_hand, dealer_total)
  if dealer_hit?(dealer_total)
    dealer_hand << hit!(shoe)
  else
    dealer_hand
  end
end

def win_or_bust(hand_total)
  if hand_total > BLACKJACK
    'busts'
  elsif hand_total == BLACKJACK
    'wins'
  end
end

def determine_winner(player_total, dealer_total, player_hand, dealer_hand)
  if dealer_total > BLACKJACK ||
     player_total == BLACKJACK ||
     (player_total < BLACKJACK &&
      player_total > dealer_total)
    ['player', player_hand]
  else
    ['dealer', dealer_hand]
  end
end

def alternate_player(player)
  player == 'player' ? 'dealer' : 'player'
end

def display_round_winner(player_total, dealer_total,
                         player_hand, dealer_hand)
  player = determine_winner(player_total, dealer_total,
                            player_hand, dealer_hand)[0]
  hand = determine_winner(player_total, dealer_total,
                          player_hand, dealer_hand)[1]
  if player_total > BLACKJACK || dealer_total > BLACKJACK
    prompt "The #{alternate_player(player)} busts!"
  end
  if player_total == dealer_total
    prompt "It's a tie!"
  else
    prompt "The #{player} wins with #{hand}, totalling #{hand_value(hand)}!"
  end
  puts
end

def display_hand(hand, player, total)
  prompt "The #{player}'s hand is #{hand}."
  prompt "The #{player}'s hand value is #{total}."
  puts
end

def display_dealer_stay(player, dealer_total)
  if dealer_total < BLACKJACK
    prompt "The #{player} stays."
  end
end

def display_dealer_hits(player)
  prompt "The #{player} hits."
  sleep(0.5)
  puts
end

def increment_score(score, player_total, dealer_total, player_hand, dealer_hand)
  if player_total == dealer_total
    score
  else
    score[determine_winner(player_total, dealer_total,
                           player_hand, dealer_hand)[0].to_sym] += 1
  end
end

def display_scores(scores)
  prompt "The player has won #{scores[:player]} rounds."
  prompt "The dealer has won #{scores[:dealer]} rounds."
end

def score_check(scores)
  if scores.value?(ROUNDS_TO_WIN)
    scores.key(ROUNDS_TO_WIN)
  end
end

def display_game_winner(scores)
  if score_check(scores)
    puts
    prompt "The #{scores.key(ROUNDS_TO_WIN)} has won #{ROUNDS_TO_WIN} rounds!"
    prompt "The #{scores.key(ROUNDS_TO_WIN)} wins the game!"
    puts
    true
  end
end

def reset_score(score)
  score[:player] = 0
  score[:dealer] = 0
end

def play_again?
  input = nil
  loop do
    puts
    prompt 'Do you want to play again? Please enter \'yes\' or \'no\'.'
    input = gets.chomp.downcase
    if !['yes', 'y', 'n', 'no'].include?(input)
      prompt 'That\'s not a valid answer - please answer yes or no.'
    end
    break if ['yes', 'y', 'no', 'n'].include?(input)
  end
  ['yes', 'y'].include?(input)
end

def display_farewell
  puts
  prompt 'Thanks for playing Twenty-one!'
end

system 'clear'
display_welcome

loop do
  shoe = CARDS.keys * SUITS
  player_hand = initial_hand!(shoe)
  dealer_hand = initial_hand!(shoe)
  player_total = hand_value(player_hand)
  dealer_total = hand_value(dealer_hand)

  display_initial_hand(player_hand, dealer_hand)

  loop do
    break if win_or_bust(player_total)
    player = 'player'
    if player_choice == 'hit'
      prompt 'You\'ve chosen to hit.'
      player_hand << hit!(shoe)
      player_total = hand_value(player_hand)
      sleep(0.5)
      display_hand(player_hand, player, player_total)
      break if win_or_bust(player_total)
    else
      player_stay(player_hand, player, player_total)
      break
    end
  end

  loop do
    break if win_or_bust(player_total)
    player = 'dealer'
    display_hand(dealer_hand, 'dealer', dealer_total)
    if !dealer_hit?(dealer_total)
      display_dealer_stay(player, dealer_total)
      break
    end
    dealer_turn(shoe, dealer_hand, dealer_total)
    dealer_total = hand_value(dealer_hand)
    display_dealer_hits(player)
  end

  display_round_winner(player_total, dealer_total, player_hand, dealer_hand)
  increment_score(scores, player_total, dealer_total, player_hand, dealer_hand)
  display_scores(scores)

  reset_score(scores) if display_game_winner(scores)

  break unless play_again?
  system 'clear'
end

display_farewell
