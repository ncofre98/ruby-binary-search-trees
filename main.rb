require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

arrs = [[1, 2, 3, 4], [1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7, 8, 9]]
arrs.each_with_index do |a, i|
  tree = Tree.new(a)
  puts "Árbol ##{i}"
  puts tree.pretty_print
  puts
end
