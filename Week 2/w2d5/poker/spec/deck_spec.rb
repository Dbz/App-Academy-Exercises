require 'rspec'
require './lib/deck.rb'

describe Deck do
  let(:deck) { Deck.new }
  describe '#initialize' do
    
    it 'has 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
    
    it 'has unique cards' do
      deck.cards.each do |card|
        expect(deck.cards.index(card)).to eq(deck.cards.rindex(card))
      end 
    end
  end
    
  it 'shuffles' do
    cards = deck.cards.dup
    deck.shuffle!
    expect(cards).not_to eq(deck.cards)
  end
    
  it 'returns the top cards' do
    cards = deck.cards.dup
    expect(deck[3]).to eq(cards[0...3])
  end
  
  it 'puts discards at the bottom' do
    discarded_cards = deck[2]
    cards = deck.cards.dup
    deck.discard(discarded_cards)
    expect(deck.cards).to eq(cards + discarded_cards)
  end
  
end