Dir[File.join(__dir__, "pieces", "*.rb")].sort.each do |file|
  require file
end

class Board

  def initialize
    @kings = []
    @board = Array.new(8) { Array.new(8) }
    setup_board
  end

  def pieces
    @board.flatten.compact
  end

  def team_pieces(is_white)
    pieces.select { |piece| piece.is_white == is_white }
  end

  def get_king(is_white)
    team_pieces(is_white).find { |piece| piece.is_a?(King) }
  end


  def get_pos(pos)
    @board[pos[0]][pos[1]]
  end

  def set_pos(pos, value)
    @board[pos[0]][pos[1]] = value
  end

  def setup_board
    # Pawns
    @board[1] = Array.new(8) { |col| Pawn.new(false, [1, col]) }
    @board[6] = Array.new(8) { |col| Pawn.new(true,  [6, col]) }

    # Black
    @board[0][0] = Rook.new(false,   [0, 0])
    @board[0][1] = Knight.new(false, [0, 1])
    @board[0][2] = Bishop.new(false, [0, 2])
    @board[0][3] = Queen.new(false,  [0, 3])
    @board[0][5] = Bishop.new(false, [0, 5])
    @board[0][6] = Knight.new(false, [0, 6])
    @board[0][7] = Rook.new(false,   [0, 7])

    # White
    @board[7][0] = Rook.new(true,   [7, 0])
    @board[7][1] = Knight.new(true, [7, 1])
    @board[7][2] = Bishop.new(true, [7, 2])
    @board[7][3] = Queen.new(true,  [7, 3])
    @board[7][5] = Bishop.new(true, [7, 5])
    @board[7][6] = Knight.new(true, [7, 6])
    @board[7][7] = Rook.new(true,   [7, 7])

    # Kings
    @board[0][4] = King.new(false,  [0, 4])
    @board[7][4] = King.new(true,   [7, 4])
    @kings = [@board[0][4], @board[7][4]]

  end

  def pretty_print(cursor_cords, cursor_symbol)
    puts
    puts "  ----------------- "
    @board.each_with_index do |row, row_index|
      height = 8 - row_index
      print "#{height}| "

      row.each_with_index do |piece, col|
        symbol = piece_symbol(piece)
        if cursor_cords == [row_index, col]
          print "\e[7m#{cursor_symbol || symbol}\e[0m "
        else
          print "#{symbol} "
        end
      end
      puts "|"
    end
    puts "  ----------------- "
    puts "   a b c d e f g h"
    puts
  end

  def piece_symbol(piece)
    return "." if piece.nil?
    return piece.symbol
  end

  def each_board_position
    (0..7).each do |row|
      (0..7).each do |col|
        yield [row, col]
      end
    end
  end

end
