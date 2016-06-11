module Pruner
  extend self

  def prune(nodes,  count = 1)
    nodes.select {  |node| self.prune?(node, count)==false  }
  end

  def prune!(nodes, count = 1)
    nodes.select! {  |node| self.prune?(node, count)==false  }
  end

  def prune?(node, count=1)
    temp = node
    count.times do
      if(temp.previous.nil?)
        return false
      elsif(temp.eq? temp.previous)
        return true
      else
        temp = temp.previous
      end
    end
    return false
  end
end
