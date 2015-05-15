require 'spec_helper.rb'

describe Calculator do
  let (:calc) { Calculator.new }

  describe '#tokenize' do
    it 'return an array of numbers and symbols' do

      expect(calc.tokenize('2*3+4-1/2')).to eq([
                                                   2,
                                                   Operator::MULTIPLY,
                                                   3,
                                                   Operator::PLUS,
                                                   4,
                                                   Operator::MINUS,
                                                   1,
                                                   Operator::DIVISION,
                                                   2
                                               ])
    end
    it 'handles numbers longer than one digit' do
      expect(calc.tokenize('10*123')).to eq([10, Operator::MULTIPLY, 123])
    end
  end

  describe '#lex' do
    it 'build an ast for 2 + 2' do
      expect(calc.lex([2, Operator::PLUS, 2])).to eq([[Operator::PLUS, 2, 2]])
    end

    it 'build an ast for 2 + 2 - 3' do
      expect(calc.lex([2, Operator::PLUS, 2, Operator::MINUS, 3])).to eq([[Operator::MINUS, [Operator::PLUS, 2, 2], 3]])
    end

    it 'build an ast for 2 + 2 * 3' do
      expect(calc.lex([2, Operator::PLUS, 2, Operator::MULTIPLY, 3])).to eq([[Operator::PLUS, 2, [Operator::MULTIPLY, 2, 3]]])
    end
  end

  describe '#evaluate' do
    it 'evals an ast of [[Operator::PLUS, 2, 2]]' do
      expect(calc.evaluate([[Operator::PLUS, 2, 2]])).to eq(4)
    end
  end
end
