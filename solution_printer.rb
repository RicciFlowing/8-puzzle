class Solution
  attr_reader :node, :searched_nodes
  def initialize(args)
    @node = args[:node]
    @searched_nodes = args[:node]
  end

  def steps
    @node.steps
  end

  def to_s
    @node
    unless node
      return "No solution found"
    end
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
