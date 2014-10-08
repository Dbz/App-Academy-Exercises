class Node
  attr_accessor :parent, :children, :value
  
  def initialize value, parent=nil
    @value = value
    @children = []
    @parent = parent
  end
end
