defmodule PingSite.Users.DeviceRegistration do
  require Logger
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "device_registrations" do
    field :device_id, :string
    field :registration_id, :string
    belongs_to :user, PingSite.Users.User, references: :id, type: :binary_id
    timestamps()
  end

  def changeset(device_registration, attrs) do
    Logger.debug("START: device_registration changeset....")
    IO.inspect(device_registration)
    IO.inspect(attrs)
    Logger.debug("END: device_registration changeset....")

    device_registration
    |> cast(attrs, [:registration_id, :device_id])
    |> validate_required([:device_id])
    |> validate_required([:registration_id])
  end
end
