require_relative 'tree'

class MazeSolver
  attr_reader :start, :end, :maze
  
  def initialize filename
    @maze = File.read(filename).each_line.map do |line|
      line.scan(/./)
    end
    @maze.each_with_index do |row, row_ind|
      if row.include? 'S'
        @start = [row_ind, row.index('S')]
      end
      if row.include? 'E'
        @end = [row_ind, row.index('E')]
      end
    end
  end
  
  def solve
    display
    puts
    puts
    puts
    paths = [Node.new(@start)]
    @visited = []
    until paths.first.value == @end
      if paths.empty?
        raise "No paths left! The maze is broken!"
      end
      current_path = paths.shift
      
      neighbors = get_neighbors(current_path)
      neighbors.each do |node|
        @visited << node.value
        paths << node
      end
    end
    puts "Found a solution!"
    # puts paths.first
    render_path paths.last.parent
    display
  end
  
  def render_path node
    until node.value == @start
      r, c = node.value
      maze[r][c] = '+'
      node = node.parent
    end
  end
  
  def display
    maze.each do |row|
      row.each do |char|
        print char
      end
      puts
    end
  end
  
  def valid_spot? position
    r, c = position
    @maze[r][c] != "*" and
      (0...maze.length).include? r and
      (0...maze.first.length).include? c and
      !@visited.include? [r, c]
  end
  
  def get_neighbors(parent)
    neighbors = []
    x, y = parent.value
    [[x+1, y], [x-1, y], [x, y+1], [x, y-1]].each do |position|
      if valid_spot? position
        neighbors << Node.new(position, parent)
      end
    end
    neighbors
  end
end 
    
if __FILE__ == $PROGRAM_NAME
  ms = MazeSolver.new(ARGV[0])
  ms.solve
end