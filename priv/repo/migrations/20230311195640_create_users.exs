defmodule ScoreRandomizer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:points, :integer)

      timestamps(type: :utc_datetime_usec)
    end

    create(
      constraint(:users, :points_must_be_between_zero_and_one_hundred,
        check: "points BETWEEN 0 AND 100"
      )
    )
  end
end
