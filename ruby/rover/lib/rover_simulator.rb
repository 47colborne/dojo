class RoverSimulator
  attr_reader :plateau_width, :plateau_length, :rover

  def plateau_setup(x, y)
    @plateau_width = x
    @plateau_length = y
  end

  def initial_rover_position(x, y, direction)
    position = Position.new(x, y, direction)
    @rover = Rover.new(position)
  end
end

class Rover
  attr_reader :position

  def initialize(position)
    @position = position
  end

  def execute(command)
    command.execute(position)
  end
end

class Position < Struct.new(:x, :y, :direction)
  DIRECTION_MAPPING = {'N' => 0, 'E' => 90, 'S' => 180, 'W' => 270}

  def degree
    DIRECTION_MAPPING[direction]
  end

  def degree=(value)
    self.direction = DIRECTION_MAPPING.invert[value % 360]
  end

end

class TurnCommand
  attr_accessor :turn_direction

  def initialize(turn_direction)
    @turn_direction = turn_direction
  end

  def execute(position)
    position.degree -= 90 if turn_direction == 'L'
    position
  end

end