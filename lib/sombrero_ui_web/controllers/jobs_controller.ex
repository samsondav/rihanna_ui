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
      "delete" ->
        import Ecto.Query
        case Sombrero.Repo.delete_all(
          from(
            Sombrero.Job,
            where: [id: ^id]
          )
        ) do
          {0, _} ->
            conn |> put_flash(:error, "Job could not be found.")
          {1, _} ->
            conn |> put_flash(:success, "Job was deleted.")
        end
    end
    |> redirect(to: "/failed")
  end
end
