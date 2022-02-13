defmodule Eyesite.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :title, :text
      add :ip, :string
      add :port, :integer
      add :description, :text

      timestamps()
    end
  end
end
