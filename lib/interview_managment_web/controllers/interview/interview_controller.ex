defmodule InterviewManagmentWeb.InterviewController do
  use InterviewManagmentWeb, :controller

  alias InterviewManagment.Interviews
  alias InterviewManagment.Interviews.Interview

  def index(conn, params) do
    search = Map.get(params, "search", "")

    render(conn, :index,
      interviews: Interviews.list_interviews(search: search),
      search: search,
      applied_today: Interviews.count_applied_on(Date.utc_today()),
      total_applied: Interviews.count_total_applied(),
      got_interview: Interviews.count_got_interview(),
      denied_without_interview: Interviews.count_denied_without_interview(),
      form: Phoenix.Component.to_form(Interviews.change_interview(%Interview{}))
    )
  end

  def create(conn, %{"interview" => interview_params}) do
    case Interviews.create_interview(interview_params) do
      {:ok, _interview} ->
        conn
        |> put_flash(:info, "Interview added.")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Please fix the errors below.")
        |> render(:index,
          interviews: Interviews.list_interviews(),
          search: "",
          applied_today: Interviews.count_applied_on(Date.utc_today()),
          total_applied: Interviews.count_total_applied(),
          got_interview: Interviews.count_got_interview(),
          denied_without_interview: Interviews.count_denied_without_interview(),
          form: Phoenix.Component.to_form(changeset)
        )
    end
  end

  def set_got_interview(conn, %{"id" => id} = params) do
    interview = Interviews.get_interview!(id)
    value = parse_got_interview(Map.get(params, "got_interview"), interview.got_interview)

    case Interviews.set_got_interview(interview, value) do
      {:ok, _interview} ->
        redirect(conn, to: ~p"/")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not update the interview status.")
        |> redirect(to: ~p"/")
    end
  end

  # Clicking the already-active choice clears it back to undecided (nil).
  defp parse_got_interview("true", true), do: nil
  defp parse_got_interview("true", _current), do: true
  defp parse_got_interview("false", false), do: nil
  defp parse_got_interview("false", _current), do: false

  def update_contacted(conn, %{"id" => id, "interview" => interview_params}) do
    interview = Interviews.get_interview!(id)

    case Interviews.update_interview(interview, interview_params) do
      {:ok, _interview} ->
        conn
        |> put_flash(:info, "Contacted date updated.")
        |> redirect(to: ~p"/")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not update the contacted date.")
        |> redirect(to: ~p"/")
    end
  end
end
