defmodule PingSiteWeb.MobileAlertSocket do
  require Logger
  use Phoenix.Socket

  ## Channels
  channel "updates:*", PingSiteWeb.MobileAlertChannel

  def connect(params, socket, _connect_info) do
    Logger.info("New connection to updates.*")
    IO.inspect(params)
    IO.inspect(socket)
    {:ok, socket}
  end

  def join("updates:errors", message, socket) do
    Logger.info("Join to updates.errors")
    IO.inspect(message)
    IO.inspect(socket)
    {:ok, socket}
  end

  def join("updates:" <> private_room_id, params, socket) do
    Logger.info("Unauthorised join to updates.errors")
    IO.inspect(private_room_id)
    IO.inspect(params)
    IO.inspect(socket)
    {:error, %{reason: "unauthorized"}}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     PingSiteWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
