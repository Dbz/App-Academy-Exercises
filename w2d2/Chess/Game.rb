# encoding: UTF-8
require_relative 'Board.rb'

class Game
  
  def initialize
    @board = Board.new
  end
  
  def play
    puts "Welcome to chess!"
    until check_mate?
      @board.display
      puts "White, it's your turn"
      move = get_valid_move
      @board.make_move(move)
      
      @board.display
      
      puts "Black, please move e.g. F5F6"
      move = get_valid_move
      @board.make_move(move)
    end
    puts "Game over!"
  end
  
  def check_mate?
    #@board.check_mate?
    false
  end
  
  def get_valid_move
      letters = %w(a b c d e f g h)
      input = gets.chomp.split("")
  
      start = [letters.index(input[0]), input[1].to_i]
      dest = [letters.index(input[2]), input[3].to_i]
      p dest
  
      piece = @board[start]
      
      p piece.to_s
      
      moves = piece.moves
      p moves
      
      unless moves.include?(dest)
        puts " not a valid move"
        get_valid_move
      end
      
      [piece, dest]
  end
      
end

g = Game.new
g.play