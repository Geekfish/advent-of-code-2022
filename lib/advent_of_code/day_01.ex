defmodule AdventOfCode.Day01 do
  def part1(input) do
    calculate_best_total(input, best_of_n(1))
  end

  def part2(input) do
    calculate_best_total(input, best_of_n(3))
  end

  defp calculate_best_total(input, best_of_fn) do
    {last_elf_snacks, best_so_far} =
      input
      |> String.split("\n")
      |> Enum.reduce({[], []}, fn snack_or_separator, {elf_snacks, best_so_far} ->
        case parse(snack_or_separator) do
          :separator ->
            {[], best_of_fn.(elf_snacks, best_so_far)}

          snack_calories ->
            {[snack_calories | elf_snacks], best_so_far}
        end
      end)

    best_of_fn.(last_elf_snacks, best_so_far)
    |> Enum.sum()
  end

  defp parse(""), do: :separator
  defp parse(snack_calories), do: snack_calories |> String.trim() |> String.to_integer()

  defp best_of_n(max_best_elfs) do
    fn elf_snacks, best_elf_totals ->
      elf_snacks
      |> Enum.sum()
      |> maybe_add_to_best(best_elf_totals, max_best_elfs)
    end
  end

  defp maybe_add_to_best(total_elf_calories, best_elf_totals, max_best_elfs) do
    [total_elf_calories | best_elf_totals]
    |> Enum.sort(:desc)
    |> Enum.take(max_best_elfs)
  end
end
