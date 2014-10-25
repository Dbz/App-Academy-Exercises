require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    node.children.any? do |child|
      return child.prev_move_pos if child.winning_node? mark
    end
    node.children.each do |child|
      return child.prev_move_pos unless child.losing_node? mark
    end
    raise "WHAT THE FUCK?!? NO NON-LOSIG NODES!!!!!"
  end
end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
