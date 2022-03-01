defmodule PingSite.ServicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PingSite.Services` context.
  """

  @doc """
  Generate a service.
  """
  def service_fixture(attrs \\ %{}) do
    {:ok, service} =
      attrs
      |> Enum.into(%{
        description: "some description",
        host: "some host",
        port: 42,
        title: "some title",
        type: :port
      })
      |> PingSite.Services.create_service()

    service
  end
end
