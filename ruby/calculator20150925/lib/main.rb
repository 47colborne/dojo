require 'pry'

class Parser
  LPAREN = :lparen
  RPAREN = :rparen

  TIER_1 = %i(+ -)
  TIER_2 = %i(* /)
  TIER_3 = %i(**)

  OPERATORS = [TIER_3, TIER_2, TIER_1]

  def parse(tokens)
    stack = []

    if tokens.include?(RPAREN)
      tokens.each do |token|
        if token != RPAREN
          stack << token
        else
          expression_tokens = []

          loop do
            holder = stack.pop
            break if holder == LPAREN
            expression_tokens.unshift(holder)
          end

          subtree = parse_expression(expression_tokens)
          stack << subtree
        end
      end
      stack.pop
    else
      parse_expression(tokens)
    end

  end

  private

  def parse_expression(tokens)
    OPERATORS.each do |tier|
      tokens = parse_pass(tier, tokens)
    end

    tokens.pop
  end

  def parse_pass(tier, tokens)
    next_level_tokens = []
    index = 0

    while index < tokens.size
      token = tokens[index]
      if tier.include?(token.value)
        subtree = token
        subtree.left = next_level_tokens.pop
        subtree.right = tokens[index + 1]
        index += 1
        next_level_tokens << subtree
      else
        next_level_tokens << token
      end
      index += 1
    end

    next_level_tokens
  end
end

LiteralNode = Struct.new(:value)
OperatorNode = Struct.new(:value, :left, :right)