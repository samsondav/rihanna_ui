defmodule RihannaUIWeb.StatusControllerTest do
  use RihannaUIWeb.ConnCase

  test "GET /status returns ok", %{conn: conn} do
    conn = get conn, "/status"

    assert text_response(conn, 200) == "ok"
  end
end
