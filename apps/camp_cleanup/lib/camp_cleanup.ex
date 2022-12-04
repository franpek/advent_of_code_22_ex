defmodule CampCleanup do
  @moduledoc """
  Documentation for `CampCleanup`.
  """

  @doc """
  Get subsets.

  ## Examples

      iex> CampCleanup.get_subsets("./apps/camp_cleanup/files/example.txt")
      2
      iex> CampCleanup.get_subsets("./apps/camp_cleanup/files/sample.txt")
      494

  """
  def get_subsets(path) do
    File.read!(path)
    |> String.split("\r\n")
    |> Enum.filter(&is_subsets/1)
    |> Enum.count()
  end

  defp is_subsets(pair) do
    [a, b, c, d] =
      pair
      |> String.split([",", "-"])
      |> Enum.map(&String.to_integer/1)

    cond do
      a <= c and b >= d -> true
      c <= a and d >= b -> true
      true -> false
    end
  end

  @doc """
  At least contained.

  ## Examples

      iex> CampCleanup.get_intersections("./apps/camp_cleanup/files/example.txt")
      4
      iex> CampCleanup.get_intersections("./apps/camp_cleanup/files/sample.txt")


  """
  def get_intersections(path) do
    File.read!(path)
    |> String.split("\r\n")
    |> Enum.filter(&is_intersection?/1)
    |> Enum.count()
  end

  defp is_intersection?(pair) do
    [a, b, c, d] =
      pair
      |> String.split([",", "-"])
      |> Enum.map(&String.to_integer/1)

    pair_one = MapSet.new(a..b)
    pair_two = MapSet.new(c..d)
    pair_map = MapSet.intersection(pair_one, pair_two)

    MapSet.size(pair_map) != 0
  end
end
