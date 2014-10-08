class Board
  attr_reader :board
  
  def initialize(board = Array.new(3) { Array.new(3, nil) } )
    @board = board
  end
  
  def won?
    %w[X O].include? winner
  end
    
  def winner
    directions = [[1,0], [0,1], [1,1], [1,-1]]
    (0..2).each do |r|
      (0..2).each do |c|
        directions.each do |r_dir, c_dir|
          next unless (0..2).include? (r + 2 * r_dir)
          next unless (0..2).include? (c + 2 * c_dir)
          %w[X O].each do |mark|
            return mark if (0..2).all? do |i|
              @board[r + r_dir * i][c + c_dir * i] == mark
            end
          end
        end
      end
    end

    nil
  end
  
  def empty? pos
    r, c = pos
    @board[r][c].nil?
  end
  
  def place_mark pos, mark
    false unless empty? pos
    r,c = pos
    @board[r][c] = mark
    true
  end
  
  def dup
    Board.new(self.board.map(&:dup))
  end
  
  def display
    @board.each do |row|
      p row
    end
  end
end

class Game
  attr_reader :board
  
  def initialize player1, player2
    @board = Board.new #maybe add arguments
    @players = [player1, player2]
  end
  
  def play
    puts "Hello! Welcome to Tic-Tac-Toe!"
    until @board.won?
      @board.display
      @players.each_with_index do |player, i|
        @board.place_mark(player.get_move(@board), player.symbol)
        if @board.won?
          puts "Player #{i+1} wins!"
          @board.display
          return
        end
      end
    end
  end
end

class Player
  attr_reader :symbol
  
  def initialize(symbol)
    @symbol = symbol
  end
end

class HumanPlayer < Player
  def get_move(board)
    loop do
      print "Please enter the coords for your move (r, c): "
      pos = gets.chomp.scan(/[1-3]/).map { |x| Integer(x) - 1 }
      if board.empty? pos
        return pos
      else
        puts "Sorry, you can't go there."
      end
    end
  end
end

class ComputerPlayer < Player
  def get_move(board)
    (0..2).each do |row|
      (0..2).each do |col|
        temp_board = board.dup
        if temp_board.place_mark([row,col], self.symbol)
          return [row, col] if temp_board.won?
        end
      end
    end
    
    #no winning solution found
    possible_moves = []
    (0..2).each do |r|
      (0..2).each do |c|
        possible_moves << [r,c] if board.empty? [r,c]
      end
    end
    
    possible_moves.sample
  end
end

game = Game.new(HumanPlayer.new('X'), ComputerPlayer.new('O'))
game.play