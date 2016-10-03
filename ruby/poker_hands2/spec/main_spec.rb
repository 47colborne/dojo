require 'spec_helper.rb'

describe Game do
  describe '.score' do
    let(:winning_hand) do
      [
          Card.new('9', 'D'),
          Card.new('2', 'H'),
          Card.new('3', 'H'),
          Card.new('4', 'H'),
          Card.new('5', 'H')
      ]
    end

    let(:losing_hand) do
      [
          Card.new('7', 'D'),
          Card.new('2', 'S'),
          Card.new('3', 'S'),
          Card.new('4', 'S'),
          Card.new('5', 'S')
      ]
    end

    it 'should return the winning hand' do
      expect(Game.score(winning_hand, losing_hand)).to eq(winning_hand)
      expect(Game.score(losing_hand, winning_hand)).to eq(winning_hand)
    end
  end
end

describe Card do
  describe '<=>' do
    let(:card) { Card.new('8', 'D') }
    context 'the card is higher than the other card' do
      it 'returns 1' do
        expect(card <=> Card.new('7', 'D')).to eq(1)
      end
    end
    context 'the cards are equal value' do
      it 'returns 0' do
        expect(card <=> Card.new('8', 'H')).to eq(0)
      end
    end
    context 'the card is lower in value than the other card' do
      it 'returns -1' do
        expect(card <=> Card.new('T', 'D')).to eq(-1)
      end
    end
  end

  it 'is comparable' do
    expect(Card.new('J', 'C')).to be > Card.new('2', 'D')
    expect(Card.new('K', 'S')).to be < Card.new('A', 'H')
  end
end

describe HighCardHand do
  let(:hand) { HighCardHand.new([
                                    Card.new('9', 'D'),
                                    Card.new('7', 'S'),
                                    Card.new('3', 'S'),
                                    Card.new('4', 'S'),
                                    Card.new('5', 'S')
                                ]) }
  describe '.type_rank' do
    it 'should return 1' do
      expect(HighCardHand.type_rank).to eq(1)
    end
  end

  describe '<=>' do
    context 'the card_rank is higher than the other hand' do
      let(:hand2) { HighCardHand.new([
                                         Card.new('7', 'D'),
                                         Card.new('2', 'S'),
                                         Card.new('3', 'S'),
                                         Card.new('4', 'S'),
                                         Card.new('5', 'S')
                                     ]) }
      it 'returns 1' do
        expect(hand <=> hand2).to eq(1)
      end
    end

    context 'the card ranks are equal value' do
      let(:hand2) { HighCardHand.new([
                                         Card.new('9', 'D'),
                                         Card.new('7', 'S'),
                                         Card.new('3', 'S'),
                                         Card.new('4', 'S'),
                                         Card.new('5', 'S')
                                     ]) }


      it 'returns 0' do
        expect(hand <=> hand2).to eq(0)
      end
    end

    context 'the card_rank is lower in value than the other hand\'s card_rank' do
      let(:hand2) { HighCardHand.new([
                                         Card.new('T', 'D'),
                                         Card.new('2', 'S'),
                                         Card.new('3', 'S'),
                                         Card.new('4', 'S'),
                                         Card.new('5', 'S')
                                     ]) }
      it 'returns -1' do
        expect(hand <=> hand2).to eq(-1)
      end
    end
  end

  describe 'comparision with another high card hand' do
    context 'when it has the highest card' do
      let(:hand2) { HighCardHand.new([
                                         Card.new('8', 'D'),
                                         Card.new('2', 'S'),
                                         Card.new('3', 'S'),
                                         Card.new('4', 'S'),
                                         Card.new('5', 'S')
                                     ]) }

      it 'is greater' do
        expect(hand).to be > hand2
      end
    end

    context 'when it has the highest card after a tie' do
      let(:hand2) { HighCardHand.new([
                                         Card.new('9', 'D'),
                                         Card.new('6', 'S'),
                                         Card.new('3', 'S'),
                                         Card.new('4', 'S'),
                                         Card.new('5', 'S')
                                     ]) }

      it 'is greater' do
        expect(hand).to be > hand2
      end
    end
  end
end
