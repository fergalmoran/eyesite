defmodule Eyesite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Eyesite.Repo,
      # Start the Telemetry supervisor
      EyesiteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Eyesite.PubSub},
      # Start the Endpoint (http/https)
      EyesiteWeb.Endpoint,
      # Start a worker by calling: Eyesite.Worker.start_link(arg)
      # {Eyesite.Worker, arg}
      Eyesite.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Eyesite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EyesiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
