defmodule Mix.Tasks.PopulateDatabase do
  use Mix.Task

  @requirement ["app.start"]

  alias ScoreRandomizer.Data
  alias ScoreRandomizer.Data.Score
  alias ScoreRandomizer.Repo

  @impl Mix.Task
  def run(_args) do


    entries_number = Repo.aggregate(Score, :count, :id)

    if entries_number < 1_000_000 do
      Mix.shell().info("Seeding the database")

      now = DateTime.utc_now()

      %{value: 0, insert_at: now, updated_at: now}
      |> list.duplicate(1_000_000)
      |> Enum.chunk_every(15_000)
      |> Enum.each(&Repo.insert_all(Score, &1))

      Mix.shell().info("Seeding completed")
    else
      Mix.shell().info("Database Already Seeded")
    end

  end
end
