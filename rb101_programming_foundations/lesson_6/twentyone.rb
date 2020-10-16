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
  prompt("The goal of this game is to get to 21 before the dealer does.")
  prompt("If you go over 21, you bust.")
  prompt("Dealer hits until 17.")
  prompt("Dealer wins on draws.")
  prompt("No splitting or doubling down.")
  puts
end

def initial_hand(shoe)
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

def dealer_choice(shoe, dealer_hand)
  if CARDS.values_at(*dealer_hand).reduce(:+) < 17
    hit!(shoe)
  end
end

def dealer_turn(shoe, dealer_hand)
  if dealer_choice(shoe, dealer_hand)
    dealer_hand << dealer_choice(shoe, dealer_hand)
  else
    dealer_hand
  end
end

def player_turn(player_choice, shoe, player_hand)
  if player_choice == 'hit'
    player_hand << hit!(shoe)
  else
    player_hand
  end
end

def value_check(hand)
  # How do I account for multiple aces?
  if CARDS.values_at(*hand).reduce(:+) > 21
    return 'Bust!'
  elsif CARDS.values_at(*hand).reduce(:+) == 21
    return 'Winner!'
  end
end


# Main game loop
system 'clear'
welcome

loop do
  shoe = CARDS.keys * 4
  player_hand = initial_hand(shoe)
  dealer_hand = initial_hand(shoe)

  print_initial_hands(player_hand, dealer_hand)
  loop do
    player_turn(player_choice, shoe, player_hand)
    p player_hand
    p value_check(player_hand)
    
    dealer_turn(shoe, dealer_hand)
  end

end
