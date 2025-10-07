require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

arrs = [[1, 2, 3, 4], [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]]
arrs = [[1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]]
arrs.each_with_index do |a, i|
  tree = Tree.new(a)
  puts "Árbol ##{i + 1}"
  puts tree.pretty_print
  puts
end
