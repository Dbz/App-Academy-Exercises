require 'rspec'
require './lib/card.rb'

describe Card do
  
  describe "#initialize" do
    let(:card) { Card.new(8, :hearts) }
    
    it "knows its value" do
      expect(card.value).to eq(8)
    end
    
    it "knows its suit" do
      expect(card.suit).to eq(:hearts)
    end
    
  end
end