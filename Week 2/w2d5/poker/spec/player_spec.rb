require 'rspec'
require './lib/player.rb'
require './lib/card.rb'

describe Player do
  
  describe "initializes with money" do
    let(:player) { Player.new(100) }
    it "should have the correct amount of money" do
      expect(player.money).to eq(100)
    end
  end
  
  describe "handling cards" do
    let(:player) { Player.new(100) }
    let(:cards) { Array.new(5) { Card.new(5, :hearts) } }
    it "takes cards" do
      player.give_cards(cards)
      expect(player.cards).to eq(cards)
    end
  end
end