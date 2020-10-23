defmodule RihannaUIWeb.Router do
  use RihannaUIWeb, :router

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

  scope "/", RihannaUIWeb do
    pipe_through :browser # Use the default browser stack

    # TODO: https://github.com/BlinkerGit/rihanna_ui/issues/2
    # add /status endpoint or something similar
    # to act as the health check ping
    # only log things above info level, whatever level
    # to not see a million health checks in the logs.
    # likely set to :debug

    get "/", PageController, :overview
    get "/enqueued", PageController, :enqueued
    get "/in_progress", PageController, :in_progress
    get "/failed", PageController, :failed

    post "/jobs", JobsController, :mutate
    post "/jobs/:id", JobsController, :mutate
  end

  # Other scopes may use custom stacks.
  # scope "/api", RihannaUIWeb do
  #   pipe_through :api
  # end
end
