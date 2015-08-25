require 'pry'
class Life
  attr_accessor :cells, :bus

  GENERATION_MESSAGE = {event: :generation}

  def initialize(width, height)
    @width = width
    @bus = Bus.new
    @cells = Array.new(width * height) { |index| Cell.new(calculate_column(index), calculate_row(index), bus) }
  end

  def seed_living_cell(column_num, row_num)
    @cells[(@width * (row_num - 1)) + (column_num - 1)].live!
  end

  def display
    system "clear"
    display_string = ""
    @cells.each_with_index do |cell, index|
      display_string += cell.display
      if (index + 1) % @width == 0
        display_string += "\n"
      else
        display_string += ' '
      end
    end
    display_string
  end

  def start
    puts display
    while true do
      sleep(1)
      process_generation
      puts display
    end
  end

  def process_generation
    bus.message(GENERATION_MESSAGE)
    bus.send_messages
  end

  def calculate_column(index)
    index % @width + 1
  end

  def calculate_row(index)
    index / @width + 1
  end

end

class Cell

  attr_reader :neighbour_count

  def initialize(column, row, bus, alive=false)
    @column = column
    @row = row
    @bus = bus
    @bus.register(self)
    @alive = alive
    @neighbour_count = 0
  end

  def display
    @alive ? '*' : '.'
    # @neighbour_count.to_s
  end

  def alive?
    @alive
  end

  def live!
    @alive = true
    send_message(birth_message)
  end

  def die!
    @alive = false
    send_message(death_message)
  end

  def process_message(message)
    case message[:event]
      when :birth
        @neighbour_count += 1 if is_neighbour?(message[:location][0], message[:location][1])
      when :death
        @neighbour_count -= 1 if is_neighbour?(message[:location][0], message[:location][1])
      when :generation
        set_new_status
      else
        puts 'unknown message'
    end
  end

  def set_new_status
    if alive? && (neighbour_count < 2 || neighbour_count > 3)
      die!
    elsif !alive? && neighbour_count == 3
      live!
    end
  end

  def is_neighbour?(column, row)
    is_vertical_neighbour?(column, row) || is_horizontal_neighbour?(column, row) || is_diagonal_neighbour?(column, row)
  end

  def send_message(message)
    @bus.message(message)
  end

  def birth_message
    {event: :birth, location: [@column, @row]}
  end

  def death_message
    {event: :death, location: [@column, @row]}
  end

  private

  def is_vertical_neighbour?(column, row)
    ((row - @row) == 1 || (row - @row) == -1) && column == @column
  end

  def is_horizontal_neighbour?(column, row)
    ((column - @column) == 1 || (column - @column) == -1) && row == @row
  end

  def is_diagonal_neighbour?(column, row)
    ((row - @row == 1) || (row - @row == -1)) && ((column - @column == 1) || (column - @column == -1))
  end

end


class Bus
  attr_accessor :messages, :subscribers

  def initialize
    @messages = []
    @subscribers = []
  end

  def message(message)
    @messages << message
  end

  def register(subscriber)
    subscribers << subscriber
  end

  def send_messages
    until @messages.empty?
      message = @messages.shift
      @subscribers.each do |cell|
        cell.process_message(message)
      end
    end
  end
end
