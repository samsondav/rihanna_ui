defmodule RihannaUIWeb.PageControllerTest do
  use RihannaUIWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Enqueued"
  end
end
