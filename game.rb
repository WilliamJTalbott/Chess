require_relative 'board.rb'
require_relative 'player.rb'
require "io/console"


class Game

  def initialize()
    @board = Board.new()
    @players = [Player.new(true), Player.new(false)]
    @tile = [0,0]
    @piece = nil
  end
  
  def play_game()
    loop do
      execute_move(get_input(@players[0]))
      if checkmate?(@players[1].is_white)
        victory(@players[0])
        return
      end
      @players = [@players[1], @players[0]]
    end
  end

  def victory(player)
    puts (player.is_white ? "White wins!" : "Black wins!")
  end

  def get_input(player)
    moves = {
      "w" => [-1, 0],
      "s" => [1, 0],
      "a" => [0, -1],
      "d" => [0, 1]
    }

    loop do
      system("clear")
      
      @board.pretty_print(@tile, @piece&.symbol)

      input = STDIN.getch

      if input == "q"
        @piece = nil
        next
      end

      if ["\r", "\n"].include?(input)
        if @piece.nil?
          piece = @board.get_pos(@tile)
          if piece and piece.is_white == player.is_white
            @piece = piece
          end
        else
          return @tile if legal_move?(@piece, @tile, player.is_white)
        end
      end

      if moves.key?(input)
        row_change, col_change = moves[input]

        @tile[0] = (@tile[0] + row_change).clamp(0, 7)
        @tile[1] = (@tile[1] + col_change).clamp(0, 7)
      end
    end
  end

  def execute_move(pos)
    
    @board.set_pos(@piece.position, nil)
    @board.set_pos(pos, @piece)
    
    @piece.position = pos.dup
    @piece = nil

  end

  def checkmate?(is_white)
    return false unless in_check?(is_white)

    @board.team_pieces(is_white).each do |piece|
      @board.each_board_position do |to|
        return false if legal_move?(piece, to, is_white)
      end
    end

    true
  end

  def legal_move?(piece, to, is_white)
    from = piece.position

    return false if from == to

    target = @board.get_pos(to)
    return false if target && target.is_white == piece.is_white
    return false unless piece.valid_move?(from, to, @board)

    !self_check_for_piece?(piece, from, to, is_white)
  end

  def in_check?(is_white)
    king_pos = @board.get_king(is_white).position

    @board.pieces.any? do |piece|
      piece.is_white != is_white &&
        piece.valid_move?(piece.position, king_pos, @board)
    end
  end

  def self_check_for_piece?(piece, from, to, is_white)
    captured_piece = @board.get_pos(to)
    old_position = piece.position.dup

    @board.set_pos(from, nil)
    @board.set_pos(to, piece)
    piece.position = to.dup

    in_check = in_check?(is_white)

    @board.set_pos(from, piece)
    @board.set_pos(to, captured_piece)
    piece.position = old_position

    in_check
  end

end

game = Game.new()
game.play_game()