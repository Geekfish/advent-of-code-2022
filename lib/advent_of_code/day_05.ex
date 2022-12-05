defmodule AdventOfCode.Day05 do
  def part1(input) do
    input
    |> parse_input()
    |> solve(:one_by_one)
    |> render_solution()
  end

  def part2(input) do
    input
    |> parse_input()
    |> solve(:batched)
    |> render_solution()
  end

  defp parse_input(raw_input) do
    [raw_stacks, raw_instructions] = String.split(raw_input, "\n\n")

    {
      parse_stacks(raw_stacks),
      parse_instructions(raw_instructions)
    }
  end

  defp parse_stacks(raw_stacks) do
    raw_stacks
    |> String.split("\n")
    |> Enum.reverse()
    |> then(fn [_numbers_row | reversed_rows] ->
      Enum.reduce(reversed_rows, %{}, &parse_row_into_stacks/2)
    end)
  end

  defp parse_row_into_stacks(raw_row, stacks) do
    raw_row
    |> String.codepoints()
    |> Enum.chunk_every(4)
    |> Enum.with_index(1)
    |> Enum.reduce(stacks, fn
      {[_, " " | _], _index}, stacks -> stacks
      {[_, box | _], index}, stacks -> move_to_stack(stacks, index, box)
    end)
  end

  defp parse_instructions(raw_instructions) do
    raw_instructions
    |> String.split("\n", trim: true)
    |> Enum.map(fn raw_instruction ->
      ~r/move (?<repeat>\d+) from (?<from>\d+) to (?<to>\d+)/
      |> Regex.named_captures(raw_instruction)
      |> Enum.into(%{}, fn {key, val} -> {String.to_atom(key), String.to_integer(val)} end)
    end)
  end

  defp solve({stacks, instructions}, :one_by_one) do
    Enum.reduce(instructions, stacks, fn instruction, stacks ->
      Enum.reduce(1..instruction.repeat, stacks, fn _, stacks ->
        {box_to_move, stacks} = pop_from_stack(stacks, instruction.from)
        move_to_stack(stacks, instruction.to, box_to_move)
      end)
    end)
  end

  defp solve({stacks, instructions}, :batched) do
    Enum.reduce(instructions, stacks, fn instruction, stacks ->
      {boxes_to_move, stacks} = pop_from_stack(stacks, instruction.from, instruction.repeat)
      move_to_stack(stacks, instruction.to, boxes_to_move)
    end)
  end

  defp move_to_stack(stacks, index, box) when is_binary(box) do
    Map.update(stacks, index, [box], fn stack -> [box | stack] end)
  end

  defp move_to_stack(stacks, index, boxes) when is_list(boxes) do
    Map.update(stacks, index, [boxes], fn stack -> boxes ++ stack end)
  end

  defp pop_from_stack(stacks, from, number \\ 1) do
    Map.get_and_update(stacks, from, fn stack -> Enum.split(stack, number) end)
  end

  defp render_solution(stacks) do
    stacks
    |> Enum.map(fn {_index, [top_box | _]} -> top_box end)
    |> Enum.join("")
  end
end
