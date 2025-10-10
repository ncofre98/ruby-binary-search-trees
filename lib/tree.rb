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
  
  def remove(val)
    #binding.pry
    p = Pointer.new(root, nil)
    direction = :right

    while val != p.current.data && !p.current.leaf?
      direction = val < p.current.data ? :left : :right
      p.parent = p.current
      p.current = p.current.public_send(direction)
    end

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
      min = Pointer.new(p.current.right, p.current)
      while (min.current.left)
        min.parent = min.current
        min.current = min.current.left
      end
      p.current.data = min.current.data
      min.parent.right = min.current.right
      #min.parent.left = nil
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
