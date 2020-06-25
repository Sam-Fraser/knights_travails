require_relative "node.rb"
require_relative "gameboard.rb"

#knight class to hold all functionality for the knight
class Knight
  attr_accessor :nodes
  #all valid move sets for a knight
  MOVES = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]

  #initialize with starting position as parameter
  def initialize
    @nodes = []
    @board = GameBoard.new
  end

  #adds new node to nodes array
  def add_node(position)
    @nodes.push(Node.new(position))
  end

  #finds node by position
  def find_node_by_position(position)
    @nodes.each do |n|
      return n if n.position == position
    end
    nil
  end

  #counts total connections between nodes
  def count
    @nodes.length
  end

  #adds connections between nodes
  def add_edge(pos_start, pos_end)
    pos_start.add_edge(pos_end)
    pos_end.add_edge(pos_start)
  end

  #finds all possible moves for the knight from a certain position
  def possible_moves(position)
    possible_moves = []
    MOVES.each do |arr|
      possible_moves.push([position[0] + arr[0], position[1] + arr[1]])
    end
    possible_moves
  end

  #builds a grid structure containing all possible paths between spaces
  def build_graph
    #create new nodes for each space on the board
    @board.board.each_with_index do |n, i|
      n.each_index do |j|
        add_node([i, j])
      end
    end
    #add edges to each node for all possible moves
    @nodes.each do |n|
      add_possible_moves_edges(n)
    end
  end

  #add edges to all possible moves
  def add_possible_moves_edges(node)
    position = node.position
    #add all possible moves as nodes
    possible_moves(position).each do |arr|
      if @board.valid_move?(arr)
        movement = find_node_by_position(arr)
        add_edge(node, movement) unless node.edge_exists?(movement)
      end
    end
  end

  #knight_moves method, moves the knight from one spot to another on shortest possible path
  def knight_moves(pos_start, pos_end)
    prev = solve(pos_start)

    path = reconstruct_path(pos_start, pos_end, prev)

    puts "You made it in #{path.length - 1} moves!  Heres your path:"
    path.each { |n| p n.position }

  end

  #creates paths for all possible spaces you could get to from starting position
  def solve(pos_start)
    queue = [find_node_by_position(pos_start)]
    
    visited = Array.new(count, false)
    visited[@nodes.index(find_node_by_position(pos_start))] = true
    
    prev = Array.new(count, nil)

    until queue.length == 0
      node = queue.shift
      node.possible_moves.each do |n|
        unless visited[@nodes.index(n)] == true
          queue.push(n)
          visited[@nodes.index(n)] = true
          prev[@nodes.index(n)] = node
        end
      end
    end
    return prev
  end

  #starts at ending and works its way back to the start along shortest path
  def reconstruct_path(pos_start, pos_end, prev)
    path = []
    at = find_node_by_position(pos_end)
    until at == nil
      path.push(at)
      at = prev[@nodes.index(at)]
    end
    path.reverse!

    return path if path[0] == find_node_by_position(pos_start)
    []
  end

end

k = Knight.new
k.build_graph
k.knight_moves([3,3],[4,4])