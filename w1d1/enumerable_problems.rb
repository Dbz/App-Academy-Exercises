def multiply_by_two(arr)
  arr.map {|element| element * 2 }
end

#puts multiply_by_two([2,3,4])

class Array
  def my_each
    idx = 0
    while idx < self.length
      yield(self[idx])
      idx+=1
    end
    self     
  end
  
end

return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

def median(arr)
  arr.sort!  
  len = arr.length
  if len % 2 == 0
    (arr[len / 2] + arr[len / 2 - 1]) / 2.0
  else
    arr[len / 2]
  end 
end


p median([1, 5, 7, 3, 12])
p median([1, 5, 7, 3, 12, 13])

def concat(arr)
  arr.inject(:+) #{|accum, el| accum}
end

p concat(['qon', 'rty'])

