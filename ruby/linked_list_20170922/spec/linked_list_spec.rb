require 'spec_helper.rb'

describe LinkedList do
  describe '#append' do
    context 'when the list is empty' do
      it 'appends to the list' do
        linked_list = LinkedList.new
        linked_list.append('1')
        expect(linked_list.get(0)).to eq('1')
      end
    end

    context 'when the list is not empty' do
      it 'appends to the end of the list' do
        linked_list = LinkedList.new
        linked_list.append('1')
        linked_list.append('2')
        linked_list.append('3')
        expect(linked_list.get(2)).to eq('3')
      end
    end
  end
end
