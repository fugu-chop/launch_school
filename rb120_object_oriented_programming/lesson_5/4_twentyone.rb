class Deck
  attr_accessor :shoe

  CARDS = ('2'..'10').to_a + ['Ace', 'King', 'Queen', 'Jack']
  CARD_VALUES = CARDS.zip((2..11).to_a + [10, 10, 10]).to_h

  def initialize
    @shoe = (CARDS * 4).shuffle
  end
end

class Player
  attr_accessor :hand, :score

  def initialize
    @hand = []
    @score = 0
  end

  def hit(deck)
    hand << deck.pop
  end

  def deal_initial_hand(deck)
    2.times { |_| hit(deck) }
  end

  def busted?
    calculate_total > 21
  end

  def blackjack?
    calculate_total == 21
  end

  def calculate_total
    total = hand.reduce(0) do |sum, card|
      sum += Deck::CARD_VALUES[card]
    end

    if hand.include?('Ace') && total > 21
      hand.count('Ace').times do |_|
        total -= 10
      end
    end

    total
  end
end

class Human < Player
  def display_hand
    puts "Your hand is #{hand.join(', ')}, totalling #{calculate_total}."
    puts
  end

  def hit?
    answer = nil
    loop do
      puts "Do you want to [h]it or [s]tay?"
      answer = gets.chomp.downcase
      break if ['h', 'hit', 's', 'stay'].include?(answer)
      puts "That's not a valid answer. Please try again!"
      puts
    end
    ['h', 'hit'].include?(answer)
  end

  def choose_action(deck)
    hit? ? hit(deck) : false
  end

  def display_busted
    puts "You've busted! Your total is #{calculate_total}!"
    puts
  end

  def display_blackjack
    puts "You've drawn to Twenty One! You win!"
    puts
  end
end

class Dealer < Player
  def hit?
    calculate_total < 17
  end

  def choose_action(deck)
    hit(deck) if hit?
  end

  def display_first_hand
    puts "The dealer's hand is #{hand.first} and another card."
  end

  def display_hand
    puts <<~MSG
    The dealer's hand is #{hand.join(', ')}, totalling #{calculate_total}.
    MSG
    puts
  end

  def display_hit
    puts "The dealer hits!"
    puts
  end

  def display_stay
    puts "The dealer stays on #{calculate_total}."
    puts
  end

  def display_busted
    puts "The dealer busts with a total of #{calculate_total}!"
    puts
  end

  def display_blackjack
    puts "Twenty-one! The dealer wins!"
    puts
  end
end

class Twentyone
  GAME_WIN = 3

  attr_accessor :deck, :human, :dealer

  def initialize
    @human = Human.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def display_welcome
    puts "Welcome to Twenty One!"
    puts
  end

  def display_rules
    puts <<~MSG
    The goal of this game is to draw cards totalling 21.
    The value of a card is it's numerical value. King, Queen and Jack cards are worth 10.
    Aces are worth either 1 or 11, depending on which value gets you closest to a score of 21.
    If any player's score exceeds 21, they bust and lose the game.
    The Dealer will hit until they reach a score of 17 or higher.
    In the event of a tie, the dealer wins.
    The first player to win #{GAME_WIN} rounds, wins the game!
    MSG
    puts
  end

  def calculate_winner
    if (human.calculate_total > dealer.calculate_total && !human.blackjack? &&
       !human.busted?) || dealer.busted? || human.blackjack?
      "Player"
    else
      "Dealer"
    end
  end

  def display_result
    puts "The #{calculate_winner} wins this round!"
    puts
  end

  def deal_initial_hands
    [human, dealer].each do |participant|
      participant.deal_initial_hand(deck.shoe)
    end
  end

  def display_initial_hands
    human.display_hand
    dealer.display_first_hand
    puts
  end

  def dealer_hit_sequence(deck)
    dealer.choose_action(deck.shoe)
    dealer.display_hit
    dealer.display_hand if !dealer.busted?
  end

  # ABC is too high
  def player_turn
    loop do
      break human.display_blackjack if human.blackjack?
      break if human.choose_action(deck.shoe) == false
      human.display_hand
      break human.display_busted if human.busted?
    end
    human.display_hand unless human.blackjack?
  end

  # I think a lot of the display methods here can be generalised to the Twentyone class
  # ABC is too high
  def dealer_turn
    dealer.display_hand
    loop do
      dealer_hit_sequence(deck) if dealer.hit?
      break dealer.display_busted if dealer.busted?
      break dealer.display_blackjack if dealer.blackjack?
      break dealer.display_stay unless dealer.blackjack?
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(answer)
      puts "That's not a valid answer - please try again!"
      puts
    end
    ['y', 'yes'].include?(answer)
  end

  def reset_hands
    @deck = Deck.new
    [human, dealer].each do |participant|
      participant.hand = []
    end
  end

  def increment_score
    calculate_winner == 'Player' ? human.score += 1 : dealer.score += 1
  end

  def display_scores
    puts "The player has won #{human.score} rounds."
    puts "The dealer has won #{dealer.score} rounds."
    puts
  end

  def display_goodbye
    puts "Thanks for playing Twenty One! We hope to see you again soon."
  end

  def game_loop
    deal_initial_hands
    display_initial_hands
    player_turn
    dealer_turn unless human.busted? || human.blackjack?
    display_result
    increment_score
    display_scores
    reset_hands
  end

  def start
    display_welcome
    display_rules
    loop do
      game_loop
      break unless play_again?
    end
    display_goodbye
  end
end

Twentyone.new.start
