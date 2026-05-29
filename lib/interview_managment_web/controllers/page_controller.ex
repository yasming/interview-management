defmodule InterviewManagmentWeb.PageController do
  use InterviewManagmentWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
