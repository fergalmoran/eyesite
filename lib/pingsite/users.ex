defmodule PingSite.Users do
  @moduledoc """
  The Services context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias PingSite.Repo

  alias PingSite.Users.User

  def get_registrations(user_id) do
    results = Repo.get!(User, user_id) |> Repo.preload(:devices)
    results.devices
  end

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  @spec create_user(%{optional(:__struct__) => none, optional(atom | binary) => any}) :: any
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
