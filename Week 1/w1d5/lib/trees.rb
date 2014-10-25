class PolyTreeNode
  attr_accessor :value, :parent, :children
  
  def initialize(value, parent = nil)
    @value = value
    @children = []
    self.parent = parent
  end
  
  def parent=(node)
    #p "Parent first: #{@parent}"
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    (@parent.children << self) unless node.nil? || @parent.children.include?(self)
    #p "Parent second: #{@parent}"
  end
  
  def add_child node
    node.parent = self
  end
  
  def remove_child node
    raise "This ain't my kid" unless @children.include?(node)
    node.parent = nil
  end
  
  def dfs(target)
    return self if target == @value
    @children.each do |child|
      this_child = child.dfs(target)
      return this_child unless this_child.nil?
    end
    nil
  end
  
  def bfs target  
    queue = [self]
    until queue.empty?
      return queue[0] if queue.first.value == target
      queue += queue[0].children
      queue.shift
    end
    nil
  end
end
