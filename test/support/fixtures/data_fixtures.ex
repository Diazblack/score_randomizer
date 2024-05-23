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
        value: 42
      })
      |> ScoreRandomizer.Data.create_score()

    score
  end
end
