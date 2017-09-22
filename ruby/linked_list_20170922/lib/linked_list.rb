class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      append_to(@head, value)
    end
  end

  def get(index)
    current_node = @head
    current_index = 0

    while current_node
      if index == current_index
        return current_node.value
      else
        current_node = current_node.next_node
        current_index += 1
      end
    end

    nil
  end

  private

  def append_to(node, value)
    if node.next_node.nil?
      node.next_node = Node.new(value)
    else
      append_to(node.next_node, value)
    end
  end
end
