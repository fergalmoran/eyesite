defmodule Eyesite.ServicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Eyesite.Services` context.
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
      |> Eyesite.Services.create_service()

    service
  end
end
