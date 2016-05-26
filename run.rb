require_relative './puzzle.rb'
require 'benchmark'


puzzle = Puzzle.new(positions: [1,2,3,4,5,6,7,8,nil], dimension: 3)
puzzle2  = Puzzle.new(positions: [1,8,5,4,nil,2,7,6,3], dimension: 3)
puzzle3  = Puzzle.new(positions: [11,5,12,14,15,2,nil,9,13,7,6,1,3,10,4,8], dimension: 4)

#[].sort{ |x,y| y.priority <=> x.priority }
#p puzzle.count_false_positions
#Element = Struct.new(:data, :priority)

puzzles = [puzzle3]

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
    @children = Shuffle.next(@data).map!{ |x| Node.new(data: x, previous: self) }
  end
end


class Tree
  attr_reader :root

  def initialize(args)
    @root = args.fetch(:root).to_a
  end

  def children(node)
    node.children
  end

  def parent(node)
    node.previous
  end
end

root = PuzzleNode.new(data: puzzle2, previous: nil)
p Tree.new(root: Node.new(data: puzzle2, previous: nil))
p root.children
p root.add_children
p root.children
# Breadthsearch (restrictid)

def breadth_search(puzzles, count)
  count.times do |i|
   next_puzzle = puzzles.shift
   new_puzzles = Shuffle.next(next_puzzle)
   if new_puzzles.inject(false){|b, current| b || current.correct? }
     p "Victory"
     return i
   end
   # Put new puzzles at the end of the array
   puzzles += new_puzzles
  end
end


def heuristic(puzzles, count)
  count.times do |i|
   next_puzzle = puzzles.shift
   new_puzzles = Shuffle.next(next_puzzle)
   if new_puzzles.inject(false){|b, current| b || current.correct? }
     p "Victory"
     return i
   end
   # Put new puzzles at the end of the array
   puzzles += new_puzzles
   puzzles = puzzles.sort{ |x,y| x.count_false_positions <=> y.count_false_positions }
  end
  p puzzles.count
  p puzzles.pop.count_false_positions
  p puzzles.pop.steps
  #puzzles.each { |pu| p pu.to_s}
  return false
end



def heuristic_a(puzzles, count)
  count.times do |i|
   next_puzzle = puzzles.shift
   new_puzzles = Shuffle.next(next_puzzle)
   if new_puzzles.inject(false){|b, current| b || current.correct? }
     p "Victory"
     return i
   end
   # Put new puzzles at the end of the array
   puzzles += new_puzzles
   puzzles = puzzles.sort{ |x,y| (x.steps + x.count_false_positions) <=> (y.steps + y.count_false_positions) }
  end
  p puzzles.count
  p puzzles.pop.count_false_positions
  return false
end

#puts Benchmark.measure { p heuristic_a(puzzles, 2000) }
