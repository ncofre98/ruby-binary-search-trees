require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

def print_all_orders(tree)
  puts "Level order:\n#{tree.level_order.inspect}"
  puts "Pre order:\n#{tree.preorder.inspect}"
  puts "Post order:\n#{tree.postorder.inspect}"
  puts "In order:\n#{tree.inorder.inspect}"
end

#1).
tree = Tree.new(Array.new(15) { rand(1..100) })
puts tree.pretty_print

#2).
puts 'The tree is balanced' if tree.balanced?

#3).
print_all_orders(tree)

#4).
100.times { tree.insert(rand(1..200)) }

#5).
puts 'The tree is unbalanced' if !tree.balanced?
puts tree.pretty_print

#6).
tree.rebalance

#7).
puts 'The tree is balanced again!' if tree.balanced?
puts tree.pretty_print

#8).
print_all_orders(tree)
