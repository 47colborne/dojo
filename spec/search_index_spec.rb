require 'spec_helper'

describe SearchIndex do
  describe 'find' do
    context 'number does no exist in the tree' do
      it 'return nil' do
        index = SearchIndex.new([])
        expect(index.find(6)).to be_nil
      end
    end

    context 'number already exists in the tree' do
      it 'given a random number find it in the sequence' do
        index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
        expect(index.find(123)).to eq({num: 123})
      end
    end
  end

  describe 'insert' do
    context 'when number is already in the index' do
      it 'should do nothing' do
        index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
        index.insert({num: 123})
        expect(index.count).to eq(4)
      end
    end

    context 'when number is already in the index' do
      it 'should increase the number of items in the index' do
        index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
        index.insert({num: 124})
        expect(index.count).to eq(5)
      end
    end
  end

  describe 'find_range' do
    context 'when index is empty' do
      it 'should return nil' do
        index = SearchIndex.new([])
        expect(index.find_range([1,5])).to eq([])
      end
    end

    context 'when index is not empty' do
      context 'when start is not given' do
        it 'returns all items <= start' do
          index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
          expect(index.find_range([nil,5])).to eq([{num: -12}, {num: 1}])
        end
      end

      context 'when end is not given' do
        it 'returns all items >= start' do
          index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
          expect(index.find_range([1, nil])).to eq([{num: 1}, {num: 123}, {num: 575}])
        end
      end

      context 'when both are given' do
        it 'returns all items between the two' do
          index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
          expect(index.find_range([100,200])).to eq([{num: 123}])
        end
      end

      context 'when neither is given' do
        it 'returns the full sorted index' do
          index = SearchIndex.new([{num: 1}, {num: 575}, {num: 123}, {num: -12}])
          expect(index.find_range([nil, nil])).to eq([{num: -12}, {num: 1}, {num: 123}, {num: 575}])
        end
      end
    end
  end
end
