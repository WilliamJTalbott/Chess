require_relative '../chess-pieces.rb'

class Rook < ChessPieces
  def initialize(is_white, position)
    symbol = (is_white ? "♖"  : "♜")

    @move_offsets = STRAIGHTS
    @move_count = 7

    super(is_white, position, symbol)
  end
end