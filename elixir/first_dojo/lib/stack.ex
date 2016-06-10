defmodule Stack do
  def push(list, item) do
    [item | list]
  end

  def pop([]) do
    {nil, []}
  end

  def pop([head | list]) do
    {head, list}
  end

  def size(list) do
    do_size(list, 0)
  end

  defp do_size([], count) do
    count
  end

  defp do_size([_head | list], count) do
    do_size(list, count + 1)
  end

  def empty?([]), do: true
  def empty?(_),  do: false
end
