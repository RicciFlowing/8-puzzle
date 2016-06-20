module Shuffle

  def self.shuffle(puzzle,count=1)
    count.times do
      next_position = puzzle.empty.next(puzzle.dimension).sample
      puzzle.switch(puzzle.empty, next_position)
    end
    puzzle
  end
end
