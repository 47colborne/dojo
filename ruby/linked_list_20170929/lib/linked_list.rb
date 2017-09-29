class LinkedList
  Node = Struct.new(:value, :next)

  def insert_at(index, value)
    new_node = Node.new(value)

    if index == 0
      new_node.next = @head
      @head = new_node
    else
      previous_node = node_at(index - 1)

      raise 'Index out of bounds error' if previous_node.nil?

      previous_node_next = previous_node.next

      previous_node.next = new_node
      new_node.next = previous_node_next
    end
  end

  def remove_from(index)
    if index == 0
      @head = @head.next
    else
      previous_node = node_at(index - 1)
      previous_node.next = previous_node.next.next
    end
  end

  def reverse_list
    new_list = LinkedList.new

    current_node = @head

    while current_node
      new_list.insert_at(0, current_node.value)
      current_node = current_node.next
    end

    new_list
  end

  def get(index)
    node = node_at(index)
    raise 'Index out of bounds error' if node.nil?
    node.value
  end

  private

  def node_at(index)
    current_node = @head
    current_index = 0

    while current_node
      if index == current_index
        return current_node
      else
        current_node = current_node.next
        current_index += 1
      end
    end

    nil
  end
end
