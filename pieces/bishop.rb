require_relative '../piece.rb'

class Bishop < Piece
  def initialize(is_white, position)

    symbol = (is_white ? "♝"  : "♗")

    @move_offsets = DIAGONALS
    @move_count = 7

    super(is_white, position, symbol)
  end

  def valid_move?(from, to, board)
    return false unless (from[0] - to[0]).abs == (from[1] - to[1]).abs

    dx = (to[0] - from[0]) <=> 0
    dy = (to[1] - from[1]) <=> 0

    current = from.dup

    loop do
      current[0] += dx
      current[1] += dy

      return true if current == to
      return false unless board.get_pos(current).nil?
    end
  end

end