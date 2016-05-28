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
end

class PuzzleNode < Node
  def initialize(args)
    super(args)
  end

  def add_children
    @children = Shuffle.next(@data).map!{ |x| PuzzleNode.new(data: x, previous: self) }
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
