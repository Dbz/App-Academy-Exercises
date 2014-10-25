class Array
  def my_uniq
    answer = []
    self.each { |x| answer << x  unless answer.include?(x) }
    answer
  end 
  
  def two_sum
    answer = []
    self.each_with_index do |el1, idx1|
      self.each_with_index do |el2, idx2|
        next unless idx2 > idx1
        answer.push([idx1, idx2]) if (el1 + el2) == 0 
      end
    end
    answer
  end
end

puts 'my uniq'
puts [1,2,3,3,4,5,6,6,1,7].my_uniq

puts 'two sum'
p [-1, 0, 2, -2, 1].two_sum


whole_pile = [[4,3,2,1], [], []]
def play_ball
  while whole_pile.last != [4, 3, 2, 1]
    p whole_pile
    puts "Which pile would you like to select a disk from? (1, 2, 3)"
    source = gets.chomp.to_i
    puts "Which pile would you like to put this disk on?"
    destination = gets.chomp.to_i

    if whole_pile[destination - 1].last.nil? || 
            whole_pile[destination-1].last > whole_pile[source - 1].last
      whole_pile[destination - 1] << whole_pile[source - 1].pop
    end
  end
end

# class HanoiGame
#
#   def initialize(num_discs)
#     @towers
#   end
#
# def display_game
# end
#
# def get_user_input
#   # get, validate input
#   [source, destination]
# end
#
# def validate_move(source, destination)
# end
#
# def game_won?
# end
#
# def play
#   until game_won?
#     display_game
#     get_input...
#   end
# end


def my_transpose(matrix)
  transposed_array = Array.new( Array.new ) 
  matrix.each_with_index do |row, i|
    # transposed_array << Array.new(matrix.length, Array.new(matrix[i].length))
    row.each_with_index do |x, j|
      transposed_array[j][i] = x
    end
  end
  transposed_array
end

p my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])

def stock_picker(arr)
  diff = 0
  days = []
  arr.each_with_index do |price1, i|
    arr.each_with_index do |price2, j|
      next if j <= i
      if price2 - price1 > diff
        diff = price2-price1
        days = [i, j]
      end
    end
  end
  days
end

puts stock_picker([2,2,4,8,3,1,10])

