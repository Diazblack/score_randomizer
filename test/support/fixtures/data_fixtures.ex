defmodule ScoreRandomizer.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScoreRandomizer.Data` context.
  """

  @doc """
  Generate a score.
  """
  def score_fixture(attrs \\ %{}) do
    {:ok, score} =
      attrs
      |> Enum.into(%{
        id: Ecto.UUID.generate(),
        value: Enum.random(0..100)
      })
      |> ScoreRandomizer.Data.create_score()

    score
  end

  def score_fixtures(number \\ 5) when number > 2 do
    for _i <- 1..number, do: score_fixture(%{})
  end
end
