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
          form: Phoenix.Component.to_form(changeset)
        )
    end
  end

  def toggle_got_interview(conn, %{"id" => id}) do
    interview = Interviews.get_interview!(id)

    case Interviews.toggle_got_interview(interview) do
      {:ok, _interview} ->
        redirect(conn, to: ~p"/")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not update the interview status.")
        |> redirect(to: ~p"/")
    end
  end

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
