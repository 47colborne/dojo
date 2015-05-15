class Calculator
  def tokenize(string)
    stack = []
    number = ""
    string.each_char do |char|
      if char =~ /[0-9]/
        number << char
      else
        stack << number.to_i
        number = ""
        stack << char
      end
    end

    stack << number.to_i
    stack
  end

  def lex_pass(tokens, high_precedence_operators)

    ast = []

    tokens.each do |token|
      if is_operator?(token)
        ast << token
      else
        if ast.empty?
          ast << token
        else
          previous_token = ast.pop

          if high_precedence_operators.include?(previous_token)
            left_term = ast.pop
            ast << [previous_token, left_term, token]
          elsif is_operator?(previous_token)
            ast << previous_token
            ast << token
          end
        end
      end
    end

    ast
  end

  def lex(tokens)
    first_pass = lex_pass(tokens,[Operator::MULTIPLY, Operator::DIVISION])
    lex_pass(first_pass, [Operator::PLUS, Operator::MINUS])
  end

  def evaluate(ast)
    ast = ast[0]
    ast[1].send(ast[0], ast[2])
  end

  private

  def is_operator?(token)
    token.is_a? String
  end

end

class Operator
  MULTIPLY = '*'
  PLUS = '+'
  MINUS = '-'
  DIVISION = '/'
end
