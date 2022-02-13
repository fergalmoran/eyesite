defmodule EyesiteWeb.PageControllerTest do
  use EyesiteWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to EyeSite!"
  end
end
