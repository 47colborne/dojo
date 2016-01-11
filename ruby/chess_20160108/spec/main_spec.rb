require 'spec_helper.rb'

describe Chess do

  let(:chess) { Chess.new }

  context 'when piece is a king' do

    it 'should move a king one space forward' do
      king = King.new(4, 0)
      chess.place_piece(king, 4, 0)
      chess.move_piece(king, 4, 1)
      expect(chess.board[4][1].class).to eq(King)
      expect(chess.board[4][0].class).to eq(NilClass)
    end

    it 'should not move a king more than one space forward' do
      king = King.new(4, 0)
      chess.place_piece(king, 4, 0)
      expect { chess.move_piece(king, 4, 2) }.to raise_error
      expect(chess.board[4][0].class).to eq(King)
    end
  end

  context 'when piece is a rook' do
    it 'should move a rook one space forward' do
      rook = Rook.new(0,0)
      chess.place_piece(rook, 0, 0)
      chess.move_piece(rook, 0, 1)
      expect(chess.board[0][1].class).to eq(Rook)
      expect(chess.board[0][0].class).to eq(NilClass)
    end

    it 'should move a rook more than one space forward' do
      rook = Rook.new(0,0)
      chess.place_piece(rook, 0, 0)
      chess.move_piece(rook, 0, 5)
      expect(chess.board[0][5].class).to eq(Rook)
      expect(chess.board[0][0].class).to eq(NilClass)
    end
  end

end
