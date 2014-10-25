def make_change(amount, coins)
  return coins * (amount / coins.first) if coins.count == 1
  running_total = 0
  change = []
  coins.each do |coin|
    until running_total + coin > amount
      running_total += coin
      change << coin
    end
  end
  option = make_change(amount, coins[1..-1])
  if change.count < option.count
    return change
  else
    return option
  end
end

#p make_change(14, [10, 7, 1])

def subsets arr
  return [[]] if arr.empty?
  subset = [[arr.first]]
  arr[1..-1].each do |el|
    subset += subset.map { |element| [element].flatten + [el] }
  end
  subset + subsets(arr[1..-1])
end
    
#p subsets([1, 2])

def make_change2(amount, coins)
  return [] if coins.count == 0
  #change = []
  # if coins.first <= amount
  #   change << coins.first
  #   return change + make_change2(amount - coins.first, coins)
  # else
  #   return make_change2(amount, coins[1..-1])
  # end
  solutions = []
  coins.each do |coin|
    if coin <= amount
      solutions << [coin] + make_change2(amount - coin, coins).flatten
    # else
      # solutions << make_change2(amount, coins[1..-1]).flatten
    end
  end
  #p "solutions: #{solutions}"
  solutions.min_by { |el| el.size }
end

p make_change2(75, [25, 10, 7, 1])