defmodule RucksackOrganization do
  @moduledoc """
  Documentation for `RucksackOrganization`.
  """

  @doc """
  Get priorities.

  ## Examples

      iex> RucksackOrganization.get_priorities("./apps/rucksack_organization/files/example.txt")
      157
      iex> RucksackOrganization.get_priorities("./apps/rucksack_organization/files/sample.txt")
      7878

  """

  def get_priorities(path) do
    File.read!(path)
    |> String.split("\r\n")
    |> Enum.map(fn s -> String.split_at(s, div(String.length(s), 2)) end)
    |> Enum.map(fn s -> String.myers_difference(elem(s, 0), elem(s, 1)) end)
    |> Enum.map(fn s -> Keyword.fetch!(s, :eq) end)
    |> Enum.map(&get_priority/1)
    |> Enum.sum()
  end

  defp get_priority(char) do
    cond do
      char == String.upcase(char) -> String.to_charlist(char) |> hd() |> (&(&1 - 38)).()
      char == String.downcase(char) -> String.to_charlist(char) |> hd() |> (&(&1 - 96)).()
    end
  end

  @doc """
  Get group priorities.

  ## Examples

      iex> RucksackOrganization.get_group_priorities("./apps/rucksack_organization/files/example.txt")
      70
      iex> RucksackOrganization.get_group_priorities("./apps/rucksack_organization/files/sample.txt")
      2760

  """

  def get_group_priorities(path) do
    File.read!(path)
    |> String.split("\r\n")
    |> Enum.map(&String.to_charlist/1)
    |> paja(0)
  end

  defp paja([], acc), do: acc

  defp paja([h1, h2, h3 | t], acc) do
    aux =
      Enum.filter(h1, fn char -> char in h2 and char in h3 end)
      |> Enum.uniq()
      |> to_string()
      |> get_priority()

    paja(t, acc + aux)
  end
end
