defmodule FirstDojoTest do
  use ExUnit.Case
  doctest FirstDojo

  test "return 1 for a charlist of a, looking for a" do
    assert FirstDojo.char_count('a', ?a) == 1
  end

  test "return 2 for a charlist of aa, looking for a" do
    assert FirstDojo.char_count('aa', ?a) == 2
  end

  test "return 0 for a charlist of aa, looking for b" do
    assert FirstDojo.char_count('aa', ?b) == 0
  end

  test "return 0 for an empty charlist, looking for a" do
    assert FirstDojo.char_count('', ?b) == 0
  end

  test "works with binaries" do
    assert FirstDojo.char_count("", ?) == 0
    assert FirstDojo.char_count("", ?) == 1
    assert FirstDojo.char_count("...∆...", ?) == 2
  end
end
