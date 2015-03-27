require 'ostruct'

Location = Struct.new(:row, :column)
Event = Struct.new(:type, :location)

class RandomPlacementStrategy
  def mine_locations(num_mines, rows, columns)
    locations = []

    num_mines.times do
      mine_coord = nil

      loop do
        mine_coord = Location.new(rand(rows), rand(columns))
        break unless locations.include?(mine_coord)
      end

      locations << mine_coord
    end

    locations
  end
end

class Minefield
  def initialize(placement_strategy, rows, columns)
    @placement_strategy = placement_strategy
    @rows = rows
    @columns = columns

    @field = Array.new(@rows) do |row|
      Array.new(@columns) do |column|
        Cell.new(self, Location.new(row, column))
      end
    end
  end

  def lay_mines(number_of_mines)
    mine_locations = @placement_strategy.mine_locations(number_of_mines, @rows, @columns)

    mine_locations.each do |mine_location|
      cell = @field[mine_location.row][mine_location.column]
      cell.insert_mine
    end
  end

  def display
    @field.collect { |row| row.collect { |cell| cell.to_s } }
  end

  def dispatch(event)
    cells.each { |cell| cell.handle(event) }
  end

  def cells
    @field.flatten
  end

  def guess(row,column)
    cell = @field[row][column]
    cell.click(cell.location)
  end
end

class Cell
  MINE = -1
  MASK = "#"

  attr_reader :location, :value, :hidden

  def initialize(field, location)
    @value = 0
    @field = field
    @location = location
    @hidden = true
  end

  def to_s
    if hidden
      MASK
    else
      (has_mine?) ? '*' : @value.to_s
    end
  end

  def insert_mine
    @value = MINE
    @field.dispatch(Event.new(:mine_placed, location))
  end

  def handle(event)
    send(event.type, event.location) if respond_to?(event.type)
  end

  def mine_placed(location)
    increment_value if neighbour?(location)
  end

  def has_mine?
    @value == MINE
  end

  def reveal(location=nil)
    @hidden = false
  end

  def click(location)
    if @location == location

      if blank?
        @field.dispatch(Event.new(:click, @location)) if hidden
      end
      @field.dispatch(Event.new(:reveal, @location)) if has_mine?
      reveal

    elsif neighbour?(location)
      if blank?
        @field.dispatch(Event.new(:click, @location)) if hidden
        reveal
      end
    end
  end

  def increment_value
    @value += 1 unless has_mine?
  end

  def blank?
    @value == 0
  end

  private

  def neighbour?(other_location)
    (location.column - other_location.column).abs <= 1 &&
    (location.row - other_location.row).abs <= 1
  end


end