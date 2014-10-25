require_relative 'tic_tac_toe'
require 'debugger'
class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.winner == opposite(evaluator)
      return false if @board.winner == evaluator || @board.winner.nil?
    end
    
    if next_mover_mark == evaluator
      return true if children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
      return true if children.any? do |child|
        child.losing_node?(evaluator)
      end
    end
    false 
    
    # if @board.winner == opposite(evaluator)
#       return true
#     elsif @board.over?
#       return false
#     end
#
#     return true if children.all? do |child|
#       child.losing_node?(evaluator)
#       #child.losing_node?(opposite(evaluator))
#     end
#     return true if children.any? do |child|
#       child.losing_node?(opposite(evaluator))
#     end
#     return true
  end

  def winning_node?(evaluator)
    if @board.winner == opposite(evaluator)
      return false
    elsif @board.over?
      return true
    end
    children.each do |child|
      return false if child.winning_node?(opposite(evaluator))
    end
    true
  end
  
  def opposite(mark)
    if mark == :o
      :x
    else
      :o
    end
  end

  def children
    child_pile = []
    (0..2).each do |row|
      (0..2).each do |pos|
        if @board[[row, pos]].nil?
          board_copy = @board.dup
          board_copy[[row, pos]] = @next_mover_mark
          #board_copy.rows.each { |row| p row }
          #p ' '
          child_pile << TicTacToeNode.new(
            board_copy,
            opposite(@next_mover_mark), 
            [row, pos]
          )
        end
      end
    end
    child_pile
  end
end

 # node = TicTacToeNode.new(Board.new(), :x)
 # p node.children