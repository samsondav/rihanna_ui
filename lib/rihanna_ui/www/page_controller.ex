defmodule RihannaUI.WWW.PageController do
  use Raxx.Server

  require EEx
  require Ecto.Query, as: Query

  @templates ~w(app overview)

  app = Path.join(__DIR__, "./app.html.eex")
  EEx.function_from_file(:defp, :app, app, [:assigns])

  overview = Path.join(__DIR__, "./overview.html.eex")
  EEx.function_from_file(:defp, :overview, overview, [:assigns])

  @impl Raxx.Server
  def handle_request(%{method: :GET, path: []}, _) do
    enqueued = Enum.count(RihannaUI.Job.enqueued())
    in_progress = Enum.count(RihannaUI.Job.in_progress())
    failed = Enum.count(RihannaUI.Job.failed())

    template = overview(%{enqueued: enqueued, in_progress: in_progress, failed: failed})

    response(:ok)
    |> set_header("content-type", "text/html")
    |> set_body(app(%{template: template, path: "/overview"}))
  end

  # def enqueued(conn, _params) do
  #   render conn, "enqueued.html", jobs: enqueued_jobs
  # end

  # def in_progress(conn, _) do
  #   render conn, "in_progress.html", jobs: in_progress_jobs
  # end

  # def failed(conn, _params) do
  #   render conn, "failed.html", jobs: failed_jobs
  # end
end
