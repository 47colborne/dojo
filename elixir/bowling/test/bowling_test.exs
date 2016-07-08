defmodule BowlingTest do
  use ExUnit.Case
  doctest Bowling

  test "empty frame should return 0" do
    assert Bowling.calc([]) == 0
  end

  test "one frame calculation" do
    frame = [8, 2]
    assert Bowling.calc([frame]) == 10
  end

  test "two frame calculation without bonus" do
    frames = [[8, 1], [3, 0]]
    assert Bowling.calc(frames) == 12
  end

  test "spare frame bonus calculation" do
    frames = [[5, 5], [4, 3]]
    assert Bowling.calc(frames) == 21
  end

  test "spare frame mid round calculation" do
     frames = [[5,5]]
     assert Bowling.calc(frames) == 10
  end

  test "all spares calculation" do
    frames = [[5,5], [5,5,5]] # (5 + 5 + 5) + (5 + 5 + 5)
    assert Bowling.calc(frames) == 30
  end
end
