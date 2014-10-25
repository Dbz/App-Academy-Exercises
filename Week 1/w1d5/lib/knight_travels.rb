require './trees.rb'

class KnightPathFinder
  KNIGHT_OFFSETS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, -1],
    [-2, 1]
  ]
  def initialize start
    @root = PolyTreeNode.new(start)
    @visited_posistions = []
  end
  
  def build_move_tree
    queue = [@root]
    until queue.empty?
      new_move_posistions(queue[0].value).each do |move|
        queue << PolyTreeNode.new(move, queue[0])
      end
      queue.shift
    end
  end
  
  def new_move_posistions pos
    canidates = valid_moves(pos)
    new_moves = []
    canidates.each do |pos|
      next if @visited_posistions.include?(pos)
      new_moves << pos
      @visited_posistions << pos
    end
    new_moves
  end
  
  def valid_moves pos
    valids = []
    KNIGHT_OFFSETS.each do |vec|
      new_vec = [vec.first + pos.first, vec.last + pos.last]
      valids << new_vec if check_bounds?(new_vec)
    end
    valids
  end
  
  def check_bounds? pos
    (pos.first < 8 && pos.first > -1) &&
    (pos.last < 8 && pos.last > -1)
  end
  
  def find_path pos
    trace_path_back(@root.dfs(pos))
  end
  
  def trace_path_back node
    path = []
    until node == @root
      path << node.value
      node = node.parent
    end
    path << @root.value
    path.reverse
  end
end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new([5,4])
  k.build_move_tree
  p k.find_path([7,4])
end