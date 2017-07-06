require 'treetop'

class Calculator
  def self.calc(expression)
    CalculatorParser.parse(expression).value
  end
end
