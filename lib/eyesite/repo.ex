defmodule Eyesite.Repo do
  use Ecto.Repo,
    otp_app: :eyesite,
    adapter: Ecto.Adapters.Postgres
end
