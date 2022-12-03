defmodule AdventOfCode.Day02 do
  @shape_points %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @outcome_points %{
    loss: 0,
    draw: 3,
    win: 6
  }

  @strategies %{
    ?X => :loss,
    ?Y => :draw,
    ?Z => :win
  }

  @wins_against [rock: :scissors, paper: :rock, scissors: :paper]

  def part1(input) do
    # Code as shape
    solve(input, fn my_shape_code, _opponent_shape -> shape(my_shape_code) end)
  end

  def part2(input) do
    # Code as strategy
    solve(input, fn strategy_code, opponent_shape ->
      shape_for_strategy(@strategies[strategy_code], opponent_shape)
    end)
  end

  def solve(input, my_shape_picking_method) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn _pair = <<opponent_shape_code, ?\s, solution_code>>, total ->
      opponent_shape = shape(opponent_shape_code)
      my_shape = my_shape_picking_method.(solution_code, opponent_shape)

      accumulate_pair_points(total, my_shape, opponent_shape)
    end)
  end

  defp shape(code) when code in [?A, ?X], do: :rock
  defp shape(code) when code in [?B, ?Y], do: :paper
  defp shape(code) when code in [?C, ?Z], do: :scissors

  defp accumulate_pair_points(total, my_shape, opponent_shape) do
    Enum.sum([
      total,
      @shape_points[my_shape],
      to_outcome_points({my_shape, opponent_shape})
    ])
  end

  defp to_outcome_points({same_shape, same_shape}), do: @outcome_points.draw
  defp to_outcome_points(shape_pair) when shape_pair in @wins_against, do: @outcome_points.win
  defp to_outcome_points(_shape_pair), do: @outcome_points.loss

  defp shape_for_strategy(strategy, opponent_shape) do
    case strategy do
      :draw ->
        opponent_shape

      :loss ->
        @wins_against[opponent_shape]

      :win ->
        Enum.find_value(@wins_against, fn {wins, loses} ->
          if opponent_shape == loses, do: wins
        end)
    end
  end
end
