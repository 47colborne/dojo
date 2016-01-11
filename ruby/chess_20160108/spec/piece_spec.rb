require 'spec_helper.rb'


describe Piece do


  describe '#invalid_move?' do
    let(:piece1) { Piece.new(0, 0) }
    let(:piece2) { Piece.new(7, 7) }

    it 'should return true if the piece goes out of bounds' do
      expect(piece1.invalid_move?(-1, 0)).to eq(true)
      expect(piece1.invalid_move?(0, -1)).to eq(true)
      expect(piece2.invalid_move?(8, 7)).to eq(true)
      expect(piece2.invalid_move?(7, 8)).to eq(true)
    end

  end
end