defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  @input """
  30373
  25512
  65332
  33549
  35390
  """

  test "part1" do
    result = part1(@input)

    # XXXXX
    # XXX1X
    # XX3XX
    # X3X4X
    # XXXXX
    # All the trees on the periphery (16)
    # + the ones that are visible from any direction (5).

    assert 21 == result
  end

  test "part2" do
    result = part2(@input)

    # 30373
    # 25512
    # 65332
    # 33X49
    # 35390
    #
    # (Where X is 5)
    # Looking up, its view is blocked at 2 trees (by another tree with a height of 5).
    # Looking left, its view is not blocked; it can see 2 trees.
    # Looking down, its view is also not blocked; it can see 1 tree.
    # Looking right, its view is blocked at 2 trees (by a massive tree of height 9).

    # This tree's scenic score is 8 (2 * 2 * 1 * 2)

    assert 8 == result
  end
end
