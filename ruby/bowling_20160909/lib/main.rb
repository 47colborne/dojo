class Game
  def self.score(frame_data)
    frames = Frames.new(frame_data)
    frames.inject(0) { |sum, e| sum + e.score }
  end
end

class Frames
  def initialize(frame_data)
    # TODO
  end
end

class Frame
  def initialize(rolls, next_frame = EmptyFrame.new)
    @rolls = rolls
    @next_frame = next_frame
  end

  def first_roll
    @rolls[0]
  end

  def second_roll
    @rolls[1]
  end

  def score
    @rolls.reduce(:+)
  end

  def self.from_rolls(rolls)
    return StrikeFrame.new(rolls) if rolls[0] == 10
    return SpareFrame.new(rolls) if rolls[0] + rolls[1] == 10
    new(rolls)
  end
end

class SpareFrame < Frame
  def score
    super + @next_frame.first_roll
  end
end

class StrikeFrame < Frame
  def score
    super + @next_frame.first_roll + @next_frame.second_roll
  end

  def second_roll
    @next_frame.first_roll
  end
end

class EmptyFrame < Frame
  def initialize
  end

  def first_roll
    0
  end

  def second_roll
    0
  end
end
