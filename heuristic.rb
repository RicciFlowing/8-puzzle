class Heuristic
  def initialize(puzzle)
    @puzzle = puzzle
  end

  def value
    @puzzle.count_false_positions
  end
end
