class BreadthSearch
  def initialize(args)
    @root = args.fetch(:root)
    @puzzles = Queue.new(data: @root)
  end

  def find(count)
    count.times do |i|
     new_puzzles = @puzzles.get.children
     new_puzzles.each do |current_puzzle|
       if current_puzzle.correct?
         p "Solution found in the #{i}th step"
         return current_puzzle
       end
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
     new_puzzles.each do |current_puzzle|
       if current_puzzle.correct?
         p "Solution found in the #{i}th step"
         return current_puzzle
       end
     end
     # Put new puzzles at the end of the array
     @puzzles.add(new_puzzles)
    end
    return false
  end
end
