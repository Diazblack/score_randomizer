defmodule ScoreRandomizer.Repo.Migrations.AddRangeToScoreTableValues do
  use Ecto.Migration

  def up do
    create constraint(:scores, :value_range_constraint, check: "value BETWEEN 0 AND 100")
  end

  def down do
    drop constraint(:scores, :value_range_constraint)
  end
end
