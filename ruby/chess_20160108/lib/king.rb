require 'piece'

class King < Piece
  def invalid_move?(x, y)
    (@x - x).abs > 1 || (@y - y).abs > 1 || super
  end


end