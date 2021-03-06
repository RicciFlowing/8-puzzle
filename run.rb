require_relative './puzzle.rb'
require_relative './shuffle.rb'
require_relative './p_queue.rb'
require_relative './heuristic.rb'
require_relative './tree.rb'
require_relative './search.rb'
require_relative './solution.rb'
require 'benchmark'


puzzle = Puzzle.new(positions: [1,2,3,4,5,6,7,8,nil], dimension: 3)
puzzle2  = Puzzle.new(positions: [1,2,3,4,5,6,nil,7,8], dimension: 3)
puzzle3  = Shuffle.shuffle(puzzle, 15)
puzzle3a = Puzzle.new(positions: [1,nil,5, 4, 3, 2, 7 ,8, 6], dimension: 3)

puzzle4  = Puzzle.new(positions: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,nil], dimension: 4)
puzzle5  = Shuffle.shuffle(puzzle4, 15)
puzzle4a  = Puzzle.new(positions: [2,nil,3,4,1,5,7,8,9,6,15,11,13,10,14,12], dimension: 4)


root = PuzzleNode.new(data: puzzle5, previous: nil)
#puts Benchmark.measure { puts BreadthSearch.new(root: root).find(2000) }
#puts Benchmark.measure { puts HeuristicSearch.new(root: root).find(2000) }

puts Benchmark.measure { puts  HeuristicSearch.new(root: root).find(2000) }
