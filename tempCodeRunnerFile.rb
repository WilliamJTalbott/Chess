  def execute_move(pos)
    
    @board.set_pos(@piece.position, nil)
    @board.set_pos(pos, @piece)
    
    @piece.position = pos
    @piece = nil

  end