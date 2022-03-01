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

  def changeset(user_or_changeset, attrs) do
    Logger.debug("changeset....")
    IO.inspect(user_or_changeset)
    IO.inspect(attrs)
    user_or_changeset
    |> cast(attrs, [:display_name])
    |> validate_required([:display_name])
  end
end
