defmodule InterviewManagment.Repo do
  use Ecto.Repo,
    otp_app: :interview_managment,
    adapter: Ecto.Adapters.Postgres
end
