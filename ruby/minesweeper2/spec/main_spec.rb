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
    minefield.dispatch(Event.new(:reveal, nil))
    expect(minefield.display).to eq([%w(0 0 0),
                                     %w(0 0 0)])
  end

  context 'mine laying' do
    it 'should increment all adjacent cells value' do
      minefield.dispatch(Event.new(:reveal, nil))
      expect(placement_strategy).to receive(:mine_locations).and_return([Location.new(0, 0)])
      minefield.lay_mines(1)
      expect(minefield.display).to eq([%w(* 1 0),
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

  describe '#guess' do
    it 'should click the guessed cell' do
      location = Location.new(0,0)
      expect(minefield.cells.first).to receive(:click).with(location)
      minefield.guess(0,0)
    end
  end
end

describe Cell do

  let(:field) { instance_double(Minefield, :dispatch => {}) }
  let(:location) { Location.new(1, 1) }

  subject(:cell) { Cell.new(field, location) }

  describe '#insert_mine' do
    it 'should insert a mine' do
      cell.insert_mine
      expect(cell).to have_mine
    end

    it 'should notify minefield' do
      expect(field).to receive(:dispatch).with(Event.new(:mine_placed, location))
      cell.insert_mine
    end
  end

  context 'upon creation' do
    it 'should be hidden' do
      expect(cell.hidden).to eq(true)
    end
  end

  describe '#to_s' do
    it 'should not display its value if hidden' do
      expect(cell.to_s).to eq(Cell::MASK)
    end

    it 'should return its value if not hidden' do
      cell.reveal
      expect(cell.to_s).to eq('0')

    end
  end

  describe '#reveal' do
    it 'should set hidden to false' do
      cell.reveal
      expect(cell.hidden).to eq(false)
    end
  end

  describe '#click' do

    context 'on numbered cell' do
      before do
        cell.increment_value
        expect(field).to_not receive(:dispatch)
      end

      context 'with this cell`s location' do
        it 'should reveal the cell' do
          cell.click(location)
          expect(cell.hidden).to eq(false)
        end
      end

      context 'with a neighbouring location' do
        it 'should remain hidden' do
          cell.click(Location.new(location.row + 1, location.column))
          expect(cell.hidden).to eq(true)
        end
      end

      context 'with a non-neighbouring location' do
        it 'should remain hidden' do
          cell.click(Location.new(location.row + 2, location.column + 1))
          expect(cell.hidden).to eq(true)
        end
      end
    end

    context 'blank cell' do
      context 'with this cell\'s location' do
        it 'should reveal this cell and propagate' do
          expect(field).to receive(:dispatch).with(Event.new(:click, location))
          cell.click(location)
          expect(cell.hidden).to eq(false)
        end
      end

      context 'with a neighbouring location' do
        it 'should reveal this cell and propagate' do
          expect(field).to receive(:dispatch).with(Event.new(:click, location))
          cell.click(Location.new(location.row+1, location.column+1))
          expect(cell.hidden).to eq(false)
        end
      end

      context 'with a non-neighbouring location' do
        it 'should remain hidden' do
          expect(field).not_to receive(:dispatch)
          cell.click(Location.new(location.row+2, location.column+2))
          expect(cell.hidden).to eq(true)
        end
      end
    end

    context 'mine cell' do
      before do
        cell.insert_mine
      end

      context 'with this cell`s location' do
        it 'should reveal the cell' do
          expect(field).to receive(:dispatch).with(Event.new(:reveal, location))
          cell.click(location)
          expect(cell.hidden).to eq(false)
        end
      end

      context 'with a neighbouring location' do
        it 'should remain hidden' do
          expect(field).to_not receive(:dispatch)
          cell.click(Location.new(location.row + 1, location.column))
          expect(cell.hidden).to eq(true)
        end
      end

      context 'with a non-neighbouring location' do
        it 'should remain hidden' do
          expect(field).to_not receive(:dispatch)
          cell.click(Location.new(location.row + 2, location.column + 1))
          expect(cell.hidden).to eq(true)
        end
      end
    end
  end

  describe '#mine_placed' do
    it 'should increment value if a mine is placed next to it' do
      expect { cell.mine_placed(Location.new(0, 0)) }.to change { cell.value }.by(1)
    end

    it 'should not increment value if a mine is placed far from it' do
      expect { cell.mine_placed(Location.new(2, 3)) }.not_to change { cell.value }
    end

    it 'should not change value if the cell already contains a mine' do
      cell.insert_mine
      expect { cell.mine_placed(Location.new(1, 0)) }.not_to change { cell.value }
    end
  end

  describe '#handle' do
    it 'should invoke method based on given event type' do
      expect(cell).to receive(:respond_to?).with(:foo).and_return(true)
      expect(cell).to receive(:send).with(:foo, location)
      cell.handle(Event.new(:foo, location))
    end
    it 'should not invoke a method that it does not respond to' do
      expect(cell).to_not receive(:send)
      cell.handle(Event.new(:foo, location))
    end
  end
end