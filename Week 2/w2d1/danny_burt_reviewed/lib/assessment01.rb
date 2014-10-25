def factors(num)
  facts = []
  (1..num).each do |x|
    if num % x == 0
      facts << x
    end
  end
  facts
end

def fibs_rec(count)
  if count == 1
    return [0]
  elsif count == 2
    return [0, 1]
  end
  last = fibs_rec(count - 1)
  last << last[-1] + last[-2]
end

class Array
  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

  def bubble_sort!(&prc)
    #TA: prefer `self.count` over just `count`
    return self if count <= 1
    prc = Proc.new { |x, y| x <=> y } unless prc.class == Proc
    (0...self.count).each do |x|
      (0...self.count).each do |y|
        #TA: it's slightly more efficient to start your inner loop at x + 1
        # than to have this `next` check inside the loop
        next if y < x + 1
        self[x], self[y] = self[y], self[x] if prc.call(self[x], self[y]) == 1
      end
    end
    self
  end
end

#p [5, 4, 12, 20, 3, 2, 1, 9, 8, 17].bubble_sort

class Array
  def two_sum
    pairs = []
    (0...(self.count - 1)).each do |x|
      (x...self.count).each do |y|
        #TA: again, you could equally just start your inner loop at `x + 1`
        next if y < x + 1
        pairs << [x, y] if self[x] + self[y] == 0
      end
    end
    pairs
  end
end

# p [5, 1, -7, -5].two_sum

class String
  def subword_counts(dictionary)
    subs = Hash.new(0)
    (0...self.length).each do |x|
      (0...self.length).each do |y|
        subs[self[x..y]] += 1 if dictionary.include? self[x..y]
      end
    end
    subs
  end
end
