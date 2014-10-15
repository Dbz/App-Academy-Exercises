# encoding: UTF-8
require_relative './Piece.rb'
class Pawn < Piece
  def initialize(pos, color, board)
    @has_moved = false
    if color
      @symbol = "♙"
    else
      @symbol = "♟"
    end
    super
  end
  
  def moves
    total_moves = []
    x, y = @pos[0], @pos[1]
    #Staring Move
    total_moves << [x, y + 2] unless @has_moved
    # Attack
    total_moves << [x+1, y+1] if @board.enemy_piece?([[x+1, y+1]], !@color)
    total_moves << [x-1, y+1] if @board.enemy_piece?([[x-1, y+1]], !@color)
    # Forward
    total_moves << [x, y+1] if @board[[x, y+1]].nil?
    
    total_moves
  end
  
  
end