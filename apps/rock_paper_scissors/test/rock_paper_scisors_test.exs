defmodule ROCK_PAPER_SCISSORSTest do
  use ExUnit.Case
  doctest ROCK_PAPER_SCISSORS

  test "greets the world" do
    assert ROCK_PAPER_SCISSORS.hello() == :world
  end
end
