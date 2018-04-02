defmodule RihannaUI.WWW.PageController do
  use Raxx.Server
  use Phoenix.HTML

  require EEx
  require Ecto.Query, as: Query

  app = Path.join(__DIR__, "./app.html.eex")
  EEx.function_from_file(:defp, :app, app, [:assigns], engine:  Phoenix.HTML.Engine)

  overview = Path.join(__DIR__, "./overview.html.eex")
  EEx.function_from_file(:defp, :overview, overview, [:assigns], engine:  Phoenix.HTML.Engine)

  enqueued = Path.join(__DIR__, "./enqueued.html.eex")
  EEx.function_from_file(:defp, :enqueued, enqueued, [:assigns], engine:  Phoenix.HTML.Engine)

  in_progress = Path.join(__DIR__, "./in_progress.html.eex")
  EEx.function_from_file(:defp, :in_progress, in_progress, [:assigns], engine:  Phoenix.HTML.Engine)

  failed = Path.join(__DIR__, "./failed.html.eex")
  EEx.function_from_file(:defp, :failed, failed, [:assigns], engine:  Phoenix.HTML.Engine)

  @impl Raxx.Server
  def handle_request(%{method: :GET, path: path = []}, _) do
    enqueued = Enum.count(RihannaUI.Job.enqueued())
    in_progress = Enum.count(RihannaUI.Job.in_progress())
    failed = Enum.count(RihannaUI.Job.failed())

    template = overview(%{enqueued: enqueued, in_progress: in_progress, failed: failed})

    response(:ok)
    |> IO.inspect
    |> set_header("content-type", "text/html")
    |> set_body(app(%{template: template, path: path}))
  end

  def handle_request(%{method: :GET, path: path = ["enqueued"]}, _params) do
    jobs = RihannaUI.Job.enqueued()

    template = enqueued(%{jobs: jobs})

    response(:ok)
    |> set_header("content-type", "text/html")
    |> set_body(app(%{template: template, path: path}))
  end

  def handle_request(%{method: :GET, path: path = ["in_progress"]}, _params) do
    jobs = RihannaUI.Job.in_progress()

    template = in_progress(%{jobs: jobs})

    response(:ok)
    |> set_header("content-type", "text/html")
    |> set_body(app(%{template: template, path: path}))
  end

  def handle_request(%{method: :GET, path: path = ["failed"]}, _params) do
    jobs = RihannaUI.Job.failed()

    template = failed(%{jobs: jobs})

    response(:ok)
    |> set_header("content-type", "text/html")
    |> set_body(app(%{template: template, path: path}))
  end

  defp render_term({mod, fun, args}) do
    args_string = args
    |> Enum.map(&inspect/1)
    |> Enum.join(", ")
    "#{mod}.#{fun}(#{args_string})"
  end

  defp render_term({mod, arg}) do
    "#{mod}.perform(#{inspect(arg)})"
  end

  defp render_datetime(%{year: year, month: month, day: day, hour: hour, minute: minute, second: second, zone_abbr: zone_abbr}) do
   datetime_string = :io_lib.format("~4..0B-~2..0B-~2..0B ~2..0B:~2..0B:~2..0B",
     [year, month, day, hour, minute, second])
     |> List.flatten
     |> to_string

    "#{datetime_string} #{zone_abbr}"
 end

 def safe_text_to_html(string) do
  string
  |> text_to_html
  |> IO.inspect
  |> Phoenix.HTML.Safe.to_iodata
  |> IO.inspect
  |> raw
  |> IO.inspect
  |> safe_to_string
  |> IO.inspect
 end

  # def in_progress(conn, _) do
  #   render conn, "in_progress.html", jobs: in_progress_jobs
  # end

  # def failed(conn, _params) do
  #   render conn, "failed.html", jobs: failed_jobs
  # end

  # def render()
end
