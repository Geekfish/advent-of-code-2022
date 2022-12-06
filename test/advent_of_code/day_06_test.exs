defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  @tag :skip
  test "part1" do
    assert 5 == part1("bvwbjplbgvbhsrlpgdmjqwftvncz")
    assert 6 == part1("nppdvjthqldpwncqszvftbrmjlhg")
    assert 10 == part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
    assert 11 == part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
  end

  test "part2" do
    assert 19 == part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
    assert 23 == part2("bvwbjplbgvbhsrlpgdmjqwftvnczc")
    assert 23 == part2("nppdvjthqldpwncqszvftbrmjlhg")
    assert 29 == part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
    assert 26 == part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
  end
end
