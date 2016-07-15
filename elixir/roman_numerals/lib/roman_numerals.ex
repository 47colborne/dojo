defmodule RomanNumerals do
  @moduledoc false

  @roman_digits %{
    "I" => 1,
    "V" => 5,
    "X" => 10,
    "L" => 50,
    "C" => 100,
    "D" => 500,
    "M" => 1000,
  }

  def translate(x) when x < 4 do
    String.duplicate("I", x)
  end

  def translate(4) do
    "IV"
  end

  def translate(x) when x >= 5 and x < 9 do
    "V" <> translate(x - 5)
  end

  def translate(9) do
    "IX"
  end

  def translate(x) when x >= 10 and x < 14 do
    "X" <> translate(x - 10)
  end
end
