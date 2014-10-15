# encoding: UTF-8
# require 'SlidingPiece.rb'
class Rook < SlidingPiece
  def initialize(pos, color, board)
    if color
      @symbol = "♖"
    else
      @symbol = "♜"
    end
    super
  end
  def move_dirs
    # moves returns [rows, cols, diags]
    moves[0..1]
  end
end