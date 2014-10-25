class Hand
  attr_accessor :cards
  def initialize(cards)
    @cards = cards
    set_values
    @suits = @cards.map { |card| card.suit }.sort
  end
  
  
  
  def hand_value # straight vs pair
    value_array.each_with_index do |value, i|
      return i unless value == false
    end
  end
  
  def hand_rank # highest straight
    value_array.each_with_index do |value, i|
      return value unless value == false
    end
  end
  
  def value_array
    [
      high_card,
      is_pair?,
      is_two_pair?,
      is_three_of_a_kind?,
      is_straight?,
      is_flush?,
      is_full_house?,
      is_four_of_a_kind?,
      is_straight_flush?
    ].reverse
  end
  
  
  
  
  private
  
  def set_values
    @values_high = @cards.map { |card| card.value }.sort
    if @values_high.last == 14
      @values_low = @values_high[0..-2]
      @values_low << 1
      @values_low.sort
    else
      @values_low = @values_high
    end
  end
  
  def is_straight_flush?
    return @values_high.last if is_straight? && is_flush?
    false
  end
  
  def is_four_of_a_kind?
    value_hash = Hash.new(0)
    @values_high.each { |v| value_hash[v] += 1 }
    return @values_high[1] if value_hash.values.any? { |v| v == 4 }
    false
  end
  
  def is_full_house?
    value_hash = Hash.new(0)
    @values_high.each { |v| value_hash[v] += 1 }
    
    return @values_high[2] if value_hash.values.any? { |v| v == 3 } &&
      value_hash.values.any? { |v| v == 2 }
    false
  end
  
  def is_flush?
    return @values_high[-1] if @cards.all? { |card| card.suit == @cards[0].suit }
    false
  end
  
  def is_straight?
    return @values_high[-1] if (@values_high.first..@values_high.last).to_a == @values_high
    return @values_low[-1] if (@values_low.first..@values_low.last).to_a == @values_low
    false
  end
  
  def is_three_of_a_kind?
    value_hash = Hash.new(0)
    @values_high.each { |v| value_hash[v] += 1 }
    
    return @values_high[2] if value_hash.values.any? { |v| v == 3 }
    false
  end
  
  def is_two_pair?
    value_hash = Hash.new(0)
    @values_high.each { |v| value_hash[v] += 1 }
    
    pair_count = 0
    keys = []
    
    value_hash.each do |k, v|
      if v == 2
        pair_count += 1
        keys << k
      end
    end
    
    return keys.sort.last if pair_count == 2
    false
  end
  
  def is_pair?
    value_hash = Hash.new(0)
    @values_high.each { |v| value_hash[v] += 1 }
    
    value_hash.each do |k, v|
      if v == 2
        return k
      end
    end
    false
  end
  
  def high_card
    @values_high.last
  end
  
end