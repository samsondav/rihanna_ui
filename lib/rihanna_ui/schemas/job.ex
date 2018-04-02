defmodule RihannaUI.Job do
  use Ecto.Schema
  require Ecto.Query, as: Query

  schema Rihanna.Job.table() do
    field :term, RihannaUI.ETF
    field :enqueued_at, :utc_datetime
    field :failed_at, :utc_datetime
    field :fail_reason, :string
  end

  def enqueued() do
    Query.from(
      j in RihannaUI.Job,
      left_join: lock in "pg_locks",
      on: j.id == lock.objid,
      on: lock.classid == ^Rihanna.Config.pg_advisory_lock_class_id(),
      on: lock.locktype == "advisory",
      where: lock.objid |> is_nil,
      where: j.failed_at |> is_nil
    )
    |> RihannaUI.Repo.all()
  end

  def in_progress() do
    Query.from(
      j in RihannaUI.Job,
      join: lock in "pg_locks",
      on: j.id == lock.objid,
      where: lock.classid == ^Rihanna.Config.pg_advisory_lock_class_id(),
      where: lock.locktype == "advisory"
    )
    |> RihannaUI.Repo.all()

  end

  def failed() do
    Query.from(
      j in RihannaUI.Job,
      where: not j.failed_at |> is_nil
    )
    |> RihannaUI.Repo.all()
  end
end
