require 'spec_helper.rb'

describe Minefield do
  M = Minefield::MINE

  context 'when generating an empty field' do
    it 'should create a small map' do
      field = Minefield.new(1, 1, 0)
      expect(field.cells).to eq([[0]])
    end

    it 'should create a medium sized map' do
      field = Minefield.new(2, 2, 0)
      expect(field.cells).to eq([[0, 0], [0, 0]])
    end
  end

  context 'with mines' do
    it 'should place the requested number of mines' do
      field = Minefield.new(3, 3, 2)
      expect(field.cells.flatten.count(Minefield::MINE)).to eq(2)
    end

    it 'should create a medium sized map' do
      field = Minefield.new(3,3,0)
      field.place_mine([0,0])
      field.place_mine([1,2])
      expect(field.cells).to eq([[M, 2, 1],
                                 [1, 2, M],
                                 [0, 1, 1]
                                ])
    end
  end

  describe '#place_mine' do
    it 'should place a mine randomly onto the map' do
      field = Minefield.new(4, 5, 0)
      x, y = field.place_mine([2,3])
      expect(x).to eq(2)
      expect(y).to eq(3)
      expect(field.cells[2][3]).to eq(Minefield::MINE)
    end

    it 'should re-pick a new random location if conflict occurs' do
      field = Minefield.new(2, 3, 0)

      field.place_mine([0,0])

      expect(field).to receive(:rand).and_return(1)
      expect(field).to receive(:rand).and_return(1)

      x, y = field.place_mine([0,0])

      expect(x).to eq(1)
      expect(y).to eq(1)

      expect(field.cells[0][0]).to eq(Minefield::MINE)
      expect(field.cells[1][1]).to eq(Minefield::MINE)
    end
  end
end
