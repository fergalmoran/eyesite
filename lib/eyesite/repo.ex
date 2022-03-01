defmodule PingSite.Repo do
  use Ecto.Repo,
    otp_app: :pingsite,
    adapter: Ecto.Adapters.Postgres
end
