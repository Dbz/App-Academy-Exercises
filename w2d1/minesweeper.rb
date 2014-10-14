# encoding: UTF-8
require 'yaml'

class Game
  def initialize
    @board = Board.new(9, 9)
    @board.populate_bombs(10)
  end
  def play
    system "clear" or system "cls"
    puts "Welcome to MiNeSwEePeR"
    position = [-1, -1]
    until game_over?
      display_board
      puts "Please choose a square to sweep (X Y), or place a flag (F X Y)  [or SAVE/LOAD]"
      position = get_input #until @board.valid_move? position[0..1]
      next if load_save(position.first)
      if position.last == "F"
        @board.flag position[0..1]
      else
        game_lost if @board.has_bomb? position
        @board.reveal position
      end
      system "clear" or system "cls"
    end
    end_message
  end
  
  def end_message
    puts "Good for you, this thankless job did not end your life this time!"
    @board.show_bombs
    display_board
  end
  
  def game_lost
    system "clear" or system "cls"
    puts "YOU JUST LOST THE GAME"
    @board.show_bombs
    display_board
    exit
    #delete_save #because we are HARD CORE
  end
  
  def delete_save
    File.delete("minesweeper_save") if File.exist?("minesweeper_save")
  end
  
  def save
    board = @board.to_yaml
    File.open("minesweeper_save", "w") do |f|
      f.puts board
    end
  end
  
  def load
    @board = YAML::load(File.read("minesweeper_save")) if File.exist?("minesweeper_save")
  end
  
  def load_save value
    if value == "SAVE"
      save
    elsif value == "LOAD"
      load
    else
      return false
    end
    system "clear" or system "cls"
    true
  end
  
  def display_board
    @board.display
  end
  
  def game_over?
    @board.game_over?
  end
  
  def get_input
    flag = false
    
    input = gets.chomp.split(" ")
    
    if input.first.upcase == "SAVE" || input.first.upcase == "LOAD"
      return [input.first.upcase]
    end
    
    if input.first == "F"
      flag = true
      input.shift
    end
    
    begin
      input.map! { |i| Integer(i) }
    rescue TypeError
      get_input
    end
    
    input << "F" if flag
    
    input
  end
    
end

class Board
  attr_accessor
  
  OFFSETS = [0, 1], [1, 0], [0, -1], [-1, 0], [-1, 1], [1, 1], [1, -1], [-1, -1]
  
  def initialize(width, height)
    @tiles = Array.new(height) { Array.new(width) { Tile.new } }
    @width, @height = width, height
    @bombs = 0
  end
  
  def populate_bombs(num)
    @bombs = 0
    until @bombs == num
      pos_x = (0...@height).to_a.sample
      pos_y = (0...@width).to_a.sample
      unless @tiles[pos_x][pos_y].has_bomb
        @tiles[pos_x][pos_y].set_bomb
        @bombs += 1
      end
    end
  end
  
  def display
    @tiles.each do |row|
      row.each do |tile|
        print tile.display_value.rjust(3)
      end
      puts
    end
  end
  
  def get_neighbors pos
    pos_x = pos[0]
    pos_y = pos[1]
    neighbors = []
    OFFSETS.each do |off_x, off_y|
      if valid_move?([off_x + pos_x, off_y + pos_y])
        neighbors << [off_x + pos_x, off_y + pos_y] 
      end
    end
    neighbors
  end
  
  def show_bombs
    @tiles.each do |row|
      row.each do |tile|
        if tile.has_bomb
          tile.display_value = "♱"
        end
      end
    end
  end
  
  def valid_move? pos
    return false if pos.nil?
    pos_x = pos[0]
    pos_y = pos[1]
    pos_x >= 0 && pos_x < @width &&
    pos_y >= 0 && pos_y < @height
  end
  
  def reveal(tile)
    pos_x, pos_y = tile[0], tile[1]
    our_tile = @tiles[pos_x][pos_y]
    return if our_tile.display_value != '⚛'
    return if our_tile.has_bomb
    bomb_count = 0
    neighbors = get_neighbors(tile)
    neighbors.each do |n_pos_x, n_pos_y|
      bomb_count += 1 if @tiles[n_pos_x][n_pos_y].has_bomb  
    end
    our_tile.display_value = bomb_count.to_s
    our_tile.display_value = "∷" if bomb_count == 0
    neighbors.each {|neighbor| reveal(neighbor) if bomb_count == 0}
  end
  
  def has_bomb?(pos)
    @tiles[pos[0]][pos[1]].has_bomb
  end
  
  def flag(pos)
    pos_x, pos_y = pos[0], pos[1]
    if @tiles[pos_x][pos_y].display_value == "⚑"
      @tiles[pos_x][pos_y].display_value = "⚛"
    elsif @tiles[pos_x][pos_y].display_value == "⚛"
      @tiles[pos_x][pos_y].display_value = "⚑"
    end
  end
  
  def game_over?
    flags_or_bombs = 0
    @tiles.each do |row|
      row.each do |tile|
        flags_or_bombs += 1 if tile.display_value == '⚛' || tile.display_value == "⚑"
      end
    end
    return true if flags_or_bombs == @bombs
    false
  end
end

class Tile
  attr_accessor :has_bomb, :has_flag, :display_value
  def initialize
    @display_value = "⚛"
    @has_flag, @has_bomb = false, false
  end
  def set_bomb
    @has_bomb = true
    # Remove later
    #@display_value = "B"
  end
end
  
game = Game.new
game.play