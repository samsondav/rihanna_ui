defmodule RihannaUIWeb.JobsController do
  use RihannaUIWeb, :controller

  def mutate(conn, %{"id" => id, "action" => "retry"}) do
    case Rihanna.retry(id) do
      {:ok, :retried} ->
        conn |> put_flash(:success, "Job was retried!")
      {:error, :job_not_found} ->
        conn |> put_flash(:error, "Job could not be retried")
    end
    |> redirect(to: "/failed")
  end

  def mutate(conn, %{"id" => id, "action" => "delete"}) do
    import Ecto.Query
    case RihannaUI.Repo.delete_all(
      from(
        RihannaUI.Job,
        where: [id: ^id]
      )
    ) do
      {0, _} ->
        conn |> put_flash(:error, "Job could not be found.")
      {1, _} ->
        conn |> put_flash(:success, "Job was deleted.")
    end
    |> redirect(to: "/failed")
  end

  def mutate(conn, %{"action" => "retry_all"}) do
    retries =
      RihannaUI.Job.failed()
      |> Enum.map(&Rihanna.retry(&1.id))

    conn
    |> put_flash(:success, "Retrying all jobs. #{inspect(retries)}")
    |> redirect(to: "/failed")
  end
end
