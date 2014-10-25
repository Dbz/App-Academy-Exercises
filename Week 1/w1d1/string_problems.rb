def num_to_s(num, base)
  digits = []
  letters = %w(A B C D E F)
  
  i = 0
  while base**i < num
    new_digit = (num / (base ** i)) % base 
    if new_digit < 10
      digits << new_digit
    else 
      digits << letters[(new_digit-10)]
    end
    i+=1
  end
  digits.join.reverse
end
#
# p num_to_s(234, 2)


def caesar(str, shift)
  letter = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  cipher = ""
  str.each_char do |l|
    i = letter.index(l)
    if i + shift > 26
      cipher += letter[i + shift - 26]
    else
      cipher += letter[i+ shift]
    end
  end
  cipher
end

# p caesar("hello", 3)