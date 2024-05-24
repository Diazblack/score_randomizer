defmodule Mix.Tasks.PopulateDatabase do
  use Mix.Task

  @requirements ["app.start"]

  alias ScoreRandomizer.Data
  alias ScoreRandomizer.Data.Score
  alias ScoreRandomizer.Repo

  @impl Mix.Task
  def run(_args) do
    entries = Repo.aggregate(Score, :count, :id)

    if entries < 100 do
      Mix.shell().info("Seeding the database")
      result = Data.create_scores_in_bulk(1_000_000)

      Mix.shell().info("#{inspect(result, pretty: true)}")
      Mix.shell().info("Seeding completed")
    else
      Mix.shell().info("Database Already Seeded")
    end
  end
end
