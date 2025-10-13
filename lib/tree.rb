class Tree
  Pointer = Struct.new(:current, :parent)
  require_relative 'node'
  attr_reader :arr, :root

  
  def initialize(arr)
    @arr = arr.uniq.sort
    @root = build_tree(@arr)
  end

  
  def build_tree(arr)
    return nil if arr.empty?
    mid = (arr.length - 1) / 2
    left = arr[0...mid]
    right = arr[mid + 1..-1]
    
    Node.new(arr[mid], build_tree(left), build_tree(right))
  end

  
  def insert(val)
    p = root
    
    while p
      return if val == p.data
      break if p.leaf?
      p = val < p.data ? p.left : p.right
    end
    direction = val < p.data ? :left : :right
    p.public_send("#{direction}=", Node.new(val, nil, nil))
  end

  
  def traverse(val, pointer = root, parent = nil)
    p = Pointer.new(pointer, parent)
    direction = nil
    cond = if [:min, :max].include?(val)
             -> { !p.current.leaf? }
           else
             -> { val != p.current.data && !p.current.leaf? }
           end

    while cond.call
      direction = val == :min || val < p.current.data ? :left : :right
      break if p.current.public_send(direction).nil?
      p.parent = p.current
      p.current = p.current.public_send(direction)
    end
    
    { :pointer => p, :direction => direction }
  end


  def remove(val)
    traversal = traverse(val)
    p, direction = traversal[:pointer], traversal[:direction]

    #Case 0:
    return if p.current.data != val
    #Case 1:
    if p.current.leaf?
      p.parent.public_send("#{direction}=", nil)
    #Case 2:
    elsif p.current.single_child?
      p.current.data = p.current.public_send(direction).data
      p.current.public_send("#{direction}=", nil)
    #Case 3:
    else
      traversal = traverse(:min, p.current)
      min, direction = traversal[:pointer], traversal[:direction]
      p.current.data = min.current.data
      min.parent.public_send("#{direction}=", min.current.right)
    end
  end

  def find(val)
    node = traverse(val)[:pointer][:current]
    node.data != val ? nil : node
  end

  def level_order
    i = 0
    queue = [root]
    
    while queue.size != arr.size
      node = queue[i]
      yield(node) if block_given?
      queue << node.left if node.left
      queue << node.right if node.right
      i += 1
    end
    
    queue.map { |node| node.data } unless block_given?
  end

  def preorder(node = root, arr = [], &blk)
    return if node.nil?
    yield(node) if block_given?
    arr << node.data
    preorder(node.left, arr, &blk)
    preorder(node.right, arr, &blk)
    
    arr unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
