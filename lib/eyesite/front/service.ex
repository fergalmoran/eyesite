defmodule Eyesite.Front.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :description, :string
    field :ip, :string
    field :port, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title, :ip, :port, :description])
    |> validate_required([:title, :ip, :port])
  end
end
