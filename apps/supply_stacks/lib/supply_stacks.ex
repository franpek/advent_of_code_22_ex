defmodule SupplyStacks do
  @moduledoc """
  Documentation for `SupplyStacks`.
  """

  @doc """
  Get priorities.

  ## Examples

      iex> SupplyStacks.stack("./apps/supply_stacks/files/example.txt")
      CMZ
      iex> SupplyStacks.stack("./apps/supply_stacks/files/sample.txt")
      ZBDRNPMVH

  """

  def stack(path) do
    File.read!(path)
    |> String.split("\r\n\r\n")
    |> supply_stack
  end

  defp supply_stack([h | t]) do
      init_stack =
        h
      |> String.split("\r\n")
      |> Enum.map(&String.graphemes(&1))
      |> Enum.map(&tl/1)
      |> Enum.map(&Enum.chunk_every(&1, 1, 4))
      |> Enum.map(&List.flatten(&1))
      |> Enum.zip
      |> Enum.map(&Tuple.to_list(&1))
      |> Enum.map(&Enum.filter(&1, fn x -> x != " " end))
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(fn x -> {String.to_integer(hd(x)) , tl(x)} end)
      |> Map.new()

      moves =
      t
      |> hd()
      |> String.split("\r\n")
      |> Enum.map(&parse_movement/1)

      Enum.reduce(moves, init_stack, fn x, prev_stack -> apply_move(prev_stack, x) end)
      |> Map.values()
      |> Enum.map(&List.last(&1, ""))
      |> Enum.join()
  end

  defp apply_move(stack, [move: x, from: y, to: z]) do
    Map.put(stack, z, stack[z] ++ Enum.reverse(Enum.take(stack[y], -x)))
    |> Map.put(y, Enum.drop(stack[y], -x))
  end

  defp parse_movement(text) do
    [move, from, to] =
      text
      |> String.replace(~r/[^\d]/, " ")
      |> String.split
      |> Enum.map(&String.to_integer(&1))
    [move: move, from: from, to: to]
  end

  @doc """
  Get priorities.

  ## Examples

      iex> SupplyStacks.stack_multiple("./apps/supply_stacks/files/example.txt")
      MCD
      iex> SupplyStacks.stack_multiple("./apps/supply_stacks/files/sample.txt")


  """

  def stack_multiple(path) do
    File.read!(path)
    |> String.split("\r\n\r\n")
    |> supply_stack_multiple
  end

  defp supply_stack_multiple([h | t]) do
      init_stack =
        h
      |> String.split("\r\n")
      |> Enum.map(&String.graphemes(&1))
      |> Enum.map(&tl/1)
      |> Enum.map(&Enum.chunk_every(&1, 1, 4))
      |> Enum.map(&List.flatten(&1))
      |> Enum.zip
      |> Enum.map(&Tuple.to_list(&1))
      |> Enum.map(&Enum.filter(&1, fn x -> x != " " end))
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(fn x -> {String.to_integer(hd(x)) , tl(x)} end)
      |> Map.new()

      moves =
      t
      |> hd()
      |> String.split("\r\n")
      |> Enum.map(&parse_movement/1)

      Enum.reduce(moves, init_stack, fn x, prev_stack -> apply_move_multiple(prev_stack, x) end)
      |> Map.values()
      |> Enum.map(&List.last(&1, ""))
      |> Enum.join()
  end

  defp apply_move_multiple(stack, [move: x, from: y, to: z]) do
    Map.put(stack, z, stack[z] ++ Enum.take(stack[y], -x))
    |> Map.put(y, Enum.drop(stack[y], -x))
  end

end
