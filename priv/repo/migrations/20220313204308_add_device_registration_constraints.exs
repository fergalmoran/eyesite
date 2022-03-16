defmodule PingSite.Repo.Migrations.AddDeviceRegistrationConstraints do
  use Ecto.Migration

  def change do
    create unique_index(:device_registrations, [:user_id, :device_id])
  end
end
