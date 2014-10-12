class Peg
  attr_reader :color
  
  def initialize(colors = %w(R G B Y O P).sample)
    @color = colors
  end
  
end

class Game
  def initialize
    @messages = []
  end
  
  def play
    puts "Welcome to Mastermind."
    @turns = 10
    @pegs = Array.new(4) { Peg.new }
    p @pegs.map { |p| p.color }
    
    until game_over?
      get_user_input
      check_match
      display_match
      @turns -= 1
    end
    final_message
  end
  
  def get_user_input
    # FIX: doesn't like spaces in the input
    puts "Please pick your combination(R, G, B, Y, O, P)"
    @guessed_pegs = gets.chomp.upcase.scan(/[RGBYOP]{4}/).first.split('')
    #p "guessed_pegs: #{@guessed_pegs}"
    get_user_input if @guessed_pegs.nil? || @guessed_pegs.count != 4
  end
  
  def check_match
    correct_pegs = @pegs.map(&:dup)
    dup_guessed = @guessed_pegs.map(&:dup)
    @messages = []
    
    # Find right color right spot
    @guessed_pegs.each_with_index do |color, i|
      if @pegs[i].color == color
        correct_pegs[i] = ""
        @messages << "RR"
      end
    end
    
    #turn pegs into colors
    colors = []
    correct_pegs.each do |peg|
      colors << peg.color if peg.class != String
    end
    
    #Find right color wrong spot
    dup_guessed.each_with_index do |color, i|
      if colors.include? color
        @messages << "RW"
        colors.delete_at(i)
      end
    end
  end
  
  def display_match
    puts "Key Pegs: " + @messages.sort.join(", ")
  end
  
  def game_over?
    @turns == 0 || @messages.count("RR") == 4
  end
  
  def final_message
    if @messages.count("RR") == 4
      puts "Yay! You just won!"
    else
      puts "Sorry, you kind of suck at this!"
    end
  end
end

mastermind = Game.new
mastermind.play