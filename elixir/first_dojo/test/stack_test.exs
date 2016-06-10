defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "pushing to a stack" do
    assert Stack.push([1], 2) == [2, 1]
  end

  test "popping stack when empty" do
    assert Stack.pop([]) == {nil, []}
  end

  test "popping stack with items" do
    assert Stack.pop([1, 2, 3]) == {1, [2,3]}
  end

  test "size of empty stack" do
    assert Stack.size([]) == 0
  end

  test "size of stack with items" do
    assert Stack.size(['a', 'b', 'c']) == 3
  end

  test "#empty? should return true when empty list passed in" do
    assert Stack.empty?([]) == true
  end

  test "#empty? should return false when non-empty list passed in" do
    assert Stack.empty?([1,2,3]) == false
  end
end
