require 'spec_helper.rb'
require 'ostruct'

describe Parser do
  describe '#parse' do
    it 'should handle a simple addition' do
      parser = Parser.new
      tokens = [OpenStruct.new(value: 1), OpenStruct.new(value: :+), OpenStruct.new(value: 2)]

      root = parser.parse(tokens)

      expect(root).to be_a PlusNode
      expect(root.left).to eq(LiteralNode.new(1))
      expect(root.right).to eq(LiteralNode.new(2))
    end

    it 'should handle 1 + 2 + 3' do
      parser = Parser.new
      tokens = [OpenStruct.new(value: 1), OpenStruct.new(value: :+), OpenStruct.new(value: 2),
                OpenStruct.new(value: :+), OpenStruct.new(value: 3)]

      root = parser.parse(tokens)
      expect(root).to be_a PlusNode
      expect(root.left).to eq(PlusNode.new(LiteralNode.new(1), LiteralNode.new(2)))
      expect(root.right).to eq(LiteralNode.new(3))
    end
  end
end

describe PlusNode do
  describe '#evaluate' do
    it 'should add left and right node values' do
      root = PlusNode.new(LiteralNode.new(1), LiteralNode.new(2))
      expect(root.evaluate).to eq(3)
    end
  end
end

describe LiteralNode do
  describe '#evaluate' do
    it 'should return its value' do
      expect(LiteralNode.new(1).evaluate).to eq(1)
    end
  end
end

