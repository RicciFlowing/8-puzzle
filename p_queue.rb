
class Queue
  def initialize(args)
    @data = args.fetch(:data).to_a || []
  end

  def get
    @data.shift
  end

  def add(new_elements)
    @data += new_elements.to_a
  end
end

class PriorityQueue < Queue
  def initialize(args)
    super(args)
  end

  def get
    @data.shift
  end

  def add(new_elements)
    @data += new_elements.to_a
    @data.sort!{ |x,y| (x.heuristic) <=> (y.heuristic) }
  end
end
