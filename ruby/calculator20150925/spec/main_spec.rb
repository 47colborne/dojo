require 'spec_helper.rb'

describe Parser do
  def op(value, left=nil, right=nil)
    OperatorNode.new(value, left, right)
  end

  def lit(value)
    LiteralNode.new(value)
  end

  it 'should parse an equation with one operator and two operands' do
    expression = [lit(1), op(:+), lit(2)]
    expect(subject.parse(expression)).to eq op(:+, lit(1), lit(2))
  end

  it 'should parse an equation with two operator and 3 operands' do
    expression = [lit(1), op(:+), lit(2), op(:-), lit(3)]
    expect(subject.parse(expression)).to eq op(:-, op(:+, lit(1), lit(2)), lit(3))
  end

  it 'should parse an equation with 2 levels of precedence' do
    expression = [lit(1), op(:+), lit(2), op(:*), lit(3)]
    expect(subject.parse(expression)).to eq op(:+, lit(1), op(:*, lit(2), lit(3)))
  end

  it 'should parse an equation with 3 levels of precedence' do
    expression = [lit(1), op(:+), lit(2), op(:/), lit(3), op(:**), lit(4)]
    expect(subject.parse(expression)).to eq op(:+, lit(1), op(:/, lit(2), op(:**, lit(3), lit(4))))
  end

  describe 'parens' do
    LP = Parser::LPAREN
    RP = Parser::RPAREN

    it 'should parse and expression wrapped in parens' do
      expression = [LP, lit(1), op(:+), lit(2), RP]
      expect(subject.parse(expression)).to eq op(:+, lit(1), lit(2))
    end
  end

end
