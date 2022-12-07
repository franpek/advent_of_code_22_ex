defmodule TuningTrouble do
  @moduledoc """
  Documentation for `TuningTrouble`.
  """

  @doc """
  Get message marker.

  ## Examples

      iex> TuningTrouble.get_message_marker("./apps/tuning_trouble/files/example.txt", 4)
      7
      iex> TuningTrouble.get_message_marker("./apps/tuning_trouble/files/sample.txt", 4)
      1909

      iex> TuningTrouble.get_message_marker("./apps/tuning_trouble/files/example.txt", 14)
      19
      iex> TuningTrouble.get_message_marker("./apps/tuning_trouble/files/sample.txt", 14)
      3380

  """

  def get_message_marker(path, marker_size) do
    File.read!(path)
    |> String.graphemes()
    |> tl()
    |> find_message_marker(marker_size, marker_size)
  end

  defp find_message_marker([h | t], marker_size, pos) do
    has_repeated =
      [h | t]
      |> Enum.take(marker_size)
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.any?(fn x -> x > 1 end)

    cond do
      has_repeated -> find_message_marker(t, marker_size, pos + 1)
      true -> 1 + pos
    end
  end
end
