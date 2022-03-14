defmodule PingSite.Users.User do
  require Logger
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    pow_user_fields()
    field :display_name, :string
    timestamps()
  end

  def changeset(changeset, attrs) do
    changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:display_name])
  end
end
