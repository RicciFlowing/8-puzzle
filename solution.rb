class Solution
  attr_reader :node, :nodes_searched
  def initialize(args)
    @node = args[:node]
    @searched_nodes = args[:nodes_searched]
  end

  def steps
    @node.steps
  end

  def to_s
    @node
    nodes_to_s
  end

  private
    def nodes_to_s
      count = 0
      node = @node
      str = node.to_s
      until node.previous.nil? do
        count += 1
        node = node.previous
        str += count.to_s + "step \n"
        str += node.to_s unless node.to_s.nil?
      end
      str = str+ count.to_s
    end
end

class NullSolution < Solution
  def initialize(args)
    super(args)
  end

  def to_s
    return "No solution found"
  end

  def steps
    nil
  end
end
