require 'spec_helper.rb'

describe Hand do

  describe '#score' do
    context 'high card' do
      it 'with 2H 3D 5S 9C KD' do
        score = Hand.new(%w(2H 3D 5S 9C KD)).score
        expect(score).to eq(Score.new(Score::HIGH_CARD, 13))
      end

      it 'with 2C 3H 4S 8C AH' do
        score = Hand.new(%w(2C 3H 4S 8C AH)).score
        expect(score).to eq(Score.new(Score::HIGH_CARD, 14))
      end
    end

    context 'pair' do
      it 'with 2H 3D 5S JC JD' do
        score = Hand.new(%w(2H 3D 5S JC JD)).score
        expect(score).to eq(Score.new(Score::PAIR, 11))
      end

      it 'with 2H 3D QS JC JD' do
        score = Hand.new(%w(2H 3D QS JC JD)).score
        expect(score).to eq(Score.new(Score::PAIR, 11))
      end
    end

    context 'three of a kind' do
      it 'with 2H 3D JS JC JD' do
        score = Hand.new(%w(2H 3D JS JC JD)).score
        expect(score).to eq(Score.new(Score::THREE_OF_A_KIND, 11))
      end
    end
  end
end
