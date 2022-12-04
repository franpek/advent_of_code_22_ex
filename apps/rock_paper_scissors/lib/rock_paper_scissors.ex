defmodule RockPaperScissors do
  @moduledoc """
  Documentation for `RockPaperScissors`.
  """

  @doc """
  Calculate score.

  ## Examples

      iex> RockPaperScissors.calculate_score("./apps/rock_paper_scissors/files/example.txt")
      15
      iex> RockPaperScissors.calculate_score("./apps/rock_paper_scissors/files/sample.txt")
      10624

  """

  def calculate_score(path) do
    File.read!(path)
    |> String.split("\r\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&process_round/1)
    |> Enum.sum()
  end

  defp process_round(["A", "X"]), do: 1 + 3
  defp process_round(["A", "Y"]), do: 2 + 6
  defp process_round(["A", "Z"]), do: 3 + 0

  defp process_round(["B", "X"]), do: 1 + 0
  defp process_round(["B", "Y"]), do: 2 + 3
  defp process_round(["B", "Z"]), do: 3 + 6

  defp process_round(["C", "X"]), do: 1 + 6
  defp process_round(["C", "Y"]), do: 2 + 0
  defp process_round(["C", "Z"]), do: 3 + 3

  @doc """
  Calculate real score.

  ## Examples

      iex> ROCK_PAPER_SCISSORS.calculate_real_score("./apps/rock_paper_scissors/files/example.txt")
      12
      iex> ROCK_PAPER_SCISSORS.calculate_real_score("./apps/rock_paper_scissors/files/sample.txt")
      14060

  """

  def calculate_real_score(path) do
    File.read!(path)
    |> String.split("\r\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&process_real_round/1)
    |> Enum.sum()
  end

  defp process_real_round(["A", "X"]), do: 3 + 0
  defp process_real_round(["A", "Y"]), do: 1 + 3
  defp process_real_round(["A", "Z"]), do: 2 + 6

  defp process_real_round(["B", "X"]), do: 1 + 0
  defp process_real_round(["B", "Y"]), do: 2 + 3
  defp process_real_round(["B", "Z"]), do: 3 + 6

  defp process_real_round(["C", "X"]), do: 2 + 0
  defp process_real_round(["C", "Y"]), do: 3 + 3
  defp process_real_round(["C", "Z"]), do: 1 + 6
end
