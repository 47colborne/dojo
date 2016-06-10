defmodule FirstDojo do
  def char_count(string, char) do
    do_char_count(string, char, 0)
  end

  # Character lists
  defp do_char_count([], _char, sum),           do: sum
  defp do_char_count([char | tail], char, sum), do: do_char_count(tail, char, sum + 1)
  defp do_char_count([_ | tail], char, sum),    do: do_char_count(tail, char, sum)

  # Binaries
  defp do_char_count(<<>>, _char, count), do: count

  defp do_char_count(<<char :: utf8, rest :: binary>>, char, count) do
    do_char_count(rest, char, count + 1)
  end

  defp do_char_count(<<_ :: utf8, rest :: binary>>, char, count) do
    do_char_count(rest, char, count)
  end
end
