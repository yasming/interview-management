defmodule InterviewManagment.Interviews do
  @moduledoc """
  The Interviews context.
  """

  import Ecto.Query, warn: false
  alias InterviewManagment.Repo
  alias InterviewManagment.Interviews.Interview

  def list_interviews(opts \\ []) do
    search = opts |> Keyword.get(:search) |> normalize_search()

    Interview
    |> filter_by_company_name(search)
    |> order_by([i], desc: i.inserted_at, desc: i.id)
    |> Repo.all()
  end

  defp normalize_search(nil), do: nil

  defp normalize_search(search) when is_binary(search) do
    case String.trim(search) do
      "" -> nil
      trimmed -> trimmed
    end
  end

  defp filter_by_company_name(query, nil), do: query

  defp filter_by_company_name(query, search) do
    pattern = "%#{String.replace(search, ["%", "_"], &("\\" <> &1))}%"

    from i in query,
      where: like(fragment("lower(?)", i.company_name), fragment("lower(?)", ^pattern))
  end

  def get_interview!(id), do: Repo.get!(Interview, id)

  def count_applied_on(date) do
    Repo.aggregate(from(i in Interview, where: i.date_applied == ^date), :count, :id)
  end

  def count_total_applied do
    Repo.aggregate(Interview, :count, :id)
  end

  def count_got_interview do
    Repo.aggregate(from(i in Interview, where: i.got_interview == true), :count, :id)
  end

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
