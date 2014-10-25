require 'rspec'
require './lib/card.rb'
require './lib/deck.rb'
require './lib/hand.rb'

describe Hand do
  
  deck = Deck.new
  suits = [:hearts, :spades, :diamonds, :clubs]
  
  describe '#initialize' do
    hand = Hand.new(deck[5])

    it 'has five cards' do
      expect(hand.cards.count).to eq(5)
    end
  end

  describe "gives the correct value of the hand" do
    context "when straight flush" do
      let(:straight_flush) do
        straight_flush = []
        (2..6).each do |x|
          straight_flush << Card.new(x, :hearts)
        end
        Hand.new(straight_flush)
      end

      it "returns value of 0" do
        expect(straight_flush.hand_value).to eq(0)
      end
    end

    context "when four of a kind" do
      let(:four_of_a_kind) do
        four_of_a_kind = []
        4.times do
          four_of_a_kind << Card.new(7, suits.sample)
        end
        four_of_a_kind += deck[1]
        Hand.new(four_of_a_kind)
      end

      it "returns value of 1" do
        expect(four_of_a_kind.hand_value).to eq(1)
      end
    end

    context "when full house" do
      let(:full_house) do
        f_h = []
        3.times do
          f_h << Card.new(7, :hearts)
        end
        2.times do
          f_h << Card.new(2, :spades)
        end
        Hand.new(f_h)
      end

      it "returns a value of 2" do
        expect(full_house.hand_value).to eq(2)
      end
    end

    context "flush" do
      let (:flush) do
        deck.shuffle!
        f = deck[5]
        f.map! { |c| c.suit = :hearts; c }
        Hand.new(f)
      end

      it "returns value of 3" do
        expect(flush.hand_value).to eq(3)
      end
    end

    context "straight" do
      let(:straight) do
        s = []
        (5..9).each do |x|
          s << Card.new(x, suits.sample)
        end
        Hand.new(s)
      end

      it "returns value of 4" do
        expect(straight.hand_value).to eq(4)
      end
    end

    context "three of a kind" do
      let(:three_of_a_kind) do
        t_k = [Card.new(6, :clubs), Card.new(5, :clubs)]
        3.times do
          t_k << Card.new(7, suits[0...3].sample)
        end
        Hand.new(t_k)
      end

      it "returns value of 5" do
        expect(three_of_a_kind.hand_value).to eq(5)
      end
    end

    context "two pair" do
      let(:two_pair) do
        t_p = [
          Card.new(5, :hearts),
          Card.new(5, :hearts),
          Card.new(6, :clubs),
          Card.new(6, :clubs),
          Card.new(7, :hearts)
        ]
        Hand.new(t_p)
      end

      it "returns a value of 6" do
        expect(two_pair.hand_value).to eq(6)
      end
    end

    context "pair" do
      let(:pair) do
        Hand.new(
        [
          Card.new(5, :hearts),
          Card.new(5, :hearts),
          Card.new(6, :clubs),
          Card.new(8, :clubs),
          Card.new(7, :hearts)
        ]
        )
      end

      it "returns a value of 7" do
        expect(pair.hand_value).to eq(7)
      end
    end

    context "high card" do
      let(:high_card) do
        Hand.new(
        [
          Card.new(5, :hearts),
          Card.new(6, :hearts),
          Card.new(11, :clubs),
          Card.new(8, :clubs),
          Card.new(7, :hearts)
        ]
        )
      end
      it "returns a value of 8" do
        expect(high_card.hand_value).to eq(8)
      end
    end
  end
  
  describe "finds the right hand in a tiebreaker" do
    let(:pair) do
      Hand.new(
      [
        Card.new(5, :hearts),
        Card.new(5, :hearts),
        Card.new(6, :clubs),
        Card.new(8, :clubs),
        Card.new(7, :hearts)
      ]
      )
    end
      
    let(:higher_pair) do
      Hand.new(
      [
        Card.new(5, :hearts),
        Card.new(6, :hearts),
        Card.new(6, :clubs),
        Card.new(8, :clubs),
        Card.new(7, :hearts)
      ]
      )
    end
      
    
    it "should return true" do
      expect(higher_pair.hand_rank).to be > pair.hand_rank
    end
      
  end
end
