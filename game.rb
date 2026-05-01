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
      play_turn()
      @players = [@players[1], @players[0]]
    end
  end

  def play_turn()
    execute_move(get_input(@players[0]))
    @players[1].is_checked = checked_enemy?
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

      if ["\r", "\n"].include?(input)
        if @piece.nil?
          piece = @board.get_pos(@tile)
          if piece and piece.is_white == player.is_white
            @piece = piece
          end
        else
          return @tile if valid_move?(@tile)
        end
      end

      if moves.key?(input)
        row_change, col_change = moves[input]

        @tile[0] = (@tile[0] + row_change).clamp(0, 7)
        @tile[1] = (@tile[1] + col_change).clamp(0, 7)
      end
    end
  end

  def valid_move?(pos)

    from = @piece.position
    to = pos

    return false if from == to

    target = @board.get_pos(to)
    return false if target and target.is_white == @piece.is_white

    return @piece.valid_move?(from, to, @board)
  end
  
  def execute_move(pos)
    
    @board.set_pos(@piece.position, nil)
    @board.set_pos(pos, @piece)
    
    @piece.position = pos.dup
    @piece = nil

  end

  def checked_enemy?
    false
  end

end

game = Game.new()
game.play_game()


# run_game
# create players and board
# call play_round with the player
# 
# play_round
# get_input
# if input = valid move
# execute move and end
# else repeat cycle
# after, run check? to see if you put your opponents king in check.
# 
# get_input
# loop
# if piece is selected check if it belongs to player
# if piece isn't nil, and tile is selected return cursor and piece