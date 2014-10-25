def guessing_game
  computer_number = rand(100) + 1
  player_number = nil
  
  while computer_number != player_number
    print "Please guess a number: "
    player_number = Integer(gets.chomp)
    if player_number < computer_number
      puts "Too low"
    elsif player_number > computer_number
      puts "Too high"
    end
  end
  
  puts "You got it!"
end

# guessing_game

def shuffle_file
  print "What file should we shuffle? "
  input_name = gets.chomp
  lines = File.readlines(input_name)
  lines.shuffle!
  File.open("#{input_name}-shuffled.txt","w") do |file|
    lines.each do |line|
      file.puts line
    end
  end
end

shuffle_file