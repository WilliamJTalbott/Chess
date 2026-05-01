require_relative '../chess-pieces.rb'

class King < ChessPieces
  def initialize(is_white, position)

    symbol = (is_white ? "♔"  : "♚")

    @move_offsets = ALL_DIRECTIONS
    @move_count = 1

    super(is_white, position, symbol)
  end
end