require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

arr = [3, 5, 6, 8, 14, 16, 17, 21, 29, 30, 31, 32, 34, 38, 39, 41, 43, 45, 48, 49, 50, 53, 54, 56, 59, 64, 66, 67, 68, 74, 78, 79, 84, 85, 86, 88, 91, 92, 95, 97, 99]
elimination_order = [56, 92, 95, 48, 97, 29, 43, 32, 84, 41, 16, 34, 88, 8, 30, 68, 74, 66, 53, 91, 17, 14, 64, 39, 54, 99, 45, 38, 6, 79, 86, 67, 31, 49, 85, 21, 5, 3, 78, 50, 59]

#tree = Tree.new(Array.new(50) { rand(1..100) })
tree = Tree.new(arr)
puts tree.pretty_print

elimination_order.each do |el|
  puts "Eliminando el nodo #{el}\n\n"
  tree.remove(el)
  tree.pretty_print
  puts "\n\n"
end

#tree.arr.each { |val| puts "El height del nodo #{val} es #{tree.height(val)}" }
puts "\n\n"
puts "El preorder es #{tree.preorder.inspect}"
puts "El inorder es #{tree.inorder.inspect}"
puts "El postorder es #{tree.postorder.inspect}"
