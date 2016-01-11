require 'spec_helper.rb'

describe King do
  describe '#invalid_move?' do

    it 'should return true if the move is not valid for the given piece'do
      piece = King.new(0,4)

      expect(piece.invalid_move?(0,2)).to eq(true)
      expect(piece.invalid_move?(2,0)).to eq(true)
      expect(piece.invalid_move?(2,2)).to eq(true)
    end


    it 'should return true if the piece goes out of bounds' do
      piece1 = King.new(0,0)
      piece2 = King.new(7,7)

      expect(piece1.invalid_move?(-1,0)).to eq(true)
      expect(piece1.invalid_move?(0,-1)).to eq(true)
      expect(piece2.invalid_move?(8,7)).to eq(true)
      expect(piece2.invalid_move?(7,8)).to eq(true)
    end

  end
end