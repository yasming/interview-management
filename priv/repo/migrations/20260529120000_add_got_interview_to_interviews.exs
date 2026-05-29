defmodule InterviewManagment.Repo.Migrations.AddGotInterviewToInterviews do
  use Ecto.Migration

  def change do
    alter table(:interviews) do
      add :got_interview, :boolean
    end
  end
end
