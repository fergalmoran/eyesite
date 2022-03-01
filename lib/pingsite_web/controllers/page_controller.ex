defmodule PingSiteWeb.PageController do
  use PingSiteWeb, :controller

  def index(conn, _params) do
    template = (Pow.Plug.current_user(conn) && "index.html") || "onboard.html"
    render(conn, template)
  end
end
