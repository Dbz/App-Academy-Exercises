def range(start, finish)
  return [] if start > finish
  # return [s] if s == e
  [start] + range(start + 1, finish)
end

#p range(1, 10)

def sum_r(arr)
  return 0 if arr.empty?
  
  arr.pop + sum_r(arr)
end

#p sum_r([1,2,3,4,5])

def sum_i(arr)
  i = 0
  sum = 0
  while i < arr.length
    sum += arr[i]
    i += 1
  end
  sum
end

#p sum_i([1,2,3,4,5])

# If n == 256, then there are 

def exponentiation1(b, n, times = 0)
  times += 1
  if n == 0
    p times
    return 1 
  end
  b * exponentiation1(b, n - 1, times)
end

# p exponentiation1(2, 8)

def exponentiation2(b, n, times = 0)
  times += 1
  if n == 0
    p times
    return 1
  end
  if n.even?
    exponentiation2(b, n / 2, times) ** 2
  else
    b * (exponentiation2(b, (n - 1) / 2, times) ** 2)
  end
end

# p exponentiation2(2, 8)

def deep_dup(arr)
  # return [arr].first if [arr].flatten.length == 1
  new_arr = []
  arr.each do |item|
    if item.is_a?(Array)
      new_arr << deep_dup(item)
    else
      new_arr << item
    end
  end
  new_arr
end

# p deep_dup([1, [2], [3, [4]]])

def fib_i(n)
  arr = [1, 1]
  return arr[0...n] if n <= 2
  (n - 2).times do
    arr << arr[-1] + arr[-2]
  end
  arr
end

#p fib_i(2)

def fib_r(n)
  if n == 0
    return []
  elsif n == 1
    return [0]
  elsif n == 2
    return [0, 1]
  end
  
  next_fib = fib_r(n - 1) #=> [0, 1]
  next_fib << (next_fib[-1] + next_fib[-2])
end

# p fib_r(5)


def bsearch(arr, target)
  return nil if arr.empty?

  middle = arr.length / 2
  return middle if arr[middle] == target
  
  if arr[middle] > target
    bsearch(arr[0...middle], target)
  else
    value = bsearch(arr[(middle + 1)..-1], target)
    # return nil if value.nil?
    # middle + 1 + value
    value.nil? ? nil : middle + 1 + value
  end
end

# p bsearch([1, 2, 3, 4, 5], 3)
# p bsearch((1..100).to_a, 101)

def make_change(amount, coins = [25, 10, 5, 1])
  return coins * (amount / coins.last) if coins.count == 1
  
  running_sum = 0
  combo = []
  coins.each do |coin|
    until running_sum + coin > amount
      combo << coin
      running_sum += coin
    end
  end
  other_change = make_change(amount, coins[1..-1])
  if combo.length < other_change.length
    combo
  else
    other_change
  end
end


#p make_change(14, [10, 7, 1])
def choose_lower(a, b)
  if a.empty?
    b
  elsif b.empty?
    a
  elsif a.first < b.first
    [a.shift]
  elsif b.first < a.first
    [b.shift]
  else
    [a.shift]
  end
end

def merge_sort(arr)
  return arr if arr.length <= 1
  i = 0
  new_arr = []
  while i < arr.length() -1
    while arr[i].count + arr[i+1].count > 0
      new_arr << choose_lower(arr[i], arr[i+1])
    end
    merge_sort(new_arr)
    i += 2
  end
end

# def merge(arr1, arr2)
#   arr1 + arr2
# end
#
# def subsets(arr)
#   arr_subsets = []
#   arr.length.times { |x| arr_subsets += arr.combination(x).to_a }
#   arr_subsets << arr
#   arr_subsets
# end

# p subsets([1,2,3])

p merge_sort([[2],[1],[3]])

