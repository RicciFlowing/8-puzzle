# 8-puzzle
A puzzle-solver written in ruby

#What does it do?

It solves 8-Puzzles (or 15- ,.... -Puzzles) with a breadth or heuristic search.

What is a 8-puzzle?

A 8-puzzle consist of 8 numbers aligned in a quadratic grid:
 <pre>
  4 | 1 | 2
    | 8 | 3
  7 | 6 | 5
</pre>
The quest is to shove the empty field around and created a puzzle which is in order:
 <pre>
  1 | 2 | 3
  4 | 5 | 6
  7 | 8 |
  </pre>

 This ruby project solves such puzzles of different sizes (with 8, 15, 24, ...) by searching through all possible configurations
  which can be created from the starting puzzle.

#How to use it
Create a new Puzzle

puzzle = Puzzle.new(positions: [1,nil,5, 4, 3, 2, 7 ,8, 6], dimension: 3)

Create a root-node for searching:

root = PuzzleNode.new(data: puzzle)

Start using one of search algorithms (with an upper bound of searched configuration of 2000): 

puts BreadthSearch.new(root: root).find(2000)
puts HeuristicSearch.new(root: root).find(2000)
