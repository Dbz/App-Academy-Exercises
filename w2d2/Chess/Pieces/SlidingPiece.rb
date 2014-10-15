# require_relative 'Piece.rb'
class SlidingPiece < Piece
  
  def initialize(pos, color, board)
    super    
  end
  
  def moves
    x , y = @pos[0], @pos[1]
    
    columns = (0...8).map {|n| [n, y] }
    rows = (0...8).map {|n| [x, n] }
    
    diagonal1 = []
    diagonal2 = []
    
    (-7...8).each do |n|
      diagonal1 << [x + n, y + n]
      diagonal2 << [x + n, y - n]
    end
    
    diagonal1.select! { |pos| in_bounds? pos }
    diagonal2.select! { |pos| in_bounds? pos }
    
    [
      valid_pos(rows), 
      valid_pos(columns), 
      valid_pos(diagonal1) + valid_pos(diagonal2)
    ]
  end
  
  def valid_pos(arr)
    valid_slides = []
    starting = arr.index(@pos)
    ((starting + 1)...arr.length).each do |i|
      p arr[i]
      if @board[arr[i]].nil?
        valid_slides << arr[i]
      elsif @board.enemy_piece?(arr[i], !@color)
        valid_slides << arr[i]
        break
      else
        break
      end
    end
    
    (0...starting).each do |i|
      if @board[arr[i]].nil?
        valid_slides << arr[i]
      elsif @board.enemy_piece?(arr[i], !@color)
        valid_slides << arr[i]
        break
      else
        break
      end
    end
    
    valid_slides
  end
  
end