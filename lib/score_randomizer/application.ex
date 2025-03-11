defmodule ScoreRandomizer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ScoreRandomizerWeb.Telemetry,
      # Start the Ecto repository
      ScoreRandomizer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ScoreRandomizer.PubSub},
      # Start Finch
      {Finch, name: ScoreRandomizer.Finch},
      # Start the Endpoint (http/https)
      ScoreRandomizerWeb.Endpoint
      # Start a worker by calling: ScoreRandomizer.Worker.start_link(arg)
      # {ScoreRandomizer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScoreRandomizer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScoreRandomizerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
