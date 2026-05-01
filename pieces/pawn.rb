require_relative '../chess-pieces.rb'

class Pawn < ChessPieces
  attr_reader :move_offsets, :capture_offsets, :move_count
  attr_accessor :has_moved

  def initialize(is_white, position)
    direction = is_white ? -1 : 1

    @move_offsets = [direction, 0]
    @capture_offsets = [[direction, 1], [direction, -1]]

    @has_moved = false

    symbol = is_white ? "♙" : "♟"

    super(is_white, position, symbol)
  end

  def move_count
    @has_moved ? 1 : 2
  end

  def valid_move?(from, to, board)
    row_change = to[0] - from[0]
    col_change = to[1] - from[1]

    target = board.get_pos(to)

    if target
      return capture_offsets.include?([row_change, col_change])
    else
      return forward_move?(row_change, col_change)
    end

  end

  def forward_move?(row_change, col_change)
    return false unless col_change == 0

    if move_offsets == [row_change, col_change]
      has_moved = true
      return true
    elsif !has_moved
      direction = move_offsets[0]
      if [direction * 2, 0] == [row_change, col_change]
        has_moved = true
        return true
      end
    end

    false
  end

end