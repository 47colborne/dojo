require 'spec_helper.rb'

describe Calculator do
  describe '.calc' do
    xit 'evaluates a single number' do
      expect(Calculator.calc('1')).to eq(1)
      expect(Calculator.calc('(1)')).to eq(1)
    end

    xit 'adds numbers' do
      expect(Calculator.calc('(+ 1 2)')).to eq(3)
    end

    xit 'subtracts numbers' do
      expect(Calculator.calc('(- 3 2)')).to eq(1)
    end

    xit 'multiplies numbers' do
      expect(Calculator.calc('(* 2 3)')).to eq(6)
    end

    xit 'divides numbers' do
      expect(Calculator.calc('(/ 4 2)')).to eq(2)
    end

    xit 'performs multiple operations' do
      expect(Calculator.calc('(* (/ 4 (- 3 1)) 2)')).to eq(4)
    end
  end
end
