defmodule SombreroUiWeb.JobsController do
  use SombreroUiWeb, :controller

  def mutate(conn, %{"id" => id, "action" => action}) do
    case action do
      "retry" ->
        case Sombrero.Job.retry_failed(id) do
          {:ok, :retried} ->
            conn |> put_flash(:success, "Job was retried!")
          {:error, :job_not_found} ->
            conn |> put_flash(:error, "Job could not be retried")
        end
    end
    |> redirect(to: "/failed")
  end
end
