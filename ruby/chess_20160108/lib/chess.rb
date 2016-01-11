class Chess
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def place_piece(piece, x, y)
    @board[x][y] = piece
  end

  def move_piece(piece, x, y)
    raise InvalidMoveError "You cannot make that move" if piece.invalid_move?(x, y)

    @board[piece.x][piece.y] = nil
    @board[x][y] = piece
    piece.x = x
    piece.y = y
  end

end