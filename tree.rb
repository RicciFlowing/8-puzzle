require_relative 'prune.rb'

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

  def eq?(second)
    self.data === second.data
  end
end

class PuzzleNode < Node
  def initialize(args)
    super(args)
    @heuristic =args.fetch(:heuristic, Heuristic).new(@data)
  end

  def steps
    @data.steps
  end

  def add_children
    @children = @data.next.map { |x| PuzzleNode.new(data: x, previous: self)}
    Pruner.prune!(@children)
    @children
  end

  def children
    @children = @children || self.add_children
  end

  def correct?
    @data.correct?
  end

  def heuristic
    return  @heuristic.value
  end
end
