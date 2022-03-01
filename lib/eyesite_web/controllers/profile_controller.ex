defmodule PingSiteWeb.ProfileController do
  use PingSiteWeb, :controller
  alias PingSite.Users

  def index(conn, _params) do
    user = Pow.Plug.current_user(conn)
    changeset = Users.change_user(user)
    render(conn, "index.html", changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = Pow.Plug.current_user(conn)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> sync_user(user)
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", user: user, changeset: changeset)
    end
  end
end
