defmodule Eyesite.Front.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :description, :string
    field :host, :string
    field :port, :integer
    field :title, :string
    field :type, Ecto.Enum, values: [:http, :port, :response, :ping]

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title, :host, :port, :description, :type])
    |> validate_required([:title, :host, :port])
  end
end
