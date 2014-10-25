class RPNCalculator
  attr_reader :stack
  def run_interactive
    
  end
  
  def calc_from_file filename
    strings = File.read(filename).chomp.scan(/[0-9]+|[+\-*\/]/)
    strings.map! do |s|
      begin
        Integer(s)
      rescue
        s.to_sym
      end
    end
    calculate strings
    @stack.last
  end
  def calculate list #of numbers/operators
    list.each do |item|
      case item
      when :+
        add
      when :-
        subtract
      when :*
        multiply
      when :/
        divide
      else
        push Integer(item)
      end
    end
  end
  
  def initialize
    @stack = []
  end
  
  def pop
    @stack.pop
  end
  def push num
    @stack.push num
  end
  
  def add
    a,b = pop,pop
    push b+a
  end
  def subtract
    a,b = pop,pop
    push b-a
  end
  def multiply
    a,b = pop,pop
    push b*a
  end
  def divide
    a,b = pop,pop
    push b/a
  end
end

if __FILE__ == $PROGRAM_NAME
  rpn = RPNCalculator.new
  p rpn.calc_from_file(ARGV[0])
end
