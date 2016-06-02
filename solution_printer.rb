module SolutionPrinter
  def self.solution(node)
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
