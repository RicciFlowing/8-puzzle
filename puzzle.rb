class Puzzle
  attr_reader :dimension

  def initialize(args)
    @positions = args.fetch(:positions)
    @dimension = args.fetch(:dimension)
  end

  def print
    temp = ''
    @positions.each_with_index do |pos, index|
      temp +=  ' [' +pos.to_s + '] '
      if (index+1) % @dimension === 0
        p temp
        temp = ''
      end
    end
    puts "\n\n"
  end

  def value(pos)
    @positions[pos.y*@dimension+pos.x]
  end

  def set_value(pos, value)
    @count = nil
    @positions[pos.y*@dimension+pos.x] = value
  end

  def empty
    index = @positions.index(nil)
    Position.new(x: index % @dimension, y: (index / @dimension).floor)
  end

  def count_false_positions
    if(@count == nil)
      @count = 0
      @positions.each_with_index do |pos, index|
        if pos != index+1
          @count += 1
        end
      end
    end
    @count
  end

  def correct?
    positions_without_last = @positions[0, @positions.size-1]
    positions_without_last.each_with_index do |pos, index|
      if pos != index+1
        return false
      end
    end
    return true
  end

  def copy
    Puzzle.new(positions: Array.new(@positions), dimension: @dimension)
  end

  def switch(pos_1, pos_2)
    @count = nil
    value_1 = self.value(pos_1)
    value_2 = self.value(pos_2)
    self.set_value(pos_2, value_1)
    self.set_value(pos_1, value_2)
    self
  end
end

class Position
  attr_reader :x, :y
  def initialize(args)
    @x = args[:x]
    @y = args[:y]
  end

  def next(limit)
    temp = []
    if x+1 < limit
      temp << Position.new(x: self.x+1,y: self.y)
    end
    if y+1 < limit
      temp << Position.new(x: self.x,y: self.y+1)
    end
    if x-1 >= 0
      temp << Position.new(x: self.x-1,y: self.y)
    end
    if y-1 >= 0
      temp << Position.new(x: self.x,y: self.y-1)
    end
    temp
  end
end

module Shuffle

  def self.next(puzzle)
    temp = []
    next_positions = puzzle.empty.next(puzzle.dimension)
    next_positions.each do |pos|
      new_p = puzzle.copy
      temp << new_p.switch(puzzle.empty, pos)
    end
    temp
  end
end
