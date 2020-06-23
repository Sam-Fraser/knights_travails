#gameboard class for creating a gameboard
class GameBoard
  attr_accessor :board

  #initialize board
  def initialize
    @board = Array.new(8, Array.new(8, false))
  end

  #checks if a move is valid
  def valid_move?(pos_arr)
    #makes sure no other piece occupies space
    if @board[pos_arr[0]][pos_arr[1]]
      false
    #makes sure the space is within the game board  
    elsif pos_arr[0] > 7 || pos_arr[0] < 0 || pos_arr[1] > 7 || pos_arr[1] < 0
      false
    else
      true
    end
  end

end
