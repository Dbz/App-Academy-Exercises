def find
  250.upto(Float::INFINITY).each do |num|
    return num if num % 7 == 0
  end
end

# p find

def factors(number)
  p (1..number).select { |fact| number % fact == 0 }
end

# p factors (100)

def bubble_sort(arr)
  arr.length.times do 
    (0...arr.length-1).each do |i|
      if arr[i] > arr[i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
      end
    end
  end
  arr
end

# p bubble_sort([2,123,5,6,3,9,8,12,6])

def substrings(word)
  substrings = []
  (0...word.length).each do |i|
    (0...word.length).each do |j|
      next if j < i
      substrings << word[i..j]
    end
  end
  substrings
end

# p substrings("cat")

def subwords(word)
  dictionary = File.readlines("dictionary.txt").map{ |i| i.chomp }
  strings = substrings(word)
  strings.select{|w| dictionary.include? w }
end

# p subwords('hippopotamus')