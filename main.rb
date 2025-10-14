require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8])
puts tree.pretty_print
#p tree.level_order
=begin
tree.remove(4)
puts tree.pretty_print
tree.insert(4)
puts tree.pretty_print
=end
tree.arr.each { |val| puts "El height del nodo #{val} es #{tree.height(val)}" }
puts "\n\n"
puts "El preorder es #{tree.preorder.inspect}"
puts "El inorder es #{tree.inorder.inspect}"
puts "El postorder es #{tree.postorder.inspect}"
