class Piece
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def invalid_move?(x, y)
    out_of_bounds?(x, y)
  end

  private

  def out_of_bounds?(x, y)
    x < 0 || x > 7 || y < 0 || y > 7
  end

end