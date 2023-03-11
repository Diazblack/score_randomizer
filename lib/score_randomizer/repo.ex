defmodule ScoreRandomizer.Repo do
  use Ecto.Repo,
    otp_app: :score_randomizer,
    adapter: Ecto.Adapters.Postgres
end
