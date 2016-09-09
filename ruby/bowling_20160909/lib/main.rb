class Game
  def self.score(frame_data)
    frames = Frames.new(frame_data)
    frames.score
  end
end

class Frames
  def initialize(frame_data)
    @head = EmptyFrame.new

    frame_data.reverse.each do |rolls|
      frame = Frame.from_rolls(rolls, @head)
      @head = frame
    end
  end

  def score
    do_score(@head)
  end

  private

  def do_score(frame)
    return 0 if frame.nil?
    frame.score + do_score(frame.next_frame)
  end
end

class Frame
  attr_reader :next_frame

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

  def self.from_rolls(rolls, next_frame = EmptyFrame.new)
    if rolls[0] == 10
      StrikeFrame.new(rolls, next_frame)
    elsif rolls[0] + rolls[1] == 10
      SpareFrame.new(rolls, next_frame)
    else
      new(rolls, next_frame)
    end
  end
end

class SpareFrame < Frame
  def score
    super + next_frame.first_roll
  end
end

class StrikeFrame < Frame
  def score
    super + next_frame.first_roll + next_frame.second_roll
  end

  def second_roll
    @rolls[1] || next_frame.first_roll
  end
end

class EmptyFrame < Frame
  def initialize
  end

  def score
    0
  end

  def first_roll
    0
  end

  def second_roll
    0
  end
end
