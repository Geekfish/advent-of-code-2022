defmodule AdventOfCode.Day07 do
  def part1(input) do
    input
    |> parse_sys()
    |> sum_dirs_with_max_size(100_000)
  end

  def part2(input) do
    input
    |> parse_sys()
    |> find_dir_to_delete(70_000_000, 30_000_000)
  end

  defp parse_sys(raw_input) do
    raw_input
    |> String.split("$ ", trim: true)
    |> Enum.reduce(new_sys(), fn raw_command, sys ->
      raw_command
      |> String.split("\n", trim: true)
      |> Enum.reduce(sys, &parse_io/2)
    end)
  end

  defp parse_io(output, sys) do
    case String.split(output, " ") do
      ["cd", dir_name] ->
        update_pwd(sys, dir_name)

      ["ls"] ->
        sys

      ["dir", dir_name] ->
        add_dir(sys, dir_name)

      [file_size, file_name] ->
        add_file(sys, file_name, String.to_integer(file_size))
    end
  end

  defp update_pwd(sys, next_dir) do
    new_pwd =
      case sys do
        %{pwd: nil} ->
          next_dir

        %{pwd: pwd} ->
          append_to_path(pwd, next_dir)
      end

    %{sys | pwd: new_pwd}
  end

  defp add_dir(sys, dir_name) do
    fs = Map.put_new(sys.fs, append_to_path(sys.pwd, dir_name), new_dir())
    %{sys | fs: fs}
  end

  defp add_file(sys, file_name, file_size) do
    update_in(sys, [:fs, sys.pwd], fn dir ->
      file = new_file(file_name, file_size)

      %{dir | files: [file | dir.files]}
    end)
    |> update_parent_sizes(sys.pwd, file_size)
  end

  defp update_parent_sizes(sys, parent_path, size_change) do
    sys =
      update_in(sys, [:fs, parent_path], fn dir ->
        %{dir | size: dir.size + size_change}
      end)

    case append_to_path(parent_path, "..") do
      ^parent_path -> sys
      next_parent_path -> update_parent_sizes(sys, next_parent_path, size_change)
    end
  end

  defp new_sys, do: %{fs: %{"/" => new_dir()}, pwd: nil}
  defp new_dir, do: %{size: 0, files: []}
  defp new_file(name, size), do: %{name: name, size: size}

  defp append_to_path(path, dir_name) do
    [path, "/", dir_name] |> Path.join() |> Path.expand()
  end

  # 1st Part-specific
  defp sum_dirs_with_max_size(sys, max_size) do
    sys.fs
    |> Enum.map(fn {_key, %{size: size}} ->
      if size <= max_size, do: size, else: 0
    end)
    |> Enum.sum()
  end

  # 2nd Part-specific
  defp find_dir_to_delete(sys, total_space, desired_free_space) do
    current_free_space = total_space - sys.fs["/"].size
    space_to_free = desired_free_space - current_free_space

    sys.fs
    |> Enum.map(fn {_path, %{size: size}} -> size end)
    |> Enum.sort()
    |> Enum.find(&(&1 >= space_to_free))
  end
end
