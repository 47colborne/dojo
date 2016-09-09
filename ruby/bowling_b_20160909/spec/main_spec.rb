require 'spec_helper.rb'

describe Game do
  describe 'calculate_score' do
    it 'should be passed 2D array of frames and return the sum of the scores' do
      expect(Game.calculate([[1, 2], [3, 4]])).to eq(3 + 7)
      expect(Game.calculate([[1, 0], [4, 4]])).to eq(1 + 8)
    end

    it 'detects spares and adds the single score following the spare' do
      expect(Game.calculate([[1, 9], [3, 4]])).to eq(13 + 7)
    end

    it 'should return the score for strikes' do
      expect(Game.calculate([[10, 0], [3, 4]])).to eq(17 + 7)
    end

    # it 'should return the score for perfect game' do
    #   expect(Game.calculate([[10, 10, 10]])).to eq(30)
    # end
  end
end

describe Frame do
  describe '#initialize' do
    it 'should create frame with row attributes' do
      next_frame = Frame.new(3, 4, nil)
      frame = Frame.new(1, 2, next_frame)
      expect(frame.row1).to eq 1
      expect(frame.row2).to eq 2
      expect(frame.next_frame).to eq(next_frame)
    end
  end

  describe 'spare?' do
    it 'should return true if the frame is a spare' do
      frame1 = Frame.new(1, 2, nil)
      frame2 = Frame.new(5, 5, nil)
      expect(frame1.spare?).to be_falsey
      expect(frame2.spare?).to be_truthy
    end
  end

  describe 'strike?' do
    it 'should return true if the frame is a strike' do
      frame1 = Frame.new(1, 2, nil)
      frame2 = Frame.new(10, 0, nil)
      expect(frame1.strike?).to be_falsey
      expect(frame2.strike?).to be_truthy
    end
  end

  describe 'score' do
    it 'should return the total score of the frame' do
      frame1 = Frame.new(1, 2, nil)
      expect(frame1.score).to eq(3)
    end

    it 'should return the score of the spare frame' do
      next_frame = Frame.new(3, 4, nil)
      frame = Frame.new(5, 5, next_frame)
      expect(frame.score).to eq(10 + 3)
    end

    it 'should return the score of the strike frame' do
      next_frame = Frame.new(3, 4, nil)
      frame = Frame.new(10, 0, next_frame)
      expect(frame.score).to eq(17)
    end



  end
end

