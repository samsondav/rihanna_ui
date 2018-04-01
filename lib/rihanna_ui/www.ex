defmodule RihannaUI.WWW do
  use Ace.HTTP.Service, [port: 8080, cleartext: true]

  use Raxx.Router, [
    {%{method: :GET, path: []}, RihannaUI.WWW.HomePage},
    {_, RihannaUI.WWW.NotFoundPage}
  ]

  @external_resource "lib/rihanna_ui/public/main.css"
  @external_resource "lib/rihanna_ui/public/main.js"
  use Raxx.Static, "./public"
  use Raxx.Logger, level: :info
end
