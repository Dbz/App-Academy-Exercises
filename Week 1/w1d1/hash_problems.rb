class MyHashSet
  def initialize
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store.has_key?(el)
  end
  
  def delete(el)
    if @store.include?(el)
      @store.delete(el)  
      true
    else
      false
    end
  end
  
  def to_a
    @store.keys
  end
  
  def union(set2)
    @store.keys | set2.to_a
  end
  
  def intersect(set2)
    @store.keys & set2.to_a
  end
  
  def minus(set2)
    elements = []
    @store.keys.each do |el|
      elements << el unless set2.include?(el)
    end
    elements
  end
    
end


hash1 = MyHashSet.new
hash1.insert("hello")
p hash1.include?("hello")
p hash1.delete("hllo")
p hash1.delete("hello")
hash1.insert("1")
hash1.insert("3")
hash1.insert("5")
hash1.insert("9")
p hash1.to_a.join(' ')
hash2 = MyHashSet.new
hash2.insert("1")
hash2.insert("3")
hash2.insert("4")
hash2.insert("8")
p hash1.union(hash2)
p hash1.intersect(hash2)
p hash1.minus(hash2)

