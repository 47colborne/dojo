defmodule RomanNumeralsTest do
  use ExUnit.Case, async: true
  doctest RomanNumerals

  test "basic cases" do
    assert RomanNumerals.translate(1) == "I"
    assert RomanNumerals.translate(2) == "II"
    assert RomanNumerals.translate(3) == "III"
    assert RomanNumerals.translate(5) == "V"
  end

  test "subtraction" do
    assert RomanNumerals.translate(4) == "IV"
    assert RomanNumerals.translate(9) == "IX"
  end

  test "addition" do
    assert RomanNumerals.translate(6) == "VI"
    assert RomanNumerals.translate(8) == "VIII"

    assert RomanNumerals.translate(11) == "XI"
    # assert RomanNumerals.translate(13) == "XIII"
    # assert RomanNumerals.translate(15) == "XV"
  end
end
