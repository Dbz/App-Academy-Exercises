def merge_sort(arr)
  return arr if arr.length <= 1
  middle = arr.length / 2
  merge(merge_sort(arr[0...middle]), merge_sort(arr[middle..-1]))
end

def merge(arr1, arr2)
  result = []
  until arr1.empty? || arr2.empty?
    if arr1.first < arr2.first
      result << arr1.shift
    else
      result << arr2.shift
    end
  end
  result += (arr1 + arr2)
end

#p merge_sort((1..9).to_a.shuffle)
#p merge_sort([])