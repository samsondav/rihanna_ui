defmodule HyperUiWeb.PageController do
  use HyperUiWeb, :controller

  def index(conn, _params) do
    jobs = Hyper.Job
    |> Hyper.Repo.all()
    |> Enum.group_by(&(&1.state))
    enqueued = Enum.count(jobs["ready_to_run"] || [])
    in_progress = Enum.count(jobs["in_progress"] || [])
    failed = Enum.count(jobs["failed"] || [])

    render conn, "index.html", enqueued: enqueued, in_progress: in_progress, failed: failed
  end
end
