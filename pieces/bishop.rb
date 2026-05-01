require_relative '../chess-pieces.rb'

class Bishop < ChessPieces
  def initialize(is_white, position)

    symbol = (is_white ? "♗"  : "♝")

    @move_offsets = DIAGONALS
    @move_count = 7

    super(is_white, position, symbol)
  end
end