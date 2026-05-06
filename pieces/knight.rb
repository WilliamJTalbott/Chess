require_relative '../piece.rb'

class Knight < Piece
  def initialize(is_white, position)

    symbol = (is_white ? "♞"  : "♘")

    @move_offsets = [
      [-2, -1], [-2, 1],
      [-1, -2], [-1, 2],
      [1, -2],  [1, 2],
      [2, -1],  [2, 1]
    ]

    super(is_white, position, symbol)
  end

  def can_jump?
    true
  end

  def valid_move?(from, to, board)
    row_diff = to[0] - from[0]
    col_diff = to[1] - from[1]

    @move_offsets.include?([row_diff, col_diff])
  end

end