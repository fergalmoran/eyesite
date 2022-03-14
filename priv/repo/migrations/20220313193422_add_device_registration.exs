defmodule PingSite.Repo.Migrations.AddDeviceRegistration do
  use Ecto.Migration

  def change do
    create table(:device_registrations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, :binary_id, null: false
      add :device_id, :string, null: false
      add :registration_id, :string, null: false
      timestamps()
    end
  end
end
