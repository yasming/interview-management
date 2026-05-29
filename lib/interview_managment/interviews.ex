defmodule InterviewManagment.Interviews do
  @moduledoc """
  The Interviews context.
  """

  import Ecto.Query, warn: false
  alias InterviewManagment.Repo
  alias InterviewManagment.Interviews.Interview

  def list_interviews do
    Repo.all(from i in Interview, order_by: [desc: i.date_applied])
  end

  def create_interview(attrs \\ %{}) do
    %Interview{}
    |> Interview.changeset(attrs)
    |> Repo.insert()
  end

  def change_interview(%Interview{} = interview, attrs \\ %{}) do
    Interview.changeset(interview, attrs)
  end
end
