defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  # # As tree representation
  # - / (dir)
  # - a (dir)
  #   - e (dir)
  #     - i (file, size=584)
  #   - f (file, size=29116)
  #   - g (file, size=2557)
  #   - h.lst (file, size=62596)
  # - b.txt (file, size=14848514)
  # - c.dat (file, size=8504156)
  # - d (dir)
  #   - j (file, size=4060174)
  #   - d.log (file, size=8033020)
  #   - d.ext (file, size=5626152)
  #   - k (file, size=7214296)

  @input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  test "part1" do
    result = part1(@input)

    # directories are a and e are of size <= 100000
    # 94853 + 584
    assert 95437 == result
  end

  test "part2" do
    result = part2(@input)

    assert 24_933_642 == result
  end
end
