defmodule EyesiteWeb.PageController do
  use EyesiteWeb, :controller

  def index(conn, _params) do
    template = (Pow.Plug.current_user(conn) && "index.html") || "onboard.html"
    render(conn, template)
  end
end
