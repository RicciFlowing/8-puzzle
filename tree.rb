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
    return  @data.count_false_positions
  end

  private
    def circled?(node)
      false
      #Pruner.prune?(node,1)
    end
end

module Pruner
  extend self

  def prune(nodes,  count = 1)
    nodes.select {  |node| self.prune?(node, count)==false  }
  end

  def prune!(nodes, count = 1)
    nodes.select! {  |node| self.prune?(node, count)==false  }
  end

  def prune?(node, count=1)
    temp = node
    count.times do
      if(temp.previous.nil?)
        return false
      elsif(temp.eq? temp.previous)
        return true
      else
        temp = temp.previous
      end
    end
    return false
  end
end
