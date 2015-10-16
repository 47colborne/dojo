require 'pry'

class Calculator

  def calculate(token_array)
    root = Node.new(:r)

    token_array.each do |token|
      node = Node.new(token)
      node.insert_against(root)
    end

    root.evaluate
  end
end


class Node
  PRIORITY_MAP = {
      :+ => 1,
      :- => 1,
      :* => 2,
      :/ => 2,
      :^ => 3,
      '(' => 0,
      ')' => 10,
      '()' => 10,
      :r => -1,
  }

  attr_accessor :left, :right
  attr_reader :priority, :token

  def initialize(token)
    @left = nil
    @right = nil
    @token = token
    @priority = PRIORITY_MAP[token] || 10
  end

  def insert_against(existing_node, parent_of_existing_node = nil)
    if existing_node.token   self.token == ')' && existing_node.token == '('
      @token = '()'
      self.right = existing_node.right
      parent_of_existing_node.right = existing_node.left
      insert_against(existing_node.left, parent_of_existing_node)
    elsif existing_node && self.priority > existing_node.priority
      insert_as_right_child(existing_node.right, existing_node)
    else
      insert_as_parent(existing_node, parent_of_existing_node)
    end
  end

  def evaluate
    case @token
      when :+
        left.evaluate + right.evaluate
      when :-
        left.evaluate - right.evaluate
      when :*
        left.evaluate * right.evaluate
      when :/
        left.evaluate / right.evaluate
      when :^
        left.evaluate ** right.evaluate
      when :r
        right.evaluate
      when '()'
        right.evaluate
      else
        token.to_f
    end
  end

  private

  def insert_as_right_child(existing_node, parent_of_existing_node)
    insert_against(existing_node, parent_of_existing_node)
  end

  def insert_as_parent(existing_node, parent_of_existing_node)
    self.left = existing_node
    parent_of_existing_node.right = self if parent_of_existing_node
  end
end

