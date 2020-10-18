number_cards = (2..10).to_a.map(&:to_s)
face_cards = %w(King Queen Jack Ace)
cards = number_cards + face_cards
values = (2..10).to_a + [10, 10, 10, 11]
CARDS = Hash[cards.zip(values)]
DEALER_STAY = 17
BLACKJACK = 21
SUITS = 4
STARTING_HAND_SIZE = 2

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  prompt("Welcome to Twenty-one!")
  puts
  prompt("The goal of this game is to draw to 21.")
  prompt("If you go over 21, you bust.")
  prompt("Dealer hits to 17 exclusive.")
  prompt("No splitting or doubling down.")
  puts
end

def initial_hand!(shoe)
  shoe.shuffle!.pop(STARTING_HAND_SIZE)
end

def print_initial_hands(player_hand, dealer_hand)
  prompt("The dealer has a #{dealer_hand[0]} and unknown card in hand.")
  prompt("You have a #{player_hand[0]} and #{player_hand[1]} in hand.")
  puts
end

def player_choice
  loop do
    prompt('Do you hit or stay?')
    answer = gets.chomp.downcase
    if ['hit', 'stay'].include?(answer)
      return answer
    end
    prompt('Sorry, pick a valid choice - hit or stay.')
    puts
  end
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

def dealer_hit?(dealer_hand)
  hand_value(dealer_hand) < DEALER_STAY
end

def dealer_turn(shoe, dealer_hand)
  if dealer_hit?(dealer_hand)
    dealer_hand << hit!(shoe)
  else
    dealer_hand
  end
end

def win_or_bust(hand)
  if hand_value(hand) > BLACKJACK
    'busts'
  elsif hand_value(hand) == BLACKJACK
    'wins'
  end
end

def determine_winner(player_hand, dealer_hand)
  if hand_value(dealer_hand) > BLACKJACK ||
     hand_value(player_hand) == BLACKJACK ||
     (hand_value(player_hand) < BLACKJACK &&
      hand_value(player_hand) > hand_value(dealer_hand))
    ['player', player_hand]
  else
    ['dealer', dealer_hand]
  end
end

def alternate_player(player)
  player == 'player' ? 'dealer' : 'player'
end

def display_winner(player_hand, dealer_hand)
  player = determine_winner(player_hand, dealer_hand)[0]
  hand = determine_winner(player_hand, dealer_hand)[1]
  if hand_value(player_hand) > BLACKJACK || hand_value(dealer_hand) > BLACKJACK
    prompt("The #{alternate_player(player)} busts!")
  end
  if hand_value(player_hand) == hand_value(dealer_hand)
    prompt("It's a tie!")
  else
    prompt("The #{player} wins with #{hand}, totalling #{hand_value(hand)}!")
  end
  puts
end

def display_hand(hand, player)
  prompt("The #{player}'s hand is #{hand}.")
  prompt("The #{player}'s hand value is #{hand_value(hand)}.")
end

system 'clear'
welcome

loop do
  shoe = CARDS.keys * SUITS
  player_hand = initial_hand!(shoe)
  dealer_hand = initial_hand!(shoe)

  print_initial_hands(player_hand, dealer_hand)
  loop do
    player = 'player'
    break if win_or_bust(player_hand)
    if player_choice == 'hit'
      prompt('You\'ve chosen to hit.')
      player_hand << hit!(shoe)
      display_hand(player_hand, player)
      puts
      break if win_or_bust(player_hand)
    else
      prompt('You\'ve chosen to stay.')
      display_hand(player_hand, player)
      puts
      prompt('It\'s the dealer\'s turn!')
      break
    end
  end

  puts
  loop do
    player = 'dealer'
    break if win_or_bust(player_hand)
    display_hand(dealer_hand, player)
    puts
    break if !dealer_hit?(dealer_hand)
    dealer_turn(shoe, dealer_hand)
    prompt("The #{player} hits.")
    puts
  end

  display_winner(player_hand, dealer_hand)

  prompt('Do you want to play again? Please enter \'yes\' or \'no\'.')
  input = gets.chomp.downcase
  break unless input.start_with?('y')

  system 'clear'
end

puts
prompt('Thanks for playing Twenty-one!')
