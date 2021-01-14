=begin
Nouns: card, player, dealer, participant, deck, game, total
Verbs: deal, hit, stay, busts

Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start
=end

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
    @hand.reduce(0) do |sum, card|
      sum += Deck::CARD_VALUES[card]
    end
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
    puts "The dealer busts with a total of #{calculate_total}!"
    puts
  end

  def display_blackjack
    puts "Blackjack! The dealer wins with #{calculate_total}!"
    puts
  end
end

class Twentyone
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
    No splitting or doubling down.
    MSG
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

  def player_turn
    loop do
      break if human.choose_action(deck.shoe) == false
      human.display_hand
      # Add in logic here for break, bust, stay?
      break if human.calculate_total >= 21
    end
    human.display_hand
  end

  # I think a lot of the display methods here can be generalised to the Twentyone class
  def dealer_turn
    dealer.display_hand
    loop do
      if dealer.hit?
        dealer_hit_sequence(deck)
        # Can we generalise the break statements here?
      elsif dealer.busted?
        dealer.display_busted
        break
      elsif dealer.blackjack?
        dealer.display_blackjack
        break
      else
        dealer.display_stay
        break
      end
    end
  end

  def start
    display_welcome
    display_rules
    deal_initial_hands
    display_initial_hands
    player_turn
    dealer_turn
    # show_result
    # play_again?
  end
end

Twentyone.new.start
