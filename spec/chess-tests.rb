require_relative "../board"
require_relative "../game"

RSpec.describe "Check and Checkmate" do
  let(:board) { Board.new }

  def clear_board(board)
    (0..7).each do |r|
      (0..7).each do |c|
        board.set_pos([r, c], nil)
      end
    end
  end
  
  describe "check detection" do
    it "detects when a king is in check" do
      clear_board(board)

      white_king = King.new(true, [7, 4])
      black_rook = Rook.new(false, [7, 0])

      board.set_pos([7, 4], white_king)
      board.set_pos([7, 0], black_rook)

      game = Game.new
      game.instance_variable_set(:@board, board)

      expect(game.in_check?(true)).to be true
    end
  end

  describe "checkmate detection" do
    it "detects checkmate with two distant rooks" do
      clear_board(board)

      white_king = King.new(true, [7, 7])

      checking_rook = Rook.new(false, [7, 0])
      trapping_rook = Rook.new(false, [6, 0])

      board.set_pos([7, 7], white_king)
      board.set_pos([7, 0], checking_rook)
      board.set_pos([6, 0], trapping_rook)

      game = Game.new
      game.instance_variable_set(:@board, board)

      expect(game.in_check?(true)).to be true
      expect(game.checkmate?(true)).to be true
    end
  end
end