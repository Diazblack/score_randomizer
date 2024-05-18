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
        id: "7488a646-e31f-11e4-aace-600308960662",
        value: 42
      })
      |> ScoreRandomizer.Data.create_score()

    score
  end
end
