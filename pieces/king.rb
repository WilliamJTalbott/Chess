require_relative '../chess-pieces.rb'

class King < ChessPieces
  def initialize(is_white, position)

    symbol = (is_white ? "♔"  : "♚")

    @move_offsets = ALL_DIRECTIONS
    @move_count = 1

    super(is_white, position, symbol)
  end

  def valid_move?(from, to, board)
    dx = (to[0] - from[0]).abs
    dy = (to[1] - from[1]).abs

    return false if dx > 1 || dy > 1

    true
  end

end