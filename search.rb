class SearchAlgorithm
  def initialize(args)
    @root = args.fetch(:root)
  end

  def find(count)
    count.times do |i|
      result = find_hook
      unless result.nil?
        success(i)
        return result
      end
    end
    failure
    nil
  end

  def find_hook
    new_puzzles = @puzzles.get.children
    result = check_puzzles(new_puzzles)
    @puzzles.add(new_puzzles)
    return result
  end

  private
    def success(i)
      p "Solution found in the #{i}th step"
    end
    def failure
      p "No Solution found"
    end

    def check_puzzles(puzzles)
      puzzles.each do |current_puzzle|
        if current_puzzle.correct?
           return current_puzzle
        end
      end
      return nil
    end
end

class BreadthSearch < SearchAllgorithm
  def initialize(args)
    super(args)
    @puzzles = Queue.new(data: @root)
  end
end

class HeuristicSearch < SearchAllgorithm
  def initialize(args)
    super(args)
    @puzzles = PriorityQueue.new(data: @root)
  end
end
