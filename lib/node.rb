class Node

  include Comparable
  attr_accessor :data, :left, :right
  
  
  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end

  def leaf?
    self.left.nil? && self.right.nil? ? true : false
  end

  def single_child?
    self.left.nil? ^ self.right.nil?
  end

  def <=>(other)
    return nil if other.nil?
    data <=> other.data
  end
  
end
