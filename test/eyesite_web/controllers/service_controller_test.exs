defmodule EyesiteWeb.ServiceControllerTest do
  use EyesiteWeb.ConnCase

  import Eyesite.FrontFixtures

  @create_attrs %{description: "some description", host: "some host", port: 42, title: "some title", type: :port}
  @update_attrs %{description: "some updated description", host: "some updated host", port: 43, title: "some updated title", type: :ping}
  @invalid_attrs %{description: nil, host: nil, port: nil, title: nil}

  describe "index" do
    test "lists all services", %{conn: conn} do
      conn = get(conn, Routes.service_path(conn, :index))
      assert html_response(conn, 200) =~ "Services"
    end
  end

  describe "new service" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.service_path(conn, :new))
      assert html_response(conn, 200) =~ "New Service"
    end
  end

  describe "create service" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @create_attrs)

      assert redirected_to(conn) == Routes.service_path(conn, :index)

      conn = get(conn, Routes.service_path(conn, :index))
      assert html_response(conn, 200) =~ "Services"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Service"
    end
  end

  describe "edit service" do
    setup [:create_service]

    test "renders form for editing chosen service", %{conn: conn, service: service} do
      conn = get(conn, Routes.service_path(conn, :edit, service))
      assert html_response(conn, 200) =~ "Edit Service"
    end
  end

  describe "update service" do
    setup [:create_service]

    test "redirects when data is valid", %{conn: conn, service: service} do
      conn = put(conn, Routes.service_path(conn, :update, service), service: @update_attrs)
      assert redirected_to(conn) == Routes.service_path(conn, :index)

      conn = get(conn, Routes.service_path(conn, :index))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, service: service} do
      conn = put(conn, Routes.service_path(conn, :update, service), service: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Service"
    end
  end

  describe "delete service" do
    setup [:create_service]

    test "deletes chosen service", %{conn: conn, service: service} do
      conn = delete(conn, Routes.service_path(conn, :delete, service))
      assert redirected_to(conn) == Routes.service_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.service_path(conn, :show, service))
      end
    end
  end

  defp create_service(_) do
    service = service_fixture()
    %{service: service}
  end
end
