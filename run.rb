require_relative './puzzle.rb'
require_relative './p_queue.rb'
require_relative './tree.rb'
require 'benchmark'


puzzle = Puzzle.new(positions: [1,2,3,4,5,6,7,8,nil], dimension: 3)
puzzle2  = Puzzle.new(positions: [1,2,3,4,5,6,nil,7,8], dimension: 3)
puzzle3  = Shuffle.shuffle(puzzle, 20)
puzzle4  = Puzzle.new(positions: [11,5,12,14,15,2,nil,9,13,7,6,1,3,10,4,8], dimension: 4)

puzzles = [puzzle3]


class BreadthSearch
  def initialize(args)
    @root = args.fetch(:root)
    @puzzles = Queue.new(data: @root)
  end

  def find(count)
    count.times do |i|
     new_puzzles = @puzzles.get.children
     if new_puzzles.inject(false){|b, current| b || current.correct? }
       p "Victory"
       return i
     end
     @puzzles.add(new_puzzles)
    end
    return false
  end
end

class HeuristicASearch
  def initialize(args)
    @root = args.fetch(:root)
    @puzzles = PriorityQueue.new(data: @root)
  end

  def find(count)
    count.times do |i|
     new_puzzles = @puzzles.get.children
     if new_puzzles.inject(false){|b, current| b || current.correct? }
       p "Victory"
       return i
     end
     # Put new puzzles at the end of the array
     @puzzles.add(new_puzzles)
    end
    return false
  end
end


root = PuzzleNode.new(data: puzzle3, previous: nil)

puts Benchmark.measure { p BreadthSearch.new(root: root).find(2000) }
puts Benchmark.measure { p HeuristicASearch.new(root: root).find(2000) }
