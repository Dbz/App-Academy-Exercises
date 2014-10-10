class Array
  def my_each
    if block_given?
      i = 0
      while i < self.count
        yield(self[i])
        i += 1 
      end
    end
  end
  
  def my_map(&proc)
    newarr = []
    self.my_each { |item| newarr << proc.call(item) }
    newarr
  end
  
  def my_select
    if block_given?
      newarr = []
      self.my_each { |item| newarr << item if yield(item) }
      newarr
    end
  end
  
  def my_inject(&proc)
    result = self.first
    self[1..-1].my_each { |item| result = proc.call(result, item) }
    result
  end
  
  def my_sort!(&proc)
    self[0..-1].each_with_index do |item1, index1|
      self[0..index1].each_with_index do |item2, index2|
        response = proc.call(item1, item2)
        if response == -1
          self[index1], self[index2] = self[index2], self[index1]
        end
      end
    end
    self
  end
  def my_sort(&proc)
    self.dup.my_sort! { |item1, item2| proc.call(item1, item2) }
  end
end

#arr = [1, 2, 3, 4, 5]

#arr.my_each { |x| puts x }

#p arr.my_map { |x| x * x }

#p arr.my_select { |x| x > 3 }

# p arr.my_inject { |one, two| one + two }

# p [1, 3, 2, 6, 4].my_sort! { |num1, num2| num1 <=> num2 }
# p [1, 3, 2, 6, 4].my_sort! { |num1, num2| num2 <=> num1 }

# p [1, 3, 2, 6, 4].my_sort { |num1, num2| num1 <=> num2 }
# p [1, 3, 2, 6, 4].my_sort { |num1, num2| num2 <=> num1 }

# proc = Proc.new { |num1, num2| num2 <=> num1 }
# p [1, 3, 2, 6, 4].my_sort { |num1, num2| num2 <=> num1 }

def eval_block(*args, &prc)
  prc.call(*args)
end

def thing(one, two, three)
  
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end