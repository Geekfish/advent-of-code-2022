defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @example_input "1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000"

  # @tag :skip
  test "part1" do
    result = part1(@example_input)

    assert 24000 == result
  end

  test "part2" do
    result = part2(@example_input)

    assert 45000 == result
  end
end
