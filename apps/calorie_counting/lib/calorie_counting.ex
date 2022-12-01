defmodule CalorieCounting do
  @moduledoc """
  Documentation for `CalorieCounting`.
  """

  @doc """
  count_calories

  ## Examples

      iex> CalorieCounting.count_calories("./apps/calorie_counting/files/example.txt")
      2400
      iex> CalorieCounting.count_calories("./apps/calorie_counting/files/example.txt")
      66306

      iex> CalorieCounting.count_calories("./apps/calorie_counting/files/sample.txt", 3)
      4500
      iex> CalorieCounting.count_calories("./apps/calorie_counting/files/sample.txt", 3)
      195292

  """

  ## FIRST IMPLEMENTATION
  #  def find_most_calories_elf(path) do
  #    File.read!(path)
  #    |> String.split("\r\n\r\n")
  #    |> Enum.map(&count_elf_calories/1)
  #    |> Enum.max()
  #  end

  def count_calories(path, take \\ 1) do
    File.read!(path)
    |> String.split("\r\n\r\n")
    |> Enum.map(&count_elf_calories/1)
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(take)
    |> Enum.sum()
  end

  defp count_elf_calories(elf) do
    String.split(elf, "\r\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
