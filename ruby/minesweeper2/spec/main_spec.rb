require 'spec_helper.rb'

describe RandomPlacementStrategy do
  it 'should return random points to place mines' do
    expect(subject).to receive(:rand).with(4).and_return(0)
    expect(subject).to receive(:rand).with(3).and_return(1)
    expect(subject).to receive(:rand).with(4).and_return(2)
    expect(subject).to receive(:rand).with(3).and_return(3)

    expect(subject.mine_locations(2, 4, 3)).to eq([Location.new(0, 1), Location.new(2, 3)])
  end

  it 'should not place more than one mine in a location' do
    expect(subject).to receive(:rand).with(4).twice.and_return(0)
    expect(subject).to receive(:rand).with(3).twice.and_return(1)
    expect(subject).to receive(:rand).with(4).and_return(2)
    expect(subject).to receive(:rand).with(3).and_return(3)

    expect(subject.mine_locations(2, 4, 3)).to eq([Location.new(0, 1), Location.new(2, 3)])
  end
end

describe Minefield do
  let(:placement_strategy) { instance_double(RandomPlacementStrategy) }
  let(:minefield) { Minefield.new(placement_strategy, 2, 3) }

  it 'should start with an empty field' do
    expect(minefield.to_s_m).to eq([%w(0 0 0),
                                    %w(0 0 0)])
  end

  context 'mine laying' do
    it 'should increment all adjacent cells value' do
      expect(placement_strategy).to receive(:mine_locations).and_return([Location.new(0, 0)])
      minefield.lay_mines(1)
      expect(minefield.to_s_m).to eq([%w(* 1 0),
                                      %w(1 1 0)])
    end
  end

  describe '#dispatch' do
    it 'should notify all cells to handle the event' do
      event = double(:event)

      minefield.cells.each do |cell|
        expect(cell).to receive(:handle).with(event)
      end

      minefield.dispatch(event)
    end
  end
end
