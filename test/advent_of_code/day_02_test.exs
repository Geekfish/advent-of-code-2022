defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  @input """
  A Y
  B X
  C Z
  """

  test "part1" do
    result = part1(@input)

    # (8 + 1 + 6)
    assert 15 == result
  end

  test "part2" do
    result = part2(@input)

    # (4 + 1 + 7)
    assert 12 == result
  end
end
