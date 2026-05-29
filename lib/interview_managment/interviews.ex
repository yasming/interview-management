defmodule InterviewManagment.Interviews do
  @moduledoc """
  The Interviews context.
  """

  import Ecto.Query, warn: false
  alias InterviewManagment.Repo
  alias InterviewManagment.Interviews.Interview

  def list_interviews do
    Repo.all(from i in Interview, order_by: [desc: i.inserted_at, desc: i.id])
  end

  def get_interview!(id), do: Repo.get!(Interview, id)

  def create_interview(attrs \\ %{}) do
    %Interview{}
    |> Interview.changeset(attrs)
    |> Repo.insert()
  end

  def update_interview(%Interview{} = interview, attrs) do
    interview
    |> Interview.changeset(attrs)
    |> Repo.update()
  end

  def change_interview(%Interview{} = interview, attrs \\ %{}) do
    Interview.changeset(interview, attrs)
  end

  def toggle_got_interview(%Interview{} = interview) do
    update_interview(interview, %{got_interview: !interview.got_interview})
  end
end
