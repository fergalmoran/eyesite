defmodule Eyesite.Repo.Migrations.AddServicesTable do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE service_type AS ENUM (
      'http', 'port', 'response', 'ping'
    )")
    create table(:services) do
      add :title, :text
      add :host, :string
      add :port, :integer
      add :description, :text
      add :type, :service_type
      timestamps()
    end
  end
end
