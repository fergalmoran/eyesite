defmodule PingSite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {PhoenixProfiler, name: PingSite.Profiler},
      # Start the Ecto repository
      PingSite.Repo,
      # Start the Telemetry supervisor
      PingSiteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PingSite.PubSub},
      # Start the Endpoint (http/https)
      PingSiteWeb.Endpoint,
      # Start a worker by calling: PingSite.Worker.start_link(arg)
      # {PingSite.Worker, arg}
      PingSite.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PingSite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PingSiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
