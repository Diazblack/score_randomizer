defmodule ScoreRandomizer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScoreRandomizerWeb.Telemetry,
      ScoreRandomizer.Repo,
      {DNSCluster, query: Application.get_env(:score_randomizer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ScoreRandomizer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ScoreRandomizer.Finch},
      # Start a worker by calling: ScoreRandomizer.Worker.start_link(arg)
      # {ScoreRandomizer.Worker, arg},
      # Start to serve requests, typically the last entry
      ScoreRandomizerWeb.Endpoint
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
