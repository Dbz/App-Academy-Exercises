# encoding: UTF-8
# require_relative 'SlidingPiece.rb'

class Bishop < SlidingPiece
  def initialize(pos, color, board)
    super
    if color
      @symbol = "♗"
    else
      @symbol = "♝"
    end
      
  end
  
  def move_dirs
    # moves returns [rows, cols, diags]
   moves[2]
  end
  
end
