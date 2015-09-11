require 'pry'

class Parser
  def parse(tokens)
    stack = []

    tokens.each do |token|
      if token.value.is_a? Symbol
        stack.push(PlusNode.new)
      else
        stack.push(LiteralNode.new(token.value))
      end

      if stack.size == 3
        right_node = stack.pop
        operator_node = stack.pop
        left_node = stack.pop
        operator_node.left = left_node
        operator_node.right = right_node

        stack.push(operator_node)
      end
    end

    stack.pop
  end
end


class LiteralNode < Struct.new(:value)
  def evaluate
    value
  end
end

class PlusNode < Struct.new(:left, :right)

  def evaluate
    left.evaluate + right.evaluate
  end
end
