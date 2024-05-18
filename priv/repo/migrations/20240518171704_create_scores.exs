defmodule ScoreRandomizer.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores, primary_id: false) do
      add :id, :uuid, primary_id: true
      add :value, :integer

      timestamps(type: :utc_datetime_usec)
    end


  end
end
