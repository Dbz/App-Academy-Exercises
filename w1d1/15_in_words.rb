class Fixnum
  def in_words
    one_digit = %w[zero one two three four five six seven eight nine]
    special = %w(ten eleven twelve thirteen fourteen fifteen
      sixteen seventeen eighteen nineteen)
    two_digit = %w(ten twenty thirty forty fifty sixty seventy eighty ninety)
    multi_digit = %w(hundred thousand million billion trillion)
    words = []
    # Split into bits of three bytes
    bits = []
    num = self.to_s.reverse
    i = 0
    while i < num.length
      bits << num[i...i+3]
      i += 3
    end
    
    bits.each_with_index do |byte, idx1|
      byte.split("").each_with_index do |n, idx|
        if idx == 2
          next if n == "0"
          words << one_digit[n.to_i] + " hundred"
        elsif idx == 1
          if n == "1"
            words.pop
            if idx1 != 0
              words << multi_digit[idx1]
            end
            words << (special[byte[idx - 1].to_i]) 
            next
          elsif n != "0"
            words << two_digit[n.to_i - 1]
          end
        elsif idx == 0
          #next if n == "0" && byte.length > 1
          #next if n == "0" && byte.length > 2
          if idx1 == 0
            next if n == "0" && byte.length > 1
            words << one_digit[n.to_i]
          else
            next if byte == "000" 
            if n != "0"
              words << one_digit[n.to_i] + " " +  multi_digit[idx1]
            else
              words << multi_digit[idx1]
            end
          end
        end
      end
    end
    words.reverse.join(" ")
  end
end

# 1,234,567,890
#puts 1234567890.in_words
#1,000,001
puts 1888259040036.in_words

