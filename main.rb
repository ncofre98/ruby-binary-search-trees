require_relative 'lib/node'
require_relative 'lib/tree'
require 'pry-byebug'

arrs = [
  # 🔹 Caso 1: eliminar una hoja (sin hijos)
  { arr: [50, 30, 70, 20, 40, 60, 80], delete: 20 },
  { arr: [10, 5, 15, 3, 7], delete: 7 },
  { arr: [25, 15, 50, 10, 22, 35, 70], delete: 10 },
  { arr: [40, 20, 60, 10, 30, 50, 70], delete: 70 },
  { arr: [8, 3, 10, 1, 6, 14, 4, 7, 13], delete: 4 },

  # 🔹 Caso 2: eliminar un nodo con un solo hijo
  { arr: [50, 30, 70, 20, 40, 60], delete: 70 },   # 70 tiene un hijo (60)
  { arr: [10, 5, 15, 12], delete: 15 },            # 15 tiene solo hijo izquierdo (12)
  { arr: [25, 15, 50, 22, 35, 70, 65], delete: 70 }, # 70 tiene un solo hijo (65)
  { arr: [40, 20, 60, 10, 30, 50], delete: 20 },   # 20 tiene un solo hijo (10 o 30)
  { arr: [8, 3, 10, 1, 6, 14, 7], delete: 6 },     # 6 tiene un solo hijo (7)

  # 🔹 Caso 3: eliminar un nodo con dos hijos
  { arr: [50, 30, 70, 20, 40, 60, 80], delete: 30 },
  { arr: [10, 5, 15, 3, 7, 13, 17], delete: 10 },
  { arr: [25, 15, 50, 10, 22, 35, 70], delete: 25 },
  { arr: [40, 20, 60, 10, 30, 50, 70], delete: 40 },
  { arr: [8, 3, 10, 1, 6, 14, 4, 7, 13], delete: 3 },

  # 🔹 Caso 4: eliminar la raíz
  { arr: [50, 30, 70, 20, 40, 60, 80], delete: 50 },
  { arr: [10, 5, 15], delete: 10 },
  { arr: [25, 15, 50, 10, 22, 35, 70], delete: 25 },
  { arr: [40, 20, 60], delete: 40 },
  { arr: [8, 3, 10], delete: 8 },
]

arrs.each_with_index do |test, i|
  puts "\n🌳 Test ##{i + 1}"
  tree = Tree.new(test[:arr])
  puts "Inicial:"
  tree.pretty_print

  tree.remove(test[:delete])
  puts "\nDespués de eliminar #{test[:delete]}:"
  tree.pretty_print
  puts "-----------------------------------"
end

