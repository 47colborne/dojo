require 'spec_helper.rb'

describe Calculator do

  describe '#calculate' do
    it 'adds two numbers' do
      expect(subject.calculate([1, :+, 1])).to eq(2)
    end
    it 'calculates three numbers with order of operations' do
      expect(subject.calculate([1, :+, 1, :*, 5])).to eq(6)
    end
    it 'subtracts correctly' do
      expect(subject.calculate([1, :-, 1, :-, 5])).to eq(-5)
    end

    it 'should evaluate brackets first' do
      expect(subject.calculate([ 3, :*, '(', 4, :-, 1, ')', :+, 6])).to eq(15)
    end

    it 'should evaluate nested bracket' do
      expect(subject.calculate([ '(','(', 6, ')', ')'])).to eq(6)
    end

    it 'should be awesome!' do
      expect(subject.calculate([ '(', 2, :^, '(', 16, :/, 4, ')', :+, 4, ')' , :*, '(', '(', 3, :*, 12, ')' , :/, 6, ')'])).to eq(120)
    end
  end

end

describe Node do

  describe '#insert_against' do
    context 'new nodes priority is greater existing node' do
      it 'should assign the right node to new' do
        existing_node = Node.new(:+)
        new_node = Node.new(1)
        new_node.insert_against(existing_node)
        expect(existing_node.right).to eq(new_node)
      end

      it 'should call insert_against on the existing node\'s right child right node to new' do
        existing_node = Node.new(:+)
        existing_node_right_child = Node.new(:*)
        existing_node.right = existing_node_right_child
        new_node = Node.new(1)
        new_node.insert_against(existing_node)
        expect(existing_node_right_child.right).to eq(new_node)
      end
    end

    context 'new nodes priority is less than existing node' do
      it 'should assign the new node as the parent of the existing node' do
        existing_node = Node.new(:*)
        new_node = Node.new(:+)
        new_node.insert_against(existing_node)
        expect(new_node.left).to eq(existing_node)
      end
    end

    context 'new nodes priority equal to existing node' do
      it 'should assign the new nodes left to the existing' do
        existing_node = Node.new(:-)
        new_node = Node.new(:+)
        new_node.insert_against(existing_node)
        expect(new_node.left).to eq(existing_node)
      end
    end

  end
end


