defmodule PingSiteWeb.API.V1.DeviceController do
  use PingSiteWeb, :controller
  alias PingSite.DeviceRegistrations

  alias Plug.Conn

  @spec register(Conn.t(), map()) :: Conn.t()
  # def register(conn, %{"device_id" => deviceId, "registration_id" => registrationId}) do
  def register(conn, attrs) do
    IO.inspect(conn.assigns.current_user)
    IO.inspect(attrs)

    case DeviceRegistrations.update_registration(conn.assigns.current_user, attrs) do
      {:ok, _service} ->
        conn
        |> put_status(200)
        |> json(%{success: "ok"})

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_status(500)
        |> json(%{error: "bugger"})
    end
  end
end
