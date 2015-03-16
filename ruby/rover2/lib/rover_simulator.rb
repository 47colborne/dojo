class Rover
  attr_accessor :x, :y, :direction

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

  def process(command)
      Command.create(command).execute(self)
  end

end

class Command
  def self.create(command_string)
    return MoveCommand.new if command_string == 'M'
    return LeftTurnCommand.new if command_string == 'L'
  end
end

class MoveCommand < Command
  MOVEMENT_MAP = {
      'E' => ->(rover) { rover.x += 1 },
      'W' => ->(rover) { rover.x -= 1 },
      'N' => ->(rover) { rover.y += 1 },
      'S' => ->(rover) { rover.y -= 1 }
  }

  def execute(rover)
    MOVEMENT_MAP[rover.direction].call(rover)
  end
end

class LeftTurnCommand < Command
  DIRECTION_MAP = {
      'E' =>  'N',
      'S' =>  'E',
      'W' =>  'S',
      'N' =>  'W'
  }

  def execute(rover)
    rover.direction = DIRECTION_MAP[rover.direction]
  end
end
