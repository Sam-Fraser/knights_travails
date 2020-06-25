require_relative 'knight.rb'

k = Knight.new
k.build_graph
k.knight_moves([3,3],[4,4])