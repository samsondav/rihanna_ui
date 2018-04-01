defmodule RihannaUI.WWW.HomePageTest do
  use ExUnit.Case

  alias RihannaUI.WWW.HomePage

  test "returns the Raxx.Kit home page" do
    request = Raxx.request(:GET, "/")

    response = HomePage.handle_request(request, %{})

    assert response.status == 200
    assert response.headers == [{"content-type", "text/html"}]
    assert String.contains?(response.body, "Raxx.Kit")
  end
end
