#node class for creating pieces on the gameboard
class Node
  attr_accessor :position, :possible_moves

  #initialize with position and last_position taking starting position as a parameter
  def initialize(arr)
    @position = arr
    @possible_moves = []
  end

  def add_edge(adjacent_node)
    @possible_moves.push(adjacent_node)
  end

  def edge_exists?(adjacent_node)
    @possible_moves.include?(adjacent_node)
  end

end