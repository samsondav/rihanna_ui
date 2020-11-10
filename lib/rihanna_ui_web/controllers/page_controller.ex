defmodule RihannaUIWeb.PageController do
  use RihannaUIWeb, :controller

  def overview(conn, _params) do
    enqueued = Enum.count(RihannaUI.Job.enqueued())
    in_progress = Enum.count(RihannaUI.Job.in_progress())
    failed = Enum.count(RihannaUI.Job.failed())

    render conn, "overview.html", enqueued: enqueued, in_progress: in_progress, failed: failed
  end

  def enqueued(conn, _params) do
    enqueued_jobs = RihannaUI.Job.enqueued()

    render conn, "enqueued.html", jobs: enqueued_jobs
  end

  def in_progress(conn, _) do
    in_progress_jobs = RihannaUI.Job.in_progress()
    render conn, "in_progress.html", jobs: in_progress_jobs
  end

  def failed(conn, _params) do
    failed_jobs = RihannaUI.Job.failed()
    render conn, "failed.html", jobs: failed_jobs
  end
end
