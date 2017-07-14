class CalculatorParser
  def self.parse(data)
    ast = parser.parse(data)

    if ast
      ast
    else
      parser.failure_reason =~ /^(Expected .+) after/m
      m = Regexp.last_match(1)
      raise parser.failure_reason if m.nil?

      raise "#{m.gsub("\n", '$NEWLINE')}:\n#{data.lines.to_a[parser.failure_line - 1]}\n#{'~' * (parser.failure_column - 1)}^"
    end
  end

  def self.parser
    if @parser.nil?
      Treetop.load(File.join(File.dirname(__FILE__), 'arithmetic'))
      @parser = ArithmeticParser.new
    end

    @parser
  end
end
