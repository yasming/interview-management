defmodule InterviewManagmentWeb.InterviewController do
  use InterviewManagmentWeb, :controller

  alias InterviewManagment.Interviews
  alias InterviewManagment.Interviews.Interview

  def index(conn, _params) do
    render(conn, :index,
      interviews: Interviews.list_interviews(),
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
          form: Phoenix.Component.to_form(changeset)
        )
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
