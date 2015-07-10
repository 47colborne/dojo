class Life
  attr_accessor :cells, :bus

  def initialize(width, height)
    @width = width
    @string = Array.new(width * height) { '.' }
    @cells = []
    @bus = Bus.new
  end

  def display
    @string.each_with_index.reduce('') do |display_string, (cell, index)|
      display_string += cell

      if (index + 1) % @width == 0
        display_string += "\n"
      else
        display_string += ' '
      end
    end
  end

  def add_cell(column_num, row_num)
    @string[(@width * (row_num -1)) + (column_num -1)] = "*"
    @cells << Cell.new(column_num, row_num)
  end
end

class Cell
  def initialize(column, row)
    @column = column
    @row = row
  end
end


class Bus
  attr_accessor :messages

  def initialize()
    @messages = []
  end

  def receive_message message
  end
end