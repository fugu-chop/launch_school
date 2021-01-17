require 'io/console'

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
    calculate_total > Twentyone::BLACKJACK
  end

  def blackjack?
    calculate_total == Twentyone::BLACKJACK
  end

  def calculate_total
    total = hand.reduce(0) do |sum, card|
      sum + Deck::CARD_VALUES[card]
    end

    if hand.include?('Ace') && total > Twentyone::BLACKJACK
      hand.count('Ace').times do |_|
        total -= 10
        break if total <= Twentyone::BLACKJACK
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

  def display_busted
    puts "You've busted!"
    puts
  end

  def display_blackjack
    puts "You've drawn to Twenty One!"
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
    puts
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
    puts "The dealer busts!"
    puts
  end

  def display_blackjack
    puts "The dealer has drawn to Twenty-one!"
    puts
  end
end

class Twentyone
  GAME_WIN = 3
  BLACKJACK = 21

  def initialize
    @human = Human.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    clear_screen
    display_welcome
    display_rules
    enter_to_continue
    loop do
      game_loop
      break unless play_again?
      clear_screen
    end
    display_goodbye
  end

  private

  attr_accessor :deck, :human, :dealer

  def clear_screen
    system 'clear'
  end

  def enter_to_continue
    puts "Please press any key to continue..."
    STDIN.getch
    clear_screen
  end

  def display_welcome
    puts "Welcome to Twenty One!"
    puts
  end

  def display_rules
    puts <<~MSG
    The goal of this game is to draw cards totalling #{BLACKJACK}.
    The value of a card is it's numerical value. King, Queen and Jack cards are worth 10. 
    Aces are worth either 1 or 11, depending on which value gets you closest to a score of #{BLACKJACK}.
    
    If any player's score exceeds #{BLACKJACK}, they bust and lose the game.
    The Dealer will hit until they reach a score of 17 or higher. 
    In the event of a tie, the dealer wins.
    
    The first player to win #{GAME_WIN} rounds, wins the game!
    MSG
    puts
  end

  def calculate_winner
    if (human.calculate_total > dealer.calculate_total && !human.blackjack? &&
       !human.busted?) || dealer.busted? || human.blackjack?
      "player"
    else
      "dealer"
    end
  end

  def display_result
    sleep(1)
    if human.calculate_total == dealer.calculate_total && !human.blackjack?
      puts "Hand values are tied. Remember that the dealer wins ties."
    end
    puts "The #{calculate_winner} wins this round!"
    puts
  end

  def deal_initial_hands
    [human, dealer].each do |participant|
      participant.deal_initial_hand(deck.shoe)
    end
  end

  def dealer_hit_sequence(deck)
    dealer.choose_action(deck.shoe)
    dealer.display_hit
    dealer.display_hand
  end

  def display_player_hit
    puts
    puts "You chose to hit!"
  end

  def display_player_stay
    puts
    puts "You chose to stay!"
  end

  def display_partial_hands
    dealer.display_first_hand
    human.display_hand
  end

  def display_full_hands
    clear_screen
    human.display_hand
    dealer.display_hand
  end

  def player_hit_sequence
    human.hit(deck.shoe)
    display_player_hit
  end

  def player_loop
    loop do
      clear_screen
      display_partial_hands
      break human.display_busted if human.busted?
      break human.display_blackjack if human.blackjack?
      break display_player_stay unless human.hit?
      player_hit_sequence
      sleep(1)
    end
  end

  def player_turn
    if human.blackjack?
      human.display_hand
      return human.display_blackjack
    end

    player_loop
  end

  def display_dealer_alt_states
    dealer.display_busted if dealer.busted?
    dealer.display_blackjack if dealer.blackjack?
  end

  def stay?
    !dealer.hit? && !dealer.blackjack? && !dealer.busted?
  end

  def dealer_turn
    sleep(1)
    display_full_hands
    loop do
      sleep(1)
      dealer_hit_sequence(deck) if dealer.hit?
      sleep(1)
      break dealer.display_stay if stay?
      break display_dealer_alt_states if !dealer.hit?
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? [y]es/[n]o"
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
    calculate_winner == 'player' ? human.score += 1 : dealer.score += 1
  end

  def display_scores
    puts "The player has won #{human.score} rounds."
    puts "The dealer has won #{dealer.score} rounds."
    puts
  end

  def grand_winner?
    human.score == GAME_WIN || dealer.score == GAME_WIN
  end

  def calculate_grand_winner
    return unless grand_winner?
    if human.score > dealer.score
      "player"
    else
      "dealer"
    end
  end

  def display_grand_winner
    puts "The #{calculate_grand_winner} wins the game with #{GAME_WIN} wins!"
    puts "Scores will be reset."
    puts
  end

  def score_reset
    [human, dealer].each do |participant|
      participant.score = 0
    end
  end

  def display_goodbye
    puts "Thanks for playing Twenty One! We hope to see you again soon."
  end

  def reset_state
    score_reset if grand_winner?
    reset_hands
  end

  def round_end_actions
    display_result
    increment_score
    display_scores
    display_grand_winner if grand_winner?
  end

  def game_loop
    deal_initial_hands
    player_turn
    dealer_turn unless human.busted? || human.blackjack?
    round_end_actions
    reset_state
  end
end

Twentyone.new.start
