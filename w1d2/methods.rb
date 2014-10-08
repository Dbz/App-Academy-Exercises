def rps(move)
  options = ["Rock", "Paper", "Scissors"]
  computer_move = rand(3)
  user_move = options.index(move.capitalize)
  # if (computer_move - user_move) % 3 == 2
  case (computer_move - user_move) % 3
  when 0
    puts "#{options[computer_move]}, Tie"
  when 1
    puts "#{options[computer_move]}, Lose"
  when 2
    puts "#{options[computer_move]}, Win"
  end
end
#
# rps("Paper")
# rps("Paper")
# rps("Rock")
# rps("Scissors")

def remix pairs
  alcohols = pairs.map{ |pair| pair[0] }
  mixers = pairs.map{ |pair| pair[1] }
  
  mixed_pairs = alcohols.zip mixers.shuffle
  
  while mixed_pairs.any? { |pair| pairs.include? pair }
    mixed_pairs = alcohols.zip mixers.shuffle
  end
  
  mixed_pairs
end

# p remix([
#   ["rum", "coke"],
#   ["gin", "tonic"],
#   ["scotch", "soda"]
# ])