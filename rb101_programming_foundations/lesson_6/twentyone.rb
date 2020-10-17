number_cards = (2..10).to_a.map(&:to_s)
face_cards = %w(King Queen Jack Ace)
cards = number_cards + face_cards
values = (2..10).to_a + [10, 10, 10, 11]
CARDS = Hash[cards.zip(values)]

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  prompt("Welcome to Twenty-one!")
  puts
  prompt("The goal of this game is to draw to 21.")
  prompt("If you go over 21, you bust.")
  prompt("Dealer hits to 17 exclusive.")
  prompt("Dealer wins on draws.")
  prompt("No splitting or doubling down.")
  puts
end

def initial_hand!(shoe)
  shoe.shuffle!.pop(2)
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
  CARDS.values_at(*hand).reduce(:+)
end

def dealer_choice(dealer_hand)
  hand_value(dealer_hand) < 17
end

def dealer_turn(shoe, dealer_hand)
  if dealer_choice(dealer_hand)
    dealer_hand << hit!(shoe)
  else
    dealer_hand
  end
end

def player_win_or_bust(hand)
  # How do I account for multiple aces?
  if hand_value(hand) > 21
    'busts'
  elsif hand_value(hand) == 21
    'wins'
  end
end

def win_or_bust_result(player, condition, hand)
  if condition == 'busts' || condition == 'wins'
    [player, condition, hand]
  end
end

system 'clear'
welcome

loop do
  shoe = CARDS.keys * 4
  player_hand = initial_hand!(shoe)
  dealer_hand = initial_hand!(shoe)

  print_initial_hands(player_hand, dealer_hand)
  loop do
    if player_choice == 'hit'
      player_hand << hit!(shoe)
      puts
      prompt("Your hand is #{player_hand}")
      break if player_win_or_bust(player_hand)
    else
      prompt("Your hand is #{player_hand}")
      puts
      break
    end
  end

  break if player_win_or_bust(player_hand)
  prompt('It\'s the dealer\'s turn!')
  puts
  loop do
    prompt("The dealer's hand is #{dealer_hand}")
    break if !dealer_choice(dealer_hand)
    dealer_turn(shoe, dealer_hand)
    prompt('The dealer hits.')
    puts
  end

  puts
  prompt('Do you want to play again? Please enter \'yes\' or \'no\'.')
  input = gets.chomp.downcase
  break unless input.start_with?('y')
  system 'clear'
end

puts
prompt('Thanks for playing Twenty-one!')

=begin
To DOs:
- win conditions
- Ace logic
=end
