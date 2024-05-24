defmodule ScoreRandomizer.Genservers.RealRandomizer do
  use GenServer

  alias ScoreRandomizer.Data
  # alias ScoreRandomizer.Data.Score
  # in miliseconds
  @interval 10000

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  ## GenServer Callback
  @impl true
  def init(opts) do
    Process.send_after(self(), :random, @interval * 2)
    {:ok, opts}
  end

  @impl true
  def handle_info(:random, state) do
    IO.inspect("Updating Score Tables at: #{DateTime.utc_now()}")

    {update_number, _any} = Data.update_score_values()
    IO.inspect("#{update_number} Scores updated at: #{DateTime.utc_now()}")
    Process.send_after(self(), :random, @interval)
    {:noreply, state}
  end
end
