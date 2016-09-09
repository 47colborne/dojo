require 'spec_helper.rb'

describe Game do
  describe '.score' do
    context 'when scoring a single frame' do
      it 'gets the score from the frame' do
        score = Game.score([[2, 5]])
        expect(score).to eq(7)
      end
    end

    context 'when scoring multiple regular frames' do
      it 'sums the score of each frame' do
        score = Game.score([[1, 2], [3, 4]])
        expect(score).to eq(10)
      end
    end

    context 'when scoring a spare' do
      context 'that is the final frame' do
        it 'should get the score from the frame with the third roll as the bonus' do
          score = Game.score([[3, 7, 2]])
          expect(score).to eq(12)
        end
      end

      context 'that is not the last frame' do
        it 'should add the first roll of the next frame to the spare frame' do
          score = Game.score([[2, 8], [3, 2]])
          expect(score).to eq(18)
        end
      end
    end

    it 'scores a perfect game' do
      score = Game.score([[10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10, 10]])
      expect(score).to eq(300)
    end
  end
end

describe Frame do
  let(:frame) { Frame.new([1, 2]) }

  describe '#score' do
    it 'returns the sum it`s rolls' do
      expect(frame.score).to eq(3)
    end
  end

  describe '#first_roll' do
    it 'returns the first of the frame\'s rolls' do
      expect(frame.first_roll).to eq(1)
    end
  end

  describe '#second_roll' do
    it 'returns the second of the frame\'s rolls' do
      expect(frame.second_roll).to eq(2)
    end
  end

  describe '.from_rolls' do
    it 'converts a set of rolls into a frame' do
      frame = Frame.from_rolls([2, 4])
      expect(frame).to be_an_instance_of(Frame)
    end

    context 'when the first roll is a ten' do
      it 'should create a StrikeFrame' do
        frame = Frame.from_rolls([10])
        expect(frame).to be_an_instance_of(StrikeFrame)
      end
    end

    context 'when the first and second rolls sum to ten' do
      it 'should create a SpareFrame' do
        frame = Frame.from_rolls([2, 8])
        expect(frame).to be_an_instance_of(SpareFrame)
      end
    end
  end
end

describe SpareFrame do
  describe '#score' do
    let(:frame) { SpareFrame.new([5, 5], next_frame) }
    let(:next_frame) { instance_double(Frame, first_roll: 3, second_roll: 4) }

    it 'includes the first roll of the next frame as a bonus' do
      expect(frame.score).to eq(13)
    end
  end
end

describe StrikeFrame do
  let(:frame) { StrikeFrame.new([10], next_frame) }
  let(:next_frame) { instance_double(Frame, first_roll: 3, second_roll: 4) }

  describe '#score' do
    it 'includes the next two rolls as a bonus' do
      expect(frame.score).to eq(17)
    end
  end

  describe '#second_roll' do
    context 'in a regular strike frame' do
      it 'returns the first roll from the next frame' do
        expect(frame.second_roll).to eq(3)
      end

      context 'that has no next_frame' do
        let(:frame) { StrikeFrame.new([10]) }

        it 'returns 0 as its second roll' do
          expect(frame.second_roll).to eq(0)
        end
      end
    end

    context 'in the final frame' do
      let(:frame) { StrikeFrame.new([10, 1, 2]) }

      it 'returns its second roll' do
        expect(frame.second_roll).to eq(1)
      end
    end
  end
end

describe EmptyFrame do
  let(:frame) { EmptyFrame.new }

  describe '#score' do
    it 'returns 0' do
      expect(frame.score).to eq(0)
    end
  end

  describe '#first_roll' do
    it 'returns 0' do
      expect(frame.first_roll).to eq(0)
    end
  end

  describe '#second_roll' do
    it 'returns 0' do
      expect(frame.second_roll).to eq(0)
    end
  end
end
