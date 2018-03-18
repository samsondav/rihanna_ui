defmodule SombreroUiWeb.PageController do
  use SombreroUiWeb, :controller
  require Ecto.Query, as: Query

  def overview(conn, _params) do
    jobs = Sombrero.Job
    |> Sombrero.Repo.all()
    |> Enum.group_by(&(&1.state))
    enqueued = Enum.count(jobs["ready_to_run"] || [])
    in_progress = Enum.count(jobs["in_progress"] || [])
    failed = Enum.count(jobs["failed"] || [])

    render conn, "overview.html", enqueued: enqueued, in_progress: in_progress, failed: failed
  end

  def enqueued(conn, _params) do
    enqueued_jobs = Sombrero.Job
    |> Query.where(state: "ready_to_run")
    |> Sombrero.Repo.all()

    render conn, "enqueued.html", jobs: enqueued_jobs
  end

  def in_progress(conn, _) do
    in_progress_jobs = Sombrero.Job
    |> Query.where(state: "in_progress")
    |> Sombrero.Repo.all()

    render conn, "in_progress.html", jobs: in_progress_jobs
  end

  def failed(conn, _params) do
    failed_jobs = Sombrero.Job
    |> Query.where(state: "failed")
    |> Sombrero.Repo.all()

    render conn, "failed.html", jobs: failed_jobs
  end
end
