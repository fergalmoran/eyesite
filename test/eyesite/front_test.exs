defmodule Eyesite.FrontTest do
  use Eyesite.DataCase

  alias Eyesite.Front

  describe "services" do
    alias Eyesite.Front.Service

    import Eyesite.FrontFixtures

    @invalid_attrs %{description: nil, ip: nil, port: nil, title: nil}

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Front.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Front.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      valid_attrs = %{description: "some description", ip: "some ip", port: 42, title: "some title"}

      assert {:ok, %Service{} = service} = Front.create_service(valid_attrs)
      assert service.description == "some description"
      assert service.ip == "some ip"
      assert service.port == 42
      assert service.title == "some title"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Front.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      update_attrs = %{description: "some updated description", ip: "some updated ip", port: 43, title: "some updated title"}

      assert {:ok, %Service{} = service} = Front.update_service(service, update_attrs)
      assert service.description == "some updated description"
      assert service.ip == "some updated ip"
      assert service.port == 43
      assert service.title == "some updated title"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Front.update_service(service, @invalid_attrs)
      assert service == Front.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Front.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Front.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Front.change_service(service)
    end
  end
end
