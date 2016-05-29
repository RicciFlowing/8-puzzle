class Node
  attr_accessor :data, :previous, :children
  def initialize(args)
    @previous = args.fetch(:previous)
    @data     = args.fetch(:data)
    @children = args.fetch(:children, nil)
  end

  def to_a
    [self]
  end

  def to_s
    @data.to_s
  end
end

class PuzzleNode < Node
  def initialize(args)
    super(args)
  end

  def add_children
    @children = @data.next.map!{ |x| PuzzleNode.new(data: x, previous: self) }
    @children
  end

  def children
    @children = @children || self.add_children
  end

  def correct?
    @data.correct?
  end

  def heuristic
    return  @data.count_false_positions
  end
end

module SolutionPrinter
  def self.solution(node)
    unless node
      return "No solution found"
    end
    count = 0
    str = ""
    until node.previous.nil? do
      count += 1
      node = node.previous
      str += node.to_s unless node.to_s.nil?
    end
    str = str+ count.to_s
  end
end
