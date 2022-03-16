defmodule PingSite.DeviceRegistrations do
  import Ecto.Query, warn: false
  require Logger
  alias PingSite.Repo

  alias PingSite.Users.DeviceRegistration

  def update_registration(user, attrs \\ %{}) do
    %DeviceRegistration{}
    |> DeviceRegistration.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end
end
