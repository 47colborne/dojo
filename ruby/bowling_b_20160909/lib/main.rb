class Game
  def self.calculate(frames)
    # frames.flatten.reduce(:+)
    total_score = 0

    previous_frame = nil
    frames_array = []
    frames.each_with_index do |frame|
      current_frame = Frame.new(frame[0], frame[1], nil)

      if previous_frame
        previous_frame.next_frame = current_frame
      end

      frames_array << current_frame

      previous_frame = current_frame
    end


    frames_array.each do |frame|
      total_score += frame.score
    end

    total_score
  end
end

# [ Frame.new(1,2), Frame.new(2,2)]

class Frame
    attr_accessor :next_frame
    attr_reader :row1, :row2

   def initialize(row1, row2, row3=0 ,next_frame)
     @row1 = row1
     @row2 = row2
     @row3 = row3
     @next_frame = next_frame
   end

  def spare?
    row1 + row2 == 10
  end

  def strike?
    row1 == 10
  end

  def score
    score = row1 + row2

    score += (next_frame.row1 + next_frame.row2) if strike?
    score += next_frame.row1 if spare? && !strike?

    score
  end
end