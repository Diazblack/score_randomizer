defmodule ScoreRandomizer.Repo.Migrations.AddIndexOnValuesToScoreTable do
  use Ecto.Migration

  def change do
    create index(:scores, [:value])
  end
end
