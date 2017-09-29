require 'spec_helper.rb'

describe LinkedList do
  describe '#insert_at' do
    context 'when the list is empty' do
      it 'can insert an item' do
        list = LinkedList.new

        list.insert_at(0, 'a')

        expect(list.get(0)).to eq('a')
      end
    end

    context 'when the list is not empty' do
      it 'can insert to the front of the list' do
        list = LinkedList.new

        list.insert_at(0, 'b')
        list.insert_at(0, 'a')

        expect(list.get(0)).to eq('a')
        expect(list.get(1)).to eq('b')
      end
      it 'can insert to the middle of the list' do
        list = LinkedList.new

        list.insert_at(0, 'c')
        list.insert_at(0, 'a')
        list.insert_at(1, 'b')

        expect(list.get(0)).to eq('a')
        expect(list.get(1)).to eq('b')
        expect(list.get(2)).to eq('c')
      end
      it 'can insert to the end of the list' do
        list = LinkedList.new

        list.insert_at(0, 'a')
        list.insert_at(1, 'b')
        list.insert_at(2, 'c')

        expect(list.get(0)).to eq('a')
        expect(list.get(1)).to eq('b')
        expect(list.get(2)).to eq('c')
      end
      it 'will raise error for an out of bounds index insert' do
        list = LinkedList.new
        expect { list.insert_at(100, 'a') }.to raise_error('Index out of bounds error')
      end
    end
  end

  describe '#remove_from' do
    context 'when the list is not empty' do
      it 'can remove the only item in the list' do
        list = LinkedList.new

        list.insert_at(0, 'a')
        list.remove_from(0)

        expect { list.get(0) }.to raise_error 'Index out of bounds error'
      end

      it 'can remove from the front of the list' do
        list = LinkedList.new

        list.insert_at(0, 'b')
        list.insert_at(0, 'a')
        list.remove_from(0)

        expect(list.get(0)).to eq('b')
      end

      it 'can remove from the middle of the list' do
        list = LinkedList.new

        list.insert_at(0, 'c')
        list.insert_at(0, 'b')
        list.insert_at(0, 'a')
        list.remove_from(1)

        expect(list.get(0)).to eq('a')
        expect(list.get(1)).to eq('c')
      end

      it 'can remove from the end of the list' do
        list = LinkedList.new

        list.insert_at(0, 'c')
        list.insert_at(0, 'b')
        list.insert_at(0, 'a')
        list.remove_from(2)

        expect(list.get(0)).to eq('a')
        expect(list.get(1)).to eq('b')
        expect { list.get(2) }.to raise_error 'Index out of bounds error'
      end
    end
  end
  describe '#reverse_list' do
    context 'list has multiple items' do
      it 'can reverse the order of list items' do
        list = LinkedList.new

        list.insert_at(0, 'c')
        list.insert_at(0, 'b')
        list.insert_at(0, 'a')

        new_list = list.reverse_list

        expect(new_list.get(0)).to eq('c')
        expect(new_list.get(1)).to eq('b')
        expect(new_list.get(2)).to eq('a')
      end
    end
  end
end
