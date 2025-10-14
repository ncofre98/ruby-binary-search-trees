require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

tree = Tree.new([25, 10, 8, 7, 2, 40, 1, 23, 18, 42])
puts tree.pretty_print
tree.remove(8)
puts tree.pretty_print
puts "\n\n"
puts "El preorder es #{tree.preorder.inspect}"
puts "El inorder es #{tree.inorder.inspect}"
puts "El postorder es #{tree.postorder.inspect}"
