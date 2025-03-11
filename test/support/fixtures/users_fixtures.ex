defmodule ScoreRandomizer.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScoreRandomizer.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        points: Enum.random(0..100)
      })
      |> ScoreRandomizer.Users.create_user()

    user
  end

  # def new_user_fixture(attrs \\ %{}) do
  #   {:ok, user} =
  #     attrs
  #     |> ScoreRandomizer.Users.create_user()

  #   user
  # end
end
