defmodule InterviewManagment.Repo.Migrations.CreateInterviews do
  use Ecto.Migration

  def change do
    create table(:interviews) do
      add :date, :date, null: false
      add :description, :text
      add :link, :string
      add :company_name, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
