defmodule RihannaUiWeb.PageController do
  use RihannaUiWeb, :controller
  require Ecto.Query, as: Query

  def overview(conn, _params) do
    jobs = Rihanna.Job
    |> Rihanna.Repo.all()
    |> Enum.group_by(&(&1.state))
    enqueued = Enum.count(jobs["ready_to_run"] || [])
    in_progress = Enum.count(jobs["in_progress"] || [])
    failed = Enum.count(jobs["failed"] || [])

    render conn, "overview.html", enqueued: enqueued, in_progress: in_progress, failed: failed
  end

  def enqueued(conn, _params) do
    enqueued_jobs = Rihanna.Job
    |> Query.where(state: "ready_to_run")
    |> Rihanna.Repo.all()

    render conn, "enqueued.html", jobs: enqueued_jobs
  end

  def in_progress(conn, _) do
    in_progress_jobs = Rihanna.Job
    |> Query.where(state: "in_progress")
    |> Rihanna.Repo.all()

    render conn, "in_progress.html", jobs: in_progress_jobs
  end

  def failed(conn, _params) do
    failed_jobs = Rihanna.Job
    |> Query.where(state: "failed")
    |> Rihanna.Repo.all()

    render conn, "failed.html", jobs: failed_jobs
  end
end
