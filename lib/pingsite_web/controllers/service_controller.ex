defmodule PingSiteWeb.ServiceController do
  use PingSiteWeb, :controller

  alias PingSite.Services
  alias PingSite.Services.Service

  def index(conn, _params) do
    services = Services.list_services()
    render(conn, "index.html", services: services)
  end

  def new(conn, _params) do
    changeset = Services.change_service(%Service{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"service" => service_params}) do
    user = conn.assigns.current_user

    case Services.create_service(user, service_params) do
      {:ok, _service} ->
        conn
        |> put_flash(:info, "Service created successfully.")
        |> redirect(to: Routes.service_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    service = Services.get_service!(id)
    render(conn, "show.html", service: service)
  end

  def edit(conn, %{"id" => id}) do
    service = Services.get_service!(id)
    changeset = Services.change_service(service)
    render(conn, "edit.html", service: service, changeset: changeset)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = Services.get_service!(id)

    case Services.update_service(service, service_params) do
      {:ok, _service} ->
        conn
        |> put_flash(:info, "Service updated successfully.")
        |> redirect(to: Routes.service_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", service: service, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Services.get_service!(id)
    {:ok, _service} = Services.delete_service(service)

    conn
    |> put_flash(:info, "Service deleted successfully.")
    |> redirect(to: Routes.service_path(conn, :index))
  end
end
