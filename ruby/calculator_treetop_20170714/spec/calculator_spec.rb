require 'spec_helper.rb'

describe Calculator do
  describe '.calc' do
    it 'evaluates a single number' do
      expect(Calculator.calc('1')).to eq(1)
      expect(Calculator.calc('(1)')).to eq(1)
    end

    it 'adds numbers' do
      expect(Calculator.calc('(+ 1 2)')).to eq(3)
    end

    it 'subtracts numbers' do
      expect(Calculator.calc('(- 3 2)')).to eq(1)
    end

    it 'multiplies numbers' do
      expect(Calculator.calc('(* 2 3)')).to eq(6)
    end

    it 'divides numbers' do
      expect(Calculator.calc('(/ 4 2)')).to eq(2)
    end

    it 'performs multiple operations' do
      expect(Calculator.calc('(* (/ 4 (- 3 1)) 2)')).to eq(4)
    end

    it 'adds any quantity of numbers' do
      expect(Calculator.calc('(+ 1 2 3)')).to eq(6)
    end
  end
end
