defmodule RihannaUIWeb.StatusController do
  use RihannaUIWeb, :controller

  def status(conn, _params) do
    text(conn, "ok")
  end
end
