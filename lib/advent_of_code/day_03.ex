defmodule AdventOfCode.Day03 do
  @moduledoc """
  See: https://adventofcode.com/2022/day/3
  """

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split_in_half/1)
    |> Enum.map(&find_common_priority/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&find_common_priority/1)
    |> Enum.sum()
  end

  defp find_common_priority(backpack_contents) do
    backpack_contents
    |> Enum.map(&to_charlist_sets/1)
    |> find_common()
    |> to_priority()
  end

  defp split_in_half(line),
    do: String.split_at(line, div(String.length(line), 2)) |> Tuple.to_list()

  defp to_charlist_sets(rucksack) do
    rucksack
    |> to_charlist()
    |> MapSet.new()
  end

  defp find_common(_rucksack_charlists = [first_charlist | rest_charlists]) do
    rest_charlists
    |> Enum.reduce(first_charlist, fn rucksack_charlist, intersection ->
      MapSet.intersection(intersection, rucksack_charlist)
    end)
    |> MapSet.to_list()
    |> then(fn [common] -> common end)
  end

  # We need to convert the char ranges into priorities:
  # ?a-?z (97-122)
  # vs desired lowercase priority range (1-26)
  @lowercase_offset ?a - 1
  # ?A-?Z (65-90)
  # vs uppercase priority range (27-52)
  @uppercase_offset ?A - 27

  defp to_priority(common_charlist) when common_charlist < ?a,
    do: common_charlist - @uppercase_offset

  defp to_priority(common_charlist), do: common_charlist - @lowercase_offset
end
