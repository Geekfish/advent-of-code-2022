defmodule AdventOfCode.Day04 do
  @moduledoc """
  See: https://adventofcode.com/2022/day/3
  """

  def part1(input) do
    solve(input, &either_contain?/2)
  end

  def part2(input) do
    solve(input, &overlap?/2)
  end

  defp solve(input, compare) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, result ->
      [range_one, range_two] = line_to_ranges(line)

      if compare.(range_one, range_two) do
        result + 1
      else
        result
      end
    end)
  end

  defp line_to_ranges(line) do
    line
    |> String.split(",")
    |> Enum.map(&parse_range/1)
  end

  defp parse_range(raw_range) do
    raw_range
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [start, finish] -> start..finish end)
  end

  defp either_contain?(range_one, range_two) do
    (range_one.first >= range_two.first and range_one.last <= range_two.last) or
      (range_two.first >= range_one.first and range_two.last <= range_one.last)
  end

  defp overlap?(range_one, range_two) do
    range_one.first in range_two or range_one.last in range_two or
      range_two.first in range_one or range_two.last in range_one
  end
end
