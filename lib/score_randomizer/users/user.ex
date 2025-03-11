defmodule ScoreRandomizer.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  schema "users" do
    field(:points, :integer, default: 0)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> check_constraint(:points, name: :points_must_be_between_zero_and_one_hundred)
  end
end
