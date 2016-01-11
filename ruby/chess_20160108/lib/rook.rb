class Rook < Piece

   def invalid_move?(x, y)
      !(self.x == x || self.y == y) || super
  end
end