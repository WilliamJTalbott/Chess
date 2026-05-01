class ChessPieces

  STRAIGHTS = [[-1,0], [1,0], [0,-1], [0,1]]
  DIAGONALS = [[-1,-1], [-1,1], [1,-1], [1,1]]
  ALL_DIRECTIONS = STRAIGHTS + DIAGONALS

  attr_accessor :position
  attr_reader :is_white, :symbol, :move_count, :move_offsets

  def initialize(is_white, position, symbol)
    @is_white = is_white
    @position = position
    @symbol = symbol
  end

  def can_jump?
    false
  end

end