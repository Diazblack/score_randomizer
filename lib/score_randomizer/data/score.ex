defmodule ScoreRandomizer.Data.Score do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "scores" do
    field :value, :integer

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:value])
    |> validate_required([:value])
    |> check_constraint(:value, name: :value_range_constraint)
  end
end
