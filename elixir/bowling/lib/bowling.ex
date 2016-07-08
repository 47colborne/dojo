defmodule Bowling do

  def calc(frames) do
    calculate(frames)
  end

  def calculate(frames, total \\ 0)

  def calculate([], total) do
    total
  end

  def calculate([[a, b], [c, _] = next_frame | tail], total) when a + b == 10 do
     calculate([next_frame, tail], total + a + b + c)
  end

  def calculate([head | tail], total) do
     calculate(tail, total + Enum.sum(head))
  end

end
