defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  @input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "part1" do
    result = part1(@input)

    # 16 (p), 38 (L), 42 (P), 22 (v), 20 (t), and 19 (s)
    assert 157 == result
  end

  test "part2" do
    result = part2(@input)

    # 18 (r) for the first group and 52 (Z) for the second group
    assert 70 == result
  end
end
