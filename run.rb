require_relative './puzzle.rb'
require 'benchmark'


puzzle = Puzzle.new(positions: [1,2,3,4,5,6,7,8,nil], dimension: 3)
puzzle2  = Puzzle.new(positions: [1,2,3,4,5,6,7,8,nil].shuffle, dimension: 3)

#[].sort{ |x,y| y.priority <=> x.priority }
#p puzzle.count_false_positions
#Element = Struct.new(:data, :priority)

puzzles = [puzzle2]

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
   puzzles = puzzles.sort{ |x,y| x.steps <=> y.steps }
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

puts Benchmark.measure { p heuristic(puzzles, 3000) }
