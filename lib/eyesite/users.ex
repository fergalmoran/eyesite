defmodule Eyesite.Users do
  @moduledoc """
  The Services context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias Eyesite.Repo

  alias Eyesite.Users.User

  def list_users do
    Repo.all(User)
  end


  def get_user!(id), do: Repo.get!(User, id)

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
