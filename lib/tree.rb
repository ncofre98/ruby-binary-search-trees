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
    right = arr[mid + 1..]

    Node.new(arr[mid], build_tree(left), build_tree(right))
  end

  def insert(val)
    p = root

    while p
      return if p.data == val
      dir = val < p.data ? :left : :right
      
      if p.public_send(dir).nil?
        p.public_send("#{dir}=", Node.new(val, nil, nil))
        break
      end
      p = p.public_send(dir)
    end
  end

  def locate(val, pointer = root, parent = nil)
    p = Pointer.new(pointer, parent)
    direction = nil
    cond = if %i[min max].include?(val)
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

    { pointer: p, direction: direction }
  end

  def replace_child(parent, direction, child)
    if parent
      parent.public_send("#{direction}=", child)
    else
      @root = child
    end
  end

  def remove(val)
    traversal = locate(val)
    p = traversal[:pointer]
    direction = traversal[:direction]

    # Case 0:
    return if p.current.data != val

    # Case 1:
    if p.current.leaf?
      replace_child(p.parent, direction, nil)
    # Case 2:
    elsif p.current.single_child?
      replace_child(p.parent, direction, p.current.left || p.current.right )
    # Case 3:
    else
      traversal = locate(:min, p.current.right, p.current)
      min = traversal[:pointer]
      p.current.data = min.current.data
      direction = min.parent.left == min.current ? :left : :right
      
      if min.current.leaf?
        replace_child(min.parent, direction, nil)
      else
        replace_child(min.parent, direction, min.current.left || min.current.right)
      end
    end
  end

  def find(val)
    node = locate(val)[:pointer][:current]
    node.data != val ? nil : node
  end

  def level_order(origin = root)
    i = 0
    queue = [origin]

    until queue[i].nil?
      node = queue[i]
      yield(node) if block_given?
      queue << node.left if node.left
      queue << node.right if node.right
      i += 1
    end

    queue.map { |node| node.data } unless block_given?
  end

  def traversal(order = :inoder, node = root, arr = [], &blk)
    return if node.nil?

    steps = {
      preorder: %i[data left right],
      inorder: %i[left data right],
      postorder: %i[left right data]
    }

    steps[order].each do |step|
      case step
      when :left then traversal(order, node.left, arr, &blk)
      when :right then traversal(order, node.right, arr, &blk)
      when :data
        yield(node) if block_given?
        arr << node.data
      end
    end

    arr unless block_given?
  end

  def preorder(node = root, arr = [], &blk)
    traversal(:preorder, node, arr, &blk)
  end

  def inorder(node = root, arr = [], &blk)
    traversal(:inorder, node, arr, &blk)
  end

  def postorder(node = root, arr = [], &blk)
    traversal(:postorder, node, arr, &blk)
  end

  def height(val)
    node = find(val)
    return nil if node.nil?
    deepest_val = level_order(node)[-1]
    pointer = node
    direction = deepest_val < pointer.data ? :left : :right
    counter = 0

    until pointer.data == deepest_val
      counter += 1
      pointer = pointer.public_send(direction)
    end

    counter
  end

  def depth(val)
    p = root
    counter = 0
    
    while p && p.data != val
      p = val < p.data ? p.left : p.right
      counter += 1
    end

    p.nil? ? nil : counter
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
