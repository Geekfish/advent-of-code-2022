defmodule AdventOfCode.Day06 do
  @moduledoc """
  https://adventofcode.com/2022/day/6
  """

  def part1(input) do
    solve(input, 4)
  end

  def part2(input) do
    solve(input, 14)
  end

  defp solve(input, marker_size) do
    input
    |> String.codepoints()
    |> Enum.reduce_while({0, []}, fn char, {position, buffer} ->
      buffer
      |> maybe_pop_last(marker_size)
      |> add_to_buffer(char)
      |> find_or_continue(position + 1, marker_size)
    end)
    |> then(fn {position, _} -> position end)
  end

  defp find_or_continue(buffer, position, marker_size) do
    if marker_found?(buffer, marker_size) do
      {:halt, {position, buffer}}
    else
      {:cont, {position, buffer}}
    end
  end

  defp maybe_pop_last(buffer, marker_size) do
    if length(buffer) == marker_size do
      # Deque for dummies
      buffer
      |> Enum.reverse()
      |> then(fn [_last | rest] -> rest end)
      |> Enum.reverse()
    else
      buffer
    end
  end

  defp add_to_buffer([], char), do: [char]
  defp add_to_buffer(buffer, char), do: [char | buffer]

  defp marker_found?(buffer, marker_size) do
    buffer
    |> MapSet.new()
    |> MapSet.size()
    |> Kernel.==(marker_size)
  end
end
