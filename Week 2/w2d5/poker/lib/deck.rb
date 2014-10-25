require './lib/card.rb'

class Deck
  attr_accessor :cards
  def initialize
    @cards = []
    (2..14).each do |x|
      suits = [:hearts, :clubs, :spades, :diamonds]
      suits.each do |suit|
        @cards << Card.new(x, suit)
      end
    end
  end
  
  def shuffle!
    @cards.shuffle!
  end
  
  def [](value)
    @cards.shift(value)
  end
  
  def discard(cards)
    @cards += cards
  end
end