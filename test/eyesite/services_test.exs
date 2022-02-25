defmodule Eyesite.ServicesTest do
  use Eyesite.DataCase

  alias Eyesite.Services

  describe "services" do
    alias Eyesite.Services.Service

    import Eyesite.ServicesFixtures

    @invalid_attrs %{description: nil, host: nil, port: nil, title: nil}

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Services.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      valid_attrs = %{description: "some description", host: "some host", port: 42, title: "some title", type: :port}

      assert {:ok, %Service{} = service} = Services.create_service(valid_attrs)
      assert service.description == "some description"
      assert service.host == "some host"
      assert service.port == 42
      assert service.title == "some title"
      assert service.type == :port
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      update_attrs = %{description: "some updated description", host: "some updated host", port: 43, title: "some updated title", type: :ping}

      assert {:ok, %Service{} = service} = Services.update_service(service, update_attrs)
      assert service.description == "some updated description"
      assert service.host == "some updated host"
      assert service.port == 43
      assert service.title == "some updated title"
      assert service.type == :ping
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_service(service, @invalid_attrs)
      assert service == Services.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Services.change_service(service)
    end
  end
end
