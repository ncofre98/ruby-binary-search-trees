require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

a1 = [1, 2, 3, 4]
a2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
tree = Tree.new(a1)
puts "Arbol #1"
puts tree.pretty_print
tree.remove(2)
puts tree.pretty_print
tree2 = Tree.new(a2)
puts "\n\nArbol #2"
puts tree2.pretty_print
tree2.remove(8)
puts tree2.pretty_print
