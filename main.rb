require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

arr = [1, 2, 3, 4]
tree = Tree.new(arr)
tree.insert(5)
puts tree.pretty_print
tree.insert(10)
puts tree.pretty_print
tree.insert(0.5)
puts tree.pretty_print
