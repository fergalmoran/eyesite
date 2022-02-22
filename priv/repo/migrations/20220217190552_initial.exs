defmodule Eyesite.Repo.Migrations.AddServicesTable do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE service_type AS ENUM (
      'http', 'port', 'response', 'ping'
    )")
    create table(:services, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, :binary_id, null: false
      add :title, :text, null: false
      add :host, :string, null: false
      add :port, :integer, null: false
      add :description, :text
      add :type, :service_type, null: false
      timestamps()
    end
  end
end
