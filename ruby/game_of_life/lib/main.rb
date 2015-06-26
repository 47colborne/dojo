class Grid

  def initialize(length, width)
    @width = width
    @grid = Array.new(length * width) { '.' }
  end

  def to_s
    grid_string = ''

    @grid.each_with_index do |space, index|
      grid_string += space
      grid_string += "\n" if (index + 1) % @width == 0
    end

    grid_string
  end

  def set_cell(x_pos, y_pos)
    @grid[(x_pos - 1) + (y_pos - 1) * @width] = '*'
  end
end
