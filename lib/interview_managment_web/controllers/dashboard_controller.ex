defmodule InterviewManagmentWeb.DashboardController do
  use InterviewManagmentWeb, :controller

  def index(conn, _params) do
    render(conn, :index, interviews: [])
  end
end
