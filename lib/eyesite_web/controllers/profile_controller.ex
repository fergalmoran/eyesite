defmodule EyesiteWeb.ProfileController do
  use EyesiteWeb, :controller

  def index(conn, _params) do
    profile = Pow.Plug.current_user(conn)
    render(conn, "index.html", profile: profile)
  end
end
