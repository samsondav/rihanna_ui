defmodule HyperUiWeb.Router do
  use HyperUiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HyperUiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :overview
    get "/enqueued", PageController, :enqueued
    get "/in_progress", PageController, :in_progress
    get "/failed", PageController, :failed

    post "/jobs/:id", JobsController, :mutate
  end

  # Other scopes may use custom stacks.
  # scope "/api", HyperUiWeb do
  #   pipe_through :api
  # end
end
