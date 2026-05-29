defmodule InterviewManagment.Repo.Migrations.CreateInterviews do
  use Ecto.Migration

  def change do
    create table(:interviews) do
      add :date_applied, :date, null: false
      add :date_contacted, :date
      add :description, :string, null: false
      add :link, :string, null: false
      add :company_name, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
