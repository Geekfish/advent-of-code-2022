defmodule AdventOfCode.Day08 do
  def part1(input) do
    input
    |> parse_forest()
    |> count_visible()
  end

  def part2(input) do
    input
    |> parse_forest()
    |> get_max_scenic_score()
  end

  defp parse_forest(raw_input) do
    lines = String.split(raw_input, "\n", trim: true)

    trees =
      lines
      |> Enum.with_index()
      |> Enum.flat_map(fn {raw_row, row_index} ->
        raw_row
        |> String.codepoints()
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.map(fn {tree_height, col_index} ->
          {{row_index, col_index}, tree_height}
        end)
      end)
      |> Map.new()

    %{
      max_index: length(lines) - 1,
      trees: trees
    }
  end

  defp count_visible(forest) do
    forest.trees
    |> Enum.reduce(0, fn {position, height}, num_visible ->
      if tree_visible?(forest.trees, forest.max_index, position, height) do
        num_visible + 1
      else
        num_visible
      end
    end)
  end

  defp tree_visible?(trees, max_index, {row_index, col_index}, tree_height) do
    on_boundary?(max_index, {row_index, col_index}) or
      visible_in_line(tree_height, &trees[{&1, col_index}], 0..(row_index - 1)) or
      visible_in_line(tree_height, &trees[{&1, col_index}], (row_index + 1)..max_index) or
      visible_in_line(tree_height, &trees[{row_index, &1}], 0..(col_index - 1)) or
      visible_in_line(tree_height, &trees[{row_index, &1}], (col_index + 1)..max_index)
  end

  defp visible_in_line(current_height, get_height_fn, range) do
    range
    |> Enum.map(get_height_fn)
    |> Enum.all?(fn other_height -> other_height < current_height end)
  end

  defp on_boundary?(_max_index, {0, _col_index}), do: true
  defp on_boundary?(_max_index, {_row_index, 0}), do: true
  defp on_boundary?(max_index, {max_index, _col_index}), do: true
  defp on_boundary?(max_index, {_row_index, max_index}), do: true
  defp on_boundary?(_, _), do: false

  defp get_max_scenic_score(forest) do
    forest.trees
    |> Enum.reduce(0, fn {position, height}, max_scenic_score ->
      case get_scenic_score(forest.trees, forest.max_index, position, height) do
        new_scenic_score when new_scenic_score > max_scenic_score -> new_scenic_score
        _other -> max_scenic_score
      end
    end)
  end

  defp get_scenic_score(trees, max_index, {row_index, col_index}, tree_height) do
    if on_boundary?(max_index, {row_index, col_index}) do
      0
    else
      count_visible_in_view(tree_height, &trees[{&1, col_index}], (row_index - 1)..0) *
        count_visible_in_view(tree_height, &trees[{&1, col_index}], (row_index + 1)..max_index) *
        count_visible_in_view(tree_height, &trees[{row_index, &1}], (col_index - 1)..0) *
        count_visible_in_view(tree_height, &trees[{row_index, &1}], (col_index + 1)..max_index)
    end
  end

  defp count_visible_in_view(current_height, get_height_fn, range) do
    Enum.reduce_while(range, 0, fn tree_index, count ->
      if get_height_fn.(tree_index) >= current_height do
        {:halt, count + 1}
      else
        {:cont, count + 1}
      end
    end)
  end
end
