defmodule HyperUiWeb.PageController do
  use HyperUiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
