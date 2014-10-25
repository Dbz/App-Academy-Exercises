require 'hand.rb'
require 'card.rb'

class Player
  attr_accessor :pot, :money, :cards
  def initialize(money)
    @pot = 0
    @money = money
  end
  
  def give_cards(cards)
    if @hand.is_a? Hand
      @hand.cards += cards
    else
      @hand = Hand.new(cards)
    end
  end

  def discard
    puts "Please choose up to three cards to discard e.g. 135"
    diplay_hand
    cards = gets.chomp.split("").map { |i| i.to_i - 1 }
    discards = []
    cards.each do |i|
      discards << @hand.card[i]
    end
    cards.each do |i|
      @hand.cards.delete_at(i)
    end
    discards
  end

  def display_hand
    cards.each_with_index do |card, i|
      print "(#{i+1})|#{card.value}:#{card.suit}|"
    end
  end

  def action(amount)
    puts "Would you like to fold, call, or raise? (f, c, or r)"
    input = gets.chomp.downcase
    if input == "f"
      cards = []
      return cards << @hand.cards.pop until @hand.cards.empty?
    elsif input == "c"
      if amount > @money
        @pot += @money
        t = @money
        @money = 0
        return t
      else
        @pot += amount
        @money -= amount
        return amount
      end
    else
      puts "How much money would you like to raise by?"
      input = gets.chomp.to_i
      if amount + input > money
        raise "You just raised to more money than you have!"
      else
        @pot += amount + input
        @money -= amount + input
        return amount + input
      end
    end
  end
  
  def cards
    @hand.cards
  end
end