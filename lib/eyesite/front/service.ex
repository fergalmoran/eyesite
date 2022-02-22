defmodule Eyesite.Front.Service do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "services" do
    field :description, :string
    field :host, :string
    field :port, :integer
    field :title, :string
    field :type, Ecto.Enum, values: [:http, :port, :response, :ping]
    belongs_to :user, Eyesite.Users.User, references: :id, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title, :host, :port, :description, :type])
    |> validate_required([:title, :host, :port])
  end
end
