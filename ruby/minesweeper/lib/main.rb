class Minefield
  MINE = -1

  attr_reader :cells

  def initialize(x_size, y_size, num_mines)
    @x_size = x_size
    @y_size = y_size
    @num_mines = num_mines
    @cells = generate_cells
    num_mines.times { place_mine }
  end

  def generate_cells
    Array.new(@x_size) {Array.new(@y_size, 0)}
  end

  def rand_coordinates
    x =  rand(@x_size)
    y = rand(@y_size)
    [x, y]
  end

  def place_mine(xy = rand_coordinates)
    x = xy[0]
    y = xy[1]
    if @cells[x][y] == MINE
      place_mine(rand_coordinates)
    else
      @cells[x][y] = MINE
      return x, y
    end
  end
end