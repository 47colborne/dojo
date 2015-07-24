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
    cell = Cell.new(column_num, row_num, @bus)
    @cells << cell
  end
end

class Cell
  def initialize(column, row, bus)
    @column = column
    @row = row
    @bus = bus
    @bus.register(self)
  end

  def process(message)

  end

  def send_message(message)
    @bus.receive_message(message)
  end

  def birth_message
    {event: :birth, location: [self.row, self.column]}
  end

  def death_message
    {event: :death, location: [self.row, self.column]}
  end
end


class Bus
  attr_accessor :messages, :cells

  def initialize()
    @messages = []
    @cells = []
  end

  def receive_message message
    @messages << message
  end

  def register(cell)
    cells << cell
  end

  def send_messages
    @messages.each do |message|
      @cells.each do |cell|
        cell.process(message)
      end
    end
  end
end