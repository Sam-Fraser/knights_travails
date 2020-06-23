require_relative "node.rb"
require_relative "gameboard.rb"

#knight class to hold all functionality for the knight
class Knight
  #all valid move sets for a knight
  MOVES = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]

  #initialize with starting position as parameter
  def initialize(position)
    @knight = Node.new(position)
    @board = GameBoard.new
  end

  #move method, defines how the knight can move and makes them move once
  def move(pos_start, pos_end)
    pos_start = @knight.position
    movement = Node.new([pos_start[0] - pos_end[0], pos_start[1] + pos_end[1]])
    if MOVES.include?(movement) && @board.valid_move?(pos_end)
      @knight.last_position = pos_start
      @knight.position = pos_end
    else
      "ERROR: invalid move"
    end 
  end

end