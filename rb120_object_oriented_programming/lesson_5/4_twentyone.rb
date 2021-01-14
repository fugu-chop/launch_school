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

  # Should this be in the Deck class?
  # If not, how do we access the Deck class here?
  def hit(deck)
    hand << deck.pop
  end

  def deal_initial_hand(deck)
    2.times { |_| hit(deck) }
  end

  def stay
    # Display total, end turn
  end

  def busted?
    calculate_total > 21
  end

  def calculate_total
    @hand.reduce(0) do |sum, card|
      sum += Deck::CARD_VALUES[card]
    end
  end
end

class Human < Player
  def display_hand
  end

  def choose_action
  end
end

class Computer < Player
  def choose_action
  end
end

class Game
  attr_accessor :deck, :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
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
    Aces are worth either 1 or 11.
    If your score exceeds 21, you bust and lose.
    The Dealer hits to 17 exclusive.
    No splitting or doubling down.
    MSG
    puts
  end

  def player_turn
    human.deal_initial_hand(deck.shoe)
    display_hand
  end

  def display_hand
    puts "Your hand is currently #{human.hand.join(', ')}."
  end

  def start
    display_welcome
    display_rules
    player_turn
    # deal_cards
    # show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
    # play_again?
  end
end

Game.new.start
