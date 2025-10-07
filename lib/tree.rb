class Tree
  require_relative 'node'
  attr_reader :arr, :root
  
  def initialize(arr)
    @arr = arr.uniq.sort
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    #binding.pry
    return nil if arr.length < 1
    return Node.new(arr[0], nil, nil) if arr.length == 1
    mid = (arr.length - 1) / 2
    left = arr[0...mid]
    right = arr[mid + 1..arr.length]
    
    Node.new(arr[mid], build_tree(left), build_tree(right))
  end

  def insert(val)
    pointer = root
    
    while pointer
      return if val == pointer.data
      break if pointer.left.nil? && pointer.right.nil?
      pointer = val < pointer.data ? pointer.left : pointer.right
    end
    node = Node.new(val, nil, nil)
    pointer.left = node if val < pointer.data
    pointer.right = node if val > pointer.data
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
