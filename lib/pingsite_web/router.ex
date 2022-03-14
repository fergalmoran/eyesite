defmodule PingSiteWeb.Router do
  use PingSiteWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PingSiteWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug PingSiteWeb.APIAuthPlug, otp_app: :pingsite
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: PingSiteWeb.APIAuthErrorHandler
  end

  scope "/api/v1", PingSiteWeb.API.V1, as: :api_v1 do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api/v1", PingSiteWeb.API.V1, as: :api_v1 do
    pipe_through [:api, :api_protected]

    # Your protected API endpoints here
    post "/session/validate", SessionController, :validate
    post "/device/register", DeviceController, :register
  end

  scope "/" do
    pipe_through :browser
    pow_routes()
  end

  scope "/", PingSiteWeb do
    # pipe_through [:browser, :protected]
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", PingSiteWeb do
    pipe_through [:browser, :protected]
    resources "/services", ServiceController

    get "/profile", ProfileController, :index
    put "/profile", ProfileController, :update
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PingSiteWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
