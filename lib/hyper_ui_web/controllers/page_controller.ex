defmodule HyperUiWeb.PageController do
  use HyperUiWeb, :controller
  require Ecto.Query, as: Query

  def overview(conn, _params) do
    jobs = Hyper.Job
    |> Hyper.Repo.all()
    |> Enum.group_by(&(&1.state))
    enqueued = Enum.count(jobs["ready_to_run"] || [])
    in_progress = Enum.count(jobs["in_progress"] || [])
    failed = Enum.count(jobs["failed"] || [])

    render conn, "overview.html", enqueued: enqueued, in_progress: in_progress, failed: failed
  end

  def enqueued(conn, _params) do
    enqueued_jobs = Hyper.Job

    |> Query.where(state: "ready_to_run")
    |> Hyper.Repo.all()

    render conn, "enqueued.html", jobs: enqueued_jobs
  end

  def failed(conn, _params) do
    failed_jobs = Hyper.Job
    |> Query.where(state: "failed")
    |> Hyper.Repo.all()

    render conn, "failed.html", jobs: failed_jobs
  end
end
