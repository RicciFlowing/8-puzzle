class Solution
  attr_reader :node, :searched_nodes
  def initialize(args)
    @node = args[:node]
    @searched_nodes = args[:node]
  end

  def steps
    @node.steps
  end
end

module SolutionPrinter
  def self.solution(solution)
    node = solution.node
    unless node
      return "No solution found"
    end
    count = 0
    str = node.to_s
    until node.previous.nil? do
      count += 1
      node = node.previous
      str += node.to_s unless node.to_s.nil?
    end
    str = str+ count.to_s
  end
end
