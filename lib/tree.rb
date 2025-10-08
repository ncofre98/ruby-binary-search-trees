class Tree
  Pointer = Struct.new(:current, :parent)
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
    p = Pointer.new(root, nil)

    #Case 1: Root node with both children (or single element)
    if p.current.data == val
      if p.current.leaf?
        p.current.data = nil
        return
      end
      
      p.parent, p.current = p.current, p.current.right
      p.parent, p.current = p.current, p.current.left while p.current.left
      #puts "Hasta aquí current = #{p.current.data} y parent = #{p.parent.data}"
      root.data = p.current.data

      if p.current.leaf?
        p.parent.left = nil
      else
        p.current.data = p.current.right.data
        p.current.right = nil
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
